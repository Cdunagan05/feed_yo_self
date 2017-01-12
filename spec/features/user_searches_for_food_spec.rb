require 'rails_helper'

RSpec.describe "When a user visits '/' and clicks search" do
  it "they are shown all the nutritional values for that food" do
    visit "/"

    fill_in "q", with: "Burger King Cheese Burger"
    click_on "How quickly will this kill me"

    expect(current_path).to eq("/compare")
    expect(page).to have_content("Calories: 380")
    expect(page).to have_content("Sugar: 5.97 grams")
    expect(page).to have_content("Fat: 19.70 grams")
  end
end
