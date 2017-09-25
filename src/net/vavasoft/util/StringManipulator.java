package net.vavasoft.util;

import java.util.Random;

public class StringManipulator {
	
	public String getSaltString(int len)
	{
        String SALTCHARS 	= "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
        StringBuilder salt 	= new StringBuilder();
        Random rnd 			= new Random();
        
        while (salt.length() < len) {
            int index = (int) (rnd.nextFloat() * SALTCHARS.length());
            salt.append(SALTCHARS.charAt(index));
        }
        
        String saltStr = salt.toString();
        
        return saltStr;
    }
}
