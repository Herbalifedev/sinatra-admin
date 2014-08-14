Feature: Admin login
  In order to use SinatraAdmin
  As an Admin
  I want to login and use the admin application

  Scenario: Admin is able to login with valid credentials
    Given I add SinatraAdmin as middleware
    And I am an Admin
    And I register "User" resource
    And I am on the login page
    When I fill in "email" with "admin@mail.com"
    And I fill in "password" with "admin"
    And I press "Login"
    Then I should see "Users - Index"

  Scenario: Admin is not able to login with invalid email
    Given I add SinatraAdmin as middleware
    And I am an Admin
    And I register "User" resource
    And I am on the login page
    When I fill in "email" with "invalidemail@mail.com"
    And I fill in "password" with "admin"
    And I press "Login"
    Then I should see "Sign in SinatraAdmin"
    Then I should see "The email you entered does not exist"

  Scenario: Admin is not able to login with invalid password
    Given I add SinatraAdmin as middleware
    And I am an Admin
    And I register "User" resource
    And I am on the login page
    When I fill in "email" with "admin@mail.com"
    And I fill in "password" with "invalid_password"
    And I press "Login"
    Then I should see "Sign in SinatraAdmin"
    Then I should see "You entered an incorrect password"
