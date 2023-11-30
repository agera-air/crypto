package org.agera.crypto.workerShared {
    import flash.net.registerClassAlias;

    public function registerClassAliases(): void {
        // Register class aliases
        registerClassAlias("org.agera.crypto.workerShared.CryptoTask", CryptoTask);
        registerClassAlias("org.agera.crypto.workerShared.CompletionMessage", CompletionMessage);
        registerClassAlias("org.agera.crypto.workerShared.ErrorMessage", ErrorMessage);
    }
}