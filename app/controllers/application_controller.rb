class ApplicationController < ActionController::Base
	protect_from_forgery

	before_filter :authenticate_user!

	decent_configuration do
		strategy DecentExposure::StrongParametersStrategy
	end

	include MoneyRoutines



	rescue_from CanCan::AccessDenied do |exception|
		log_error
		render "home/403"
	end

	rescue_from Mongoid::Errors::DocumentNotFound do |exception|
		log_error
		render "home/404"
	end

private
	def log_error
		logger.error exception
	end
end
