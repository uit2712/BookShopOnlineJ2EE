/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package assets;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 *
 * @author Administrator
 */
public class MD5Assets {

    public MD5Assets() {

    }

    public String getMD5(String input) throws NoSuchAlgorithmException {
        String password = null;
        MessageDigest mdEnc;
        try {
            mdEnc = MessageDigest.getInstance("MD5");
            mdEnc.update(input.getBytes(), 0, input.length());
            input = new BigInteger(1, mdEnc.digest()).toString(16);
            while (input.length() < 32) {
                input = "0" + input;
            }
            password = input;
        } catch (NoSuchAlgorithmException e1) {
            
        }
        return password;
    }
}
