package org.agera.crypto {
    import flash.utils.ByteArray;
    import org.agera.crypto.errors.*;
    import org.agera.crypto.workerShared.CryptoTask;
    import org.agera.crypto.workerShared.TaskType;
    import org.agera.util.*;

    /**
     * Encrypts data with the specified options.
     * 
     * <p>
     * The <code>options</code> parameter accepts an object with additional options:
     * <ul>
     *   <li><code>insertNewLines</code> — For the base-64 encoding, indicates a number of new lines to add.
     *     Defaults to zero.</li>
     * </ul>
     * </p>
     *
     * @param data Data to be encrypted.
     * @param format One of the constants defined in <code>EncryptionFormat</code>.
     * @param options Additional options.
     * @return Encrypted data as a <code>Promise.&lt;ByteArray&gt;</code>.
     */
    public function encryptBytes(data: ByteArray, format: String, options: Object = null): Promise {
        assert(EncryptionFormat.isValid(format), "Unknown encryption format: '" + format + "'.");
        var task: CryptoTask = new CryptoTask();
        task.format = format;
        task.input = data;
        data.position = 0;
        task.taskType = TaskType.ENCRYPT;
        task.insertNewLines = options !== null ? uint(options.insertNewLines) : 0;
        return CryptoWorker.executeTask(task)
            .then(function(data: Array): ByteArray {
                return data[0];
            });
    }
}