# encoding: utf-8
class CompareValidator < ActiveModel::Validator
  def validate(record)
    if record.original_text.mb_chars.downcase  == record.translated_text.mb_chars.downcase
      record.errors[:base] << "Original and Translated texts are equal"
    end
  end
end

class Card < ActiveRecord::Base
  before_create :set_review_date
  validates :original_text, :translated_text, presence: true
  validates_with CompareValidator
  scope :time_to_check_card, -> { where("review_date < ?", Time.zone.now).order("RANDOM()")}

  def check_translation(user_input)
    user_input.mb_chars.downcase == self.translated_text.mb_chars.downcase
  end

  def set_review_date
    self.review_date = Time.zone.now + 3.days
  end
end
