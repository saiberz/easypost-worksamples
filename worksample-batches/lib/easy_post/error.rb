module EasyPost
  module Error
    INTERNAL = EasyPost::Error::Base.new(500,
      "INTERNAL_SERVER_ERROR",
      "We're sorry, something went wrong. If the problem persists please " <<
      "contact us at support@easypost.com.")
    NOT_FOUND = EasyPost::Error::Base.new(404,
      "NOT_FOUND",
      "The requested resource could not be found.")
    FORBIDDEN = EasyPost::Error::Base.new(403,
      "FORBIDDEN",
      "Unable to access the requested resource.")
    INSUFFICIENT_FUNDS = EasyPost::Error::Base.new(402,
      "INSUFFICIENT_FUNDS",
      "We're sorry, your account balance contains insufficient funds to " <<
      "perform this operation.")
    UNAUTHORIZED = EasyPost::Error::Base.new(401,
      "UNAUTHORIZED",
      "Unable to access the requested resource, authorization failed.")
  end
end

