# encoding: utf-8
require "rails_helper"

RSpec.describe Card, type: :model do
  context "#check_translation method" do
    let(:card) {card = Card.new(original_text: "USA", translated_text: "Америка") }
    
    it "should be corret" do
      expect(card.check_translation("АмЕрика")).to eq(true)
    end

    it "should not pass the test" do
      expect(card.check_translation("америк")).to eq(false)
    end
  end
end