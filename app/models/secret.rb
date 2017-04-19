class Secret < ActiveRecord::Base
    has_many :likes, dependent: :destroy
    belongs_to :user

    validates :content, presence: true, length: {minimum: 5}
end
