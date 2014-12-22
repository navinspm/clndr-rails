class Clndr
    class Engine < ::Rails::Engine
      #  add helpers
      initializer 'clndr.action_controller' do |app|
        ActiveSupport.on_load :action_controller do
          helper Clndr::Helpers
        end
      end
    end
end