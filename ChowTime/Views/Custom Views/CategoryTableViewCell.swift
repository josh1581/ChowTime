//
//  CategoryTableViewCell.swift
//  ChowTime
//
//  Created by Joshua Hoyle on 8/24/21.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categoryImage: UIImageView!
    
    //MARK: - Properties
    //landing pad
    var category: Category? {
        didSet {
            updateViews()
        }
    }
    
    //MARK: - Functions
    
    func updateViews() {
        guard let category = category else {return}
        categoryLabel.text = category.strCategory
        CategoryController.fetchCategoryThumb(category: category) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let thumbnail) :
                    self.categoryImage.image = thumbnail
                case .failure(let error):
                    self.categoryImage.image = UIImage(named: "noImage")
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                }
            }
        }
    }
} //end of class
