require 'rails/generators/base'

class Clndr::InstallGenerator < Rails::Generators::Base
	source_root File.expand_path("../", __FILE__)

	def create_initializer_file
	  copy_file "clndr_initializer.rb", "config/initializers/clndr.rb"
	end
end

