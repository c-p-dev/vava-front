package net.vavasoft.util;

import java.sql.Connection;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import org.apache.log4j.Logger;

public class DBConnector {

	private static Logger logger = Logger.getLogger(DBConnector.class);
	private static DBConnector instance = null;
	private static DataSource dataSource = null;
	private static Context context = null;

	private DBConnector() {
	}

	static {

		try {

			context = new InitialContext();
			dataSource = (DataSource) context.lookup("java:comp/env/jdbc/sqlserver");

		} catch (Exception ex) {

			logger.debug(ex);
		}
		
		logger.debug("DBConnector now is initialized... ");
		
	}

	public static DBConnector getInstance() {

		if (instance == null) {

			synchronized (DBConnector.class) {
				if (instance == null) {
					instance = new DBConnector();
				}
			}
		}

		return instance;
	}

	public static Connection getConnection() {

		Connection con = null;

		try {
			con = dataSource.getConnection();
			
		} catch (Exception e) {
			logger.info(e);
		}
		return con;
	}

}
