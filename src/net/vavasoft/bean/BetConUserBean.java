package net.vavasoft.bean;

public class BetConUserBean {
	
	private int playerId;
	private String username;
	private String session_token;
	private String init_token;
	
	public int getPlayerId() {
		return playerId;
	}
	
	public void setPlayerId(int playerId) {
		this.playerId = playerId;
	}
	
	public String getUsername() {
		return username;
	}
	
	public void setUsername(String username) {
		this.username = username;
	}
	
	public String getSession_token() {
		return session_token;
	}
	
	public void setSession_token(String session_token) {
		this.session_token = session_token;
	}
	
	public String getInit_token() {
		return init_token;
	}
	
	public void setInit_token(String init_token) {
		this.init_token = init_token;
	}
	
}
