module SpecUtilities
  def log_in(user = nil)
    if user.nil?
      user = create(:super_admin)
    end

    visit root_path

    fill_in "Email Address", :with => user.email
    fill_in "Password", :with => user.password

    click_button "Log in"

    user
  end

  def auth_header(user = nil)
    if user.nil?
      user = Fabricate(:user)
    end

    user_session = UserSession.create_from_user(user)

    {
      "HTTP_ACCEPT" => "application/json",
      "HTTP_AUTHORIZATION" => "Token " + user_session.token
    }
  end

  def payload
    HashWithIndifferentAccess.new(JSON.parse(response.body)) rescue {}
  end

  def header
    response.header
  end

  def response_code
    response.code.to_i rescue nil
  end

  def debug_response
    divider = "#{"-" * 80}"

    puts divider + "> HEADER"
    puts response.header
    puts divider + "> PAYLOAD"
    puts response.body
    puts divider + "> RESPONSE CODE "
    puts response.code
    puts divider + "> TADA"
  end

  # Does a pp on the thing with title and other info to aid in debugging
  def debug_print(thing, title = nil, print_path = false)
    return if !%w[test development].include?(Rails.env)

    divider = "#{"-" * 80}"

    puts divider
    if title.present?
      puts %Q(#{title} (#{thing.class.name}))
    else
      puts thing.class.name
    end
    pp thing

    if print_path
      puts caller.first[0..caller.first.index(":in") - 1]
    end

    puts divider

    puts
  end
  alias_method :dp, :debug_print

  # Use to call a bunch of #debug_print statements to group them together.  Helpful when dealing with multiple files and
  # blocks of interest.
  def debug_print_wrapper(title = nil, print_path = true, &block)
    return if !%w[test development].include?(Rails.env)

    start_divider = "#{">" * 80}"
    end_divider = "#{"<" * 80}"


    if title.present?
      puts " #{title} ".upcase.center(80, start_divider[0])
    else
      puts start_divider
    end

    block.call

    if print_path
      puts " Wrapped from block call at: ".center(80, "-")
      puts caller.first[0..caller.first.index(":in") - 1]
    end

    puts end_divider
    puts
  end
  alias_method :dpw, :debug_print_wrapper

  def file_upload(file_name = nil, file_type = nil)
    file = file_name || "test_image.jpg"
    type = file_type || "image/jpg"

    Rack::Test::UploadedFile.new( Rails.root.join('spec', 'fixtures', 'files', file), file_type)
  end

  def gql(name_no_extension)
    File.read(File.join(Rails.root, "spec/requests/gql/queries", "#{name_no_extension}.gql"))
  end

  def expect_success
    expect(payload[:errors]).to be_nil
  end

  def saop
    save_and_open_page
  end

  def ssoi
    screenshot_and_open_image
  end

  def blows_up
    raise "Hell"
  end

  alias_method :blow_up, :blows_up

  def select_sidebar_subitem(title, subitem)
    within("#primary-sidebar") do
      find("li[data-tooltip-text=\"#{title}\"]").click
    end

    click_link subitem
  end
end
