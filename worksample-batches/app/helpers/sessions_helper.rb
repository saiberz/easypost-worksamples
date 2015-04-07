module SessionsHelper
  def signed_in?
    current_user.present?
  end

  def current_user
    current_api_key.try(:user)
  end

  def ensure_signed_in
    render_error EasyPost::Error::UNAUTHORIZED unless signed_in?
  end
end

