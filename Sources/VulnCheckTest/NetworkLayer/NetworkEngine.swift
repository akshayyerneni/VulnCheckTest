//
//  File.swift
//  
//
//  Created by Akshay Yerneni on 10/06/2022.
//

import Foundation

protocol Network {
    
    func request<T: Codable>(endpoint: EndPoint, completion: @escaping(Result<T, Error>) -> ())
    func downloadData(endpoint: EndPoint) -> Data?
    
}

class NetworkEngine: Network {
    
    public init() {
        
    }
    
    func request<T: Codable>(endpoint: EndPoint, completion: @escaping (Result<T, Error>) -> ()) {
        
        var components = URLComponents()
        components.scheme = endpoint.scheme
        components.host = endpoint.baseURL
        components.path = endpoint.path
        components.queryItems = endpoint.parameters
        
        guard let url = components.url else {return}
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method
        
        let session = URLSession(configuration: .default)
        
        let dataTask = session.dataTask(with: request) { data, response, error in
            
            guard error == nil else {
                completion(.failure(error!))
                print(error?.localizedDescription ?? "Uknown error")
                return
            }
            
            guard response != nil, let data = data else {return}
            
            DispatchQueue.main.async {
                
                if let responseObject = try? JSONDecoder().decode(T.self, from: data) {
                    completion(.success(responseObject))
                } else {
                    let error = NSError(domain: "", code: 200, userInfo: [NSLocalizedDescriptionKey : "Failed to decode response"])
                    completion(.failure(error))
                }
            }
        }
        dataTask.resume()
    }
    
    func downloadData(endpoint: EndPoint) -> Data? {
        guard let url = URL(string: endpoint.baseURL),
              let data = try? Data(contentsOf: url) else {
            return nil
        }
        return data
    }
}
