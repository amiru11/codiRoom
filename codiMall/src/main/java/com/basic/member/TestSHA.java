package com.basic.member;

import java.security.MessageDigest;
import java.security.SecureRandom;

public class TestSHA {
	public static void main(String[] args) throws Exception{
		StringBuffer sbuf = new StringBuffer();
	    String txt = "1q2w3e4r"; 
	    String salt = "!@#pv^&%qwe?nt";
	    MessageDigest mDigest = MessageDigest.getInstance("SHA-256");
        txt = txt + salt;
        // Salt generation 128 bits long
	    mDigest.update(txt.getBytes());
	    byte[] msgStr = mDigest.digest() ;
	     
	    for(int i=0; i < msgStr.length; i++){
	        byte tmpStrByte = msgStr[i];
	        String tmpEncTxt = Integer.toString((tmpStrByte & 0xff) + 0x100, 16).substring(1);
	         
	        sbuf.append(tmpEncTxt) ;
	    }
	     System.out.println("sha : " + sbuf.toString());
	}
}
