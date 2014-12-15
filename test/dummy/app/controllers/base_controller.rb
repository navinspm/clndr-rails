class BaseController < ApplicationController
  def index
    Clndr.new(:full).start_with_month= Time.now-1.year
    @default = Clndr.new(:blank)
    @default.template = Clndr::Template::Blank
    @default.weak_offset = true
    @default.start_with_month= nil
    Clndr.new(:custom_template).template = Clndr::Template.from_html('#custom-template')
  end
end
