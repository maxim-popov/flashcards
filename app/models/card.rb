class CompareValidator < ActiveModel::Validator
  def validate(record)
    if record.original_text.downcase  == record.translated_text.downcase
      record.errors[:base] << "Original and Translated texts are equal"
    end
  end
end

class Card < ActiveRecord::Base
  before_validation :define_review_date
  validates :original_text, :translated_text, presence: true
  validates_with CompareValidator
  scope :time_to_check_card, -> { where("review_date < ?", Time.zone.now).order("RANDOM()")}

  def check_translation(user_input)
    return false ? user_input == self.translated_text : self.define_review_date && self.save
  end

  protected
  def define_review_date
    self.review_date = Time.zone.now + 3.days
  end
end
