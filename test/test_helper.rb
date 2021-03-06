ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/reporters'
require 'minitest/autorun'
require 'shoulda/context'

# defaults to using `Minitest::Reporters::ProgressReporter.new`
Minitest::Reporters.use! 

class ActiveSupport::TestCase
  include ActionView::Helpers::NumberHelper
  
  ##
  # Setup all fixtures in test/fixtures/*.yml for all tests in
  # alphabetical order.
  fixtures :all

  # Returns true if a test user is logged in.
  # ---
  # Separate from 'logged_in?' session_helper method, b/c session
  # helper methods not available in tests
  def is_logged_in?
    !session[:user_id].nil?
  end


  # Logs in a test user.
  def log_in_as(user, options = {})
    password    = options[:password]    || 'password'
    remember_me = options[:remember_me] || '1'
    if integration_test?
      post login_path, session: { email:       user.email,
                                  password:    password,
                                  remember_me: remember_me }
    else
      session[:user_id] = user.id
    end
  end


  private #-------------------------------------------------------

    # Returns true inside an integration test.
    def integration_test?
      defined?(post_via_redirect)
    end

end
