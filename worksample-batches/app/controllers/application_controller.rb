class ApplicationController < ActionController::Base
  protect_from_forgery

  include SessionsHelper
  include ErrorsHelper

  helper_method :current_mode
  helper_method :current_api_key

  around_filter EasyPost::Job

  rescue_from Exception, with: :render_500
  rescue_from StandardError, with: :render_500
  rescue_from EasyPost::Error::Base, with: :render_error

  def current_api_key
    @api_key ||= ApiKey.find_by_key(decode_api_key)
  end

  def current_mode
    @mode ||= select_mode
  end

  def render_result(name, context, opts = {})
    if context.success?
      render({json: context.public_send(name)}.merge(opts))
    else
      render_error context.error, context.errors
    end
  end

  def render_error(error)
    respond_to do |format|
      format.html { render status: error.http_status }
      format.json { render status: error.http_status, json: ErrorPresenter.new(error) }
    end
  end

  private

  def select_mode
    api_mode = current_api_key.try(:mode).try(:to_sym)
    params_mode = params.fetch(:mode, nil).try(:to_sym)

    if api_mode && params_mode && api_mode != params_mode
      render_error EasyPost::Error::Mode::CONFLICT
      nil
    else
      api_mode || params_mode || EasyPost::ApiMode::TEST
    end
  end

  def decode_api_key
    if request.headers && request.headers['Authorization']
      auth_tokens = request.headers['Authorization'].split

      if auth_tokens[0] == "Basic" && auth_tokens.length >= 2
        decoded = Base64.decode64(auth_tokens[1])
        decoded = decoded[0..-2] if decoded[-1] == ':'
      elsif auth_tokens[0] == "Bearer" && auth_tokens.length >= 2
        decoded = auth_tokens[1]
        decoded = decoded[0..-2] if decoded[-1] == ':'
      else
        decoded = ""
      end
    elsif params[:api_key]
      decoded = params[:api_key]
    end

    decoded
  end
end

