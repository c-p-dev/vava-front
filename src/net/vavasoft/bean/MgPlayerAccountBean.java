package net.vavasoft.bean;

import java.util.List;

public class MgPlayerAccountBean {
	String FirstName;
	String LastName;
	String Email;
	String MobilePrefix;
	String MobileNumber;
	double DepositAmount;
	String PreferredAccountNumber;
	String PinCode;
	int IsProgressive;
	List<MgBettingProfileBean> BettingProfiles;
	
	public String getFirstName() {
		return FirstName;
	}
	
	public void setFirstName(String firstName) {
		FirstName = firstName;
	}
	
	public String getLastName() {
		return LastName;
	}
	
	public void setLastName(String lastName) {
		LastName = lastName;
	}
	
	public String getEmail() {
		return Email;
	}
	
	public void setEmail(String email) {
		Email = email;
	}
	
	public String getMobilePrefix() {
		return MobilePrefix;
	}
	
	public void setMobilePrefix(String mobilePrefix) {
		MobilePrefix = mobilePrefix;
	}
	
	public String getMobileNumber() {
		return MobileNumber;
	}
	
	public void setMobileNumber(String mobileNumber) {
		MobileNumber = mobileNumber;
	}
	
	public double getDepositAmount() {
		return DepositAmount;
	}
	
	public void setDepositAmount(double depositAmount) {
		DepositAmount = depositAmount;
	}
	
	public String getPreferredAccountNumber() {
		return PreferredAccountNumber;
	}
	
	public void setPreferredAccountNumber(String preferredAccountNumber) {
		PreferredAccountNumber = preferredAccountNumber;
	}
	
	public String getPinCode() {
		return PinCode;
	}
	
	public void setPinCode(String pinCode) {
		PinCode = pinCode;
	}
	
	public int getIsProgressive() {
		return IsProgressive;
	}
	
	public void setIsProgressive(int isProgressive) {
		IsProgressive = isProgressive;
	}
	
	public List<MgBettingProfileBean> getBettingProfiles() {
		return BettingProfiles;
	}
	
	public void setBettingProfiles(List<MgBettingProfileBean> bettingProfiles) {
		BettingProfiles = bettingProfiles;
	}
}
