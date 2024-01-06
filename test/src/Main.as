package {
    import flash.display.Sprite;
    import org.agera.crypto.*;
    import org.agera.util.*;

    public class Main extends Sprite {
        public function Main() {
            // Base-64
            encrypt("Some string", EncryptionFormat.BASE_64)
                .then(function(data: String): void {
                    assertEquals(data, "U29tZSBzdHJpbmc=");
                    trace("Base-64 encryption .. OK");
                })
                .otherwise(function(error: Error): void {
                    trace("Base-64 encryption .. ERROR");
                });
            decrypt("U29tZSBzdHJpbmc=", EncryptionFormat.BASE_64)
                .then(function(data: String): void {
                    assertEquals(data, "Some string");
                    trace("Base-64 decryption .. OK");
                })
                .otherwise(function(error: Error): void {
                    trace("Base-64 decryption .. ERROR");
                });

            // SHA-1
            encrypt("Some string", EncryptionFormat.SHA_1)
                .then(function(data: String): void {
                    assertEquals(data, "3febe4d69db2a2d620fa73388dbd3aed38be5575");
                    trace("SHA-1 encryption .. OK");
                })
                .otherwise(function(error: Error): void {
                    trace("SHA-1 encryption .. ERROR");
                });
        }
    }
}