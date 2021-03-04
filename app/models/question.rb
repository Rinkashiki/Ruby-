class Question < ApplicationRecord

    belongs_to :clip

    has_many :answers
    
    has_and_belongs_to_many :activities
end
