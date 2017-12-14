package bean;

import java.util.List;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

public class MgAccountAvailable {
	
	@SerializedName("Status")
    @Expose
	private MgResponseStatusBean status;
	@SerializedName("Result")
    @Expose
	private MgAccountAvailableData result;
	
	public MgResponseStatusBean getStatus() {
		return this.status;
	}
	
	public void setStatus(MgResponseStatusBean status) {
		this.status = status;
	}
	
	public MgAccountAvailableData getResult() {
		return this.result;
	}
	
	public void setResult(MgAccountAvailableData result) {
		this.result = result;
	}
	
	public class MgAccountAvailableData {
		@SerializedName("IsAccountAvailable")
	    @Expose
	    Boolean accountAvailable;

		public Boolean getAccountAvailable() {
			return accountAvailable;
		}

		public void setAccountAvailable(Boolean accountAvailable) {
			this.accountAvailable = accountAvailable;
		}
	}
}
