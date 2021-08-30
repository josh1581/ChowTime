//
//  Meal.swift
//  ChowTime
//
//  Created by Joshua Hoyle on 8/24/21.
//

import UIKit

struct MealTopLevelObject: Codable {
    let meals: [Meal]
} //end of struct

struct Meal: Codable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
} //end of struct
