require "rails_helper" 

describe "blog_management" do 
  it "shows a list of a user's blogs" do 
    user = create(:user)
    create_list(:blog, 10, :user => user)

    visit root_path

    click_link user.name

    expect(page).to have_content(user.blogs.first.title)
  end

  it "navigates to blog detail through the blog index" do
    user = create(:user)
    blogs = create_list(:blog, 10, :user => user)
    blog = blogs.first
  
    visit root_path

    click_link user.name
    click_link blog.title
  
    expect(current_path).to eq blog_path(blog)
    expect(page).to have_content(blog.title)
    expect(page).to have_content(blog.body)
  end

  it "allows creation of a blog", :focus do
    user = create(:user)
    blog_attributes = build(:blog)

    visit root_path
    click_link user.name

    # Now create a new blog
    click_link "New Blog"
    saop
    fill_in "Title", :with => blog_attributes.title
    fill_in "Body", :with => blog_attributes.body
    click_button "Create Blog"

    expect(current_path).not_to eq new_blog_path
    expect(page).to have_content(blog_attributes.title)
  end
end
