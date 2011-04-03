require "sinatra/base"
require "haml"
require "grit"
require "rdiscount"

module GitWiki
  class << self
    attr_accessor :homepage, :extension, :repository
  end

  def self.new(repository, extension, homepage)
    self.homepage   = homepage
    self.extension  = extension
    self.repository = Grit::Repo.new(repository)

    App
  end
end

require_relative "wiki/page_not_found"
require_relative "wiki/page"
require_relative "wiki/app"