package agera.crypto.bridge {
    import flash.net.registerClassAlias;

    /**
     * @private
     */
    public function registerClassAliases(): void {
        // Register class aliases
        registerClassAlias("agera.crypto.bridge.CryptoTask", CryptoTask);
        registerClassAlias("agera.crypto.bridge.CompletionMessage", CompletionMessage);
        registerClassAlias("agera.crypto.bridge.ErrorMessage", ErrorMessage);
    }
}