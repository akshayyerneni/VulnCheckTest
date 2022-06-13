import Foundation
import ArgumentParser

struct VulnCheckTest: ParsableCommand {
    
    static var configuration = CommandConfiguration(abstract: "A tool that analyses the dependencies installed using the SwiftPackageManager")
    
    @Argument(help: "Path of the project to be analysed. If not specified, default current directory is used")
    var path: String = FileManager.default.currentDirectoryPath
    
    @available(macOS 10.12, *)
    mutating func run() throws {
        
        let analyser = DependencyAnalyser(fileService: FileInfoProvider(),
                                          endpoint: CPELibDownloadEnpoint.downloadCPELibrary,
                                          networkEngine: NetworkEngine(),
                                          settings: Settings())
        analyser.getCPELibrary()
    }
}

VulnCheckTest.main()
