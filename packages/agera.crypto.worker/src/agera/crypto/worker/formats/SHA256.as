package agera.crypto.worker.formats {
    import flash.utils.ByteArray;
    import flash.system.ApplicationDomain;
    import agera.crypto.bridge.CryptoTask;

    public final class SHA256 extends Format {
        private static const _H: Vector.<int> = Vector.<int>(new <uint>[
            0x6a09e667, 0xbb67ae85, 0x3c6ef372, 0xa54ff53a,
            0x510e527f, 0x9b05688c, 0x1f83d9ab, 0x5be0cd19
        ]);

        public function SHA256(task: CryptoTask) {
            super(task);
        }

        // Code forked on by.blooddy.crypto
        // https://github.com/blooddy/blooddy_crypto
        override public function encode(): Array {
            return [SHA2Common.encode(task.input, _H)];
        }

        override public function decode(): Array {
            throw new FormatError("SHA-256 decryption is unsupported.");
        }
    }
}