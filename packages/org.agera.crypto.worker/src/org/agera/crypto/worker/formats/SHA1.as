package org.agera.crypto.worker.formats {
    import flash.utils.ByteArray;
    import org.agera.crypto.workerShared.CryptoTask;
    import flash.system.ApplicationDomain;

    public final class SHA1 extends Format {
        public function SHA1(task: CryptoTask) {
            super(task);
        }

        override public function encode(): Vector.<ByteArray> {
            ApplicationDomain.currentDomain.domainMemory = task.input;
            var output: ByteArray = new ByteArray();
            toDo();
            return new <ByteArray>[output];
        }

        override public function decode(): Vector.<ByteArray> {
            ApplicationDomain.currentDomain.domainMemory = task.input;
            var output: ByteArray = new ByteArray();
            toDo();
            return new <ByteArray>[output];
        }
    }
}