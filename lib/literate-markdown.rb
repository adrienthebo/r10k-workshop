require 'kramdown'

module Literate
  class Markdown
    def initialize(path, comment: '#', keeptext: true)
      @path = path
      @comment = comment
      @keeptext = keeptext
    end

    def code
      doc.root.children.map do |section|
        case section.type
        when :header
          header(section)
        when :p
          p(section)
        when :blank
          section.value if @keeptext
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
      if @keeptext
        "\n#{@comment} h#{element.options[:level]}. " + element.children.first.value + "\n"
      end
    end

    def p(element)
      istext = false
      text = element.children.map do |c|
        case c.type
        when :text
          istext = true
          c.value
        when :codespan
          c.value
        when :smart_quote
          istext = true
          "'"
        else
          c.value
        end
      end.join('')

      if istext
        if @keeptext
          text.gsub(/^/, "#{@comment} ")
        else
          ''
        end
      else
        text
      end
    end
  end
end
