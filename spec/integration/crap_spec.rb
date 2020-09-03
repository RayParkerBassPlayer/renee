require "rails_helper"

describe "Crap" do
  it "craps" do
    user = create(:user)

    visit root_path

    click_link user.name

    expect(current_path).to eq blogs_path 
  end
end
