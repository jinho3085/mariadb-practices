package email;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class EmailDao {
	
	public int deleteByEmail(String email) {
			Connection con = null;
			PreparedStatement pstmt = null;
			int result = 0;
			
			try {
				con =  getConnection();
				
				String sql = "delete from email where email = ?";
				pstmt = con.prepareStatement(sql);
				
				pstmt.setString(1, email);
				
				result = pstmt.executeUpdate();
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
	
	public  int insert(EmailVo vo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int result = 0;
		
		
		try {
			con = getConnection();
			
			String sql  = "insert into email(first_name, last_name, email) values (?, ?, ?)";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, vo.getFirstName());
			pstmt.setString(2, vo.getLastName());
			pstmt.setString(3, vo.getEmail());
			
			result = pstmt.executeUpdate();
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
		
	public Connection getConnection() throws SQLException {
		Connection con = null;
		
		try {
			Class.forName("org.mariadb.jdbc.Driver");
			
			String url  = "jdbc:mariadb://192.168.0.177:3306/webdb";
			con =  DriverManager.getConnection (url, "webdb", "webdb");
		} catch (ClassNotFoundException ex) {
			System.out.println("Driver Class Not Found");
		}
		 return con;
	 }

	public Long count() {
		Long result = 0L;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		
		try {
			con =  getConnection();
			
			String sql = "select count(*) from email";
			pstmt = con.prepareStatement(sql);
			
			 rs = pstmt.executeQuery();
			 if(rs.next()) {
				 result = rs.getLong(1);
			 }
		} catch (SQLException e) {
			 System.out.println("error:" + e);
		} finally {
			try {
				if(rs != null) {
					rs.close();
				}
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

	public List<EmailVo> findAll() {
		List<EmailVo> result = new ArrayList<EmailVo>();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		
		try {
			con =  getConnection();
			
			String sql = "select id, first_name, last_name, email from email order by id desc;";
			pstmt = con.prepareStatement(sql);
			
			 rs = pstmt.executeQuery();
			 while(rs.next()) {
				 Long id = rs.getLong(1);
				 String firstName = rs.getString(2);
				 String lastName = rs.getString(3);
				 String email = rs.getString(4);
				 
				 EmailVo vo = new EmailVo();
				 vo.setId(id);
				 vo.setFirstName(firstName);
				 vo.setLastName(lastName);
				 vo.setEmail(email);
				 
				 result.add(vo);
			 }
		} catch (SQLException e) {
			 System.out.println("error:" + e);
		} finally {
			try {
				if(rs != null) {
					rs.close();
				}
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