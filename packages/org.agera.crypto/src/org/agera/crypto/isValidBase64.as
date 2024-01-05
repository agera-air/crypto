package org.agera.crypto {
    /**
     * Indicates whether the parameter is a valid base-64 string.
     */
    public function isValidBase64(string: String): Boolean {
        return /^[A-Za-z\d\+\/\s\v\b]*[=\s\v\b]*$/.test(string);
    }
}