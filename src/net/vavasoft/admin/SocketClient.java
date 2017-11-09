package net.vavasoft.admin;

import java.io.*;
import java.net.*;
import java.util.*;


public class SocketClient {
	
	// ¼ÒÄÏÀ» ¸¸µé±â À§ÇÑ ÀÎ½ºÅÏ½ºµé
	private Socket socket=null;
	
	// ¼ÒÄÏ¿¡¼­ ½ºÆ®¸²À» ¾ò¾î¿À±â À§ÇÑ ÀÎ½ºÅÏ½ºµé
	private OutputStream os = null;
	private OutputStreamWriter writer = null;		
	

	// »ý¼ºÀÚ. ÁÖ¾îÁø IP¿Í Æ÷Æ®¹øÈ£·Î ¼ÒÄÏÀ» »ý¼ºÇÑ´Ù.
	public SocketClient(String ip, int port) throws IOException {

		try {		
			// ¼­¹ö ¼ÒÄÏÀ» »ý¼ºÇÏ°í, Å¬¶óÀÌ¾ðÆ®¿¡¼­ ½ºÆ®¸²À» ¹Þ¾Æµå¸± ¼ÒÄÏÀ» ÇÏ³ª ´õ »ý¼ºÇÕ´Ï´Ù.
			socket=new Socket(ip, port);
	
		} catch (IOException e) { 
			throw e;
		}
	}
	
	public void startSocket() {

		String str="abcdefghij";

		
		try {		
			
			// ¼ÒÄÏ¿¡ ½ºÆ®¸²À» ¿¬°áÇÏ°í, ½ºÆ®¸²À» º¸³¾ Writer¸¦ ¸¸µì´Ï´Ù.
			os = socket.getOutputStream();
			writer = new OutputStreamWriter(os);

		} catch (IOException e) {

		}
		
		try {
			writer.write(str,0,10);
			writer.flush();
		} catch (IOException e) { 

		}
		

		
		try {
			socket.close();
			writer.close();			
			os.close();
		} catch (IOException e) {
			System.out.println("¼ÒÄÏ ´Ý±â¿¡ ½ÇÆÐÇß½À´Ï´Ù");
		}

	}	
	
	/*
	public static void main(String args[]) {
		
		SocketClient c;
		String ip="127.0.0.1";
		int port=5777;
		
		if (args.length>1) {
			ip=args[1];
			port=Integer.parseInt(args[0]);
		} else if (args.length==1) {
			port=Integer.parseInt(args[0]);
		}
		
		try {
			c=new SocketClient(ip, port);
			c.startSocket();
		} catch (IOException e) {
			System.out.println("¼ÒÄÏ »ý¼º¿¡ ½ÇÆÐÇß½À´Ï´Ù.");
		}

	}
	*/
	
	
}
