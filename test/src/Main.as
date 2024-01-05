package {
    import flash.display.Sprite;
    import org.agera.crypto.*;
    import org.agera.util.*;

    public class Main extends Sprite {
        public function Main() {
            /*
            encrypt("Some string", EncryptionFormat.BASE_64)
                .then(function(data: String): void {
                    assertEquals(data, "U29tZSBzdHJpbmc=");
                    trace("Base-64 encryption .. OK");
                })
                .otherwise(function(error: Error): void {
                    trace("Base-64 encryption .. ERROR");
                });
            */
            decrypt("U29tZSBzdHJpbmc=", EncryptionFormat.BASE_64)
                .then(function(data: String): void {
                    assertEquals(data, "Some string");
                    trace("Base-64 decryption .. OK");
                })
                .otherwise(function(error: Error): void {
                    trace("Base-64 decryption .. ERROR");
                });
        }
    }
}