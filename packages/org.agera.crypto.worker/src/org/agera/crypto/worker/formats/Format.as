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
            }
            throw new Error("Non-exhaustive constant match");
        }

        /**
         * @throws org.agera.crypto.worker.formats.FormatError
         */
        public function encode(): Vector.<ByteArray> {
            return new <ByteArray> [];
        }

        /**
         * @throws org.agera.crypto.worker.formats.FormatError
         */
        public function decode(): Vector.<ByteArray> {
            return new <ByteArray> [];
        }
    }
}