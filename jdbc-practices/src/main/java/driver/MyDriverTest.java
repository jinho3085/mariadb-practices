package driver;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class MyDriverTest {

	public static void main(String[] args) {
		try {
			// Class.forName("oracle.jdbc.driver.OracleDriver");
			Class.forName("driver.MyDriver");
			
			String url  = "jdbc:mydb://127.0.0.1:1234";
			Connection con =  DriverManager.getConnection (url, "mydb", "mysql");
			
			System.out.println("연결성공");
		} catch (ClassNotFoundException e) {
			System.out.println("Driver Class Not Found");
		} catch (SQLException e) {
			 System.out.println("error:" + e);
		}
	}

}