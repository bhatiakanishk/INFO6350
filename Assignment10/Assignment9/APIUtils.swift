//
//  APIUtils.swift
//  Assignment10
//
//  Created by Kanishk Bhatia on 11/26/22.
//

import Foundation

class APIUtils {
    //Mock API endpoint
    static let baseURL: String = "https://6382a5f81ada9475c8f10909.mockapi.io"

    static let shared = APIUtils()
    
    // MARK: Items
    
    func getAllItems(completion: @escaping ([Item])->Void) {
        let session = URLSession(configuration: .default)
        
        // URL for items
        let urlString: String = APIUtils.baseURL + "/items"
        guard let url = URL(string: urlString) else {
            print("invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        // Check for API call
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error calling API \(error)")
                return
            }
            
            // Check for successful response
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 200, let data = data {
                    do {
                        let items = try JSONDecoder().decode([Item].self, from: data)
                        completion(items)
                    } catch {
                        print("error parsing data")
                    }
                    
                } else {
                    print("response error \(response.statusCode)")
                }
            }
        }
        task.resume()
    }

    // MARK: Locations
    
    func getAllLocations(completion: @escaping ([Location])->Void) {
        let session = URLSession(configuration: .default)
        
        // URL for locations
        let urlString: String = APIUtils.baseURL + "/locations"
        guard let url = URL(string: urlString) else {
            print("invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        // Check for API Call
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error calling API \(error)")
                return
            }
            
            // Check for successful response
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 200, let data = data {
                    do {
                        let locations = try JSONDecoder().decode([Location].self, from: data)
                        completion(locations)
                    } catch {
                        print("error parsing data")
                    }
                    
                } else {
                    print("response error \(response.statusCode)")
                }
            }
        }
        task.resume()
    }
}
