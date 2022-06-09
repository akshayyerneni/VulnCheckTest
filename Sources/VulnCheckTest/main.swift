import Foundation
import ArgumentParser


VulnCheckTest.main()

struct VulnCheckTest: ParsableCommand {
    
    static var configuration = CommandConfiguration(abstract: "A tool that analyses the dependencies installed using the SwiftPackageManager")
    
    @Argument(help: "Path of the project to be analysed. If not specified, default current directory is used")
    var path: String = FileManager.default.currentDirectoryPath
}
