require 'test_helper'

class PasswordResetsTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
    @user = users(:alexander)
  end

  test "password resets" do
    get new_password_reset_path
    assert_template 'password_resets/new'
    # Неверный адрес электронной почты
    post password_resets_path, password_reset: { email: "" }
    assert_not flash.empty?
    assert_template 'password_resets/new'
    # Правильный адрес электронной почты
    post password_resets_path, password_reset: { email: @user.email }
    assert_not_equal @user.reset_digest, @user.reload.reset_digest
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_not flash.empty?
    assert_redirected_to root_url
    # Форма смены пароля
    user = assigns(:user)
    # Неверный email
    get edit_password_reset_path(user.reset_token, email: "")
    assert_redirected_to root_url
    # Неактивный пользователь
    user.toggle!(:activated)
    get edit_password_reset_path(user.reset_token, email: user.email)
    assert_redirected_to root_url
    user.toggle!(:activated)
    # Верный email, неправильный токен
    get edit_password_reset_path('wrong token', email: user.email)
    assert_redirected_to root_url
    # Верный email, правильный токен
    get edit_password_reset_path(user.reset_token, email: user.email)
    assert_template 'password_resets/edit'
    assert_select "input[name=email][type=hidden][value=?]", user.email
    # Невалидный пароль & подтверждение
    patch password_reset_path(user.reset_token),
          email: user.email,
          user: { password:              "foobaz",
                  password_confirmation: "barquux" }
    assert_select 'div#error_explanation'
    # Пустой пароль
    patch password_reset_path(user.reset_token),
          email: user.email,
          user: { password:              "",
                  password_confirmation: "" }
    assert_select 'div#error_explanation'
    # Валидный пароль & подтверждение
    patch password_reset_path(user.reset_token),
          email: user.email,
          user: { password:              "foobaz",
                  password_confirmation: "foobaz" }
    assert is_logged_in?
    assert_not flash.empty?
    assert_redirected_to user
  end
end