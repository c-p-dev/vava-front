package bean;

import java.util.List;

public class ScBetBean {
	
	private Double betAmount;
	private String betStatus;
	private String betUID;
	private String createdDateUTC;
	private String currency;
	private String gameCode;
	private String gameEndTime;
	private String gameStartTime;
	private Double payoutAmount;
	private String platform;
	private String playerId;
	private String productId;
	
	public Double getBetAmount() {
		return betAmount;
	}
	
	public void setBetAmount(Double betAmount) {
		this.betAmount = betAmount;
	}
	
	
	public String getBetStatus() {
		return betStatus;
	}
	
	public void setBetStatus(String betStatus) {
		this.betStatus = betStatus;
	}
	
	public String getBetUID() {
		return betUID;
	}
	
	public void setBetUID(String betUID) {
		this.betUID = betUID;
	}
	
	public String getCreatedDateUTC() {
		return createdDateUTC;
	}
	
	public void setCreatedDateUTC(String createdDateUTC) {
		this.createdDateUTC = createdDateUTC;
	}
	
	public String getCurrency() {
		return currency;
	}
	
	public void setCurrency(String currency) {
		this.currency = currency;
	}
	
	public String getGameCode() {
		return gameCode;
	}
	
	public void setGameCode(String gameCode) {
		this.gameCode = gameCode;
	}
	
	public String getGameEndTime() {
		return gameEndTime;
	}
	
	public void setGameEndTime(String gameEndTime) {
		this.gameEndTime = gameEndTime;
	}
	
	public String getGameStartTime() {
		return gameStartTime;
	}
	
	public void setGameStartTime(String gameStartTime) {
		this.gameStartTime = gameStartTime;
	}
	
	public Double getPayoutAmount() {
		return payoutAmount;
	}
	
	public void setPayoutAmount(Double payoutAmount) {
		this.payoutAmount = payoutAmount;
	}
	
	public String getPlatform() {
		return platform;
	}
	
	public void setPlatform(String platform) {
		this.platform = platform;
	}
	
	public String getPlayerId() {
		return playerId;
	}
	
	public void setPlayerId(String playerId) {
		this.playerId = playerId;
	}
	
	public String getProductId() {
		return productId;
	}
	
	public void setProductId(String productId) {
		this.productId = productId;
	}
}
