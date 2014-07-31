module Cropable
  module CropableConcern

    extend ActiveSupport::Concern
    
    included do

    end

    def image_geometry(field = :image, style = :original)
      @geometry ||= {}
      @geometry[ field ] ||= {}
      @geometry[ field ][ style ] ||= Paperclip::Geometry.from_file( self.send( field.to_s ).url( style ) )
    end

    def reprocess!(params)
      style = params[:style]
      
      iw = params[:w].to_i
      ih = params[:h].to_i

      geometry = self.image_geometry style

      r_params = params[ self.class.name.underscore ]

      if false and iw == geometry.width
        self.update_columns r_params
      else
        diff = geometry.width / iw

        x_name = "#{style}_x"
        y_name = "#{style}_y"
        w_name = "#{style}_w"
        h_name = "#{style}_h"

        x = r_params[ x_name ].to_i * diff
        y = r_params[ y_name ].to_i * diff
        w = r_params[ w_name ].to_i * diff
        h = r_params[ h_name ].to_i * diff

        self.update_columns x_name => x,
          y_name => y,
          w_name => w,
          h_name => h
      end

      self.send( style ).reprocess!
    end

  end
end