class BaseController < ApplicationController
  def index
    Clndr.new(:simple)
  end
end
