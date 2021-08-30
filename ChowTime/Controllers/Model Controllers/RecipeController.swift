//
//  RecipeController.swift
//  ChowTime
//
//  Created by Joshua Hoyle on 8/24/21.
//

import UIKit

class RecipeController {
    
    //MARK: - Properties
    static let shared = RecipeController()
    var recipe: Recipe?
    var recipeToView: String?
    var recipeForVC: Recipe?
    var ingredients: [String] = []
    
    
    static let recipeBaseURL = URL(string: "https://www.themealdb.com/api/json/v1/1/")
    static let lookupPathComponent = "lookup.php"
    static let queryItem = "i"
    
    
    //MARK: - Functions
    
    static func fetchRecipes(completion: @escaping (Result<[Recipe], FetchError>) -> Void) {
        guard let baseURL = CategoryController.baseURL else {return completion(.failure(.invalidURL))}
        let lookupURL = baseURL.appendingPathComponent(InstructionsViewController.lookupPathComponent)
        var components = URLComponents(url: lookupURL, resolvingAgainstBaseURL: true)
        
        let recipeQueryKey = URLQueryItem(name: self.queryItem, value: RecipeController.shared.recipeToView)
        
        components?.queryItems = [recipeQueryKey]
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
                    print("RECIPE STATUS CODE: \(response.statusCode)")
                }
            }
            guard let data = data else { return
                completion(.failure(.noData))}
            do{
                let recipe = try JSONDecoder().decode(RecipeTopLevelObject.self, from: data)
                completion(.success(recipe.meals))
                RecipeController.shared.recipeForVC = recipe.meals[0]
            }catch{
                completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
    
    static func fetchRecipeThumb(recipe: Recipe, completion: @escaping(Result<UIImage,FetchError>) -> Void) {
        guard let thumbnailURL = URL(string: recipe.strMealThumb) else { return
            completion(.failure(.invalidURL)) }
        URLSession.shared.dataTask(with: thumbnailURL) { data, response, error in
            if let error = error {
                return
                    completion(.failure(.thrownError(error)))
            }
            if let response = response as? HTTPURLResponse {
                let responseString = "\(response.statusCode)"
                if responseString != "200" {
                    print("THUMBNAIL STATUS CODE: \(response.statusCode)")
                }
            }
            guard let data = data else {return completion(.failure(.noData))}
            guard let thumbnail = UIImage(data: data) else { return
                completion(.failure(.unableToDecode)) }
            completion(.success(thumbnail))
        }.resume()
    }

} //end of class
