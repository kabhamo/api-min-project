class Person < ApplicationRecord
	has_many :tasks, foreign_key: :owner_id
	validates_uniqueness_of :email
end
