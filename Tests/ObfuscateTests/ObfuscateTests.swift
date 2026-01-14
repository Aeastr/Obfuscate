//
//  ObfuscateTests.swift
//  Obfuscate
//
//  Created by Aether on 14/01/2026.
//

import XCTest
@testable import Obfuscate

final class ObfuscateTests: XCTestCase {

    // MARK: - Base64 (Default)

    func testBase64() {
        let result = #Obfuscate("HelloWorld")
        XCTAssertEqual(result, "HelloWorld")
    }

    func testBase64Explicit() {
        let result = #Obfuscate("TestString", .base64)
        XCTAssertEqual(result, "TestString")
    }

    // MARK: - Bytes

    func testBytes() {
        let result = #Obfuscate("BytesTest", .bytes)
        XCTAssertEqual(result, "BytesTest")
    }

    // MARK: - XOR

    func testXOR() {
        let result = #Obfuscate("XORSecret", .xor)
        XCTAssertEqual(result, "XORSecret")
    }

    // MARK: - Bit Shift

    func testBitShift() {
        let result = #Obfuscate("ShiftMe", .bitShift)
        XCTAssertEqual(result, "ShiftMe")
    }

    // MARK: - Reversed

    func testReversed() {
        let result = #Obfuscate("ReverseMe", .reversed)
        XCTAssertEqual(result, "ReverseMe")
    }

    // MARK: - Edge Cases

    func testEmptyString() {
        let result = #Obfuscate("")
        XCTAssertEqual(result, "")
    }

    func testStringWithSpaces() {
        let result = #Obfuscate("Hello World Test", .xor)
        XCTAssertEqual(result, "Hello World Test")
    }

    func testSpecialCharacters() {
        let result = #Obfuscate("Test!@#$%^&*()", .base64)
        XCTAssertEqual(result, "Test!@#$%^&*()")
    }

    func testUnicode() {
        let result = #Obfuscate("Hello 世界 🌍", .bytes)
        XCTAssertEqual(result, "Hello 世界 🌍")
    }

    func testLongString() {
        let original = "This is a longer string that tests the obfuscation of more substantial content to ensure it works correctly."
        let result = #Obfuscate("This is a longer string that tests the obfuscation of more substantial content to ensure it works correctly.", .xor)
        XCTAssertEqual(result, original)
    }
}
