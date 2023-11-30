package org.agera.crypto {
    import flash.utils.ByteArray;
    import org.agera.crypto.errors.*;
    import org.agera.crypto.workerShared.*;
    import org.agera.util.Promise;

    /**
     * Encrypts data with the specified options.
     *
     * @param data Data to be encrypted.
     * @param format One of the constants defined in <code>EncryptionFormat</code>.
     * @param options Additional options — empty at the moment.
     * @return Encrypted data as a <code>Promise.&lt;ByteArray, EncryptionError&gt;</code>.
     */
    public function encryptBytes(data: ByteArray, format: String, options: Object = null): Promise {
    }
}