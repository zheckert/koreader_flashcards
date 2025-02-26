class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Currently, each user gets one CSV at a time.
  has_one_attached :csv_file

  # A user can have as many flashcards as there are words in their upload.
  has_many :flashcards
end
