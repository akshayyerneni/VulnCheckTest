//
//  File.swift
//  
//
//  Created by Akshay Yerneni on 09/06/2022.
//

import Zip
import Foundation
import XMLParsing

protocol FileService {
    
    func isValidDirectory(path: String) -> Bool
    func findSwiftPMFile(at path: String) throws -> String?
    func readJSONfrom(fileAt path: String) -> [String:Any]
    func save(data: Data, at path: URL, with extension: String) -> String?
    func readXMLFile(from path: String)
    func getJSONFrom(fileAt path: String) -> Data?
}

protocol XMLReader {
    func getXML(elementName: String, attributeDict: [String:String])
}

class FileInfoProvider: NSObject, FileService {
    
    private let fileManager: FileManager = .default
    
    var delegate: XMLReader? = nil
    
    public override init() {
    }
    
    func isValidDirectory(path: String) -> Bool {
        
        if fileManager.fileExists(atPath: path) {
            return true
        }
        return false
    }
    
    func findSwiftPMFile(at path: String) throws -> String? {
        
        let subPaths = try fileManager.subpathsOfDirectory(atPath: path)
        guard let resolvedExtension = subPaths.first(where: {$0.hasSuffix("Package.resolved")}) else {return ""}
        let pathURL = URL(string: path)
        let resolvedPath = pathURL?.appendingPathComponent(resolvedExtension).path
        return resolvedPath
    }
    
    func readJSONfrom(fileAt path: String) -> [String:Any] {
        do {
            let pathURL = URL(fileURLWithPath: path)
            let jsonData = try Data(contentsOf: pathURL)
            guard let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as? [String:Any] else {return [:]}
            return jsonObject
        } catch {
            print("This is the error: \(error)")
        }
        
        return [:]
    }
    
    func save(data: Data, at path: URL, with extension: String) -> String? {
        do {
            let homeDirectory = fileManager.homeDirectoryForCurrentUser
            var pathURL = path
            pathURL.appendPathExtension("zip")
            try data.write(to: pathURL, options: .atomic)
            try Zip.unzipFile(pathURL, destination: homeDirectory, overwrite: true, password: nil)
            let unzippedFilePath = homeDirectory.appendingPathComponent("official-cpe-dictionary_v2.3", isDirectory: false).appendingPathExtension("xml")
            return unzippedFilePath.path
        } catch {
            print("Error: \(error.localizedDescription)")
            return nil
            
        }
    }
    
    func readXMLFile(from path: String) {
        
        do {
            let xmlStr = try String(contentsOfFile: path)
            guard let data = xmlStr.data(using: .utf8) else {return}
            let parser = XMLParser(data: data)
            parser.delegate = self
            let success = parser.parse()
            if success {
                print("Parsing successful")
            } else {
                print("Parser Error: \(parser.parserError?.localizedDescription ?? "Unknown Error")")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getJSONFrom(fileAt path: String) -> Data? {
        guard let data = try? String(contentsOfFile: path).data(using: .utf8) else {return nil}
        return data
    }
}

extension FileInfoProvider: XMLParserDelegate {
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        delegate?.getXML(elementName: elementName, attributeDict: attributeDict)
    }
}

struct CPEData: Codable {
    var cpeItem: String
    
    private enum CodingKeys: String, CodingKey {
        case cpeItem = "/cpe-item"
    }
}
