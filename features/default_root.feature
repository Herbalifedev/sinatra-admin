Feature: Default root
  In order to use SinatraAdmin
  As an Admin
  I want to either define a root resource or allow SinatraAdmin to use the first registered

  Scenario: Admin tries to visit root without login
    Given I add SinatraAdmin as middleware
    And I register "User" resource
    And I register "Comment" resource
    And I am an Admin
    And I define "User" as root resource
    When I go to the home page
    Then I should see "Sign in SinatraAdmin"
    And I should see "You must log in"

  Scenario: Admin is redirected to defined root resource when it's defined
    Given I add SinatraAdmin as middleware
    And I register "User" resource
    And I register "Comment" resource
    And I am an Admin
    And I am logged in as admin
    And I got role "read"
    And I define "User" as root resource
    When I go to the home page
    Then I should see "Users - Index"
    And I should see "_id"
    And I should see "first_name"
    And I should see "last_name"
    And I should see "email"
    And I should see "There are no records in the database"

  Scenario: Admin is redirected to first registered route when root resource is not defined
    Given I add SinatraAdmin as middleware
    And I register "Comment" resource
    And I register "User" resource
    And I am an Admin
    And I am logged in as admin
    And I got role "read"
    When I go to the home page
    Then I should see "Users - Index"
    And I should see "_id"
    And I should see "first_name"
    And I should see "last_name"
    And I should see "email"
    And I should see "There are no records in the database"
