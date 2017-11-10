package bean;

public class MgResponseStatusBean {
	
	private int ErrorCode;
	private String ErrorName;
	private String ErrorMessage;
	private String ReferenceNumber;
	
	public int getErrorCode() {
		return ErrorCode;
	}
	
	public void setErrorCode(int errorCode) {
		ErrorCode = errorCode;
	}
	
	public String getErrorName() {
		return ErrorName;
	}
	
	public void setErrorName(String errorName) {
		ErrorName = errorName;
	}
	
	public String getErrorMessage() {
		return ErrorMessage;
	}
	
	public void setErrorMessage(String errorMessage) {
		ErrorMessage = errorMessage;
	}
	
	public String getReferenceNumber() {
		return ReferenceNumber;
	}
	
	public void setReferenceNumber(String referenceNumber) {
		ReferenceNumber = referenceNumber;
	}
	
}
