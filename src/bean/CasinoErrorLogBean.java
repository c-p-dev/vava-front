package bean;

public class CasinoErrorLogBean {
	
	private String username;
	private Integer siteId;
	private String message;
	private Integer gameProvider;
	private String method;
	private String dateAdded;
	
	public String getUsername() {
		return username;
	}
	
	public void setUsername(String username) {
		this.username = username;
	}
	
	public Integer getSiteId() {
		return siteId;
	}

	public void setSiteId(Integer siteId) {
		this.siteId = siteId;
	}
	
	public String getMessage() {
		return message;
	}
	
	public void setMessage(String message) {
		this.message = message;
	}
	
	public Integer getGameProvider() {
		return gameProvider;
	}

	public void setGameProvider(Integer gameProvider) {
		this.gameProvider = gameProvider;
	}

	public String getMethod() {
		return method;
	}

	public void setMethod(String method) {
		this.method = method;
	}
	
	public String getDateAdded() {
		return dateAdded;
	}
	
	public void setDateAdded(String dateAdded) {
		this.dateAdded = dateAdded;
	}
	
}
