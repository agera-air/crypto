# agera.crypto

<p align="center">
  <a href="https://agera-air.github.io/api/agera.crypto">
    <img src="https://img.shields.io/badge/ActionScript%20API%20Documentation-gray">
  </a>
</p>

An asynchronous ActionScript cryptography library for AIR SDK.

> **Disclaimer:** The algorithm codes are taken from the [by.blooddy.crypto](https://github.com/blooddy/blooddy_crypto) library, released in 2016. I do not own such algorithms. The license of the by.blooddy.crypto repository is mentioned wherever applicable.

Supported encryption formats:

* SHA-1
* SHA-256
* Base-64

## Getting started

```as3
import agera.crypto.*;

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

Requirements:

* `asconfigc` from [AS&MXML](https://as3mxml.com)
* Node.js

Run the `run/build` script to build a SWC artifact located at `swc/agera.crypto.swc`.

For testing, run the `run/test` script to test the library.

## License

Apache License 2.0