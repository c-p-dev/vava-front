package net.vavasoft.bean;

public class MgDepositBean {
	
	private MgResponseStatusBean Status;
	private MgDepositData Result;
	
	public MgResponseStatusBean getStatus() {
		return Status;
	}
	
	public void setStatus(MgResponseStatusBean status) {
		Status = status;
	}
	
	public MgDepositData getResult() {
		return Result;
	}
	
	public void setResult(MgDepositData result) {
		Result = result;
	}
	
	public class MgDepositData {
		private long ConfirmationNumber;
		private boolean IsSucceed;
		private String AccountNumber;
		private double TransactionAmount;
		private double TransactionCreditAmount;
		private double Balance;
		private double CreditBalance;
		private String TransactionReferenceNumber;
		
		public long getConfirmationNumber() {
			return ConfirmationNumber;
		}
		
		public void setConfirmationNumber(long confirmationNumber) {
			ConfirmationNumber = confirmationNumber;
		}
		
		public boolean isIsSucceed() {
			return IsSucceed;
		}
		
		public void setIsSucceed(boolean isSucceed) {
			IsSucceed = isSucceed;
		}
		
		public String getAccountNumber() {
			return AccountNumber;
		}
		
		public void setAccountNumber(String accountNumber) {
			AccountNumber = accountNumber;
		}
		
		public double getTransactionAmount() {
			return TransactionAmount;
		}
		
		public void setTransactionCreditAmount(double transactionCreditAmount) {
			TransactionCreditAmount = transactionCreditAmount;
		}
		
		public double getTransactionCreditAmount() {
			return TransactionCreditAmount;
		}
		
		public void setTransactionAmount(double transactionAmount) {
			TransactionAmount = transactionAmount;
		}
		
		public double getBalance() {
			return Balance;
		}
		
		public void setBalance(double balance) {
			Balance = balance;
		}
		
		public double getCreditBalance() {
			return CreditBalance;
		}
		
		public void setCreditBalance(double creditBalance) {
			CreditBalance = creditBalance;
		}
		
		public String getTransactionReferenceNumber() {
			return TransactionReferenceNumber;
		}
		
		public void setTransactionReferenceNumber(String transactionReferenceNumber) {
			TransactionReferenceNumber = transactionReferenceNumber;
		}
		
	}
}
