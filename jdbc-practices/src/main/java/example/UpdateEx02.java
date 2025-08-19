package example;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class UpdateEx02 {

	public static void main(String[] args) {
		update(new DeptVo(1L, "경영지원팀"));
	}

	private static boolean update(DeptVo vo) {
		
			Connection con = null;
			PreparedStatement pstmt = null;
			
			boolean result = false;
			
			try {
				// 1. JDBC Driver 로딩
				Class.forName("org.mariadb.jdbc.Driver");
				
				// 2. 연결하기
				String url  = "jdbc:mariadb://192.168.0.178:3306/webdb";
				con =  DriverManager.getConnection (url, "webdb", "webdb");
				
				// 3. Statement 생성
				String sql = "update dept set name = '서비스개발팀' where id = ?";
				pstmt = con.prepareStatement(sql);
				
				// 4. Parameter Binding
				pstmt.setString(1, vo.getName());
				pstmt.setLong(2, vo.getId());
				
				// 5. SQL 실행
				
				int count = pstmt.executeUpdate();
				result = count == 1;
				
			} catch (ClassNotFoundException e) {
				System.out.println("Driver Class Not Found");
			} catch (SQLException e) {
				 System.out.println("error:" + e);
			} finally {
				try {
					if(pstmt != null) {
						pstmt.close();
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
