//
//  File.swift
//  
//
//  Created by Akshay Yerneni on 10/06/2022.
//

import Foundation

enum CPELibDownloadEnpoint: EndPoint {
    
    case downloadCPELibrary
    
    var scheme: String {
        switch self {
            default:
                return ""
        }
    }
    
    var baseURL: String {
        switch self {
            default:
                return "https://nvd.nist.gov/feeds/xml/cpe/dictionary/official-cpe-dictionary_v2.3.xml.zip"
        }
    }
    
    var path: String {
        switch self {
        case .downloadCPELibrary:
            return ""
        }
    }
    
    var parameters: [URLQueryItem]  {
        switch self {
        case .downloadCPELibrary:
            return []
        }
    }
    
    var method: String  {
        switch self {
        case .downloadCPELibrary:
            return "GET"
        }
    }
}
