require 'kramdown'

module Literate
  class Markdown
    def initialize(path, comment: '#', text: :keep)
      @path = path
      @comment = comment
      @text = text
    end

    def code
      doc.root.children.map do |section|
        case section.type
        when :header
          header(section)
        when :p
          p(section)
        end
      end.compact.join
    end

    def doc
      Kramdown::Document.new(text)
    end

    def text
      File.read(@path)
    end

    private

    def header(element)
      element.children.first.value
    end

    def p(element)
      element.children.map do |c|
        case c.type
        when :text
          "\n#{@comment} #{c.value}\n" if @text == :keep
        when :codespan
          c.value
        else
          c.value
        end
      end.join
    end
  end
end
