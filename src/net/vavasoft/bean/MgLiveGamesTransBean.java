package net.vavasoft.bean;

import java.util.List;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

public class MgLiveGamesTransBean {
	
	@SerializedName("Status")
    @Expose
	private MgResponseStatusBean status;
	@SerializedName("Result")
    @Expose
	private List<MgLiveGamesTransData> result;
	
	public MgResponseStatusBean getStatus() {
		return this.status;
	}
	
	public void setStatus(MgResponseStatusBean status) {
		this.status = status;
	}
	
	public List<MgLiveGamesTransData> getResult() {
		return this.result;
	}
	
	public void setResult(List<MgLiveGamesTransData> result) {
		this.result = result;
	}
	
	public class MgLiveGamesTransData {
		@SerializedName("Date")
	    @Expose
		String date;
		@SerializedName("AccountName")
	    @Expose
	    String accountName;
		@SerializedName("tableCode")
	    @Expose
		String tableCode;
		@SerializedName("RoundId")
	    @Expose
		String roundId;
		@SerializedName("Currency")
	    @Expose
		String currency;
		@SerializedName("Bet")
	    @Expose
		Double bet;
		@SerializedName("Payout")
	    @Expose
		Double payout;
		@SerializedName("TransactionStatus")
	    @Expose
		String transactionStatus;
		@SerializedName("BetType")
	    @Expose
		String betType;
		
		public String getDate() {
			return date;
		}
		
		public void setDate(String date) {
			this.date = date;
		}
		
		public String getAccountName() {
			return accountName;
		}
		
		public void setAccountName(String accountName) {
			this.accountName = accountName;
		}
		
		public String getTableCode() {
			return tableCode;
		}
		
		public void setTableCode(String tableCode) {
			this.tableCode = tableCode;
		}
		
		public String getRoundId() {
			return roundId;
		}
		
		public void setRoundId(String roundId) {
			this.roundId = roundId;
		}
		
		public String getCurrency() {
			return currency;
		}
		
		public void setCurrency(String currency) {
			this.currency = currency;
		}
		
		public Double getBet() {
			return bet;
		}
		
		public void setBet(Double bet) {
			this.bet = bet;
		}
		
		public Double getPayout() {
			return payout;
		}
		
		public void setPayout(Double payout) {
			this.payout = payout;
		}
		
		public String getTransactionStatus() {
			return transactionStatus;
		}
		
		public void setTransactionStatus(String transactionStatus) {
			this.transactionStatus = transactionStatus;
		}
		
		public String getBetType() {
			return betType;
		}
		
		public void setBetType(String betType) {
			this.betType = betType;
		}
	}
	
}
