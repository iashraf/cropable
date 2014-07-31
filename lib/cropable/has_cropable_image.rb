module Cropable
  module Model

    def self.included(base)
      base.send :extend, ClassMethods
    end

    module ClassMethods

      def has_cropable_image
        include Cropable::CropableConcern
      end

    end

  end
end