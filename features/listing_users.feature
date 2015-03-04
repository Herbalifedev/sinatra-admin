Feature: Users listing
  In order to use SinatraAdmin
  As an Admin
  I want to see the all users when I register the "User" resource

  Scenario: Admin tries to see user listing without login
    Given I add SinatraAdmin as middleware
    And I register "User" resource
    And I am an Admin
    And There are users
    When I go to users listing
    Then I should see "Sign in SinatraAdmin"
    And I should see "You must log in"

  Scenario: Admin sees user listing when there are records
    Given I add SinatraAdmin as middleware
    And I register "User" resource
    And I am an Admin
    And I am logged in as admin
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
    And I should see "Vahak"
    And I should see "Matavosian"
    And I should see "vahak@herbalife.com"
    And I should see "Export all"
    And I should see "Export current page"
    And the "_id" link should be "/admin/users?sort=_id+desc"
    And the "first_name" link should be "/admin/users?sort=first_name+desc"
    And the "last_name" link should be "/admin/users?sort=last_name+desc"
    And the "email" link should be "/admin/users?sort=email+desc"
    And the "Export all" link should be "/admin/users/export/all?sort="
    And the "Export current page" link should be "/admin/users/export/page?"

  Scenario: Admin sees "No records" message when there are not users
    Given I add SinatraAdmin as middleware
    And I register "User" resource
    And I am an Admin
    And I am logged in as admin
    And There are not users
    When I go to users listing
    Then I should see "Users - Index"
    And I should see "_id"
    And I should see "first_name"
    And I should see "last_name"
    And I should see "email"
    And I should see "There are not records in the database"

  Scenario: Admin sees first page when visit index
    Given I add SinatraAdmin as middleware
    And I register "User" resource
    And I set 1 items per page
    And I am an Admin
    And I am logged in as admin
    And There are users
    When I go to users listing
    Then I should see "Users - Index"
    And I should see "_id"
    And I should see "first_name"
    And I should see "last_name"
    And I should see "email"
    And I should not see "Carlo"
    And I should not see "Cajucom"
    And I should not see "carlo@herbalife.com"
    And I should not see "Francisco"
    And I should not see "Delgado"
    And I should not see "francisco@herbalife.com"
    And I should see "Vahak"
    And I should see "Matavosian"
    And I should see "vahak@herbalife.com"

  Scenario: Admin is able to navigate to the second page
    Given I add SinatraAdmin as middleware
    And I register "User" resource
    And I set 1 items per page
    And I am an Admin
    And I am logged in as admin
    And There are users
    When I go to users listing
    And I follow "2"
    Then I should see "Users - Index"
    And I should see "_id"
    And I should see "first_name"
    And I should see "last_name"
    And I should see "email"
    And I should not see "Carlo"
    And I should not see "Cajucom"
    And I should not see "carlo@herbalife.com"
    And I should see "Francisco"
    And I should see "Delgado"
    And I should see "francisco@herbalife.com"
    And I should not see "Vahak"
    And I should not see "Matavosian"
    And I should not see "vahak@herbalife.com"
