Feature: User show
  In order to use SinatraAdmin
  As an Admin
  I want to see the details for each user when I register the "User" resource
  And I clik on an id link

  Scenario: Admin sees user details when clicks the _id link
    Given I add SinatraAdmin as middleware
    And I register "User" resource
    And I am an Admin
    And There are users
    And I am on users listing
    When I click on Carlo id
    Then I should see "User - Show"
    And I should see "_id"
    And I should see "first_name"
    And I should see "last_name"
    And I should see "email"
    And I should see "Carlo"
    And I should see "Cajucom"
    And I should see "carlo@herbalife.com"