package bean;

import java.util.List;

public class MgPlayerAccountBean {
	private int CustomerId;
	private String AccountNumber;
	private String FirstName;
	private String LastName;
	private String Email;
	private String MobilePrefix;
	private String MobileNumber;
	private double DepositAmount;
	private String PreferredAccountNumber;
	private String PinCode;
	private int IsProgressive;
	private List<MgBettingProfileBean> BettingProfiles;
	
	public int getCustomerId() {
		return CustomerId;
	}
	
	
	public void setCustomerId(int customerId) {
		CustomerId = customerId;
	}
	
	public String getAccountNumber() {
		return AccountNumber;
	}
	
	public void setAccountNumber(String accountNumber) {
		AccountNumber = accountNumber;
	}
	
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
