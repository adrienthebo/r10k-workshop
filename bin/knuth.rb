#!/usr/bin/env ruby

require 'kramdown'

doc = Kramdown::Document.new(File.read(ARGV[0]))

sections = doc.root.children.select { |c| c.type == :p }

text = sections.map { |c| c.children }.flatten.map do |c|
  case c.type
  when :text
    "\n# #{c.value}\n"
  when :codespan
    c.value
  else
    c.value
  end
end.join

puts text
