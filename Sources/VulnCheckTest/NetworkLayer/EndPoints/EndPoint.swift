//
//  File.swift
//  
//
//  Created by Akshay Yerneni on 10/06/2022.
//

import Foundation

protocol EndPoint {
    
    //HTTP or HTTPS
    var scheme: String {get}
    
    // API Base URL
    var baseURL: String {get}
    
    // Path to the endpoint
    var path: String {get}
    
    // URLQueryItem(name: user_name, value: "User name")
    var parameters: [URLQueryItem] {get}
    
    // GET/POST/PUT/PATCH/DELETE
    var method: String {get}
}
