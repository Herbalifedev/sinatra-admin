Feature: Users listing
  In order to use SinatraAdmin as an Admin
  I want to see the all users when
  I register the "User" resource

  Scenario: Seeing users listing
    Given I am an Admin
    And There are users
    And I add SinatraAdmin as middleware
    And I register "User" resource
    When I go to users listing
    Then I should see "first_name"
    Then I see "last_name"
    Then I see "email"
