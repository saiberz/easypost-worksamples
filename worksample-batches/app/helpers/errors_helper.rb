module ErrorsHelper
  def render_500(e)
    if Rails.env.development?
      raise e
    else
      render_error(EasyPost::Error::INTERNAL)
    end
  end

  def render_404
    render_error(EasyPost::Error::NOT_FOUND)
  end

  def render_403
    render_error(EasyPost::Error::FORBIDDEN)
  end

  def render_402
    render_error(EasyPost::Error::INSUFFICIENT_FUNDS)
  end

  def render_401
    render_error(EasyPost::Error::UNAUTHORIZED)
  end
end

