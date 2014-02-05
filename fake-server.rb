class FakeApi
  MAX_READ = 1024 # just needs to be big enough to hold our host:port

  # the block will be evaled in the context of the sinatra app
  # make sure to close over any variables you want available to sinatra
  # an example block you might pass would be:
  #
  # FakeApi.new do
  #   get "/people" do
  #     content_type :json
  #     {mark: 1, mike: 'a'}.to_json
  #   end
  # end
  #
  def initialize &block
    assign_pipes

    # make a copy of our FakeApiServer template
    # Class.new makes a class (not an instance, ♡ Ruby)
    @fake_api_server = Class.new(FakeApiServer)

    # .instance_exec to re-open the class
    @fake_api_server.instance_exec(&block) if block_given?
  end

  def start
    # make a pipe for getting the server's boot information
    # back to test suite. ("host:port")
    server_boot_reader, server_boot_writer = IO.pipe

    # the fake server has to run in a fork.
    # when the block terminates so will the forked
    # process (the Capybara)
    fork do
      server_boot_reader.close
      server = @fake_api_server.boot
      server_boot_writer << [server.host, server.port].join(':')
      server_boot_writer.close
      IO.select([@should_die]) # stop here until the pipe is readable
    end
    server_boot_writer.close

    # this line can't run until the fork puts
    # some information in the pipe.  Once the
    # pipe is open for reads, we can return the "host:port"
    server_boot_reader.readpartial(MAX_READ)
  end

  # Call this when you're done with the fake API server
  # unless you _like_ zombies ☠
  def kill
    @killer << "sic semper tyrannis" # anything will do.
    @killer.close
  end

  private

  def assign_pipes
    @should_die, @killer = IO.pipe
  end

  # This class is going to serve as a template for
  # all of our fake servers.
  class FakeApiServer < Sinatra::Base

    ALLOWED = [:get, :post, :put, :delete, :patch, :options].freeze

    # Some default config for our mock server
    use Rack::Cors do |config|
      config.allow do |allow|
        allow.origins  '*'
        allow.resource '*', headers: :any, methods: ALLOWED
      end
    end

    # Give Capybara a instance of the Sinatra server
    # TODO: explain WTF Capybara is
    # TODO: explain `new(new)`
    # tap to return the server
    def self.boot
      Capybara::Server.new(new).tap(&:boot)
    end

  end

end
