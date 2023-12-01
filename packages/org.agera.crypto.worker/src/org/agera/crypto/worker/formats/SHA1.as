package org.agera.crypto.worker.formats {
    import flash.utils.ByteArray;
    import flash.system.ApplicationDomain;
    import org.agera.crypto.workerShared.CryptoTask;

    import avm2.intrinsics.memory.li32;
    import avm2.intrinsics.memory.li8;
    import avm2.intrinsics.memory.si32;
    import avm2.intrinsics.memory.si8;

    // Code based on by.blooddy.crypto
    // https://github.com/blooddy/blooddy_crypto
    public final class SHA1 extends Format {
        public function SHA1(task: CryptoTask) {
            super(task);
        }

        override public function encode(): Vector.<ByteArray> {
            var memory: ByteArray = digest(task.input);

            memory.position = 16;
            memory.writeBytes(memory, 0, 20);

            memory.position = 0;
            memory.writeUTFBytes("0123456789abcdef");

            memory.length = 16 + 20 + 20 * 2;

            if (memory.length < ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH) {
                memory.length = ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH;
            }

            ApplicationDomain.currentDomain.domainMemory = task.input;

            var k: int = 0;
            var i: int = 16;
            var j: int = 16 + 20 - 1;

            do {
                k = li8(i);
                si8(li8(k >>> 4), ++j);
                si8(li8(k & 0xF), ++j);
            } while (++i < 16 + 20);

            ApplicationDomain.currentDomain.domainMemory = null;

            memory.position = 16 + 20;
            var output: ByteArray = new ByteArray();
            output.length = 20 * 2;
            memory.readBytes(output, 0, 20 * 2);
            return new <ByteArray>[output];
        }

        private function digest(bytes: ByteArray): ByteArray {
            var i: int = bytes.length << 3;
            var bytesLength: int = 80 * 4 + (((((i + 64) >>> 9) << 4) + 15) << 2);
            
            var memory: ByteArray = new ByteArray();
            memory.length = bytesLength + 4
            memory.position = 80 * 4;
            memory.writeBytes( bytes );
                
            if (memory.length < ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH) {
                memory.length = ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH;
            }
        }

        override public function decode(): Vector.<ByteArray> {
            throw new FormatError("SHA-1 decryption is unsupported.");
        }
    }
}