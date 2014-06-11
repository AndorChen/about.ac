module Jekyll
  module Converters
    class Markdown
      class MyKramdown
        def initialize(config)
          require 'kramdown'
          @config = config
        rescue LoadError
          STDERR.puts 'You are missing a library required for Markdown. Please run:'
          STDERR.puts '  $ [sudo] gem install kramdown'
          raise FatalException.new("Missing dependency: kramdown")
        end

        def convert(content)
          ::Kramdown::Document.new(content, Utils.symbolize_hash_keys(@config["kramdown"])).to_myhtml
        end

      end
    end
  end
end

module Kramdown
  module Parser
    class MyMarkdownParser < Kramdown

      def initialize(source, options)
        super
        @block_parsers.unshift(:gfm_codeblock_fenced)
      end

      GFM_FENCED_CODEBLOCK_START = /^`{3,}/
      GFM_FENCED_CODEBLOCK_MATCH = /^(`{3,})\s*?(\w+)?\s*?\n(.*?)^\1`*\s*?\n/m

      # Parser the GitHub Flavored Markdown fenced code block.
      #
      # Examples
      #
      #   ```ruby
      #   def hello
      #     puts 'Hello'
      #   end
      #   ```
      #
      def parse_gfm_codeblock_fenced
        if @src.check(GFM_FENCED_CODEBLOCK_MATCH)
          @src.pos += @src.matched_size
          el = new_block_el(:codeblock, @src[3])
          lang = @src[2].to_s.strip
          el.attr['lang'] = lang unless lang.empty?
          @tree.children << el
          true
        else
          false
        end
      end
      define_parser(:gfm_codeblock_fenced, GFM_FENCED_CODEBLOCK_START)

    end
  end
end

module Kramdown
  module Converter
    class Myhtml < Html

      # Converts the codeblock to HTML, using rouge to highlight.
      #
      def convert_codeblock(el, indent)
        require 'rouge'
        attr = el.attr.dup
        lang = attr['lang']
        lang = 'text' if lang.nil? || lang.empty?
        title = attr['title']
        code = ::Rouge.highlight(el.value, lang, 'html') << "\n"

        output = "<div class=\"codeblock #{lang}"
        output << ' has-caption' if title
        output << '">'
        if title
          title_el = ::Kramdown::Parser::DCKramdown.parse(title).first
          title_html = inner(title_el.children.first, 0)
          output << "<p class=\"caption\">#{title_html}</p>"
        end
        output << "#{code}</div>"
      end

    end
  end
end
