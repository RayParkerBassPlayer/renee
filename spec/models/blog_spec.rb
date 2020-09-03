require "rails_helper"

describe Blog do
  describe "structure and validation" do
    it "validates its validatables" do
        should validate_presence_of(:title)
        should validate_presence_of(:body)
    end

    it "has its relationships" do 
        should belong_to(:user)
    end 
  end
end
