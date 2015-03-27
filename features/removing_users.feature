Feature: User show
  In order to use SinatraAdmin
  As an Admin
  I want to remove user records when I register the "User" resource
  And I click on remove button

  Scenario: Admin tries to remove a user without login
    Given I add SinatraAdmin as middleware
    And I register "User" resource
    And I am an Admin
    And I got role "read, remove"
    And There are users
    When I go to users listing
    Then I should see "Sign in SinatraAdmin"
    And I should see "You must log in"

  Scenario: Admin removes user from list
    Given I add SinatraAdmin as middleware
    And I register "User" resource
    And I set 1 items per page
    And I am an Admin
    And I am logged in as admin
    And I got role "read, remove"
    And There are users
    And I am on users listing
    And I follow "3"
    When I click on Carlo remove button
    Then I should see "Users - Index"
    And I should see "_id"
    And I should see "first_name"
    And I should see "last_name"
    And I should see "email"
    And I should see "Vahak"
    And I should see "Matavosian"
    And I should see "vahak@herbalife.com"
    And I should not see "Carlo"
    And I should not see "Cajucom"
    And I should not see "carlo@herbalife.com"

  Scenario: Admin removes user from list without remove ability
    Given I add SinatraAdmin as middleware
    And I register "User" resource
    And I set 1 items per page
    And I am an Admin
    And I am logged in as admin
    And I got role "read"
    And There are users
    And I am on users listing
    And I follow "3"
    And I should not see "Delete"
