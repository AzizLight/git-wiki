#!/usr/bin/env rackup
require File.join(File.dirname(__FILE__), "lib/wiki")

repository = File.expand_path(ARGV[1] || "~/.wiki")
extension  = ARGV[2] || ".markdown"
homepage   = ARGV[3] || "Home"
run GitWiki.new(repository, extension, homepage)
