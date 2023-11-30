package org.agera.crypto.workerShared {
    import flash.utils.ByteArray;

    /**
     * @private
     */
    public final class CompletionMessage {
        public var taskId: String;
        public var data: Vector.<ByteArray>;
        public function CompletionMessage(taskId: String, data: Vector.<ByteArray>) {
            this.taskId = taskId;
            this.data = data;
        }
    }
}