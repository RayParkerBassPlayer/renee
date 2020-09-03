require "rails_helper"

describe "Crap" do
  it "craps" do
    visit root_path

    expect(page).to have_content(/renee/i)
  end
end
