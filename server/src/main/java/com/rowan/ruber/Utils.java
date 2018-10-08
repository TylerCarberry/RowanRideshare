package com.rowan.ruber;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.nio.charset.Charset;

public class Utils {

    public static InputStream convertStringToStream(String str) {
        return new ByteArrayInputStream(str.getBytes(Charset.defaultCharset()));
    }

}
