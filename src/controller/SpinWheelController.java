package controller;

import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Base64;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Random;
import java.util.Scanner;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import java.sql.*;
import javax.sql.*;
import javax.naming.*;

public class SpinWheelController {
	
	public SpinWheelController() {
		
	}
    
	public String calculateTicketRng(String json_post)
	{
		/*	Variable Declaration	*/
		Gson gson							= new Gson();
		
		ArrayList<Integer[]> combo_list 	= new ArrayList<Integer[]>();
		HashMap<String, String> json_data 	= gson.fromJson(json_post, new TypeToken<HashMap<String, String>>(){}.getType());

		int ticket_num	= Integer.valueOf(json_data.get("ticket_num"));
		int win_amt		= Integer.valueOf(json_data.get("win_amt"));
		
		int first_val	= 0;
		int last_val	= ticket_num - 1;
		
		Integer[] ticket_vals	= new Integer[ticket_num];
		
		Arrays.fill(ticket_vals, 0);		
		Integer spinr_vals[]	= {
			10000,
			20000,
			50000,
			100000,
			500000,
			1000000,
		};
		
		int roulette_size	= spinr_vals.length;
		
		if (1 < ticket_num) {
			/*	Determine combinations that is equal to win amount				*/
			while (roulette_size > ticket_vals[first_val]) {
				
				for (int roulette_idx = 0; roulette_idx < roulette_size; roulette_idx++) {
					
					if (5 >= roulette_idx) {
						ticket_vals[last_val] = roulette_idx;
					}
					
					int set_sum = 0;
					
					for (int set_idx = last_val; 0 <= set_idx; set_idx--) {
						set_sum += spinr_vals[ticket_vals[set_idx]];
					}
					
					if (set_sum == win_amt) {
						Integer[] temp_list	= new Integer[ticket_num];
						System.arraycopy(ticket_vals, 0, temp_list, 0, ticket_num);
						combo_list.add(temp_list);
	
					}
					
					if ((roulette_size - 1) == roulette_idx) {
						
						for (int tik_inc = last_val; 0 < tik_inc; tik_inc--) {
							
							if (tik_inc == last_val) {
								if ((roulette_size - 1) == ticket_vals[tik_inc]) {
									ticket_vals[tik_inc]		= 0;
									ticket_vals[tik_inc - 1] 	= ticket_vals[tik_inc - 1] + 1;
								}
							}
							else if (roulette_size == ticket_vals[tik_inc]) {
								ticket_vals[tik_inc]		= 0;
								ticket_vals[tik_inc - 1] 	= ticket_vals[tik_inc - 1] + 1;
								
							}
							
						}
						
					}
					
					if (7 <= combo_list.size()) {
						ticket_vals[first_val] = ticket_num + 1;
						break;
					}
				}
			}
		}
		
		ArrayList<Integer> combo_result = new ArrayList<Integer>();
		
		if (0 < combo_list.size()) {
			Random rand			= new Random();
			int random_combo 	= rand.nextInt(combo_list.size());
			
			combo_result = new ArrayList<>(Arrays.asList(combo_list.get(random_combo)));
			
			Collections.shuffle(combo_result);
			
			this.updateTestWheel(ticket_num, win_amt, combo_result);
		}
		else {

		}
		
		String json_combo = gson.toJson(combo_result,  new TypeToken<ArrayList<Integer>>(){}.getType());
		
		return json_combo;
	}
	
	class WheelDetails {
		int sts;
        int ticket_left;
		ArrayList<Integer> spin_result;
		ArrayList<String> spinr_lbl;
		ArrayList<Integer> spinr_val;
	}
	
    class SpinDetails {
        String user_id;
        int ticket_num;
        int total_win;
        int ticket_used;
        String rng_result;
    }
    
    //-----------------------------------------------------
    //  Function 1.0: getDbSpinInfo
    //      Get the user's spin details from DB
    //-----------------------------------------------------
	public SpinDetails getDbSpinInfo(String user_id)
	{
        /*  Variable Declaration    */
        /*  DB Connection   */
        Connection con          = null;
		PreparedStatement pstmt = null;
		ResultSet rs            = null;
        SpinDetails db_spin     = new SpinDetails();
        String query            = "SELECT TOP 1 * from user_spins WHERE user_id = ? AND status = 0 ORDER BY date_added DESC";
        
        /*  Connect to Database */
        try {	      
			
		 	Context initContext = new InitialContext();
		 	Context envContext  = (Context)initContext.lookup("java:/comp/env");
			DataSource ds       = (DataSource)envContext.lookup("jdbc/ibet");
            
			con     = ds.getConnection();
            
			pstmt   = con.prepareStatement(query);
            pstmt.setString(1, user_id);
            
			rs      = pstmt.executeQuery();
            
            if (rs.next()) {
                db_spin.ticket_num  = Integer.valueOf(rs.getString("ticket_num"));
                db_spin.total_win   = Integer.valueOf(rs.getString("total_win"));
                db_spin.rng_result  = rs.getString("rng_result");
                db_spin.ticket_used = Integer.valueOf(rs.getString("ticket_used"));
            }
        
	        rs.close();
	        pstmt.close();
	        con.close();

		}
        catch (Exception e) {
            e.printStackTrace();
		}
        finally {
            
		}
        
        return db_spin;
    }
    
    //-----------------------------------------------------
    //  Function 2.0: getUserWheelDetails
    //      Get the user's spin details
    //-----------------------------------------------------
    public String getUserWheelDetails()
    {
        /*  Libraries       */
		Gson gson			= new Gson();
		DecimalFormat df	= new DecimalFormat("#,###,###,###,###");
        
        /*  Get Spin information from DB    */
        SpinDetails db_spin = this.getDbSpinInfo("test1234");
        
        /*  Ticket Information  */
        int ticket_num	    = db_spin.ticket_num;
		int win_amt		    = db_spin.total_win;
		int min_amt		    = win_amt / 10;
		
		int mult_ng		= 0;
		int mult_1		= min_amt;
		int mult_2		= min_amt * 2;
		int mult_3		= min_amt * 3;
		int mult_4		= min_amt * 4;
		int mult_5		= min_amt * 5;
		int mult_jp		= min_amt * 10;
        
		WheelDetails srv_resp	= new WheelDetails();
		
		//srv_resp.spin_result	= this.calculateTicketRng();
		srv_resp.ticket_left	= ticket_num - db_spin.ticket_used;
		srv_resp.spin_result	= gson.fromJson(db_spin.rng_result, new TypeToken<ArrayList<Integer>>(){}.getType());
		srv_resp.spinr_lbl		= new ArrayList<String>();
		srv_resp.spinr_val		= new ArrayList<Integer>();
		srv_resp.spinr_val.add(10000);
		srv_resp.spinr_val.add(20000);
		srv_resp.spinr_val.add(50000);
		srv_resp.spinr_val.add(10000);
		srv_resp.spinr_val.add(100000);
		srv_resp.spinr_val.add(20000);
		srv_resp.spinr_val.add(10000);
		srv_resp.spinr_val.add(500000);
		srv_resp.spinr_val.add(1000000);
		srv_resp.spinr_val.add(10000);
		srv_resp.spinr_val.add(20000);
		srv_resp.spinr_val.add(50000);
		srv_resp.spinr_val.add(10000);
		srv_resp.spinr_val.add(100000);
		srv_resp.spinr_val.add(20000);
		srv_resp.spinr_val.add(50000);
		srv_resp.spinr_val.add(10000);
		
		for (int idx = 0; idx < srv_resp.spinr_val.size(); idx++) {
			String conv_val	= new String(df.format(srv_resp.spinr_val.get(idx)));
			//srv_resp.spinr_lbl.add(String.valueOf(Double.valueOf(df.format(srv_resp.spinr_val.get(idx)))));
			srv_resp.spinr_lbl.add(conv_val);
		}
		
		String json_out = gson.toJson(srv_resp, WheelDetails.class);
		
		return json_out;
	}
    
    //-----------------------------------------------------
    //  Function 3.0: getUserSpinData
    //      Get the user's current spin data
    //-----------------------------------------------------
    public String calculateUserSpinResult()
    {
        /*  Libraries       */
		Gson gson			= new Gson();
        
        /*  Get Spin information from DB    */
        SpinDetails db_spin = this.getDbSpinInfo("test1234");
        
        /*  Variable Declaration    */
        int rng_idx 							= 0;
        int sts									= 0;
        String json_output						= "";
        HashMap<String, Integer> rng_result		= new HashMap<String, Integer>();
        
        
        ArrayList<Integer> spin_result = gson.fromJson(db_spin.rng_result, new TypeToken<ArrayList<Integer>>(){}.getType());
        
        switch (spin_result.get(db_spin.ticket_used)) {
            case 1:
                rng_idx = 6;
                break;
            
            case 2:
                rng_idx = 3;
                break;
                
            case 3:
                rng_idx = 14;
                break;
            
            case 4:
                rng_idx = 8;
                break;
            
            case 5:
                rng_idx = 9;
                break;
            
            case 0:
            default:
                rng_idx = 4;
                break;
        }
        
        this.updateUserTicketUsage(1);
        
        rng_result.put("rng_idx", rng_idx);
        rng_result.put("status", sts);
        
        json_output = gson.toJson(rng_result, new TypeToken<HashMap<String, Integer>>(){}.getType());
        
        return json_output;
    }
    
    public boolean updateUserTicketUsage(int spin_id)
    {
        /*  Variable Declaration    */
        boolean status  = false;
        int upd_sts     = 0;
        
        /*  DB Connection   */
        Connection con          = null;
		PreparedStatement pstmt = null;
        String query            = "UPDATE user_spins SET status = ?, ticket_used = ticket_used + 1 WHERE spin_id = ?";
        
        /*  Connect to Database */
        try {	      
			
		 	Context initContext = new InitialContext();
		 	Context envContext  = (Context)initContext.lookup("java:/comp/env");
			DataSource ds       = (DataSource)envContext.lookup("jdbc/ibet");
            
			con     = ds.getConnection();
			pstmt   = con.prepareStatement(query);
			
            pstmt.setString(1, "0");
            pstmt.setString(2, Integer.toString(spin_id));
            
            upd_sts  = pstmt.executeUpdate();
            
            if (upd_sts > 0) {
                status = true;
            }
            
	        pstmt.close();
	        con.close();

		}
        catch (Exception e) {
            e.printStackTrace();
		}
        finally {
            
		}
        
        return status;
    }
    
    public boolean updateTestWheel(int ticket_num, int win_amt, ArrayList<Integer> combo_result)
    {
        /*  Variable Declaration    */
    	Gson gson		= new Gson();
        boolean status  = false;
        int upd_sts     = 0;
        String json_combo = gson.toJson(combo_result,  new TypeToken<ArrayList<Integer>>(){}.getType());
        /*  DB Connection   */
        Connection con          = null;
		PreparedStatement pstmt = null;
        String query            = "UPDATE user_spins SET ticket_used = 0, ticket_num = ?, total_win = ?, rng_result = ? WHERE spin_id = 1";
        
        /*  Connect to Database */
        try {	      
			
		 	Context initContext = new InitialContext();
		 	Context envContext  = (Context)initContext.lookup("java:/comp/env");
			DataSource ds       = (DataSource)envContext.lookup("jdbc/ibet");
            
			con     = ds.getConnection();
			pstmt   = con.prepareStatement(query);
			
            pstmt.setInt(1, ticket_num);
            pstmt.setInt(2, win_amt);
            pstmt.setString(3, json_combo);
            
            upd_sts  = pstmt.executeUpdate();
            
            if (upd_sts > 0) {
                status = true;
            }
            
	        pstmt.close();
	        con.close();
		}
        catch (Exception e) {
            e.printStackTrace();
		}
        finally {
            
		}
        
        return status;
    }
}
