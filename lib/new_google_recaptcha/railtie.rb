module NewGoogleRecaptcha
  class Railtie < ::Rails::Railtie
    initializer 'new_google_recaptcha.helpers' do
      ActiveSupport.on_load :action_view do
        ActionView::Base.send :include, NewGoogleRecaptcha::ViewExt
        ActionController::Base.send :include, NewGoogleRecaptcha::ControllerExt
      end
    end
  end
end
