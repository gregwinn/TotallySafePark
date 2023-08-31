class User < ApplicationRecord
  acts_as_token_authenticatable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: %i[doctor scientist builder goldblum]

  def full_name
    "#{first_name} #{last_name}"
  end
end
