Feature: Users exporting
  In order to use SinatraAdmin
  As an Admin
  I want to export users when I register the "User" resource

  Scenario: Admin tries to export users without login
    Given I add SinatraAdmin as middleware
    And I register "User" resource
    And I am an Admin
    And I got role "read"
    And There are users
    When I go to users listing
    Then I should see "Sign in SinatraAdmin"
    And I should see "You must log in"

  Scenario: Admin export all users csv
    Given I add SinatraAdmin as middleware
    And I register "User" resource
    And I am an Admin
    And I will download an attachment
    And I am logged in as admin
    And I got role "read"
    And There are users
    When I go to users listing
    Then I should see "Users - Index"
    When I download from "/admin/users/export/all/"
    Then I should receive a file "users-all"
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
    And I should see "Vahak"
    And I should see "Matavosian"
    And I should see "vahak@herbalife.com"
