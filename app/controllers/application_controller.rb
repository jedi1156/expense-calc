class ApplicationController < ActionController::Base
	protect_from_forgery

	before_filter :authenticate_user!

	decent_configuration do
		strategy DecentExposure::StrongParametersStrategy
	end

	include MoneyRoutines


	rescue_from CanCan::AccessDenied do |exception|
		logger.error exception
		render "home/403"
	end

	rescue_from Mongoid::Errors::DocumentNotFound do |exception|
		logger.error exception
		render "home/404"
	end
end
