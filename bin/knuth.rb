#!/usr/bin/env ruby

$LOAD_PATH << File.expand_path("../../lib", __FILE__)

require 'literate-markdown'

if ARGV.count != 1
  $stderr.puts "Usage: #{File.basename($0)} file-to-convert.mkd"
  exit 1
end

doc = Literate::Markdown.new(ARGV[0])
puts doc.code
