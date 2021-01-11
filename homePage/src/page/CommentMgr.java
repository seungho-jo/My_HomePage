package page;

import java.sql.*;
import java.util.*;

public class CommentMgr {

	private DBConnectionMgr pool;

	public CommentMgr() {
		try {
			pool = DBConnectionMgr.getInstance();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	//댓글 입력
	public boolean insertComment(commentBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "insert tblcomment(num, name, comment) value(?, ?, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bean.getNum());
			pstmt.setString(2, bean.getName());
			pstmt.setString(3, bean.getComment());
			if(pstmt.executeUpdate() == 1) {
				flag = true;
			}
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	//댓글 출력
	public Vector<commentBean> getComment(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<commentBean> vlist = new Vector<commentBean>();
		try {
			con = pool.getConnection();
			sql = "select * from tblcomment where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				commentBean dean = new commentBean();
				dean.setNum(rs.getInt("num"));
				dean.setName(rs.getString("name"));
				dean.setComment(rs.getString("comment"));
				dean.setNumber(rs.getInt("number"));
				vlist.add(dean);
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	//댓글 개별 삭제
		public void deleteComment(int number) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			try {
				con = pool.getConnection();
				sql = "delete from tblcomment where number=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, number);
				pstmt.executeUpdate();
			}catch (Exception e) {
				e.printStackTrace();
			}finally {
				pool.freeConnection(con, pstmt, rs);
			}
		}
		//댓글 전체 삭제
		public void delete(int num) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql = null;
			try {
				con = pool.getConnection();
				sql = "delete from tblcomment where num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.executeUpdate();
			}catch (Exception e) {
				e.printStackTrace();
			}finally {
				pool.freeConnection(con, pstmt, rs);
			}
		}
}
