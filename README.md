# org.agera.crypto

<p align="center">
  <a href="https://agera-air.github.io/api/org.agera.crypto">
    <img src="https://img.shields.io/badge/ActionScript%20API%20Documentation-gray">
  </a>
</p>

An ActionScript cryptography library. It supports only the cryptographic operations required by the WebSocket protocols at the present.

Supported encryptions:

* SHA-1 (160 bits)
* Base64

## Getting started

```as3
import org.agera.crypto.*;
import org.agera.crypto.events.*;

const encrypt: Encrypt = new Encrypt(data, {
    type: "sha1"
});
encrypt.addEventListener(CryptoEvent.COMPLETE, function(event: CryptoEvent): void {
    // event.data
});
encrypt.addEventListener(CryptoEvent.ERROR, function(event: CryptoEvent): void {
    // event.data: Error
});
encrypt.encrypt();
```

## License

Apache License 2.0