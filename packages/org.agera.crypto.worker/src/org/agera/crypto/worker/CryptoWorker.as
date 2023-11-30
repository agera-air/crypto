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
            this.executeTasks();
        }
        
        private function initialize(): void {
            // Register class aliases
            registerClassAliases();

            // Get the MessageChannel objects
            this.executeTaskChannel = Worker.current.getSharedProperty("executeTaskChannel") as MessageChannel;
            this.executeTaskChannel.addEventListener(Event.CHANNEL_MESSAGE, this.handleAddTaskMessage);
            this.completeChannel = Worker.current.getSharedProperty("completeChannel") as MessageChannel;
            this.errorChannel = Worker.current.getSharedProperty("errorChannel") as MessageChannel;
        }

        private function executeTasks(): void {
            while (Infinity) {
                if (this.taskQueue.length != 0) {
                    const task: CryptoTask = this.taskQueue.shift();
                    this.executeTask(task);
                }
            }
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
            }
        }
    }
}