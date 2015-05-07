module Kramdown
  module Converter
    class Achtml < Html

      def convert_p(el, indent)
        if el.children.size == 1 && el.children.first.type == :img
          convert_img(el, indent)
        else
          super
        end
      end

      def convert_img(el, indent)
        img_el = el.children.first
        id = el.attr.delete('id')
        id_el = id.nil? ? '' : %( id="#{id}")
        klass = el.attr.delete('class')
        klass_el = klass.nil? ? '' : %( class="#{klass}")

        output = [%(<figure#{id_el}#{klass_el}>)]
        output << %(<img#{html_attributes(img_el.attr)} />)
        unless (alt = img_el.attr['alt']).strip.empty?
          output << "<figcaption>#{alt}</figcaption>"
        end
        output << '</figure>'

        output * "\n"
      end

    end
  end
end
