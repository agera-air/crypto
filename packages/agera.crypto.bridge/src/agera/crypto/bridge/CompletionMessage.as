package agera.crypto.bridge {
    import flash.utils.ByteArray;

    /**
     * @private
     */
    public final class CompletionMessage {
        public var taskId: String;
        /**
         * Array of <code>ByteArray</code>s.
         */
        public var data: Array;
        public function CompletionMessage(taskId: String = "", data: Array = null) {
            this.taskId = taskId;
            this.data = data;
        }
    }
}