package org.agera.crypto {
    import flash.utils.ByteArray;
    import org.agera.crypto.errors.*;
    import org.agera.crypto.workerShared.*;
    import org.agera.util.Promise;

    /**
     * Decrypts data with the specified options.
     *
     * @param data Data to be decrypted.
     * @param format One of the constants defined in <code>EncryptionFormat</code>.
     * @param options Additional options — empty at the moment.
     * @return Decrypted data as a <code>Promise.&lt;ByteArray, EncryptionError&gt;</code>.
     */
    public function decryptBytes(data: ByteArray, format: String, options: Object = null): Promise {
    }
}