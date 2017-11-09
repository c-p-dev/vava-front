package bc4;
import org.json.JSONObject;
import org.json.JSONException;

public class Properties{
	
	public JSONObject getProperties(){
		
		JSONObject array = new JSONObject();

	    try {
			array.put("p1","center_live.html");		
			array.put("p2","left_live.html");
			array.put("p3","right_bet.html");
			array.put("p4","ws://10.30.42.116:7071");
			array.put("p5","center_pre.html");
			array.put("p6","/JSON/period_name.json");
			array.put("p7","/JSON/live_status.json");
			array.put("p8","jsp/getValidMarketType.jsp");
			array.put("p9","jsp/getFavMatch.jsp");
			array.put("p10","jsp/loadLiveMatchInit.jsp");
			array.put("p11","jsp/loadPreMatchInit.jsp");
			array.put("p12","jsp/getMarketbyMatchId.jsp");
			array.put("p13","jsp/getStatusbyMatchId.jsp");
			array.put("p14","jsp/getMarketbyMarketId.jsp");
			array.put("p15","jsp/subLoadLiveMatch.jsp");
			array.put("p16","jsp/getMatchInfobyCompetition.jsp");
			array.put("p17","left_pre.html");
			array.put("p18","jsp/loadPreMatch.jsp");
			array.put("p19","jsp/subLoadPreMatch.jsp");
			array.put("p20","jsp/setFavMatch.jsp");
		
	    } catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

    return array;

	}
}