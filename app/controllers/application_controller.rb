class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_user!

  decent_configuration do
    strategy DecentExposure::StrongParametersStrategy
  end

  include MoneyRoutines

end
