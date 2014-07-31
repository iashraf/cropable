require 'rails/generators/active_record'

class CropableGenerator < ActiveRecord::Generators::Base
  desc "Add image dimensions"

  argument :image_name, :required => true, :type => :string, :desc => "Image name",
             :banner => "image"

  def self.source_root
    @source_root ||= File.expand_path('../templates', __FILE__)
  end

  def generate_migration
    migration_template "cropable_migration.rb.erb", "db/migrate/#{migration_file_name}"
  end

  def migration_name
    "add_cropable_#{image_name}_to_#{name.underscore.pluralize}"
  end

  def migration_file_name
    "#{migration_name}.rb"
  end

  def migration_class_name
    migration_name.camelize
  end
end