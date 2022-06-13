//
//  File.swift
//  
//
//  Created by Akshay Yerneni on 09/06/2022.
//

import Foundation

struct DependencyAnalyser {
    
    private var fileService: FileService!
    private let endpoint: EndPoint!
    private let networkEngine: Network!
    private let settings: Settings
    
    public init(fileService: FileService, endpoint: EndPoint, networkEngine: Network, settings: Settings) {
        self.fileService = fileService
        self.endpoint = endpoint
        self.networkEngine = networkEngine
        self.settings = settings
    }
    
    func getCPELibrary() {
//        guard let cpeData = networkEngine.downloadData(endpoint: endpoint) else {return}
//        guard let cpePath = fileService.save(data: cpeData, at: settings.homeFolder, with: "zip") else {return}
        let cpePath = "/Users/akshayyerneni/official-cpe-dictionary_v2.3.xml"
        fileService.readXMLFile(from: cpePath)
    }
    
    
    func getDependencies(in path: String) {
        
        if fileService.isValidDirectory(path: path) {
            guard let resolvedPath = try? fileService.findSwiftPMFile(at: path), let data = fileService.getJSONFrom(fileAt: resolvedPath) else {return}
            do {
                let dependencies = try JSONDecoder().decode(Dependencies.self, from: data)
                print(dependencies)
            } catch {
                print(error)
            }
        }
    }
}


extension DependencyAnalyser: XMLReader {
    
    func getXML(elementName: String, attributeDict: [String : String]) {
        if elementName == "cpe-23:cpe23-item",
        let name = attributeDict["name"], !name.isEmpty {
            print(name)
        }
    }
    
    
}
