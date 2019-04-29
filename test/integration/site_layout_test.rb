# frozen_string_literal: true

require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test 'layout links' do
    get root_path
    assert_template 'static_pages/home'
    assert_select 'a[href=?]', root_path, count: 2
    assert_select 'a[href=?]', help_path
    assert_select 'a[href=?]', users_path, 0
    assert_select 'a[href=?]', user_path(@user), 0
    assert_select 'a[href=?]', edit_user_path(@user), 0
    assert_select 'a[href=?]', logout_path, 0
    assert_select 'a[href=?]', login_path
    assert_select 'a[href=?]', about_path
    assert_select 'a[href=?]', contact_path

    assert_select '#following', 0
    assert_select '#followers', 0

    get contact_path
    assert_select 'title', full_title('Contact')
  end

  test 'layout links with login' do
    log_in_as(@user)
    get root_path
    assert_template 'static_pages/home'
    assert_select 'a[href=?]', root_path, count: 2
    assert_select 'a[href=?]', help_path
    assert_select 'a[href=?]', users_path
    assert_select 'a[href=?]', user_path(@user)
    assert_select 'a[href=?]', edit_user_path(@user)
    assert_select 'a[href=?]', logout_path
    assert_select 'a[href=?]', login_path, 0
    assert_select 'a[href=?]', about_path
    assert_select 'a[href=?]', contact_path

    assert_select '#following'
    assert_select '#followers'

    get contact_path
    assert_select 'title', full_title('Contact')
  end

  test 'access signup page' do
    get root_path
    assert_template 'static_pages/home'
    get signup_path
    assert_select 'title', full_title('Sign up')
  end
end
