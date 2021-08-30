//
//  IngredientsTableViewController.swift
//  ChowTime
//
//  Created by Joshua Hoyle on 8/29/21.
//

import UIKit

class IngredientsTableViewController: UITableViewController {
    
    //MARK: - Outlets
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        combineAndAppend()
    }
    
    //MARK: - Properties
    
    //Landing Pad
    var recipe: Recipe?  
    
    var ingredients: [String] = []
    static let shared = IngredientsTableViewController()
    
    
    //MARK: - Functions
    
    func updateViews() {
        
    }
    
    func combineAndAppend() {
        guard let recipe = recipe else {return}
        let ingredient1 = "\(recipe.strMeasure1 ?? "") \(recipe.strIngredient1 ?? "")"
        if recipe.strIngredient1 != ""  {
            ingredients.append(ingredient1)
        }
        let ingredient2 = "\(recipe.strMeasure2 ?? "") \(recipe.strIngredient2 ?? "")"
        if recipe.strIngredient2 != "" {
            ingredients.append(ingredient2)
        }
        let ingredient3 = "\(recipe.strMeasure3 ?? "") \(recipe.strIngredient3 ?? "")"
        if recipe.strIngredient3 != "" {
            ingredients.append(ingredient3)
        }
        let ingredient4 = "\(recipe.strMeasure4 ?? "") \(recipe.strIngredient4 ?? "")"
        if recipe.strIngredient4 != "" {
            ingredients.append(ingredient4)
        }
        let ingredient5 = "\(recipe.strMeasure5 ?? "") \(recipe.strIngredient5 ?? "")"
        if recipe.strIngredient5 != "" {
            ingredients.append(ingredient5)
        }
        let ingredient6 = "\(recipe.strMeasure6 ?? "") \(recipe.strIngredient6 ?? "")"
        if recipe.strIngredient6 != "" {
            ingredients.append(ingredient6)
        }
        let ingredient7 = "\(recipe.strMeasure7 ?? "") \(recipe.strIngredient7 ?? "")"
        if recipe.strIngredient7 != ""   {
            ingredients.append(ingredient7)
        }
        let ingredient8 = "\(recipe.strMeasure8 ?? "") \(recipe.strIngredient8 ?? "")"
        if recipe.strIngredient8 != "" {
            ingredients.append(ingredient8)
        }
        let ingredient9 = "\(recipe.strMeasure9 ?? "") \(recipe.strIngredient9 ?? "")"
        if recipe.strIngredient9 != "" {
            ingredients.append(ingredient9)
        }
        let ingredient10 = "\(recipe.strMeasure10 ?? "") \(recipe.strIngredient10 ?? "")"
        if recipe.strIngredient10 != "" {
            ingredients.append(ingredient10)
        }
        let ingredient11 = "\(recipe.strMeasure11 ?? "") \(recipe.strIngredient11 ?? "")"
        if recipe.strIngredient11 != "" {
            ingredients.append(ingredient11)
        }
        let ingredient12 = "\(recipe.strMeasure12 ?? "") \(recipe.strIngredient12 ?? "")"
        if recipe.strIngredient12 != "" {
            ingredients.append(ingredient12)
        }
        let ingredient13 = "\(recipe.strMeasure13 ?? "") \(recipe.strIngredient13 ?? "")"
        if recipe.strIngredient13 != "" {
            ingredients.append(ingredient13)
        }
        let ingredient14 = "\(recipe.strMeasure14 ?? "") \(recipe.strIngredient14 ?? "")"
        if recipe.strIngredient14 != "" {
            ingredients.append(ingredient14)
        }
        let ingredient15 = "\(recipe.strMeasure15 ?? "") \(recipe.strIngredient15 ?? "")"
        if recipe.strIngredient15 != "" {
            ingredients.append(ingredient15)
        }
        let ingredient16 = "\(recipe.strMeasure16 ?? "") \(recipe.strIngredient16 ?? "")"
        if recipe.strIngredient16 != "" {
            ingredients.append(ingredient16)
        }
        let ingredient17 = "\(recipe.strMeasure17 ?? "") \(recipe.strIngredient17 ?? "")"
        if recipe.strIngredient17 != "" {
            ingredients.append(ingredient17)
        }
        let ingredient18 = "\(recipe.strMeasure18 ?? "") \(recipe.strIngredient18 ?? "")"
        if recipe.strIngredient18 != "" {
            ingredients.append(ingredient18)
        }
        let ingredient19 = "\(recipe.strMeasure19 ?? "") \(recipe.strIngredient19 ?? "")"
        if recipe.strIngredient19 != "" {
            ingredients.append(ingredient19)
        }
        let ingredient20 = "\(recipe.strMeasure20 ?? "") \(recipe.strIngredient20 ?? "")"
        if recipe.strIngredient20 != "" {
            ingredients.append(ingredient20)
        }
        else {return}
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ingredients.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientsCell", for: indexPath) as? IngredientsTableViewCell
        let ingredient = ingredients[indexPath.row]
        cell?.ingredient = ingredient
        return cell ?? UITableViewCell()
    }
}
