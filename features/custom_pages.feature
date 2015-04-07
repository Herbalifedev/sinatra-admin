Feature: Custom Pages
  In order to use SinatraAdmin 
  As an Admin
  I want to add a custom page

  Scenario: Admin tries to see custom page without login
    Given I add SinatraAdmin as middleware
    And I add main app views to SinatraAdmin views
    And I register my custom page
    And I am an Admin
    When I go to my custom page
    Then I should see "Sign in SinatraAdmin"
    And I should see "You must log in"

  Scenario: Admin sees custom page
    Given I add SinatraAdmin as middleware
    And I add main app views to SinatraAdmin views
    And I register my custom page
    And I am an Admin
    And I am logged in as admin
    And I got role "read"
    And There are users
    When I go to my custom page
    And I should see "Welcome to SinatraAdmin custom pages!"
    And I should see "Admin Count: 1"

  #WIP Scenario #This feature does not work at all
  #Scenario: Admin adds custom page to a Resource(model)
  #  Given I add SinatraAdmin as middleware
  #  And I add main app views to SinatraAdmin views
  #  And I am an Admin
  #  And I am logged in as admin
  #  And There are users
  #  And I register "User" resource with custom route
  #  When I go to users custom page
  #  And I should see "Welcome to Resource model custom page"
