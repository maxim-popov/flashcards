class Compare_Validator < ActiveModel::Validator
  def validate(record)
    if record.translated_text.downcase  == record.original_text.downcase
      record.errors[:base] << "Translated and Original texts are identic"
    end
  end
end


class Card < ActiveRecord::Base
	validates_with Compare_Validator
end
