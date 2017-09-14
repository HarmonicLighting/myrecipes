class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      record.errors[attribute] << (options[:message] || "is not an email")
    end
  end
end

class Chef < ApplicationRecord
  has_many :recipes
  validates :name, :password_digest, presence: true, length: {maximum: 30}
  validates :email, presence: true, uniqueness: true, case_sensitive: false, email: true
  before_save {self.email = self.email.downcase}
end
