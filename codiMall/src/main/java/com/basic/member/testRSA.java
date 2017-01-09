package com.basic.member;

import java.security.Key;
import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.spec.RSAPrivateKeySpec;
import java.security.spec.RSAPublicKeySpec;
import java.util.Base64;
import java.util.Base64.Decoder;
import java.util.Base64.Encoder;

import javax.crypto.Cipher;

public class testRSA {


	public static void main(String[] args) {
		//RSA복호화하기//
		
			try {
	            //공개키 및 개인키 생성
	            KeyPairGenerator keyPairGenerator = KeyPairGenerator.getInstance("RSA");
	            keyPairGenerator.initialize(1024);
	            
	            System.out.println("keyPair : "+keyPairGenerator.generateKeyPair());
	            
	            KeyPair keyPair = keyPairGenerator.genKeyPair();
	            Key publicKey = keyPair.getPublic(); // 공개키
	            System.out.println("공개키 : "+publicKey);
	            Key privateKey = keyPair.getPrivate(); // 개인키
	            System.out.println("개인키 : "+privateKey);
	            KeyFactory keyFactory = KeyFactory.getInstance("RSA");
	            RSAPublicKeySpec publicKeySpec = keyFactory.getKeySpec(publicKey, RSAPublicKeySpec.class);
	            RSAPrivateKeySpec privateKeySpec = keyFactory.getKeySpec(privateKey, RSAPrivateKeySpec.class);
	 
	            //System.out.println("public key modulus(" + publicKeySpec.getModulus() + ") exponent(" + publicKeySpec.getPublicExponent() + ")");
	            //System.out.println("private key modulus(" + privateKeySpec.getModulus() + ") exponent(" + privateKeySpec.getPrivateExponent() + ")");
	 
	            
	            // 암호화(Encryption) 예제
	            String inputStr = "1q2w3e4r"; // "세이프123"을 암호화한다!
	 
	            Cipher cipher = Cipher.getInstance("RSA");
	            cipher.init(Cipher.ENCRYPT_MODE, publicKey);
	            byte[] arrCipherData = cipher.doFinal(inputStr.getBytes()); // 암호화된 데이터(byte 배열)
	            System.out.println("byte Array : "+arrCipherData);
	            
	            String strCipher = new String(arrCipherData);//암호화 키 생성
	            
	            System.out.println("암호화 결과 : "+ strCipher); // 암호화 결과물 출력(눈으로 보이기에는 깨질 수 있음)

	            // 복호화(Decryption) 예제
	            cipher.init(Cipher.DECRYPT_MODE, privateKey);
	            byte[] arrData = cipher.doFinal(arrCipherData);
	            String strResult = arrData.toString();
	 
	            System.out.println(strResult); // 복호화 결과물 출력(다시 "세이프123"이 출력됨)
	        } catch (Exception e) {
	            e.printStackTrace();
	        }

		}
}
