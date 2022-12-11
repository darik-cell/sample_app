require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: {
        name: "",
        email: "invalid@mail",
        password: "boo",
        password_confirmation: "foo"
      }
    end
    assert_template 'users/new'
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: { 
        name: "Valid User",
        email: "valid@email.com",
        password: "morethansixcharacters",
        password_confirmation: "morethansixcharacters"
       }
    end
    assert_template 'users/show'
  end
end

