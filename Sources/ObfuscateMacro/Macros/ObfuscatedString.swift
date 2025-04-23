//
//  ObfuscatedString.swift
//  Obfuscate
//
//  Created by Seb Vidal on 23/04/2025.
//

import Foundation
import SwiftSyntax
import SwiftSyntaxMacros

struct ObfuscatedString: ExpressionMacro {
    public static func expansion(of node: some FreestandingMacroExpansionSyntax, in context: some MacroExpansionContext) -> ExprSyntax {
        let stringArgument = node.arguments.first?.expression
        let stringLiteralSyntax = stringArgument?.as(StringLiteralExprSyntax.self)
        
        let string = stringLiteralSyntax?.representedLiteralValue
        
        let base64String = string!.data(using: .utf8)!.base64EncodedString()
        let characters = base64String.utf8.map { UInt8($0) }
        
        return """
            {
                let characters: [UInt8] = \(raw: characters)
                let base64 = String(bytes: characters, encoding: .utf8)!
                let data = Data(base64Encoded: base64.data(using: .utf8)!)!
        
                return String(data: data, encoding: .utf8)!
            }()
        """
    }
}
