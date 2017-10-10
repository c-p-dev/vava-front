package net.vavasoft.betconstruct;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

public class WithdrawAndDeposit {
	
	@SerializedName("OperatorId")
    @Expose
	private int operatorId;
	@SerializedName("PlayerId")
    @Expose
	private int playerId;
	@SerializedName("Token")
    @Expose
	private String token;
	@SerializedName("WithdrawAmount")
    @Expose
	private double withdrawAmount;
	@SerializedName("DepositAmount")
    @Expose
	private double depositAmount;
	@SerializedName("Currency")
    @Expose
	private String currency;
	@SerializedName("GameId")
    @Expose
	private int gameId;
	@SerializedName("RGSTransactionId")
    @Expose
	private int rgsTransactionId;
	@SerializedName("RGSRelatedTransactionId")
    @Expose
	private int rgsRelatedTransactionId;
	@SerializedName("TypeId")
    @Expose
	private int typeId;
	@SerializedName("BonusDefId")
    @Expose
	private int bonusDefId;
	@SerializedName("PublicKey")
    @Expose
	private String publicKey;
	
	public int getOperatorId() {
		return operatorId;
	}
	
	public void setOperatorId(int operatorId) {
		this.operatorId = operatorId;
	}
	
	public int getPlayerId() {
		return playerId;
	}
	
	public void setPlayerId(int playerId) {
		this.playerId = playerId;
	}
	
	public String getToken() {
		return token;
	}
	
	public void setToken(String token) {
		this.token = token;
	}
	
	public double getWithdrawAmount() {
		return withdrawAmount;
	}
	
	public void setWithdrawAmount(double withdrawAmount) {
		this.withdrawAmount = withdrawAmount;
	}
	
	public double getDepositAmount() {
		return depositAmount;
	}
	
	public void setDepositAmount(double depositAmount) {
		this.depositAmount = depositAmount;
	}
	
	public String getCurrency() {
		return currency;
	}
	
	public void setCurrency(String currency) {
		this.currency = currency;
	}
	
	public int getGameId() {
		return gameId;
	}
	
	public void setGameId(int gameId) {
		this.gameId = gameId;
	}
	
	public int getRgsTransactionId() {
		return rgsTransactionId;
	}
	
	public void setRgsTransactionId(int rgsTransactionId) {
		this.rgsTransactionId = rgsTransactionId;
	}
	
	public int getRgsRelatedTransactionId() {
		return rgsRelatedTransactionId;
	}
	
	public void setRgsRelatedTransactionId(int rgsRelatedTransactionId) {
		this.rgsRelatedTransactionId = rgsRelatedTransactionId;
	}
	
	public int getTypeId() {
		return typeId;
	}
	
	public void setTypeId(int typeId) {
		this.typeId = typeId;
	}
	
	public int getBonusDefId() {
		return bonusDefId;
	}
	
	public void setBonusDefId(int bonusDefId) {
		this.bonusDefId = bonusDefId;
	}
	
	public String getPublicKey() {
		return publicKey;
	}
	
	public void setPublicKey(String publicKey) {
		this.publicKey = publicKey;
	}
	
}
