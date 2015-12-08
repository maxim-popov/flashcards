# encoding: utf-8
require 'rails_helper'
require 'capybara/rspec'

describe "visiting /check page" do
  let(:card) { create(:card) }
  it "put wrong answer" do
    visit '/check'
    #puts body
    fill_in 'user_input_translation', with: card.translated_text
    click_button 'Check'
    expect(page).to have_content 'Right translation'
  end
end
