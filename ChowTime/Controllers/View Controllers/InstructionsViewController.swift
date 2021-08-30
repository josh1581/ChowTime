//
//  InstructionsViewController.swift
//  ChowTime
//
//  Created by Joshua Hoyle on 8/29/21.
//

import UIKit

class InstructionsViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeThumb: UIImageView!
    @IBOutlet weak var recipeInstructionsTextView: UITextView!
    @IBOutlet weak var ingredientsButton: UIButton!
    
    //MARK: - Lifecycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ingredientsButton.layer.cornerRadius = 15
        fetchRecipesVC()
    }
    
    
    //MARK: - Properties
    
    //landing pad
    var recipeToView: String?
    var recipeForVC: Recipe? {
        didSet {
            updateViews()
        }
    }
    
    var recipes: [Recipe] = []
    static let recipeBaseURL = URL(string: "https://www.themealdb.com/api/json/v1/1/")
    static let lookupPathComponent = "lookup.php"
    static let queryItem = "i"
    
    //MARK: - Actions
    
    @IBAction func ingredientsButtonTapped(_ sender: Any) {
        
    }
    
    //MARK: - Functions
    
    func fetchRecipesVC() {
        RecipeController.fetchRecipes { (result) in
            DispatchQueue.main.async { [self] in
                
                switch result {
                case .success(let recipes) :
                    self.recipes = recipes
                    self.recipeForVC = recipes[0]
                case .failure(let error):
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
    }
    
    func updateViews() {
        guard let recipeForVC = self.recipeForVC else {return}
        
        let swiftCompliantInstructions = recipeForVC.strInstructions.replacingOccurrences(of: "\r\n", with: "\n")
        print(swiftCompliantInstructions)
        
        print(recipeForVC.strInstructions)
        RecipeController.fetchRecipeThumb(recipe: recipeForVC) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let thumbnail) :
                    self.recipeThumb.image = thumbnail
                    self.recipeNameLabel.text = recipeForVC.strMeal
                    self.recipeInstructionsTextView.text = swiftCompliantInstructions
                case .failure(let error) :
                    self.recipeThumb.image = UIImage(named: "noImage")
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toIngredientsVC" {
            guard let destinationVC = segue.destination as? IngredientsTableViewController else {return}
            
            destinationVC.recipe = recipeForVC
            RecipeController.shared.recipeForVC = recipeForVC
        }
    }
}



