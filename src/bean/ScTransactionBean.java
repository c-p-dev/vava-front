package bean;

public class ScTransactionBean {
	private String id;
	private String status;
	private String type;
	private String productId;
	private String playerId;
	private Double balance;
	private Double amount;
	private String externalTransactionid;
	private String idempotencykey;
	private String createdDateUTC;
	private String uri;
	
	public String getId() {
		return id;
	}
	
	
	public void setId(String id) {
		this.id = id;
	}
	
	public String getStatus() {
		return status;
	}
	
	public void setStatus(String status) {
		this.status = status;
	}
	
	public String getType() {
		return type;
	}
	
	public void setType(String type) {
		this.type = type;
	}
	
	public String getProductId() {
		return productId;
	}
	
	public void setProductId(String productId) {
		this.productId = productId;
	}
	
	public String getPlayerId() {
		return playerId;
	}
	
	public void setPlayerId(String playerId) {
		this.playerId = playerId;
	}
	
	public Double getBalance() {
		return balance;
	}
	
	public void setBalance(Double balance) {
		this.balance = balance;
	}
	
	public Double getAmount() {
		return amount;
	}
	
	public void setAmount(Double amount) {
		this.amount = amount;
	}
	
	public String getExternalTransactionid() {
		return externalTransactionid;
	}
	
	public void setExternalTransactionid(String externalTransactionid) {
		this.externalTransactionid = externalTransactionid;
	}
	
	public String getIdempotencykey() {
		return idempotencykey;
	}
	
	public void setIdempotencykey(String idempotencykey) {
		this.idempotencykey = idempotencykey;
	}
	
	public String getCreatedDateUTC() {
		return createdDateUTC;
	}
	
	public void setCreatedDateUTC(String createdDateUTC) {
		this.createdDateUTC = createdDateUTC;
	}
	
	public String getUri() {
		return uri;
	}
	
	public void setUri(String uri) {
		this.uri = uri;
	}
	
}
