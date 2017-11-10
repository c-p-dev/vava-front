package admin;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.Socket;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import org.json.JSONArray;
import org.json.JSONObject;

/**
 * Oddsfeed client
 * 
 * @author betconstruct.com
 *
 */
public class OddsfeedClient {
	
	String socketHost;
	int socketPort;
	InputStream is;
	BufferedReader in;
	DataOutputStream os;
	Socket socket;
	Calendar lastDt;	
	Boolean subscribeToLiveMatches = false;
	Boolean subscribeToPreMatches = false;
	Boolean isConnected = false;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSXXX");
	public Boolean keepRunning = true;
		
	/**
	 * Constructs the object OddsfeedClient
	 * 
	 * @param hostName
	 * @param port
	 * @param userName
	 * @param password
	 */
	public OddsfeedClient(String hostName, int port, String userName, String password) {
		socketHost = hostName;
		socketPort = port;
	//	Commands.LOGIN = String.format(Commands.LOGIN, userName, password);
	}
	
	/**
	 * Establish connection with partner server, try to authenticate by LOGIN command
	 * and also subscribe to live or/and prematch events, if they are required
	 */
	private void EstablishConnection() {
		
		lastDt = Calendar.getInstance();

		// close socket if not closed
		try {
			if(socket!=null && !socket.isClosed()) {
				socket.close();
				socket = null;
			}
		}
		catch(Exception ex) {
			ex.printStackTrace();
		}
			
		try {			
			socket = new Socket(socketHost, socketPort);

			is = socket.getInputStream();
			os = new DataOutputStream(socket.getOutputStream());

//			byte[] login = Commands.LOGIN.getBytes();
//			os.write(Helper.intToByte(login.length));
//			os.write(login);
			os.flush();

			if(subscribeToLiveMatches)				
//				sendString(Commands.SUBSCRIBE_MATCHES);

			if(subscribeToPreMatches) 
//				sendString(Commands.SUBSCRIBE_PREMATCHES);		
			
			isConnected = true;

		} catch (IOException e) {			
			e.printStackTrace();
		}	
		catch (Exception e) {			
			e.printStackTrace();
		}
	}
	
	/**
	 * Sending a few requests for getting large size information from partner server
	 * 
	 * @throws Exception
	 */
	private void RequestLargeInfoBucketForTest() throws Exception {
//		sendString(Commands.GETSPORTS);
//		sendString(Commands.GETREGIONS);
//		sendString(Commands.GETCOMPETITIONS);
		
		Calendar cStart = Calendar.getInstance();    
		cStart.add(Calendar.DATE, -3);		
		Calendar cEnd = Calendar.getInstance();    
		cEnd.add(Calendar.DATE, 3);		
//		sendString(String.format(Commands.GETMATCHES, sdf.format(cStart.getTime()),sdf.format(cEnd.getTime())));
	}
	
	/**
	 * Start the client
	 * 
	 * @param subscribeToLive
	 * @param subscribeToPreMatch
	 */
	public void Start(Boolean subscribeToLive, Boolean subscribeToPreMatch) {
		lastDt = Calendar.getInstance();
	
		try {						
				subscribeToLiveMatches = subscribeToLive; 
				subscribeToPreMatches = subscribeToPreMatch;
					
				
				
				while (keepRunning)
				{	
					try {
						if(!isConnected) {
							EstablishConnection();
							Thread.sleep(100);	
						}
						//RequestLargeInfoBucketForTest();
						
						String resp = readMessage();
						if(resp.isEmpty()) Thread.sleep(10);	
						else {	
							ProcessCommand(resp);
						}
					}
					catch (Exception e) {
						isConnected = false;
					}
					finally
					{
						Calendar now = Calendar.getInstance();
						if (now.after(lastDt))
						{
							try {
//								sendString(Commands.HEARTBEAT);
							} catch (Exception e) {
								e.printStackTrace();
								isConnected = false;
							}
							lastDt = now;
							lastDt.add(Calendar.SECOND, 3);
						}		    		
					}		
				}
				is.close();
				os.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			if(socket!=null) {
				try {
					socket.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}
	
	private void ProcessCommand(String commandStr) {
		try {				
			JSONObject obj = new JSONObject(commandStr);
			String command = obj.getString("Command");
			if(command.isEmpty()) {
				System.out.println(commandStr);
			}
			else {
				if(!obj.isNull("Objects")) {
					JSONArray jArr = obj.getJSONArray("Objects");																
					System.out.println(command + " - objects count - " + jArr.length() + ", Size - " + commandStr.length());
					System.out.println("Response: " + commandStr);
				}
				else{
					System.out.println(command);
				}
			}
		}catch(Exception ex) {
			ex.printStackTrace();
		}
	}

	/**
	 * Send the string to the server
	 * 
	 * @param commandStr
	 * @throws Exception
	 */
	private void sendString(String commandStr) throws Exception {
		byte[] commandByteArray = commandStr.getBytes();
//		os.write(Helper.intToByte(commandByteArray.length));
		os.write(commandByteArray);
		os.flush();
	}

	/**
	 * Read the message from server
	 * 
	 * @return String
	 * @throws Exception
	 * @throws IOException
	 */
	private String readMessage() throws Exception, IOException
	{	
		String retVal = "";	
		while(true) {

			byte[] content = new byte[ 4 ];  

			if(is.available()>0)
			{
				int commandSize = 0;
				while( is.read( content )  != -1 ) {
//					commandSize = Helper.byteToInt(content);	
					//Helper.stringToFile(dateFormat.format(new Date()) + " " + content[0] + "," + content[1] + "," + content[2] + "," + content[3] + ", size=" + commandSize + "\n", "C:\\bytes.txt");  		
					break;
				} 

				if(commandSize>0) {
					retVal = new String(readBytes(is, commandSize), "UTF-8");
				}
				break;
			}else break;
		}
		return retVal;
	}
		
	/**
	 * Read maxBytes bytes from stream
	 * @param in InputStream
	 * @param maxBytes max count of byte to read from the stream
	 * @return Byte array
	 * @throws IOException
	 */
	private byte[] readBytes(InputStream in, int maxBytes) throws IOException 
	{
		byte[] result = new byte[maxBytes];

		int bytesRead = 0;
		int totalBytesRead = maxBytes;
		do{
			bytesRead = is.read( result, maxBytes - totalBytesRead, totalBytesRead );
			totalBytesRead = totalBytesRead - bytesRead;
		} while (totalBytesRead > 0);

		return result;
	}
	
}
