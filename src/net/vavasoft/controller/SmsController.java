package net.vavasoft.controller;

import infobip.api.client.SendSingleTextualSms;
import infobip.api.config.BasicAuthConfiguration;
import infobip.api.model.sms.mt.send.SMSResponse;
import infobip.api.model.sms.mt.send.SMSResponseDetails;
import infobip.api.model.sms.mt.send.textual.SMSTextualRequest;

import java.sql.SQLException;
import java.util.Arrays;
import java.util.concurrent.ThreadLocalRandom;
import org.apache.log4j.Logger;

import net.vavasoft.dao.SmsDao;
import net.vavasoft.bean.SmsAuthBean;

public class SmsController {
	private String BASE_URL = "https://api.infobip.com/";
    private String USERNAME = "vavasoft";
    private String PASSWORD = "qwer1234";
    private String FROM = "VaVa";
    public static Logger logger = Logger.getLogger(SmsController.class);
    
    
    public boolean verifyNumber(SmsAuthBean smsBean){
    	boolean result = false;
    	SmsDao sd = new SmsDao();
    	
		try {
			String authcode = generateRandomNumber();
			String numberExistsAuthcode = sd.checkNumberStatus(smsBean);
			System.out.println(numberExistsAuthcode);
	    	if(numberExistsAuthcode != null){
	    		authcode = numberExistsAuthcode;	
	    	}
	  
	    	int responseGroupId = sendSms(smsBean,authcode);
	    	
	    	/*
	    	 * responseGroupId 
	    	 * 1 - pending
	    	 * 2 - sent 
	    	 * 
	    	 * reference  https://dev.infobip.com/v1/docs/response-codes
	    	 * 
	    	 * */
	    	
	    	if((responseGroupId == 1 || responseGroupId == 3) && numberExistsAuthcode == null){
	    		result = addSmsAuthRecord(smsBean, authcode);
	    	}else if((responseGroupId == 1 || responseGroupId == 3) && numberExistsAuthcode != null){
	    		result = true;
	    	}
	    	
		} catch (SQLException e) {
			e.printStackTrace();
		}
  
    	return result;
    }
    
    public int sendSms(SmsAuthBean smsBean, String authcode){
    	int groupId = 0;
 
    	SendSingleTextualSms client = new SendSingleTextualSms(new BasicAuthConfiguration(BASE_URL,USERNAME, PASSWORD));
        String MESSAGE_TEXT = " 회원가입을 하시면 보다 폭넓은 서비스 이용이 가능합니다. Your Certification Number is : " + authcode;
        	
		SMSTextualRequest requestBody = new SMSTextualRequest();
		requestBody.setFrom(FROM);
		requestBody.setTo(Arrays.asList("+"+smsBean.getTel()));
		requestBody.setText(MESSAGE_TEXT);
		
		SMSResponse response = client.execute(requestBody);
		SMSResponseDetails sentMessageInfo = response.getMessages().get(0);
		System.out.println(response);
		System.out.println(sentMessageInfo);
		
		groupId = sentMessageInfo.getStatus().getGroupId();
         
    	return groupId;
    }
    
    public boolean addSmsAuthRecord(SmsAuthBean smsBean, String authcode) throws SQLException{
    	boolean result = false;
    	SmsDao sd = new SmsDao();
    	
    	try{
    		result = sd.addSmsAuth(smsBean,authcode);
		}catch(SQLException e){
			e.printStackTrace();
		}    	
    	
    	return result;
    }
    
    public String generateRandomNumber(){
    	String code ="";
    	for(int i = 0; i <=5; i++){
    		int randomNum = ThreadLocalRandom.current().nextInt(0, 9 + 1);
    		code = code + Integer.toString(randomNum);
    	}
    	return code;
    }
    
    public boolean verifyAuthCode(SmsAuthBean sab) throws SQLException{
    	System.out.println("VERIFY AUTH CODE");
    	boolean result = false;
    	SmsDao sd = new SmsDao();
    	result = sd.checkAuthCode(sab);
    	System.out.println(result);
    	
    	return result;
    }
    
    public boolean checkDuplicateNumber(SmsAuthBean sab) throws SQLException{
    	boolean res = false;
    	SmsDao sd = new SmsDao();
    	res = sd.checkActiveNumber(sab);
    	System.out.println(res);
    	return res;
    }

}
