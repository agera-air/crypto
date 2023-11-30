# org.agera.crypto

<p align="center">
  <a href="https://agera-air.github.io/api/org.agera.crypto">
    <img src="https://img.shields.io/badge/ActionScript%20API%20Documentation-gray">
  </a>
</p>

An ActionScript cryptography library for AIR SDK.

Supported encryption formats:

* SHA-1 (160 bits)
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

## License

Apache License 2.0