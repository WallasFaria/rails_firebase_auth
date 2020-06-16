class User < ApplicationRecord
  has_one_attached :avatar

  with_options presence: true, on: :update do
    validates :name
    validates :email
    validates :phone
  end
end
