Feature: Users change password
  In order to use SinatraAdmin
  As an Admin
  I want to change users password when I register the "User" resource

  Scenario: Admin tries to edit a record without login
    Given I add SinatraAdmin as middleware
    And I register "User" resource
    And I am an Admin
    And I got role "read, edit"
    And There are users
    When I go to users listing
    Then I should see "Sign in SinatraAdmin"
    And I should see "You must log in"

  Scenario: Admin change password without errors
    Given I add SinatraAdmin as middleware
    And I register "User" resource
    And I am an Admin
    And I am logged in as admin
    And I got role "read, edit"
    And There are users
    And I am on users listing
    And I click on Carlo id
    When I follow "Change Password"
    And I should see "User - Change Password"
    And I fill in "password" with "admin1234"
    And I press "Change Password"
    And I click OK on the popup dialog
    Then I should see "User - Show"
    And I should see "_id"
    And I should see "first_name"
    And I should see "last_name"
    And I should see "email"
    And I should see "Carlo"
    And I should see "Cajucom"
    And I should see "carlo@herbalife.com"

  Scenario: Admin change password with errors
    Given I add SinatraAdmin as middleware
    And I register "User" resource
    And I am an Admin
    And I am logged in as admin
    And I got role "read, edit"
    And There are users
    And I am on users listing
    And I click on Carlo id
    When I follow "Change Password"
    And I should see "User - Change Password"
    And I fill in "password" with ""
    And I press "Change Password"
    And I click OK on the popup dialog
    Then I should see "password ["can't be blank"]"
