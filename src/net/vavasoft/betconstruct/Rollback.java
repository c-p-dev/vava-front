package net.vavasoft.betconstruct;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

public class Rollback {
	@SerializedName("OperatorId")
    @Expose
	private int operatorId;
	@SerializedName("PlayerId")
    @Expose
	private int playerId;
	@SerializedName("Token")
    @Expose
	private String token;
	@SerializedName("RGSTransactionId")
    @Expose
	private int rgsTransactionId;
	@SerializedName("GameId")
    @Expose
	private int gameId;
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
	
	public int getRgsTransactionId() {
		return rgsTransactionId;
	}
	
	public void setRgsTransactionId(int rgsTransactionId) {
		this.rgsTransactionId = rgsTransactionId;
	}
	
	public int getGameId() {
		return gameId;
	}
	
	public void setGameId(int gameId) {
		this.gameId = gameId;
	}
	
	public String getPublicKey() {
		return publicKey;
	}
	
	public void setPublicKey(String publicKey) {
		this.publicKey = publicKey;
	}
	
}
