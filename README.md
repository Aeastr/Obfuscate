<div align="center">
  <h1><b>Obfuscate</b></h1>
  <p>
    Compile-time string obfuscation macro for Swift.
  </p>
</div>

<p align="center">
  <a href="https://swift.org"><img src="https://img.shields.io/badge/Swift-6.0+-F05138?logo=swift&logoColor=white" alt="Swift 6.0+"></a>
  <a href="https://developer.apple.com"><img src="https://img.shields.io/badge/iOS-13+-000000?logo=apple" alt="iOS 13+"></a>
  <a href="https://developer.apple.com"><img src="https://img.shields.io/badge/macOS-10.15+-000000?logo=apple" alt="macOS 10.15+"></a>
  <a href="https://developer.apple.com"><img src="https://img.shields.io/badge/tvOS-13+-000000?logo=apple" alt="tvOS 13+"></a>
  <a href="https://developer.apple.com"><img src="https://img.shields.io/badge/watchOS-6+-000000?logo=apple" alt="watchOS 6+"></a>
  <a href="https://developer.apple.com"><img src="https://img.shields.io/badge/visionOS-1+-000000?logo=apple" alt="visionOS 1+"></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/License-MIT-green.svg" alt="License: MIT"></a>
</p>


## Overview

A Swift macro that obfuscates string literals at compile-time by converting them to Base64-encoded byte arrays. Helps hide sensitive strings from static analysis.


## Installation

```swift
dependencies: [
    .package(url: "https://github.com/Aeastr/Obfuscate.git", from: "1.0.0")
]
```

```swift
import Obfuscate
```


## Usage

```swift
let secret = #Obfuscate("MySecretString")
// Compiles to byte array → Base64 decode → String at runtime
```

> [!NOTE]
> Xcode will prompt you to trust macros from this package on first use. This is standard for Swift macro packages—click "Trust & Enable" to proceed.


## How It Works

At compile-time, the macro transforms:
```swift
#Obfuscate("CAFilter")
```

Into:
```swift
{
    let characters: [UInt8] = [81, 48, 70, 71, ...]
    let base64 = String(bytes: characters, encoding: .utf8)!
    let data = Data(base64Encoded: base64.data(using: .utf8)!)!
    return String(data: data, encoding: .utf8)!
}()
```

The original string never appears in the binary.


## License

MIT. See [LICENSE](LICENSE) for details.
