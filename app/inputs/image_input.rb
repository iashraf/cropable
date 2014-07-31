class ImageInput
	include Formtastic::Inputs::Base

	def to_html
    input_wrapping do
      output = label_html <<
      builder.file_field(method, input_html_options)


      unless @object.new_record? or @object.send( @method ).blank?
        cropable = @object.respond_to? "#{method}_x"

        output << "<div class=\"image-input-container\">".html_safe

        output << "<a class=\"modal\" href=\"#{ Rails.application.routes.url_helpers.crop_admin_product_path( @object, image: method, style: @options[:style] ) }\">".html_safe if cropable

        output << "<img class=\"image-input-image\" src=\"#{@object.send( @method ).url @options[:style] }\" />".html_safe

        output << "</a><p class=\"inline-hints\">Click image to crop</p>".html_safe if cropable

        output << "</div>".html_safe
      end

      output
    end
	end

end
# , hint: "#{ link_to "Crop", crop_admin_product_path(resource, image: :listing), class: "modal" }".html_safe