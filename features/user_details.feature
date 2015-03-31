Feature: User show
  In order to use SinatraAdmin
  As an Admin
  I want to see the details for each user when I register the "User" resource
  And I click on an id link

  Scenario: Admin tries to see user details thithout login
    Given I add SinatraAdmin as middleware
    And I register "User" resource
    And I am an Admin
    And There are users
    And I got role "read"
    When I go to users listing
    Then I should see "Sign in SinatraAdmin"
    And I should see "You must log in"

  Scenario: Admin sees user details when clicks the _id link
    Given I add SinatraAdmin as middleware
    And I register "User" resource
    And I set 1 items per page
    And I am an Admin
    And I am logged in as admin
    And I got role "read"
    And There are users
    When I click on user edit link for Carlo
    Then I should see "User - Show"
    And I should see "_id"
    And I should see "first_name"
    And I should see "last_name"
    And I should see "email"
    And I should see "Carlo"
    And I should see "Cajucom"
    And I should see "carlo@herbalife.com"
