//
//  Category.swift
//  ChowTime
//
//  Created by Joshua Hoyle on 8/24/21.
//

import UIKit

struct CategoryTopLevelObject: Codable {
    let categories: [Category]
    
}//end of struct

struct Category: Codable {
    let strCategory: String
    let strCategoryThumb: String

} //end of struct
