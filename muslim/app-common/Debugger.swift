//
//  debugger.swift
//  muslim
//
//  Created by Rangga Leo on 07/12/20.
//

import Foundation

func debugLog(_ items: Any..., fileName: String = #file,
                     functionName: String = #function,
                     lineNumber: Int = #line,
                     separator: String = " ",
                     terminator: String = "\n") {
//    #if DEBUG
        let prefix = "[🚀] \(fileName).\(functionName) line \(lineNumber): "
        let output = items.map { "\($0)" }.joined(separator: separator)
        Swift.print(prefix + output, terminator: terminator)
//    #else
//    #endif
}
