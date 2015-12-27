module Jekyll
  module Converters
    class Markdown
      class ACKramdownParser < KramdownParser

        def convert(content)
          Kramdown::Document.new(content, Utils.symbolize_hash_keys(@config)).to_achtml
        end

      end
    end
  end
end
