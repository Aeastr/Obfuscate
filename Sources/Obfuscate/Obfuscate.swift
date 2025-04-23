//
//  Obfuscate.swift
//  Obfuscate
//
//  Created by Seb Vidal on 23/04/2025.
//

import Foundation

@freestanding(expression)
public macro Obfuscate(_ string: StaticString) -> String = #externalMacro(module: "ObfuscateMacro", type: "ObfuscatedString")
