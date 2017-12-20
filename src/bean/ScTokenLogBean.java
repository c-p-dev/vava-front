package bean;

public class ScTokenLogBean {
	
	private long scTokenId;
	private String token;
	private String expireDate;
	
	public long getScTokenId() {
		return scTokenId;
	}
	
	
	public void setScTokenId(long scTokenId) {
		this.scTokenId = scTokenId;
	}
	
	public String getToken() {
		return token;
	}
	
	public void setToken(String token) {
		this.token = token;
	}
	
	public String getExpireDate() {
		return expireDate;
	}

	public void setExpireDate(String expireDate) {
		this.expireDate = expireDate;
	}
	
}
