package bookmall.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bookmall.vo.CartVo;

public class CartDao {

	public void insert(CartVo vo) {
		try (
	            Connection conn = getConnection();
	            PreparedStatement pstmt = conn.prepareStatement(
	                "insert into cart(user_no, book_no, quantity) values (?, ?, ?)"
	            );
	        ) {
	            pstmt.setLong(1, vo.getUserNo());
	            pstmt.setLong(2, vo.getBookNo());
	            pstmt.setInt(3, vo.getQuantity());
	            pstmt.executeUpdate();
	        } catch (SQLException e) {
	            System.out.println("error:" + e);
	        }
	}

	public List<CartVo> findByUserNo(Long no) {
		List<CartVo> list = new ArrayList<>();
        try (
            Connection conn = getConnection();
            PreparedStatement pstmt = conn.prepareStatement(
                "select c.user_no, c.book_no, c.quantity, b.title " +
                "from cart c join book b on c.book_no = b.no " +
                "where c.user_no=?"
            );
        ) {
            pstmt.setLong(1, no);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    CartVo vo = new CartVo();
                    vo.setUserNo(rs.getLong(1));
                    vo.setBookNo(rs.getLong(2));
                    vo.setQuantity(rs.getInt(3));
                    vo.setBookTitle(rs.getString(4));
                    list.add(vo);
                }
            }
        } catch (SQLException e) {
            System.out.println("error:" + e);
        }
        return list;
	}

	public void deleteByUserNoAndBookNo(Long userNo, Long bookno) {
		try (
	            Connection conn = getConnection();
	            PreparedStatement pstmt = conn.prepareStatement("delete from cart where user_no=? and book_no=?");
	        ) {
	            pstmt.setLong(1, userNo);
	            pstmt.setLong(2, userNo);
	            pstmt.executeUpdate();
	        } catch (SQLException e) {
	            System.out.println("error:" + e);
	        }
	}
	
	private Connection getConnection() throws SQLException{
		Connection conn = null;
        try {
            Class.forName("org.mariadb.jdbc.Driver");
            String url = "jdbc:mariadb://192.168.0.178:3306/bookmall";
            conn = DriverManager.getConnection(url, "bookmall", "bookmall");
        } catch (ClassNotFoundException e) {
            System.out.println("드라이버 로딩 실패:" + e);
        }
        return conn;
	}

}
