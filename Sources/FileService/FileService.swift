//
//  File.swift
//  
//
//  Created by Akshay Yerneni on 09/06/2022.
//

import Foundation

protocol FileService {
    
    func isValidDirectory(path: String) -> Bool
}

struct FileInfoProvider: FileService {
    
    private let fileManager: FileManager = .default
    
    func isValidDirectory(path: String) -> Bool {
        
        if fileManager.fileExists(atPath: path) {
            print("The file exists at: \(path)")
        } else {
            print("There is no file at: \(path)")
        }
        return true
    }
}
