Feature: Users edit
  In order to use SinatraAdmin
  As an Admin
  I want to edit users records when I register the "User" resource

  Scenario: Admin tries to edit a record without login
    Given I add SinatraAdmin as middleware
    And I register "User" resource
    And I am an Admin
    And I got role "read, edit"
    And There are users
    When I go to users listing
    Then I should see "Sign in SinatraAdmin"
    And I should see "You must log in"

  Scenario: Admin edits a record without errors
    Given I add SinatraAdmin as middleware
    And I register "User" resource
    And I am an Admin
    And I am logged in as admin
    And I got role "read, edit"
    And There are users
    And I am on users listing
    And I click on Carlo id
    When I follow "Edit"
    And I fill in "email" with "carlo.edit@herbalife.com"
    And I press "Update"
    Then I should see "User - Show"
    And I should see "_id"
    And I should see "first_name"
    And I should see "last_name"
    And I should see "email"
    And I should see "Carlo"
    And I should see "Cajucom"
    And I should see "carlo.edit@herbalife.com"

  Scenario: Admin edits a record with errors
    Given I add SinatraAdmin as middleware
    And I register "User" resource
    And I am an Admin
    And I am logged in as admin
    And I got role "read, edit"
    And There are users
    And I am on users listing
    And I click on Carlo id
    When I follow "Edit"
    And I fill in "email" with ""
    And I press "Update"
    Then I should see "email ["can't be blank"]"

  Scenario: Admin tries to create a user without edit ability
    Given I add SinatraAdmin as middleware
    And I register "User" resource
    And I am an Admin
    And I am logged in as admin
    And I got role "read"
    And There are users
    And I am on users listing
    And I click on Carlo id
    And I should not see "Edit"

  Scenario: Admin tries to create a user without edit ability
    Given I add SinatraAdmin as middleware
    And I register "User" resource
    And I am an Admin
    And I got role "read"
    And I am logged in as admin
    And There are users
    And I am on users listing
    And I go to user Carlo edit
    Then I should see "Sorry you aren't allow to access"
