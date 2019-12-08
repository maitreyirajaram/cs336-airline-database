package com.cs336.pkg;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map;

public class ApplicationDB {
	
	public ApplicationDB(){
		
	}

	public Connection getConnection(){
		
		//Create a connection string
		//String connectionUrl = "jdbc:mysql://rakshaadb.ccd5ejynxyym.us-east-1.rds.amazonaws.com:3306/cs336Final";
		String connectionUrl = "jdbc:mysql://localhost:3306/airlinedb";
		Connection connection = null;
		
		try {
			//Load JDBC driver - the interface standardizing the connection procedure. Look at WEB-INF\lib for a mysql connector jar file, otherwise it fails.
			Class.forName("com.mysql.jdbc.Driver").newInstance();
		} catch (InstantiationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			//Create a connection to your DB
			//connection = DriverManager.getConnection(connectionUrl,"cs336Fall2019", "rakshaadb");
			connection = DriverManager.getConnection(connectionUrl,"root", "rootroot");

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return connection;
		
	}
	
	public void closeConnection(Connection connection){
		try {
			connection.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	public Map<String, String> getAirports() throws SQLException {
		Connection conn = null;
		Statement stmt = null;
		Map<String, String> airports = new HashMap<String, String>(); 
		System.out.println("Get airports");
		try {
			conn = this.getConnection();
			stmt = conn.createStatement();
	        ResultSet rs = stmt.executeQuery("select airportid, airportname from airport");
	        System.out.println("Get airports after query");
	        while (rs.next()) {
	        	airports.put(rs.getString("airportid"), rs.getString("airportname"));
	        	System.out.println(rs.getString("airportid"));
	        }
	        return airports; 
			
		} finally {
			if(stmt != null) {
				stmt.close();
			}
			if (conn != null) {
				this.closeConnection(conn);
			}
		}
		
	}
	
	public Map<Integer, Float> getFlights(String airportorigin, String airportdest, String startdate) throws SQLException{
		Connection conn = null;
		Statement stmt = null;
		Map<Integer, Float> flightnums = new HashMap<Integer, Float>(); 
		System.out.println("Get flights");
		try {
			conn = this.getConnection();
			stmt = conn.createStatement();
	        String sql = "select flightnum, price from flight where departureairport ='" 
			+ airportorigin +  "' and destinationairport ='" + airportdest + 
			"' and departuredate = '" + startdate + "';";
	        System.out.println(sql);
			ResultSet rs = stmt.executeQuery(sql);
	        while (rs.next()) {
	        	flightnums.put(new Integer(rs.getInt("flightnum")), rs.getFloat("price"));
	 
	        }
	        return flightnums; 
			
		} finally {
			if(stmt != null) {
				stmt.close();
			}
			if (conn != null) {
				this.closeConnection(conn);
			}
		}
		
	}
	
	public void saveTicket(int cid, int flightNum) throws SQLException {
		Connection conn = null;
		Statement stmt = null;
		try {
			conn = this.getConnection();
			stmt = conn.createStatement();
	        String sql = "Insert into ticket(cid, flightNum) values(" + cid + "," + flightNum + ");";
	        System.out.println(sql);
	        conn.setAutoCommit(false); //transaction for multiple updates
	        stmt.executeUpdate(sql);
	        conn.commit(); 
			
		} finally {
			if(stmt != null) {
				stmt.close();
			}
			if (conn != null) {
				this.closeConnection(conn);
			}
		}
		
	}
	
	
	public static void main(String[] args) {
		ApplicationDB dao = new ApplicationDB();
		Connection connection = dao.getConnection();
		
		System.out.println(connection);		
		dao.closeConnection(connection);
	}
	
	

}
