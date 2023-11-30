package org.agera.crypto {
    import org.agera.crypto.errors.*;
    import org.agera.util.Promise;
    import flash.utils.ByteArray;

    /**
     * Encrypts data with the specified options.
     *
     * @param data Data to be encrypted.
     * @param format One of the constants defined in <code>EncryptionFormat</code>.
     * @param options Additional options — refer to <code>encryptBytes()</code> for available options.
     * @return Encrypted data as a <code>Promise.&lt;String, EncryptionError&gt;</code>.
     */
    public function encrypt(data: String, format: String, options: Object = null): Promise {
        var dataBytes: ByteArray = new ByteArray();
        dataBytes.writeUTFBytes(data);
        return encryptBytes(dataBytes, format, options)
            .then(function(outputBytes: ByteArray): String {
                outputBytes.position = 0;
                return outputBytes.readUTFBytes(outputBytes.length);
            });
    }
}