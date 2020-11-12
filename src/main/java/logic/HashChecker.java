package logic;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class HashChecker {
    public static boolean isSame(String message, String hash) {

        StringBuilder builder = new StringBuilder();

        try {
            MessageDigest md5 = MessageDigest.getInstance("MD5");
            byte[] digest = md5.digest(message.getBytes());

            for (byte b: digest) {
                builder.append(String.format("%02X", b));
            }
            System.out.println(builder.toString());

        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }

        return hash.equals(builder.toString());
    }
}
