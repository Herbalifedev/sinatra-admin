Feature: Users listing
  In order to use SinatraAdmin 
  As an Admin
  I want to see the all users when I register the "User" resource

  Scenario: Admin sees user listing when there are records
    Given I add SinatraAdmin as middleware
    And I register "User" resource
    And I am an Admin
    And There are users
    When I go to users listing
    Then I should see "Users - Index"
    And I should see "_id"
    And I should see "first_name"
    And I should see "last_name"
    And I should see "email"
    And I should see "Carlo"
    And I should see "Cajucom"
    And I should see "carlo@herbalife.com"
    And I should see "Francisco"
    And I should see "Delgado"
    And I should see "francisco@herbalife.com"

  Scenario: Admin sees "No records" message when there are not users
    Given I add SinatraAdmin as middleware
    And I register "User" resource
    And I am an Admin
    And There are not users
    When I go to users listing
    Then I should see "Users - Index"
    And I should see "_id"
    And I should see "first_name"
    And I should see "last_name"
    And I should see "email"
    And I should see "There are not records in the database"
