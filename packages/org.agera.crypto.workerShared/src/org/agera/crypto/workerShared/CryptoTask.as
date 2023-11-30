package org.agera.crypto.workerShared {
    import flash.utils.ByteArray;

    public final class CryptoTask {
        public var input: ByteArray;

        /**
         * An <code>EncryptionFormat</code> constant.
         */
        public var format: String;

        /**
         * A <code>TaskType</code> constant.
         */
        public var taskType: String;
    }
}