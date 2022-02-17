module PatchFormatUrl; end # Just place here to let the warning shutting up

module Bridgetown
  module Resource
    class Base
      private
      # Monkey patching `format_url' method in Bridgetown core
      # DO NOT remove `.html' from the end of URL
      def format_url(url)
        url.to_s.sub(%r{index\.html?$}, "")
      end
    end
  end
end
