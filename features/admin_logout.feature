Feature: Admin login
  In order to use SinatraAdmin
  As a logged in Admin
  I want to logout when I click the "Lougout" link

  Scenario: Admin is able to logout
    Given I add SinatraAdmin as middleware
    And I am an Admin
    And I register "User" resource
    And I am logged in as admin
    And I am on the home page
    When I follow "Logout"
    Then I should see "Login - SinatraAdmin"
    Then I should see "Successfully logged out"
