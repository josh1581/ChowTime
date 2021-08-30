//
//  MealController.swift
//  ChowTime
//
//  Created by Joshua Hoyle on 8/24/21.
//

import UIKit


class MealController {
  
    //Properties
    
    static let shared = MealController()
    //var category: Category?
    var categoryToView: String = ""
    
    //MARK: - Functions
    
    
    static let filterPathComponent = "filter.php"
    static let queryItem = "c"
    
    static func fetchMeals(completion: @escaping (Result<[Meal], FetchError>) -> Void) {
        guard let baseURL = CategoryController.baseURL else {return completion(.failure(.invalidURL))}
        let filterURL = baseURL.appendingPathComponent(MealTableViewController.filterPathComponent)
        var components = URLComponents(url: filterURL, resolvingAgainstBaseURL: true)
        
        let categoryQueryKey = URLQueryItem(name: self.queryItem, value: MealController.shared.categoryToView )
        components?.queryItems = [categoryQueryKey]
        guard let finalURL = components?.url else {return completion(.failure(.invalidURL))}
        print(finalURL)
        URLSession.shared.dataTask(with: finalURL) { data, response, error in
            if let error = error {
                return
                    completion(.failure(.thrownError(error)))
            }
            if let response = response as? HTTPURLResponse {
                let responseString = "\(response.statusCode)"
                if responseString != "200" {
                    print("MEAL STATUS CODE: \(response.statusCode)")
                }
            }
            guard let data = data else { return
                completion(.failure(.noData))}
            do {
                let meal = try JSONDecoder().decode(MealTopLevelObject.self, from: data)
                completion(.success(meal.meals))
            }catch{
                completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
    
    static func fetchMealThumb(meal: Meal, completion: @escaping(Result<UIImage,FetchError>) -> Void) {
        guard let thumbnailURL = URL(string: meal.strMealThumb) else { return
            completion(.failure(.invalidURL)) }
        URLSession.shared.dataTask(with: thumbnailURL) { data, response, error in
            if let error = error {
                return
                    completion(.failure(.thrownError(error)))
            }
            if let response = response as? HTTPURLResponse {
                let responseString = "\(response.statusCode)"
                if responseString != "200" {
                    print("Thumbnail Status Code: \(response.statusCode)")
                }
            }
            guard let data = data else {return completion(.failure(.noData))}
            
            guard let thumbnail = UIImage(data: data) else { return
                completion(.failure(.unableToDecode))}
            completion(.success(thumbnail))
        }.resume()
    }
    
} //end of class
