# -*- ruby -*-

require 'rubygems'
require 'hoe'
require './lib/badger.rb'

Hoe.new('badger', Badger::VERSION) do |p|
  p.rubyforge_name = 'codefluency'
  p.summary = "Badger is a library used to generate badge sheets for events, given a PDF template and data for the badges."
  p.description = p.paragraphs_of('README.txt', 2..5).join("\n\n")
  p.url = p.paragraphs_of('README.txt', 0).first.split(/\n/)[1..-1]
  p.changes = p.paragraphs_of('History.txt', 0..1).join("\n\n")
  p.extra_deps = [['activesupport', '>= 1.3.1']]
  p.email = %q{bruce@codefluency.com}
  p.author = "Bruce Williams"
end

# vim: syntax=Ruby
