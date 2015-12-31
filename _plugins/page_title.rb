module Jekyll
  module PageTitleFilter

    def get_title(page)
      title = page['title']

      if page['layout'] == 'book'
        site = @context.registers[:site]
        book_cat = page['book_category']
        book_slug = page['id'].split('/').last
        book = site.data['books'][book_cat][book_slug]
        title = book['title']
      end

      return "#{title} - " if title

      nil
    end

  end
end

Liquid::Template.register_filter(Jekyll::PageTitleFilter)
