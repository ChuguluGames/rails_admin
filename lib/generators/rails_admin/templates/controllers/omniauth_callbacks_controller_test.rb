require 'test_helper'

class Users::OmniauthCallbacksControllerTest < ActionController::TestCase
  def setup
    @access_token = OpenStruct.new(:info => {})
    @valid_email = "user@chugulu.com"
    @invalid_email = "user@anothercompany.com"
  end

  test "should connect via google if email is valid" do
    @access_token.info['email'] = @valid_email
    @controller.request.env["omniauth.auth"] = @access_token
    @controller.expects(:current_admin_user).at_least_once.returns(nil)
    @controller.expects(:sign_in_and_redirect).at_least_once
    @controller.send(:google)
  end

  test "should not connect via google if email is invalid" do
    @access_token.info['email'] = @invalid_email
    @controller.request.env["omniauth.auth"] = @access_token
    @controller.expects(:current_admin_user).at_least_once.returns(nil)
    @controller.expects(:redirect_to).at_least_once
    @controller.send(:google)
  end
end
