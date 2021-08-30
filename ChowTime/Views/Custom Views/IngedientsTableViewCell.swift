//
//  IngedientsTableViewCell.swift
//  ChowTime
//
//  Created by Joshua Hoyle on 8/28/21.
//

import UIKit

class IngredientsTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    
    @IBOutlet weak var ingredientLabel: UILabel!
    
    //MARK: - Properties
    
    var ingredient: String? {
        didSet {
            updateViews()
        }
    }
    var ingredients: [String] = []
   
    //MARK: - Functions
    
        func updateViews() {
        ingredientLabel.text = ingredient
    }
  
}//end of class
