package org.agera.crypto.events {
    import flash.events.*;

    /**
     * Event from a cryptographic operation.
     */
    public final class CryptoEvent extends Event {
        public static const COMPLETE: String = "complete";
        public static const ERROR: String = "error";

        /**
         * Encoded data, decoded data or an <code>Error</code> object.
         */
        public var data: Object = null;

        /**
         * Constructor.
         */
        public function CryptoEvent(type: String) {
            super(type);
        }
    }
}