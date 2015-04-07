Feature: Creating Users
  In order to use SinatraAdmin
  As an Admin
  I want to create users when I register the "User" resource

  Scenario: Admin tries to create a user without login
    Given I add SinatraAdmin as middleware
    And I register "User" resource
    And I am an Admin
    And I got role "read, create"
    When I go to users listing
    Then I should see "Sign in SinatraAdmin"
    And I should see "You must log in"

  Scenario: Admin creates user
    Given I add SinatraAdmin as middleware
    And I register "User" resource
    And I am an Admin
    And I am logged in as admin
    And I got role "read, create"
    And I am on users listing
    When I follow "New"
    And I fill in "first_name" with "Vahak"
    And I fill in "last_name" with "Matavosian"
    And I fill in "email" with "vahak@herbalife.com"
    And I fill in "password" with "vpass"
    And I press "Create"
    Then I should see "User - Show"
    Then I should see "_id"
    Then I should see "first_name"
    Then I should see "last_name"
    Then I should see "email"
    Then I should see "Vahak"
    Then I should see "Matavosian"
    Then I should see "vahak@herbalife.com"

  Scenario: Admin creates user with errors
    Given I add SinatraAdmin as middleware
    And I register "User" resource
    And I am an Admin
    And I am logged in as admin
    And I got role "read, create"
    And I am on users listing
    When I follow "New"
    And I fill in "first_name" with "Vahak"
    And I fill in "last_name" with "Matavosian"
    And I press "Create"
    Then I should see "email ["can't be blank"]"
    Then I should see "password ["can't be blank"]"

  Scenario: Admin tries to create a user without create ability
    Given I add SinatraAdmin as middleware
    And I register "User" resource
    And I am an Admin
    And I am logged in as admin
    And I got role "read"
    When I go to users listing
    And I should not see "New"

  Scenario: Admin tries to create a user without create ability
    Given I add SinatraAdmin as middleware
    And I register "User" resource
    And I am an Admin
    And I am logged in as admin
    And I got role "read"
    And I go to user create new
    Then I should see "Sorry you aren't allow to access"
