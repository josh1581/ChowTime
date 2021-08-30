//
//  MealTableViewController.swift
//  ChowTime
//
//  Created by Joshua Hoyle on 8/24/21.
//

import UIKit

class MealTableViewController: UITableViewController {
    
    
    //MARK: - Properties
    var meals: [Meal] = []
    static let mealBaseURL = URL(string: "https://www.themealdb.com/api/json/v1/1/")
    static let filterPathComponent = "filter.php"
    static let queryItem = "c"
    static let shared = MealTableViewController()
    //Landing Pad
    
      var categoryToView: String?
   
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMealsForTableView()
         }
    
    //MARK: - Functions

    func fetchMealsForTableView() {
        MealController.fetchMeals() { (result) in
            DispatchQueue.main.async { [self] in
                switch result {
                case .success(let meals):
                    
                    self.meals = meals
                    self.meals.sort(by: {$0.strMeal < $1.strMeal})
                    self.tableView.reloadData()
                    print(meals)
                    
                case .failure(let error):
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")

                }
            }
        }
    }
    
    
    // MARK: - Table view data source
    
       override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  
        return meals.count
    }
       
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mealCell", for: indexPath) as? MealTableViewCell
            let meal = meals[indexPath.row]
            cell?.meal = meal
            
        
        return cell ?? UITableViewCell()
    }
    
    // MARK: - Navigation
       
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toInstructionsVC" {
            guard let destinationVC = segue.destination as? InstructionsViewController, let indexPath = tableView.indexPathForSelectedRow else {return}
            let meal = self.meals[indexPath.row]
            let recipeToView = meal.idMeal
            _ = InstructionsViewController()
            destinationVC.recipeToView = recipeToView
            RecipeController.shared.recipeToView = recipeToView
           
        }
    }
  }

