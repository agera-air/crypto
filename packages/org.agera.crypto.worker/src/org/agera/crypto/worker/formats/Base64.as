package org.agera.crypto.worker.formats {
    import avm2.intrinsics.memory.li8;
	import avm2.intrinsics.memory.si16;
	import avm2.intrinsics.memory.si8;
    import flash.system.ApplicationDomain;
    import flash.utils.ByteArray;
    import org.agera.crypto.workerShared.CryptoTask;

    public final class Base64 extends Format {
        private static const ENCODE_TABLE: ByteArray = new ByteArray();

		ENCODE_TABLE.writeUTFBytes(
			"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
		);

		private static const DECODE_TABLE:ByteArray = new ByteArray();

		DECODE_TABLE.writeUTFBytes(
			"\x40\x40\x40\x40\x40\x40\x40\x40\x43\x43\x43\x43\x43\x43\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x43\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x3e\x40\x40\x40\x3f\x34\x35\x36\x37\x38\x39\x3a\x3b\x3c\x3d\x40\x40\x40\x41\x40\x40\x40\x00\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f\x10\x11\x12\x13\x14\x15\x16\x17\x18\x19\x40\x40\x40\x40\x40\x40\x1a\x1b\x1c\x1d\x1e\x1f\x20\x21\x22\x23\x24\x25\x26\x27\x28\x29\x2a\x2b\x2c\x2d\x2e\x2f\x30\x31\x32\x33\x40\x40\x40\x40\x40" +
			"\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40\x40"
		);

        public function Base64(task: CryptoTask) {
            super(task);
        }

        // Code forked on by.blooddy.crypto
        // https://github.com/blooddy/blooddy_crypto
        override public function encode(): Vector.<ByteArray> {
            var bytes: ByteArray = task.input;
            var newLines: uint = task.insertNewLines;
            if ( newLines & 3 )	throw new FormatError("Range error in insertNewLines option.");

            if (!bytes || bytes.length <= 0) return new <ByteArray> [new ByteArray()];

            var insertNewLines: Boolean = newLines != 0;
			var len: uint = Math.ceil(bytes.length / 3) << 2;
			if (insertNewLines) {
				len += (int(len / newLines + 0.5) - 1) << 1;
				newLines *= 0.75;
			}

			var i: int = 63 + len - bytes.length + 2;
			if ( insertNewLines ) {
				i += newLines - i % newLines;
			}

            ApplicationDomain.currentDomain.domainMemory = memory;

            ApplicationDomain.currentDomain.domainMemory = null;
            return new <ByteArray>[output];
        }

        // Code forked on by.blooddy.crypto
        // https://github.com/blooddy/blooddy_crypto
        override public function decode(): Vector.<ByteArray> {
            ApplicationDomain.currentDomain.domainMemory = task.input;
            toDo();
            ApplicationDomain.currentDomain.domainMemory = null;
            return new <ByteArray>[output];
        }
    }
}