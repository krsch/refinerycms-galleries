@galleries
Feature: Galleries
  In order to have galleries on my website
  As an administrator
  I want to manage galleries

  Background:
    Given I am a logged in refinery user
    And I have no galleries

  @galleries-list @list
  Scenario: Galleries List
   Given I have galleries titled UniqueTitleOne, UniqueTitleTwo
   When I go to the list of galleries
   Then I should see "UniqueTitleOne"
   And I should see "UniqueTitleTwo"

  @galleries-valid @valid
  Scenario: Create Valid Gallery
    When I go to the list of galleries
    And I follow "Add New Gallery"
    And I fill in "Title" with "This is a test of the first string field"
    And I press "Save"
    Then I should see "'This is a test of the first string field' was successfully added."
    And I should have 1 gallery

  @galleries-invalid @invalid
  Scenario: Create Invalid Gallery (without title)
    When I go to the list of galleries
    And I follow "Add New Gallery"
    And I press "Save"
    Then I should see "Title can't be blank"
    And I should have 0 galleries

  @galleries-edit @edit
  Scenario: Edit Existing Gallery
    Given I have galleries titled "A title"
    When I go to the list of galleries
    And I follow "Edit this gallery" within ".actions"
    Then I fill in "Title" with "A different title"
    And I press "Save"
    Then I should see "'A different title' was successfully updated."
    And I should be on the list of galleries
    And I should not see "A title"

  @galleries-duplicate @duplicate
  Scenario: Create Duplicate Gallery
    Given I only have galleries titled UniqueTitleOne, UniqueTitleTwo
    When I go to the list of galleries
    And I follow "Add New Gallery"
    And I fill in "Title" with "UniqueTitleTwo"
    And I press "Save"
    Then I should see "There were problems"
    And I should have 2 galleries

  @galleries-delete @delete
  Scenario: Delete Gallery
    Given I only have galleries titled UniqueTitleOne
    When I go to the list of galleries
    And I follow "Remove this gallery forever"
    Then I should see "'UniqueTitleOne' was successfully removed."
    And I should have 0 galleries
 