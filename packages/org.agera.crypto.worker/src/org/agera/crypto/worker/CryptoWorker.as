package org.agera.crypto.worker {
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.net.registerClassAlias;
    import flash.system.Worker;
    import flash.system.MessageChannel
    import org.agera.crypto.workerShared.*;

    public class CryptoWorker extends Sprite {
        private var executeTaskChannel: MessageChannel;
        private var completeChannel: MessageChannel;
        private var errorChannel: MessageChannel;
        private const taskQueue: Vector.<CryptoTask> = new <CryptoTask> [];
        private var isExecutingTasks: Boolean = false;

        public function CryptoWorker() {
            this.initialize();
        }
        
        private function initialize(): void {
            // Register class aliases
            registerClassAlias("org.agera.crypto.workerShared.CryptoTask", CryptoTask);
            registerClassAlias("org.agera.crypto.workerShared.CompletionMessage", CompletionMessage);
            registerClassAlias("org.agera.crypto.workerShared.ErrorMessage", ErrorMessage);

            // Get the MessageChannel objects
            this.executeTaskChannel = Worker.current.getSharedProperty("executeTaskChannel") as MessageChannel;
            this.executeTaskChannel.addEventListener(Event.CHANNEL_MESSAGE, this.handleAddTaskMessage);
            this.completeChannel = Worker.current.getSharedProperty("completeChannel") as MessageChannel;
            this.errorChannel = Worker.current.getSharedProperty("errorChannel") as MessageChannel;
        }

        private function executeTasks(): void {
            if (this.isExecutingTasks) {
                return;
            }
            this.isExecutingTasks = true;
            while (this.taskQueue.length != 0) {
                const task: CryptoTask = this.taskQueue.shift();
                this.executeTask(task);
            }
            this.isExecutingTasks = false;
        }

        private function executeTask(task: CryptoTask): void {
            toDo();
        }

        private function handleAddTaskMessage(event: Event): void {
            if (!executeTaskChannel.messageAvailable) {
                return;
            }
            const task: CryptoTask = executeTaskChannel.receive() as CryptoTask;
            if (task != null) {
                this.taskQueue.push(task);
                this.executeTasks();
            }
        }
    }
}