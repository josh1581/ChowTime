//
//  CategoryController.swift
//  ChowTime
//
//  Created by Joshua Hoyle on 8/24/21.
//



import UIKit

class CategoryController {
    
    static let shared = CategoryController()
    static let baseURL = URL(string: "https://www.themealdb.com/api/json/v1/1/")
    static let categoryPathComponent = "categories.php"
    
    
    static func FetchCategories(completion: @escaping (Result<[Category], FetchError>) -> Void) {
        guard let baseURL = CategoryController.baseURL else {return completion(.failure(.invalidURL))}
        let categoryURL = baseURL.appendingPathComponent(CategoryController.categoryPathComponent)
        let components = URLComponents(url: categoryURL, resolvingAgainstBaseURL: true)
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
                    print("CATEGORY STATUS CODE: \(response.statusCode)")
                }
            }
            guard let data = data else { return
                completion(.failure(.noData))}
            do {
                let category = try JSONDecoder().decode(CategoryTopLevelObject.self, from: data)
                completion(.success(category.categories))
            }catch{
                completion(.failure(.thrownError(error)))
                
            }
        }.resume()
    }
    
    static func fetchCategoryThumb(category: Category, completion: @escaping (Result<UIImage, FetchError>) -> Void) {
        guard let thumbnailURL = URL(string: category.strCategoryThumb) else { return completion(.failure(.invalidURL)) }
        
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
            
            guard let thumbnail = UIImage(data: data) else { return completion(.failure(.unableToDecode))}
            completion(.success(thumbnail))
            
        }.resume()
    }
}//End of Class
