package util;

import java.io.UnsupportedEncodingException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.KeySpec;
import java.util.UUID;
import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.PBEKeySpec;
import javax.crypto.spec.SecretKeySpec;
import org.apache.commons.codec.DecoderException;
import static org.apache.commons.codec.binary.Base64.decodeBase64;
import static org.apache.commons.codec.binary.Base64.encodeBase64String;
import org.apache.commons.codec.binary.Hex;

/**
 * A classic implementation of the AES encryption algorithm. The same algorithm is implemented in JS
 * (utils/encryption-demo.js) to demonstrate it to customers.
 * The concept was taken from https://github.com/mpetersen/aes-example
 */
public class ClassicAesEncryptor {

    private static final int KEY_SIZE = 128;
    private static final int ITERATION_COUNT = 100;
    private static final String ENCODING = "UTF-8";

    private final SecretKey key;
    private final Cipher cipher;
    private final String initialVector;

    /**
     * Create a new instance of the encryptor. Please note that the encryptionKey must contain hexadecimal symbols only!
     * 
     * @param encryptionKey
     *            encryption hexadecimal key
     */
    public ClassicAesEncryptor() {
        try {
            //this.initialVector = encryptionKey;
        	this.initialVector ="8deec885781c421794ceda8af70a5eaa";
            this.cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
            this.key = generateKey(initialVector);
        } catch (NoSuchAlgorithmException | NoSuchPaddingException e) {
            throw new IllegalStateException(e);
        }
    }

    public String e(String plainText) {
        try {
            byte[] encrypted = doFinal(Cipher.ENCRYPT_MODE, key, initialVector, plainText.getBytes(ENCODING));
            return encodeBase64String(encrypted);
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException(e);
        }
    }

    public String d(String encryptedText) {
        try {
            byte[] decrypted = doFinal(Cipher.DECRYPT_MODE, key, initialVector, decodeBase64(encryptedText));
            return new String(decrypted, ENCODING);
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException(e);
        }
    }

    public static String generateEncryptionKey() {
        String uuid = UUID.randomUUID().toString();
        return uuid.toLowerCase().replaceAll("-", "");
    }

    private byte[] doFinal(int encryptMode, SecretKey key, String iv, byte[] bytes) {
        try {
            cipher.init(encryptMode, key, new IvParameterSpec(Hex.decodeHex(iv.toCharArray())));
            return cipher.doFinal(bytes);
        } catch (InvalidKeyException | InvalidAlgorithmParameterException | DecoderException
                | IllegalBlockSizeException | BadPaddingException e) {
            throw new RuntimeException(e);
        }
    }

    private static SecretKey generateKey(String encryptionKey) {
        final String salt = encryptionKey; // just to note that we use the encryption key as a salt value
        try {
            KeySpec spec =
                    new PBEKeySpec(encryptionKey.toCharArray(), Hex.decodeHex(salt.toCharArray()), ITERATION_COUNT,
                            KEY_SIZE);
            SecretKeyFactory secretKeyFactory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA1");
            return new SecretKeySpec(secretKeyFactory.generateSecret(spec).getEncoded(), "AES");
        } catch (InvalidKeySpecException | NoSuchAlgorithmException | DecoderException e) {
            throw new IllegalStateException(e);
        }
    }
}