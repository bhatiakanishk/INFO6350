//
//  APIUtils.swift
//  Assignment9
//
//  Created by Kanishk Bhatia on 11/26/22.
//

import Foundation

class APIUtils {
    static let baseURL: String = "https://6382a5f81ada9475c8f10909.mockapi.io"

    static let shared = APIUtils()
    
    // MARK: Items
    
    func getAllItems(completion: @escaping ([Item])->Void) {
        let session = URLSession(configuration: .default)
        
        let urlString: String = APIUtils.baseURL + "/items"
        guard let url = URL(string: urlString) else {
            print("invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error calling API \(error)")
                return
            }
            
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
    
    func postItem(item: Item, completion: @escaping ()->()) {
        let session = URLSession(configuration: .default)
        
        let urlString: String = APIUtils.baseURL + "/items"
        guard let url = URL(string: urlString) else {
            print("invalid URL")
            return
        }
        
        var body: Data?
        
        do {
            body = try JSONEncoder().encode(item)
        } catch {
            print("error encoding data \(item)")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = body
        
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error calling API \(error)")
                return
            }
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 201 {
                    print("post success")
                    completion()
                    if let data = data {
                        print(data)
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
        
        let urlString: String = APIUtils.baseURL + "/locations"
        guard let url = URL(string: urlString) else {
            print("invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error calling API \(error)")
                return
            }
            
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
    
    func postLocation(location: Location, completion: @escaping ()->()) {
        let session = URLSession(configuration: .default)
        
        let urlString: String = APIUtils.baseURL + "/locations"
        guard let url = URL(string: urlString) else {
            print("invalid URL")
            return
        }
        
        var body: Data?
        do {
            body = try JSONEncoder().encode(location)
        } catch {
            print("error encoding data \(location)")
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = body
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error calling API \(error)")
                return
            }
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 201 {
                    print("post success")
                    completion()
                    if let data = data {
                        print(data)
                    }
                } else {
                    print("response error \(response.statusCode)")
                }
            }
        }
        task.resume()
    }
}
