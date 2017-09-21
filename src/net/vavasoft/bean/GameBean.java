package net.vavasoft.bean;

public class GameBean {
	
	private int game_id;
	private String game_name;
	private int game_provider;
	private String game_img; 
	private String date_added;
	
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
