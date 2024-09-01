// The Swift Programming Language
// https://docs.swift.org/swift-book
//
// Swift Argument Parser
// https://swiftpackageindex.com/apple/swift-argument-parser/documentation

import Foundation
import ArgumentParser

@main
struct Hexify: ParsableCommand {
    @Flag(name: .shortAndLong, help: "Do not include spaces between hex bytes.")
    var spaces = false

    @Flag(name: .shortAndLong, help: "Use uppercase hex digits.")
    var uppercase = false

    @Argument(help: "The path of the file to hexify.")
    var filename: String

    mutating func run() throws {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: filename))

            let format = if uppercase { "%02X" } else { "%02x" }

            for (index, byte) in data.enumerated() {
                let isLast = (index == data.count - 1)
                let terminator = if isLast { "\n" } else {
                    if spaces { " " } else { "" }
                }
                print(
                    "\(String(format: format, byte))",
                    terminator: terminator)
            }
        } catch let error {
            print(error.localizedDescription)
            throw ExitCode.failure
        }
    }
}
