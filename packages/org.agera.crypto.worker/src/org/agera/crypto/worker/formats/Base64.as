package org.agera.crypto.worker.formats {
    import flash.utils.ByteArray;
    import org.agera.crypto.workerShared.CryptoTask;
    import flash.system.ApplicationDomain;

    // Code based on by.blooddy.crypto
    // https://github.com/blooddy/blooddy_crypto
    public final class Base64 extends Format {
        public function Base64(task: CryptoTask) {
            super(task);
        }

        override public function encode(): Vector.<ByteArray> {
            ApplicationDomain.currentDomain.domainMemory = task.input;
            toDo();
            ApplicationDomain.currentDomain.domainMemory = null;
            return new <ByteArray>[output];
        }

        override public function decode(): Vector.<ByteArray> {
            ApplicationDomain.currentDomain.domainMemory = task.input;
            toDo();
            ApplicationDomain.currentDomain.domainMemory = null;
            return new <ByteArray>[output];
        }
    }
}