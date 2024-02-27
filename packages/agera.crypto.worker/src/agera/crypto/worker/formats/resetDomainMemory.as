package agera.crypto.worker.formats {
    import flash.system.ApplicationDomain;
    import flash.utils.ByteArray;

    public function resetDomainMemory(): void {
        var memory: ByteArray = new ByteArray();
        if (memory.length < ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH) {
            memory.length = ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH;
        }
        memory.position = 0;
        ApplicationDomain.currentDomain.domainMemory = memory;
    }
}