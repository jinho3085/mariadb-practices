package example;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class insertEx01 {

	public static void main(String[] args) {
		insert("기획1팀");
		insert("기획2팀");
	}
	
	public static boolean insert(String department ) {
		Connection con = null;
		Statement stmt = null;
		boolean result = false;
		
		try {
			// 1. JDBC Driver 로딩
			Class.forName("org.mariadb.jdbc.Driver");
			
			// 2. 연결하기
			String url  = "jdbc:mariadb://192.168.0.178:3306/webdb";
			con =  DriverManager.getConnection (url, "webdb", "webdb");
			
			// 3. Statement 생성
			stmt = con.createStatement();
			
			// 4. SQL 실행
			String sql = "insert into dept(name) values('" + department + "')";
			int count = stmt.executeUpdate(sql);
			
			result = count == 1;
		} catch (ClassNotFoundException e) {
			System.out.println("Driver Class Not Found");
		} catch (SQLException e) {
			 System.out.println("error:" + e);
		} finally {
			try {
				if(stmt != null) {
					stmt.close();
				}
				if(con != null) {
					con.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		return result;
	}
	
	}
