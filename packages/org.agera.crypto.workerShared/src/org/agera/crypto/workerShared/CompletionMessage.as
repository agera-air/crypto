package org.agera.crypto.workerShared {
    import flash.utils.ByteArray;
    public final class CompletionMessage {
        public var data: ByteArray;
        public function CompletionMessage(data: ByteArray) {
            this.data = data;
        }
    }
}