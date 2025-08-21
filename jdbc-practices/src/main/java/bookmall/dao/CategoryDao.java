package bookmall.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bookmall.vo.CategoryVo;


public class CategoryDao {
	
	public void insert(CategoryVo vo) {
		try (
	            Connection conn = getConnection();
	            PreparedStatement pstmt1 = conn.prepareStatement(
	                "insert into category(name) values (?)"
	            );
	            PreparedStatement pstmt2 = conn.prepareStatement("select last_insert_id() from dual");
	        ) {
	            pstmt1.setString(1, vo.getName());
	            pstmt1.executeUpdate();

	            ResultSet rs = pstmt2.executeQuery();
	            if (rs.next()) {
	                vo.setNo(rs.getLong(1));
	            }
	            rs.close();
	        } catch (SQLException e) {
	            System.out.println("error:" + e);
	        }
	}
	
	public List<CategoryVo> findAll() {
		List<CategoryVo> list = new ArrayList<>();
        try (
            Connection conn = getConnection();
            PreparedStatement pstmt = conn.prepareStatement("select no, name from category order by no desc");
            ResultSet rs = pstmt.executeQuery();
        ) {
            while (rs.next()) {
                CategoryVo vo = new CategoryVo();
                vo.setNo(rs.getLong(1));
                vo.setName(rs.getString(2));
                list.add(vo);
            }
        } catch (SQLException e) {
            System.out.println("error:" + e);
        }
        return list;
	}

	public void deleteByNo(Long no) {
		try (
	            Connection conn = getConnection();
	            PreparedStatement pstmt = conn.prepareStatement("delete from category where no=?");
	        ) {
	            pstmt.setLong(1, no);
	            pstmt.executeUpdate();
	        } catch (SQLException e) {
	            System.out.println("error:" + e);
	        }
	}

	private Connection getConnection() throws SQLException{
		 Connection conn = null;
	        try {
	            Class.forName("org.mariadb.jdbc.Driver");
	            String url = "jdbc:mariadb://192.168.0.177:3306/bookmall";
	            conn = DriverManager.getConnection(url, "bookmall", "bookmall");
	        } catch (ClassNotFoundException e) {
	            System.out.println("드라이버 로딩 실패:" + e);
	        }
	        return conn;
	}


}
