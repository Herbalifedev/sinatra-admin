Feature: User show
  In order to use SinatraAdmin
  As an Admin
  I want to remove user records when I register the "User" resource
  And I click on remove button

  Scenario: Admin tries to remove a user without login
    Given I add SinatraAdmin as middleware
    And I register "User" resource
    And I am an Admin
    And There are users
    When I go to users listing
    Then I should see "Sign in SinatraAdmin"
    And I should see "You must log in"

  Scenario: Admin removes user from list
    Given I add SinatraAdmin as middleware
    And I register "User" resource
    And I am an Admin
    And I am logged in as admin
    And There are users
    And I am on users listing
    When I click on Carlo remove button
    Then I should see "Users - Index"
    And I should see "_id"
    And I should see "first_name"
    And I should see "last_name"
    And I should see "email"
    And I should see "Francisco"
    And I should see "Delgado"
    And I should see "francisco@herbalife.com"
    And I should not see "Carlo"
    And I should not see "Cajucom"
    And I should not see "carlo@herbalife.com"
