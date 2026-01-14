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

A Swift macro that obfuscates string literals at compile-time. Helps hide sensitive strings from static analysis.


## Installation

```swift
dependencies: [
    .package(url: "https://github.com/Aeastr/Obfuscate.git", from: "1.1.0")
]
```

```swift
import Obfuscate
```


## Usage

```swift
// Default (XOR)
let secret = #Obfuscate("MySecretString")

// With explicit method
let secret = #Obfuscate("MySecretString", .xor)
let secret = #Obfuscate("MySecretString", .bitShift)
let secret = #Obfuscate("MySecretString", .reversed)
let secret = #Obfuscate("MySecretString", .base64)
let secret = #Obfuscate("MySecretString", .bytes)
```

> [!NOTE]
> Xcode will prompt you to trust macros from this package on first use. This is standard for Swift macro packages—click "Trust & Enable" to proceed.


## Methods

All methods hide strings from basic static analysis (`strings` command, hex editors). Ranked by obfuscation strength:

| Rank | Method | Description |
|:----:|--------|-------------|
| 1 | `.xor` | XOR with random compile-time key (default) |
| 2 | `.bitShift` | Bit rotation with random shift amount |
| 3 | `.reversed` | Bytes stored reversed, flipped at runtime |
| 4 | `.base64` | String → Base64 → byte array |
| 5 | `.bytes` | String → raw UTF-8 byte array |

### Which to use?

- **`.xor`** — Best. Random key each build, no recognizable patterns, output varies per compilation.
- **`.bitShift`** — Very good. Random rotation each build, bytes are transformed beyond recognition.
- **`.reversed`** — Good. Simple and fast, string isn't readable forwards in the binary.
- **`.base64`** — Moderate. Recognizable Base64 charset/padding if found, but hides from basic analysis.
- **`.bytes`** — Minimal. Raw UTF-8 bytes are readable with hex editors. Included for completeness.

> [!TIP]
> For most use cases, `.xor` or `.bitShift` are recommended. All methods achieve the same goal—the ranking reflects resistance to manual reverse engineering.


## How It Works

At compile-time, the macro transforms your string into executable code that reconstructs it at runtime. The original string never appears in the binary.

**Example (`.xor`):**
```swift
#Obfuscate("CAFilter", .xor)
```

Becomes:
```swift
{
    let bytes: [UInt8] = [142, 164, 137, ...]  // XOR'd bytes
    let key: UInt8 = 203                        // Random key
    return String(bytes: bytes.map { $0 ^ key }, encoding: .utf8)!
}()
```


## License

MIT. See [LICENSE](LICENSE) for details.
