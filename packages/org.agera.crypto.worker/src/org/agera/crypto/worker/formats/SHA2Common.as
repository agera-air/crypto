package org.agera.crypto.worker.formats {
    import flash.utils.ByteArray;
    import flash.system.ApplicationDomain;

    import avm2.intrinsics.memory.li32;
    import avm2.intrinsics.memory.li8;
    import avm2.intrinsics.memory.si32;
    import avm2.intrinsics.memory.si8;

    public class SHA2Common {
        private static const _K: ByteArray = ( function(): ByteArray {
            var tmp: ByteArray = ApplicationDomain.currentDomain.domainMemory;

            var mem: ByteArray = new ByteArray();
            mem.length = Math.max(256, ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH);

            ApplicationDomain.currentDomain.domainMemory = mem;

            var k: Vector.<uint> = new <uint>[
                0x428a2f98, 0x71374491, 0xb5c0fbcf, 0xe9b5dba5, 0x3956c25b, 0x59f111f1, 0x923f82a4, 0xab1c5ed5,
                0xd807aa98, 0x12835b01, 0x243185be, 0x550c7dc3, 0x72be5d74, 0x80deb1fe, 0x9bdc06a7, 0xc19bf174,
                0xe49b69c1, 0xefbe4786, 0x0fc19dc6, 0x240ca1cc, 0x2de92c6f, 0x4a7484aa, 0x5cb0a9dc, 0x76f988da,
                0x983e5152, 0xa831c66d, 0xb00327c8, 0xbf597fc7, 0xc6e00bf3, 0xd5a79147, 0x06ca6351, 0x14292967,
                0x27b70a85, 0x2e1b2138, 0x4d2c6dfc, 0x53380d13, 0x650a7354, 0x766a0abb, 0x81c2c92e, 0x92722c85,
                0xa2bfe8a1, 0xa81a664b, 0xc24b8b70, 0xc76c51a3, 0xd192e819, 0xd6990624, 0xf40e3585, 0x106aa070,
                0x19a4c116, 0x1e376c08, 0x2748774c, 0x34b0bcb5, 0x391c0cb3, 0x4ed8aa4a, 0x5b9cca4f, 0x682e6ff3,
                0x748f82ee, 0x78a5636f, 0x84c87814, 0x8cc70208, 0x90befffa, 0xa4506ceb, 0xbef9a3f7, 0xc67178f2
            ];
            
            var i: int = 0;
            do {
                si32( k[ i ], i << 2 );
            } while( ++i < 64 );
            
            ApplicationDomain.currentDomain.domainMemory = tmp;

            mem.length = 256;

            return mem;
        } )();

        // Code forked on by.blooddy.crypto
        // https://github.com/blooddy/blooddy_crypto
        public static function encode(bytes: ByteArray, H: Vector.<int>): ByteArray {
            var memory: ByteArray = digest(bytes, H);

            memory.position = 16;
            memory.writeBytes(memory, 0, 32);

            memory.position = 0;
            memory.writeUTFBytes("0123456789abcdef");

            if (memory.length < ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH) {
                memory.length = ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH;
            }

            ApplicationDomain.currentDomain.domainMemory = memory;

            var k: int = 0;
            var i: int = 16;
            var j: int = 16 + 32 - 1;

            do {
                k = li8( i );
                si8( li8( k >>> 4 ), ++j );
                si8( li8( k & 0xF ), ++j );
            } while (++i < 16 + 32);

            resetDomainMemory();

            memory.position = 16 + 32;
            var output: ByteArray = new ByteArray();
            output.length = 32 * 2;
            memory.readBytes(output, 0, 32 * 2);
            return output;
        }

        // Code forked on by.blooddy.crypto
        // https://github.com/blooddy/blooddy_crypto
        /**
         * @param H Hash constants.
         */
        public static function digest(bytes: ByteArray, H: Vector.<int>): ByteArray {
            var i: uint = bytes.length << 3;
            var bytesLength: uint = 512 + ( ( i + 64 >>> 9 << 4 ) + 15 << 2 );

            var mem: ByteArray = new ByteArray();
            mem.length = bytesLength + 4;
            mem.position = 256;
            mem.writeBytes( _K );
            mem.writeBytes( bytes );

            if ( mem.length < ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH ) {
                mem.length = ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH;
            }
            ApplicationDomain.currentDomain.domainMemory = mem;

            si32(
                li32( 512 + ( i >>> 5 << 2 ) ) | 0x80 << i % 32,
                      512 + ( i >>> 5 << 2 )
            );

            si8( i >> 24, bytesLength     );
            si8( i >> 16, bytesLength + 1 );
            si8( i >>  8, bytesLength + 2 );
            si8( i      , bytesLength + 3 );

            var h0:int = H[ 0 ];
            var h1:int = H[ 1 ];
            var h2:int = H[ 2 ];
            var h3:int = H[ 3 ];
            var h4:int = H[ 4 ];
            var h5:int = H[ 5 ];
            var h6:int = H[ 6 ];
            var h7:int = H[ 7 ];

            var a:int = 0;
            var b:int = 0;
            var c:int = 0;
            var d:int = 0;
            var e:int = 0;
            var f:int = 0;
            var g:int = 0;
            var h:int = 0;

            var t1:int = 0;
            var t2:int = 0;

            var w:int = 0;
            var t:int = 0;

            i = 512;
            do {

                a = h0;
                b = h1;
                c = h2;
                d = h3;
                e = h4;
                f = h5;
                g = h6;
                h = h7;

                t = 0;
                
                // phase( a, b, c, d, e, f, g, h, i, t, 16 );
                do {

                    w = li8( i + t     ) << 24 |
                        li8( i + t + 1 ) << 16 |
                        li8( i + t + 2 ) <<  8 |
                        li8( i + t + 3 )       ;

                    si32( w, t );

                    t1 = h +
                        ( ( e << 26 | e >>> 6 ) ^ ( e << 21 | e >>> 11 ) ^ ( e << 7 | e >>> 25 ) ) +
                        ( ( e & f ) ^ ( ~e & g ) ) +
                        li32( 256 + t ) +
                        w;
                    t2 = ( ( a << 30 | a >>> 2 ) ^ ( a << 19 | a >>> 13 ) ^ ( a << 10 | a >>> 22 ) ) +
                        ( ( a & b ) ^ ( a & c ) ^ ( b & c ) );

                    h = g;
                    g = f;
                    f = e;
                    e = d + t1;
                    d = c;
                    c = b;
                    b = a;
                    a = t1 + t2;

                    t += 4;

                } while ( t < 64 );
                
                // phase( a, b, c, d, e, f, g, h, i, t, 64 );
                do {

                    t1 = li32( t - 2 * 4 );
                    t2 = li32( t - 15 * 4 );

                    w = ( ( t1 << 15 | t1 >>> 17 ) ^ ( t1 << 13 | t1 >>> 19 ) ^ ( t1 >>> 10) ) +
                        li32( t - 28 ) +
                        ( ( t2 << 25 | t2 >>> 7 ) ^ ( t2 << 14 | t2 >>> 18 ) ^ ( t2 >>> 3 ) ) +
                        li32( t - 64 );

                    si32( w, t );

                    t1 = h +
                        ( ( e << 26 | e >>> 6 ) ^ ( e << 21 | e >>> 11 ) ^ ( e << 7 | e >>> 25 ) ) +
                        ( ( e & f ) ^ ( ~e & g ) ) +
                        li32( 256 + t ) +
                        w;
                    t2 = ( ( a << 30 | a >>> 2 ) ^ ( a << 19 | a >>> 13 ) ^ ( a << 10 | a >>> 22 ) ) +
                        ( ( a & b ) ^ ( a & c ) ^ ( b & c ) );

                    h = g;
                    g = f;
                    f = e;
                    e = d + t1;
                    d = c;
                    c = b;
                    b = a;
                    a = t1 + t2;

                    t += 4;

                } while ( t < 256 );

                h0 += a;
                h1 += b;
                h2 += c;
                h3 += d;
                h4 += e;
                h5 += f;
                h6 += g;
                h7 += h;

                i += 64;

            } while ( i < bytesLength );
            
            si8( h0 >> 24,  0 );
            si8( h0 >> 16,  1 );
            si8( h0 >>  8,  2 );
            si8( h0      ,  3 );

            si8( h1 >> 24,  4 );
            si8( h1 >> 16,  5 );
            si8( h1 >>  8,  6 );
            si8( h1      ,  7 );

            si8( h2 >> 24,  8 );
            si8( h2 >> 16,  9 );
            si8( h2 >>  8, 10 );
            si8( h2      , 11 );

            si8( h3 >> 24, 12 );
            si8( h3 >> 16, 13 );
            si8( h3 >>  8, 14 );
            si8( h3      , 15 );

            si8( h4 >> 24, 16 );
            si8( h4 >> 16, 17 );
            si8( h4 >>  8, 18 );
            si8( h4      , 19 );
            
            si8( h5 >> 24, 20 );
            si8( h5 >> 16, 21 );
            si8( h5 >>  8, 22 );
            si8( h5      , 23 );

            si8( h6 >> 24, 24 );
            si8( h6 >> 16, 25 );
            si8( h6 >>  8, 26 );
            si8( h6      , 27 );

            si8( h7 >> 24, 28 );
            si8( h7 >> 16, 29 );
            si8( h7 >>  8, 30 );
            si8( h7      , 31 );

            resetDomainMemory();

            mem.position = 0;
            mem.length = 32;
            return mem;
        }
    }
}