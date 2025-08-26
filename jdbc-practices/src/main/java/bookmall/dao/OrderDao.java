package bookmall.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import bookmall.vo.OrderBookVo;
import bookmall.vo.OrderVo;

public class OrderDao {

	public void insert(OrderVo vo) {
		 try (
		       Connection conn = getConnection();
		       PreparedStatement pstmt = conn.prepareStatement(
		       "insert into orders(user_no, number, payment, shipping, status) values (?, ?, ?, ?, ?)",
		       Statement.RETURN_GENERATED_KEYS
		       );
		     ) {
		        pstmt.setLong(1, vo.getUserNo());
		        pstmt.setString(2, vo.getNumber());
		        pstmt.setInt(3, vo.getPayment());
		        pstmt.setString(4, vo.getShipping());
		        pstmt.setString(5, vo.getStatus());
		        pstmt.executeUpdate();

		        try (ResultSet rs = pstmt.getGeneratedKeys()) {
		           if (rs.next()) {
		           vo.setNo(rs.getLong(1));
		         }
		       }
		        } catch (SQLException e) {
		            System.out.println("error:" + e);
		        }
	}

	public void insertBook(OrderBookVo vo) {
		try (
	            Connection conn = getConnection();
	            PreparedStatement pstmt = conn.prepareStatement(
	                "insert into order_book(order_no, book_no, quantity, price) values (?, ?, ?, ?)"
	            );
	        ) {
	            pstmt.setLong(1, vo.getOrderNo());
	            pstmt.setLong(2, vo.getBookNo());
	            pstmt.setInt(3, vo.getQuantity());
	            pstmt.setInt(4, vo.getPrice());
	            pstmt.executeUpdate();
	        } catch (SQLException e) {
	            System.out.println("error:" + e);
	        }
	}

	public OrderVo findByNoAndUserNo(long orderNo, Long userNo) {
		OrderVo vo = null;
        try (
            Connection conn = getConnection();
            PreparedStatement pstmt = conn.prepareStatement(
                "select no, number, payment, shipping, status from orders where no=? and user_no=?"
            );
        ) {
            pstmt.setLong(1, orderNo);
            pstmt.setLong(2, userNo);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    vo = new OrderVo();
                    vo.setNo(rs.getLong(1));
                    vo.setNumber(rs.getString(2));
                    vo.setPayment(rs.getInt(3));
                    vo.setShipping(rs.getString(4));
                    vo.setStatus(rs.getString(5));
                }
            }
        } catch (SQLException e) {
            System.out.println("error:" + e);
        }
        return vo;
	}

	public List<OrderBookVo> findBooksByNoAndUserNo(Long orderNo, Long userNo) {
		List<OrderBookVo> list = new ArrayList<>();
        try (
            Connection conn = getConnection();
            PreparedStatement pstmt = conn.prepareStatement(
                "select ob.order_no, ob.book_no, ob.quantity, ob.price, b.title " +
                "from order_book ob " +
                "join orders o on ob.order_no = o.no " +
                "join book b on ob.book_no = b.no " +
                "where ob.order_no=? and o.user_no=?"
            );
        ) {
            pstmt.setLong(1, orderNo);
            pstmt.setLong(2, userNo);
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    OrderBookVo vo = new OrderBookVo();
                    vo.setOrderNo(rs.getLong(1));
                    vo.setBookNo(rs.getLong(2));
                    vo.setQuantity(rs.getInt(3));
                    vo.setPrice(rs.getInt(4));
                    vo.setBookTitle(rs.getString(5));
                    list.add(vo);
                }
            }
        } catch (SQLException e) {
            System.out.println("error:" + e);
        }
        return list;
	}

	public void deleteBooksByNo(Long orderNo) {
		try (
	            Connection conn = getConnection();
	            PreparedStatement pstmt = conn.prepareStatement("delete from order_book where order_no=?");
	        ) {
	            pstmt.setLong(1, orderNo);
	            pstmt.executeUpdate();
	        } catch (SQLException e) {
	            System.out.println("error:" + e);
	        }
	}

	public void deleteByNo(Long orderNo) {
		try (
	            Connection conn = getConnection();
	            PreparedStatement pstmt = conn.prepareStatement("delete from orders where no=?");
	        ) {
	            pstmt.setLong(1, orderNo);
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
