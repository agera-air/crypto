package org.agera.crypto {
    import org.agera.util.Promise;
    import org.agera.crypto.errors.*;
    import flash.utils.ByteArray;

    /**
     * Decrypts data with the specified options.
     *
     * @param data Data to be decrypted.
     * @param format One of the constants defined in <code>EncryptionFormat</code>.
     * @param options Additional options — refer to <code>decryptBytes()</code> for available options.
     * @return Decrypted data as a <code>Promise.&lt;String&gt;</code>.
     */
    public function decrypt(data: String, format: String, options: Object = null): Promise {
        var dataBytes: ByteArray = new ByteArray();
        dataBytes.writeUTFBytes(data);
        return decryptBytes(dataBytes, format, options)
            .then(function(outputBytes: ByteArray): String {
                outputBytes.position = 0;
                return outputBytes.readUTFBytes(outputBytes.length);
            });
    }
}