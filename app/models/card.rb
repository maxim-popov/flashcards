class CompareValidator < ActiveModel::Validator
  def validate(record)
    if record.original_text.downcase  == record.translated_text.downcase
      record.errors[:base] << "Original and Translated texts are equal"
    end
  end
end

class Card < ActiveRecord::Base
  before_validation :define_review_date
  validates :original_text,:translated_text, presence: true
  validates_with CompareValidator

  protected
  def define_review_date
    self.review_date = Time.now + 3.days
  end
end
