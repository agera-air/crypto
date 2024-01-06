package org.agera.crypto {
    /**
     * Defines constants for available encryption formats.
     */
    public final class EncryptionFormat {
        public static const SHA_1: String = "sha1";
        public static const SHA_256: String = "sha256";
        public static const BASE_64: String = "base64";

        /**
         * @private
         */
        public function EncryptionFormat() {}

        public static function isValid(value: String): Boolean {
            return [
                "sha1",
                "sha256",
                "base64",
            ].indexOf(value) != -1;
        }
    }
}