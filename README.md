# org.agera.crypto

<p align="center">
  <a href="https://agera-air.github.io/api/org.agera.crypto">
    <img src="https://img.shields.io/badge/ActionScript%20API%20Documentation-gray">
  </a>
</p>

An asynchronous ActionScript cryptography library for AIR SDK.

> **Disclaimer:** The algorithm codes are taken from the [by.blooddy.crypto](https://github.com/blooddy/blooddy_crypto) library, which was released in 2016. I do not own such algorithms used throughout the library.

Supported encryption formats:

* SHA-1
* Base-64

## Getting started

```as3
import org.agera.crypto.*;

// The encrypt() and decrypt() functions return a Promise object.

encrypt("Some string", EncryptionFormat.BASE_64)
    .then(function(data: String): void {
        // Complete
    })
    .otherwise(function(error: Error): void {
        // Error
    });

// Use the encryptBytes() and decryptBytes() functions
// for ByteArray operations.

encryptBytes(myByteArray, EncryptionFormat.BASE_64)
    .then(function(data: ByteArray): void {
        // Complete
    })
    .otherwise(function(error: Error): void {
        // Error
    });
```

## Building

The library is split into three ActionScript projects configured with an `asconfig.json` configuration file from the AS&MXML extension for Visual Studio Code. Use the `asconfigc` command to build a particular project.

## License

Apache License 2.0