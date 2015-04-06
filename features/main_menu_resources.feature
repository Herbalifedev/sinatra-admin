Feature: Main Menu resources
  In order to use SinatraAdmin 
  As an Admin
  I want to see all registered routes links in the main menu

  Scenario: Admin does not see main menu when he/she is not logged in
    Given I add SinatraAdmin as middleware
    And I register "User" resource
    And I register "Comment" resource
    And I am an Admin
    And I got role "all"
    When I go to the login page
    Then I should not see "Users"
    Then I should not see "Comments"

  Scenario: Admin sees main menu when he/she is logged in
    Given I add SinatraAdmin as middleware
    And I register "User" resource
    And I register "Comment" resource
    And I am an Admin
    And I am logged in as admin
    And I got role "all"
    When I go to the home page
    Then I should see "Users"
    Then I should see "Comments"

  Scenario: Admin navigates through main menu when he/she is logged in
    Given I add SinatraAdmin as middleware
    And I register "User" resource
    And I am an Admin
    And I am logged in as admin
    And I got role "all"
    When I go to the home page
    And I follow "Users"
    Then I should see "Users - Index"

  Scenario: Admin navigates through main menu when he/she is logged in
    Given I add SinatraAdmin as middleware
    And I register "Comment" resource
    And I am an Admin
    And I am logged in as admin
    And I got role "all"
    When I go to the home page
    And I follow "Comments"
    Then I should see "Comments - Index"
