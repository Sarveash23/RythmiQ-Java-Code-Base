package com.app.other;

import org.apache.commons.codec.digest.DigestUtils;

/**
 * Created by: arif hosain
 * Created at : 4/13/2024
 */
public class Other {

    public static String filePath = "D:\\work\\resource";

    public static String encrypt(String str) {
        return DigestUtils.md5Hex(str);
    }

}
