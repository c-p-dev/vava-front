package betconstruct;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

public class GetBalanceOutput {
	
	@SerializedName("HasError")
    @Expose
	private boolean has_error;
	@SerializedName("ErrorId")
    @Expose
	private int error_id;
	@SerializedName("ErrorDescription")
    @Expose
	private String error_description;
	@SerializedName("PlayerId")
    @Expose
	private int player_id;
	@SerializedName("TotalBalance")
    @Expose
	private double total_balance;
	@SerializedName("BonusWin")
    @Expose
	private double bonus_win;
	@SerializedName("BonusMoney")
    @Expose
	private double bonus_money;
	@SerializedName("FrozenMoney")
    @Expose
	private double frozen_money;
	@SerializedName("Token")
    @Expose
	private String token;
	
	public boolean isHas_error() {
		return has_error;
	}
	
	
	public void setHas_error(boolean has_error) {
		this.has_error = has_error;
	}
	
	public int getError_id() {
		return error_id;
	}
	
	public void setError_id(int error_id) {
		this.error_id = error_id;
	}
	
	public String getError_description() {
		return error_description;
	}
	
	public void setError_description(String error_description) {
		this.error_description = error_description;
	}
	
	public int getPlayer_id() {
		return player_id;
	}
	
	public void setPlayer_id(int player_id) {
		this.player_id = player_id;
	}
	
	public double getTotal_balance() {
		return total_balance;
	}
	
	public void setTotal_balance(double total_balance) {
		this.total_balance = total_balance;
	}
	
	public double getBonus_win() {
		return bonus_win;
	}
	
	public void setBonus_win(double bonus_win) {
		this.bonus_win = bonus_win;
	}
	
	public double getBonus_money() {
		return bonus_money;
	}
	
	public void setBonus_money(double bonus_money) {
		this.bonus_money = bonus_money;
	}
	
	public double getFrozen_money() {
		return frozen_money;
	}
	
	public void setFrozen_money(double frozen_money) {
		this.frozen_money = frozen_money;
	}
	
	public String getToken() {
		return token;
	}
	
	public void setToken(String token) {
		this.token = token;
	}
	
}
