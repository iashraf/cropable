require "cropable/version"
require "cropable/cropable_concern"
require "cropable/has_cropable_image"
require "cropable/railtie" if defined?(Rails)

module Cropable
  class Engine < ::Rails::Engine
  end
end

ActiveSupport.on_load(:active_record) do
  include Cropable::Model
end