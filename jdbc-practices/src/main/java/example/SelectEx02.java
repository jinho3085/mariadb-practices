package example;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class SelectEx02 {

	public static void main(String[] args) {
		List<DeptVo> list = search("개발");
		for(DeptVo vo : list) {
			System.out.println(vo);
		}
	}

	private static List<DeptVo> search(String keyword) {
	    Connection con = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;

	    List<DeptVo> result = new ArrayList<>();

	    try {
	        // 1. JDBC Driver 로딩
	        Class.forName("org.mariadb.jdbc.Driver");

	        // 2. 연결하기
	        String url = "jdbc:mariadb://192.168.0.178:3306/webdb";
	        con = DriverManager.getConnection(url, "webdb", "webdb");

	        // 3. Statement 생성
	        String sql = "select id, name from dept where name like ?";
	        pstmt = con.prepareStatement(sql);

	        // 4. Parameter Binding
	        pstmt.setString(1, "%" + keyword + "%");

	        // 5. SQL 실행
	        rs = pstmt.executeQuery();

	        // 6. 결과처리
	        while (rs.next()) {
	            Long id = rs.getLong(1);
	            String name = rs.getString(2);

	            DeptVo vo = new DeptVo();
	            vo.setId(id);
	            vo.setName(name);

	            result.add(vo);
	        }

	    } catch (ClassNotFoundException e) {
	        System.out.println("Driver Class Not Found");
	    } catch (SQLException e) {
	        System.out.println("error:" + e);
	    } finally {
	        try {
	            if (rs != null) rs.close();
	            if (pstmt != null) pstmt.close();
	            if (con != null) con.close();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }
	    return result;
	}

}


