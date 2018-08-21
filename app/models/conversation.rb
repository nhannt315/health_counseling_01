class Conversation < ApplicationRecord
  has_many :messages, dependent: :destroy
  belongs_to :sender, foreign_key: :sender_id, class_name: User.name
  belongs_to :receiver, foreign_key: :receiver_id, class_name: User.name

  validates :sender_id, uniqueness: {scope: :receiver_id}

  scope :between, lambda{|s_id, r_id|
    where(sender_id: s_id, receiver_id: r_id).or(
      where(sender_id: r_id, receiver_id: s_id)
    )
  }

  def self.get s_id, r_id
    conversation = between(s_id, r_id).first
    return conversation if conversation.present?
    create(sender_id: s_id, receiver_id: r_id)
  end

  def opposed_user user
    user == receiver ? sender : receiver
  end

end
