Feature: Maintain a list of movies
 
  As a Movie Buff
  So that I can catalogue movies 
  I want add and delete movies

Background: movies have been added to database

  Given the following movies exist:
  | title                   | rating | release_date |
  | The Terminator          | R      | 26-Oct-1984  |
  
  And I am on the RottenPotatoes home page
  When I check the following ratings: PG, R, PG-13, G
  
Scenario: Add movie
  When I check the following ratings: PG, R, PG-13, G
  When I press "ratings_submit"
  When I follow "Add new movie"
  And I add the following movie:
  | title                   | rating | release_date |
  | Aladdin                 | G      | 25-Nov-1992  |
  When I press "Save Changes"
  Then I should be on the RottenPotatoes home page 
  And I should see "Aladdin"
  And I should see "The Terminator"


  
  
