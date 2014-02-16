#! /usr/bin/env ruby

require "tty_slides"

class TtySlides::SlideList
  BASE_PATH = Pathname.new(__FILE__) + ".." + "slides"

  SLIDES = [
    "test_pattern",
    "introduction",
    "covermymeds",
    "cover-all-mymeds",
    "pictures",
    "threads",
    "processes",
    "concurrency-in-go-pty-client",
    "concurrency-in-go-pty-server",
    "concurrency-in-go-pty-server-1",
    "concurrency-in-go-pty-server-2",
    "concurrency-in-go-pty-server-3",
    "the-pattern",
    "pipes",
    "synchronization",
    "api-demo",
    "test-server",
    "desired-interface",
    "desired-interface-1",
    "desired-interface-2",
    "desired-interface-3",
    "desired-interface-4",
    "fake-slide",
    "fin",
  ]

  GO_SLIDES = [
    "example-go",
    "example-go",
    "example-go-1",
    "example-go-2",
    "example-go-3",
    "example-go-4",
    "example-go-5",
    "example-go-6",
    "example-go-7",
    "example-go-8",
    "example-go-9",
    "example-go-10",
  ]
end

TtySlides.new('[ Concurrency ]').start
