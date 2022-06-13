//
//  File.swift
//  
//
//  Created by Akshay Yerneni on 09/06/2022.
//

import Foundation

struct Dependencies: Decodable {
    
    var dependencies: [DependencyDetails]?
    
    private enum CodingKeys: String, CodingKey {
        case dependencies = "pins"
    }
}


struct DependencyDetails: Decodable {
    
    var name: String
    var location: String
    var state: State
    var isVulnerable: Bool = false
    var cpeDetails: CPE
    
    private enum CodingKeys: String, CodingKey {
        case name = "identity", location, state, cpeDetails
    }
}

struct State: Decodable {
    
    var version: String?
}

struct CPE: Decodable {
    
    var cpeName: String
    var cpeVersion: String
    var cves: [String]
}
