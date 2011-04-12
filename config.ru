require File.dirname(__FILE__) + "/git-wiki"

require 'rubygems'
require 'bundler'

Bundler.require

run GitWiki.new(File.expand_path(ENV['WIKI_PATH'] || "~/wiki"),
  ENV['WIKI_EXT'] || ".markdown", ENV['WIKI_HOMEPAGE'] || "Home")
