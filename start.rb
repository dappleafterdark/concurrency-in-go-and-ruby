#! /usr/bin/env ruby

require "tty_slides"

class TtySlides::SlideList
  BASE_PATH = Pathname.new(__FILE__) + ".." + "slides"

  SLIDES = [
    "introduction",
    "covermymeds",
    "cover-all-mymeds",
  ]
end

TtySlides.new('[ Concurrency ]').start
