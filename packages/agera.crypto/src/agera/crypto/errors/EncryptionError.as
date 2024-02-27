package agera.crypto.errors {
    /**
     * Represents an encryption error.
     */
    public final class EncryptionError extends Error {
        /**
         * Constructor.
         */
        public function EncryptionError(message: String) {
            super(message);
        }
    }
}