class BaseController < ApplicationController
  def index
    Clndr.new(:full)
    @default = Clndr.new(:blank)
    @default.template = Clndr::Template::Blank
    @default.weak_offset = true
    Clndr.new(:custom_template).template = Clndr::Template.from_html('#custom-template')
  end
end
