package net.vavasoft.betconstruct;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

public class GetBalance {
	@SerializedName("OperatorId")
    @Expose
	private int operatorId;
	@SerializedName("PlayerId")
    @Expose
	private int playerId;
	@SerializedName("PublicKey")
    @Expose
	private String publicKey;
	@SerializedName("Token")
    @Expose
	private String token;
	
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
	
	public String getPublicKey() {
		return publicKey;
	}
	
	public void setPublicKey(String publicKey) {
		this.publicKey = publicKey;
	}
	
}
