package net.vavasoft.bean;

public class GameBean {
	
	private int game_id;
	private String game_name;
	private int game_provider;
	private int game_type;
	private String link_dsp;
	private String game_img;
	private String date_added;
	
	private String provider_name;
	private String game_type_name;
	
	public String getGame_type_name() {
		return game_type_name;
	}

	public void setGame_type_name(String game_type_name) {
		this.game_type_name = game_type_name;
	}

	public String getProvider_name() {
		return provider_name;
	}

	public void setProvider_name(String provider_name) {
		this.provider_name = provider_name;
	}

	public int getGame_id() {
		return game_id;
	}
	
	public void setGame_id(int game_id) {
		this.game_id = game_id;
	}
	
	public String getGame_name() {
		return game_name;
	}
	
	public void setGame_name(String game_name) {
		this.game_name = game_name;
	}
	
	public int getGame_provider() {
		return game_provider;
	}
	
	public void setGame_provider(int game_provider) {
		this.game_provider = game_provider;
	}
	
	public int getGame_type() {
		return game_type;
	}
	
	public void setGame_type(int game_type) {
		this.game_type = game_type;
	}
	
	public String getLink_dsp() {
		return link_dsp;
	}
	
	public void setLink_dsp(String link_dsp) {
		this.link_dsp = link_dsp;
	}
	
	public String getGame_img() {
		return game_img;
	}
	
	public void setGame_img(String game_img) {
		this.game_img = game_img;
	}
	
	public String getDate_added() {
		return date_added;
	}
	
	public void setDate_added(String date_added) {
		this.date_added = date_added;
	}
	
}
