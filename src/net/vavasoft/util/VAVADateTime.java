package net.vavasoft.util;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import org.apache.log4j.Logger;

public class VAVADateTime {

	private static Logger logger = Logger.getLogger(VAVADateTime.class);
	private static VAVADateTime instance = null;
 

	private VAVADateTime() {
	}
 

	public static VAVADateTime getInstance() {

		if (instance == null) {

			synchronized (VAVADateTime.class) {
				if (instance == null) {
					instance = new VAVADateTime();
				}
			}
		}

		return instance;
	}

	public static String getDate() {


        Calendar cal = Calendar.getInstance();
        Date date = cal.getTime();

        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        
		return sdf.format( date );
	}
	
	public static String getDateTimeForPrint(String dateTime) {
	    
		long time = Long.valueOf(dateTime ) ; 
		
		SimpleDateFormat dayTime = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		
		return dayTime.format(new Date(time));		
        
	}



}
