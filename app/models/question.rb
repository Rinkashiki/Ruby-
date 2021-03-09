class Question < ApplicationRecord

    has_one :clip

    has_many :answers
    
    has_and_belongs_to_many :activities
end
