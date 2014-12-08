include ActionController::HttpAuthentication::Token::ControllerMethods
include ActionController::MimeResponds


class ApplicationController < ActionController::API
  include ActionController::ImplicitRender
end
