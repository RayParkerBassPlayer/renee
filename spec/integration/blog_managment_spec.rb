require "rails_helper" 

describe "blog_management" do 
    it "shows a list of a user's blogs" do 
        user = create(:user)
  
        create_list(:blog, 10, :user => user)

        visit root_path
    
        click_link user.name
    
        expect(page).to have_content(user.blogs.first.title)
    end
end
