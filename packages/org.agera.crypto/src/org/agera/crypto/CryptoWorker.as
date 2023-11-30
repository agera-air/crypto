package org.agera.crypto {
    import flash.events.Event;
    import flash.net.registerClassAlias;
    import flash.system.MessageChannel;
    import flash.system.Worker;
    import flash.system.WorkerDomain;
    import flash.system.WorkerState;
    import org.agera.crypto.errors.*;
    import org.agera.crypto.workerShared.*;
    import org.agera.util.Promise;

    /**
     * @private
     */
    internal final class CryptoWorker {
        private static var backgroundWorker: Worker;
        private static var executeTaskChannel: MessageChannel;
        private static var completeChannel: MessageChannel;
        private static var errorChannel: MessageChannel;

        /**
         * Resolves to <code>Vector.&lt;ByteArray&gt;</code>.
         */
        public static function executeTask(task: CryptoTask): Promise {
            initializeWorker();

            return new Promise(function(resolve: Function, reject: Function): void {
                function onCompleteMessage(event: Event): void {
                    const message: CompletionMessage = completeChannel.receive();
                    resolve(message.data);
                }
                function onErrorMessage(event: Event): void {
                    const message: ErrorMessage = errorChannel.receive();
                    resolve(new EncryptionError(message.message));
                }

                completeChannel.addEventListener(Event.CHANNEL_MESSAGE, onCompleteMessage);
                errorChannel.addEventListener(Event.CHANNEL_MESSAGE, onErrorMessage);
            });
        }

        private static function initializeWorker(): void {
            if (backgroundWorker != null) {
                return;
            }

            // Register class aliases
            registerClassAliases();

            // Create the backgrund Worker
            backgroundWorker = WorkerDomain.current.createWorker(swfBytesHere);

            // Set up the MessageChannel for executing (sending) a task
            executeTaskChannel = Worker.current.createMessageChannel(backgroundWorker);
            backgroundWorker.setSharedProperty("executeTaskChannel", executeTaskChannel);

            // Set up the MessageChannel for receiving output on completion
            completeChannel = backgroundWorker.createMessageChannel(Worker.current);
            backgroundWorker.setSharedProperty("completeChannel", completeChannel);

            // Set up the MessageChannel for receiving output on error
            errorChannel = backgroundWorker.createMessageChannel(Worker.current);
            backgroundWorker.setSharedProperty("errorChannel", errorChannel);

            backgroundWorker.start();
        }
    }
}