Rails.application.routes.draw do

  get 'base/index'

  root "base#index"
end
