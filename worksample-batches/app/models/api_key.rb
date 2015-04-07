class ApiKey < ActiveRecord::Base
  include Concerns::UserOwnable
  include Concerns::Moded

  attr_protected # all attrs are accessible

  belongs_to :user

  before_validation :set_defaults
  validates :key, presence: true, length: {minimum: 9, maxiumum: 254}, uniqueness: {case_sensitive: true}

  private

  def set_defaults
    self.key ||= gen_key
  end

  def gen_key
    sprintf("%09d", (rand * 1000000000).round)
  end

end

