package org.agera.crypto.workerShared {
    import flash.utils.ByteArray;

    /**
     * @private
     */
    public final class ErrorMessage {
        public var taskId: String;
        public var message: String;
        public function ErrorMessage(taskId: String = "", message: String = "") {
            this.taskId = taskId;
            this.message = message;
        }
    }
}