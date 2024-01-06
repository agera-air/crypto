package org.agera.crypto.worker.formats {
    import org.agera.crypto.workerShared.CryptoTask;
    import flash.utils.ByteArray;
    import org.agera.crypto.workerShared.EncryptionFormat;

    public class Format {
        protected var task: CryptoTask;

        public function Format(task: CryptoTask) {
            this.task = task;
        }

        public static function from(task: CryptoTask): Format {
            switch (task.format) {
                case EncryptionFormat.BASE_64: return new Base64(task);
                case EncryptionFormat.SHA_1: return new SHA1(task);
                case EncryptionFormat.SHA_256: return new SHA256(task);
            }
            throw new Error("Non-exhaustive constant match");
        }

        /**
         * @throws org.agera.crypto.worker.formats.FormatError
         */
        public function encode(): Array {
            return [];
        }

        /**
         * @throws org.agera.crypto.worker.formats.FormatError
         */
        public function decode(): Array {
            return [];
        }
    }
}