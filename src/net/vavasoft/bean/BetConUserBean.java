package net.vavasoft.bean;

public class BetConUserBean {
	
	private int playerId;
	private String username;
	private String session_token;
	private String date_added;
	
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

	public String getDate_added() {
		return date_added;
	}

	public void setDate_added(String date_added) {
		this.date_added = date_added;
	}
	
}
