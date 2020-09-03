require "rails_helper"

describe User do
  describe "structure and validation" do
    it "validates its validatables" do
      should validate_presence_of(:name)
      should validate_presence_of(:email)
      should validate_uniqueness_of(:email)
    end

    it "has its relationships" do 
      should have_many(:blogs)
    end 
  end
end
