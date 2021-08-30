//
//  MealTableViewCell.swift
//  ChowTime
//
//  Created by Joshua Hoyle on 8/24/21.
//

import UIKit

class MealTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
   
    @IBOutlet weak var mealImage: UIImageView!
    @IBOutlet weak var mealName: UILabel!
   
    
    //MARK: - Properties
    
    //landing pad
    var meal: Meal? {
        didSet {
            updateViews()
        }
    }
    
    //MARK: - Functions
    
    func updateViews() {
        guard let meal = meal else {return}
        mealName.text = meal.strMeal
        MealController.fetchMealThumb(meal: meal) { (result) in
            
                   DispatchQueue.main.async {
                switch result {
                case .success(let thumbnail) :
                    self.mealImage.image = thumbnail
                case .failure(let error):
                    self.mealImage.image = UIImage(named: "noImage")
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
        
    }
}//end of class

