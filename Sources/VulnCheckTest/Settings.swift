//
//  File.swift
//  
//
//  Created by Akshay Yerneni on 12/06/2022.
//

import Foundation

class Settings {
    
    var cpeUpdateInterval: TimeInterval? = 1 * 60 * 60 * 24 // default one day
    var homeFolder: URL
    
    init() {
        let home = FileManager.default.homeDirectoryForCurrentUser
        self.homeFolder = home.appendingPathComponent("CPELibrary", isDirectory: true)
    }
}
