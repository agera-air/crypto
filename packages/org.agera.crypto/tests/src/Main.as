package {
    import flash.display.Sprite;
    import org.agera.crypto.*;

    public class Main extends Sprite {
        public function Main() {
            encrypt("Some string", EncryptionFormat.BASE_64)
                .then(function(data: String): void {
                    trace(data);
                })
                .otherwise(function(error: Error): void {
                    trace(error);
                });
        }
    }
}