package com.app.other;

import org.apache.commons.codec.digest.DigestUtils;

/**
 *
 * @author Sarveashwaran
 */

public class Other {


    public static String encrypt(String str) {
        return DigestUtils.md5Hex(str);
    }

}
