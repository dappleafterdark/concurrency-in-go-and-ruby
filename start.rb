#! /usr/bin/env ruby

require "tty_slides"

class TtySlides::SlideList
  BASE_PATH = Pathname.new(__FILE__) + ".." + "slides"

  SLIDES = [
    "introduction",
    "covermymeds",
    "cover-all-mymeds",
    "concurrency-in-go-pty-client",
    "concurrency-in-go-pty-server",
    "concurrency-in-go-pty-server-1",
    "concurrency-in-go-pty-server-2",
    "concurrency-in-go-pty-server-3",
  ]
end

TtySlides.new('[ Concurrency ]').start
