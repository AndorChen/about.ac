module Jekyll
  module TagFilters

    def tag_name(tag)
      slug = Jekyll::Utils.slugify(tag)

      meta = @context.registers[:site].data['meta']['tags']
      slugs = meta.map { |e| e['slug'] }

      return tag unless slugs.include?(slug)

      meta.select { |e| e['slug'] == slug }.first['name']

    end

  end
end

Liquid::Template.register_filter(Jekyll::TagFilters)
