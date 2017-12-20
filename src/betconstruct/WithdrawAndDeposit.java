package betconstruct;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

public class WithdrawAndDeposit {
	
	@SerializedName("BonusDefId")
    @Expose
	private Integer bonusDefId;
	@SerializedName("Currency")
    @Expose
	private String currency;
	@SerializedName("DepositAmount")
    @Expose
	private Double depositAmount;
	@SerializedName("GameId")
    @Expose
	private int gameId;
	@SerializedName("OperatorId")
    @Expose
	private int operatorId;
	@SerializedName("PlayerId")
    @Expose
	private int playerId;
	@SerializedName("PublicKey")
    @Expose
	private String publicKey;
	@SerializedName("RGSRelatedTransactionId")
    @Expose
	private Integer rgsRelatedTransactionId;
	@SerializedName("RGSTransactionId")
    @Expose
	private int rgsTransactionId;
	@SerializedName("Token")
    @Expose
	private String token;
	@SerializedName("TypeId")
    @Expose
	private int typeId;
	@SerializedName("WithdrawAmount")
    @Expose
	private Double withdrawAmount;
	
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
	
	public Double getWithdrawAmount() {
		return withdrawAmount;
	}
	
	public void setWithdrawAmount(double withdrawAmount) {
		this.withdrawAmount = withdrawAmount;
	}
	
	public Double getDepositAmount() {
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
	
	public Integer getRgsRelatedTransactionId() {
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
	
	public Integer getBonusDefId() {
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
