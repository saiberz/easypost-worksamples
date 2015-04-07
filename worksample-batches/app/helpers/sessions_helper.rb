module SessionsHelper
  def signed_in?
    current_user.present?
  end

  def current_user
    current_api_key.try(:user)
  end

  def ensure_signed_in
    if !signed_in?
      respond_to do |format|
        format.json { render_error EasyPost::Error::UNAUTHORIZED }
      end
    end
  end
end

