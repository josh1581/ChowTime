//
//  CategoryTableViewController.swift
//  ChowTime
//
//  Created by Joshua Hoyle on 8/24/21.
//

import UIKit

class CategoryTableViewController: UITableViewController {
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCategoriesForTabeleView()
    }
    
    //MARK: - Properties
    
    var categories: [Category] = []
    static let shared = CategoryTableViewController()
    
    //MARK: - Functions
    
    func fetchCategoriesForTabeleView() {
        CategoryController.FetchCategories { (result) in
            DispatchQueue.main.async { [self] in
                switch result {
                case .success(let categories):
                    
                    self.categories = categories
                    self.categories.sort(by: {$0.strCategory < $1.strCategory})
                    self.tableView.reloadData()
                    print(categories)
                    
                case .failure(let error):
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                    
                }
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as? CategoryTableViewCell
        let category = categories[indexPath.row]
        cell?.category = category
        
        return cell ?? UITableViewCell()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMealVC" {
            guard let destinationVC = segue.destination as? MealTableViewController, let indexPath = tableView.indexPathForSelectedRow else {return}
            let category =  self.categories[indexPath.row]
            let categoryToView = category.strCategory
            _ = MealTableViewController()
            
            destinationVC.categoryToView = categoryToView
            MealController.shared.categoryToView = categoryToView
        }
    }
    
} //end of class
