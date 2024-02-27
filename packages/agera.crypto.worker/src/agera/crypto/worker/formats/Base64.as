package agera.crypto.worker.formats {
    import avm2.intrinsics.memory.li8;
    import avm2.intrinsics.memory.si16;
    import avm2.intrinsics.memory.si8;
    import flash.system.ApplicationDomain;
    import flash.utils.ByteArray;
    import agera.crypto.bridge.CryptoTask;

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
        // https://github.com/blooddy/blooddy_crypto/blob/master/LICENSE.md
        override public function encode(): Array {
            var bytes: ByteArray = task.input;
            var newLines: uint = task.insertNewLines;
            if (newLines & 3) {
                throw new FormatError("Range error in insertNewLines option.");
            }

            if (!bytes || bytes.length <= 0) return [new ByteArray()];

            var insertNewLines: Boolean = newLines != 0;
            var len: uint = Math.ceil(bytes.length / 3) << 2;
            if (insertNewLines) {
                len += (int(len / newLines + 0.5) - 1) << 1;
                newLines *= 0.75;
            }

            var i: int = 63 + len - bytes.length + 2;
            if (insertNewLines) {
                i += newLines - i % newLines;
            }

            var memory: ByteArray = new ByteArray();
            memory.writeBytes(ENCODE_TABLE);
            memory.position = i + 1;
            memory.writeBytes(bytes);
            var rest: uint = bytes.length % 3;
            var bytesLength: uint = memory.length - rest - 1;

            if (memory.length < ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH) {
                memory.length = ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH;
            }

            ApplicationDomain.currentDomain.domainMemory = memory;

            var j: int = 63;
            var c: int = 0;

            do {
                c = li8(++i) << 16 |
                    li8(++i) << 8  |
                    li8(++i)       ;

                si8( li8(   c >>> 18          ), ++j );
                si8( li8( ( c >>> 12 ) & 0x3F ), ++j );
                si8( li8( ( c >>> 6  ) & 0x3F ), ++j );
                si8( li8(   c          & 0x3F ), ++j );

                if ( insertNewLines && i % newLines == 0 ) {
                    si16( 0x0A0D, ++j );
                    ++j;
                }

            } while ( i < bytesLength );

            if ( rest ) {
                if ( rest == 1 ) {
                    c = li8( ++i );
                    si8( li8(   c >>> 2       ), ++j );
                    si8( li8( ( c & 3 ) <<  4 ), ++j );
                    si8( 61, ++j );
                    si8( 61, ++j );
                } else {
                    c =    ( li8( ++i ) << 8 )    |
                          li8( ++i )        ;
                    si8( li8(   c >>> 10          ), ++j );
                    si8( li8( ( c >>>  4 ) & 0x3F ), ++j );
                    si8( li8( ( c & 15 ) << 2     ), ++j );
                    si8( 61, ++j );
                }
            }

            resetDomainMemory();

            memory.position = 64;
            var output: ByteArray = new ByteArray();
            output.length = len;
            memory.readBytes(output, 0, len);
            return [output];
        }

        // Code forked on by.blooddy.crypto
        // https://github.com/blooddy/blooddy_crypto
        // https://github.com/blooddy/blooddy_crypto/blob/master/LICENSE.md
        override public function decode(): Array {
            if (task.input.length === 0) {
                return [new ByteArray()];
            }

            var memory: ByteArray = new ByteArray();
            memory.writeBytes(DECODE_TABLE);
            memory.writeBytes(task.input, 0);
            var bytesLength: uint = memory.length;
            memory.writeUTFBytes("=");

            if (memory.length < ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH) {
                memory.length = ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH;
            }

            ApplicationDomain.currentDomain.domainMemory = memory;

            var i: int = 255;
            var j: int = 255;

            var a: int = 0;
            var b: int = 0;
            var c: int = 0;
            var d: int = 0;

            do {

                a = li8( li8( ++i ) );
                if ( a >= 0x40 ) {
                    while ( a == 0x43 ) {
                        a = li8( li8( ++i ) );
                    }
                    if ( a == 0x41 ) {
                        b = c = d = 0x41;
                        break;
                    } else if ( a == 0x40 ) {
                        resetDomainMemory();
                        throw new FormatError("Decryption error");
                    }
                }

                b = li8( li8( ++i ) );
                if ( b >= 0x40 ) {
                    while ( b == 0x43 ) {
                        b = li8( li8( ++i ) );
                    }
                    if ( b == 0x41 ) {
                        c = d = 0x41;
                        break;
                    } else if ( b == 0x40 ) {
                        resetDomainMemory();
                        throw new FormatError("Decryption error");
                    }
                }

                c = li8( li8( ++i ) );
                if ( c >= 0x40 ) {
                    while ( c == 0x43 ) {
                        c = li8( li8( ++i ) );
                    }
                    if ( c == 0x41 ) {
                        d = 0x41;
                        break;
                    } else if ( c == 0x40 ) {
                        resetDomainMemory();
                        throw new FormatError("Decryption error");
                    }
                }

                d = li8( li8( ++i ) );
                if ( d >= 0x40 ) {
                    while ( d == 0x43 ) {
                        d = li8( li8( ++i ) );
                    }
                    if ( d == 0x41 ) {
                        break;
                    } else if ( d == 0x40 ) {
                        resetDomainMemory();
                        throw new FormatError("Decryption error");
                    }
                }

                si8( ( a << 2 ) | ( b >> 4 ), ++j );
                si8( ( b << 4 ) | ( c >> 2 ), ++j );
                si8( ( c << 6 ) |   d       , ++j );

            } while ( true );

            while ( i < bytesLength ) {
                if ( !( li8( li8( ++i ) & 0x41 ) ) ) {
                    resetDomainMemory();
                    throw new FormatError("Decryption error");
                }
            }

            if ( a != 0x41 && b != 0x41 ) {
                si8( ( a << 2 ) | ( b >> 4 ), ++j );
                if ( c != 0x41 ) {
                    si8( ( b << 4 ) | ( c >> 2 ), ++j );
                    if ( d != 0x41 ) {
                        si8( ( c << 6 ) | d, ++j );
                    }
                }
            }

            resetDomainMemory();

            var result: ByteArray = new ByteArray;
            if (j > 255) {
                memory.position = 256;
                memory.readBytes(result, 0, j - 255);
            }
            return [result];
        }
    }
}