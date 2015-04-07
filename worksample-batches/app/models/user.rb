require 'digest/md5'

class User < ActiveRecord::Base
  include Concerns::PublicID

  attr_protected

  has_secure_password

  has_many :api_keys, dependent: :destroy
  has_many :addresses
  has_many :batches
  has_many :rates
  has_many :parcels
  has_many :postage_labels
  has_many :shipments

  validates :name, presence: {message: "Name required."},
    length: {maximum: 254, message: "Provided name is too long. (254 char limit)."}
  validates :email, presence: {message: "Email address required."},
    length: {maximum: 254, message: "Email is too long (254 char limit)."},
    uniqueness: {case_sensitive: false, message: "A user already exists with this email."}
  validates :password, presence: {message: "Password is required."}, on: :create
  validates :password, length: {minimum: 8, maximum: 254, message: "Password must be between 8 and 254 characters."},
    if: :validate_password?
  validate :password_matches_confirmation, if: :validate_password?
  validates :password_confirmation, presence: { message: "Password confirmation is required." }, on: :create

  after_validation do
    # Capitalize first letter in all error messages.
    self.errors.each do |key, value|
      if value.is_a?(Hash)
        value.each do |key2, value2|
          value2[0] = value2[0].capitalize
        end
      elsif value.is_a?(String)
        value[0] = value[0].capitalize
      end
    end
  end

  before_save do
    self.email = email.downcase
  end

  after_create :create_api_keys

  def self.public_id_prefix
    "user"
  end

  def as_json(options = {})
    UserPresenter.new(self).as_json(options)
  end

  def test_api_key
    api_keys.where(mode: EasyPost::ApiMode::TEST).first.try(:key)
  end

  def production_api_key
    api_keys.where(mode: EasyPost::ApiMode::PRODUCTION).first.try(:key)
  end

  private

  def create_api_keys
    self.api_keys.build(mode: EasyPost::ApiMode::TEST).save!
    self.api_keys.build(mode: EasyPost::ApiMode::PRODUCTION).save!
  end

  def validate_password?
    password.present? || password_confirmation.present?
  end

  def password_matches_confirmation
    errors.add(:password_confirmation, "Password and confirmation must match") if password != password_confirmation
  end

end

