package org.agera.crypto {
    import flash.utils.ByteArray;
    import org.agera.crypto.errors.*;
    import org.agera.crypto.workerShared.CryptoTask;
    import org.agera.crypto.workerShared.TaskType;
    import org.agera.util.*;

    /**
     * Decrypts data with the specified options.
     *
     * @param data Data to be decrypted.
     * @param format One of the constants defined in <code>EncryptionFormat</code>.
     * @param options Additional options — empty at the moment.
     * @return Decrypted data as a <code>Promise.&lt;ByteArray, EncryptionError&gt;</code>.
     */
    public function decryptBytes(data: ByteArray, format: String, options: Object = null): Promise {
        assert(EncryptionFormat.isValid(format), "Unknown encryption format: '" + format + "'.");
        var task: CryptoTask = new CryptoTask();
        task.format = format;
        task.input = data;
        task.taskType = TaskType.DECRYPT;
        return CryptoWorker.executeTask(task)
            .then(function(data: Array): ByteArray {
                return data[0];
            });
    }
}