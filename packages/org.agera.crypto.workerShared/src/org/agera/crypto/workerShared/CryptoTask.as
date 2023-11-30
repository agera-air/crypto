package org.agera.crypto.workerShared {
    import flash.utils.ByteArray;

    /**
     * @private
     */
    public final class CryptoTask {
        public var id: String;

        public var input: ByteArray;

        /**
         * An <code>EncryptionFormat</code> constant.
         */
        public var format: String;

        /**
         * A <code>TaskType</code> constant.
         */
        public var taskType: String;

        public function CryptoTask() {
            this.id = "(" + Math.random().toString() + "," + Math.random().toString() + ")";
        }
    }
}