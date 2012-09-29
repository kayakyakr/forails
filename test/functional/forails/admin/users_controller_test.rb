require 'test_helper'

module Forails
  class Admin::UsersControllerTest < ActionController::TestCase
    test "should get search" do
      get :search
      assert_response :success
    end
  
    test "should get edit" do
      get :edit
      assert_response :success
    end
  
    test "should get update" do
      get :update
      assert_response :success
    end
  
  end
end
