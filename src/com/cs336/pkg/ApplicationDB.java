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
		String connectionUrl = "jdbc:mysql://rakshaadb.ccd5ejynxyym.us-east-1.rds.amazonaws.com:3306/rakshaadb";
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
			connection = DriverManager.getConnection(connectionUrl,"rravi", "sairam23");
			//System.out.println("Inside connection");
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
	
	public Map<String, String> getAirlines() throws SQLException{
		Connection conn = null;
		Statement stmt = null;
		Map<String, String> airlineids = new HashMap<String,String>(); 
		System.out.println("Get airlines");
		try {
			conn = this.getConnection();
			stmt = conn.createStatement();
	        String sql = "select airlineid, name from airlinecompany;";
	        System.out.println(sql);
			ResultSet rs = stmt.executeQuery(sql);
	        while (rs.next()) {
	        	airlineids.put(rs.getString("airlineid"), rs.getString("name"));
	 
	        }
	        return airlineids; 
			
		} finally {
			if(stmt != null) {
				stmt.close();
			}
			if (conn != null) {
				this.closeConnection(conn);
			}
		}	
	}
	
	public Map<String, String> getAircraftsFromAirline(String airlineid) throws SQLException{
		Connection conn = null;
		Statement stmt = null;
		Map<String, String> aircrafts = new HashMap<String,String>(); 
		System.out.println("Get aircrafts based on airline");
		try {
			conn = this.getConnection();
			stmt = conn.createStatement();
	        String sql = "select aircraftid, airlineid from aircraft where airlineid='" + airlineid +"'";
	        System.out.println(sql);
			ResultSet rs = stmt.executeQuery(sql);
	        while (rs.next()) {
	        	aircrafts.put(rs.getString("aircraftid"), rs.getString("airlineid"));
	 
	        }
	        return aircrafts; 
			
		} finally {
			if(stmt != null) {
				stmt.close();
			}
			if (conn != null) {
				this.closeConnection(conn);
			}
		}	
	}
	
	public void updateTicket(int ticketNum, String classType, int isCancel, int isFlex, int cancelFee) throws SQLException {
		Connection conn = null;
		Statement stmt = null;
		try {
			conn = this.getConnection();
			stmt = conn.createStatement();
	        String sql = "Update ticket set classtype='" + classType + "', is_cancelled=" + isCancel + ", isflexible=" + isFlex + ", cancelfee=" + cancelFee + " where ticketNum=" + ticketNum +";";
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
	
	public void updateFlight(int flightnum, String depdate, String destdate, String depAirport, String destAirport, int isinternational, int isdomestic) throws SQLException {
		Connection conn = null;
		Statement stmt = null;
		try {
			conn = this.getConnection();
			stmt = conn.createStatement();
	        String sql = "Update flight set departuredate= date_format('"+depdate+"', '%Y-%m-%d'), destinationdate= date_format('"+destdate+"', '%Y-%m-%d'), departureairport='"+depAirport+"', destinationairport='"+destAirport+"', isinternational="+isinternational+", isdomestic="+isdomestic+" where flightNum=" + flightnum +";";
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
	
	public void updateAirport(String airportid, String airportname) throws SQLException {
		Connection conn = null;
		Statement stmt = null;
		try {
			conn = this.getConnection();
			stmt = conn.createStatement();
	        String sql = "Update airport set airportname= '"+airportname+"' where airportid= '" + airportid +"';";
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
	
	public void updateAirline(String airlineid, String airlinename) throws SQLException {
		Connection conn = null;
		Statement stmt = null;
		try {
			conn = this.getConnection();
			stmt = conn.createStatement();
	        String sql = "Update airlinecompany set name= '"+airlinename+"' where airlineid= '" + airlineid +"';";
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
	
	public int saveFlight(String depdate, String destdate, String depAirport, String destAirport, int isinternational, int isdomestic, int price, int stops, String aircraftid, String airlineid) throws SQLException {
		Connection conn = null;
		Statement stmt = null;
		try {
			System.out.println("before connection");
			conn = this.getConnection();
			stmt = conn.createStatement();
			System.out.println("before insert");
	        String sql = "Insert into flight(departuredate, destinationdate, departureairport, destinationairport, isinternational, isdomestic, price, stops, aircraftid, airlineid) values(date_format('"+depdate+"', '%Y-%m-%d'), date_format('"+destdate+"', '%Y-%m-%d'), '"+depAirport+"', '"+destAirport+"', "+isinternational+", "+isdomestic+", "+price+", "+stops+", '"+aircraftid+"', '"+airlineid+"');";
	        System.out.println(sql);
	        String idquery = "SELECT LAST_INSERT_ID() AS flightNum;";
	        System.out.println(idquery);
	        conn.setAutoCommit(false); //transaction for multiple updates
	        stmt.executeUpdate(sql);
	        ResultSet result = stmt.executeQuery(idquery);
	        result.next();
	        System.out.println(result.getString("flightNum"));
	        int flightNum = Integer.parseInt(result.getString("flightNum"));
	        conn.commit();
	        return flightNum;
	        
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
