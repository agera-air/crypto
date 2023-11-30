package org.agera.crypto.workerShared {
    import flash.utils.ByteArray;
    public final class CompletionMessage {
        public var data: Vector.<ByteArray>;
        public function CompletionMessage(data: Vector.<ByteArray>) {
            this.data = data;
        }
    }
}