module Jekyll
  class FigureURLTag < Liquid::Tag

    def initialize(tag_name, text, tokens)
      super
      @img_path = text
    end

    def render(context)
      site = context.registers[:site]

      "#{site.baseurl}/assets/images/figures/#{@img_path}"
    end
  end
end

Liquid::Template.register_tag('figure_url', Jekyll::FigureURLTag)
