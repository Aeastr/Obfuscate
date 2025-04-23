//
//  ObfuscateMacro.swift
//  Obfuscate
//
//  Created by Seb Vidal on 23/04/2025.
//

import SwiftSyntaxMacros
import SwiftCompilerPlugin

@main
struct ObfuscateMacro: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        ObfuscatedString.self
    ]
}
