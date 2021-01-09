package page;

import java.sql.*;
import java.util.*;

public class MemberMgr {
	
	private DBConnectionMgr pool;
	
	public MemberMgr() {
		try {
			pool = DBConnectionMgr.getInstance();
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//id 중복확인
	public boolean checkId(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select id from tblmember where id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			flag = pstmt.executeQuery().next();
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}
	
	// 우편번호 검색
	public Vector<ZipcodeBean> zipcodeRead(String area3){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<ZipcodeBean> vlist = new Vector<ZipcodeBean>();
		try {
			con = pool.getConnection();
			sql = "select * from tblzipcode where area3 like ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%" + area3 + "%");
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ZipcodeBean bean = new ZipcodeBean();
				bean.setZipcode(rs.getString(1));
				bean.setArea1(rs.getString(2));
				bean.setArea2(rs.getString(3));
				bean.setArea3(rs.getString(4));
				vlist.addElement(bean);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con,pstmt,rs);
		}
		return vlist;
	}
	
	// 회원가입
	public boolean insertMember(MemberBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "insert tblmember(id,pwd,name,gender,birthday,email,zipcode,address,extraAddress,detailAddress"
					+ ",hobby,visit,logdate) value(?,?,?,?,?,?,?,?,?,?,?,?,now())";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getId());
			pstmt.setString(2, bean.getPwd());
			pstmt.setString(3, bean.getName());
			pstmt.setString(4, bean.getGender());
			pstmt.setString(5, bean.getBirthday());
			pstmt.setString(6, bean.getEmail());
			pstmt.setString(7, bean.getZipcode());
			pstmt.setString(8, bean.getAddress());
			pstmt.setString(9, bean.getExtraAddress());
			pstmt.setString(10, bean.getDetailAddress());
			String hobby[] = bean.getHobby();
			char hb[] = {'0','0','0','0','0'};
			String lists[] = {"인터넷","여행","게임","영화","운동"};
			for(int i=0;i<hobby.length;i++) {
				for(int j=0; j<lists.length;j++){
					if(hobby[i].equals(lists[j]))
						hb[j]='1';
				}
			}
			pstmt.setString(11, new String(hb));
			pstmt.setString(12, bean.getVisit());
			if(pstmt.executeUpdate() == 1)
				flag = true;
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt);
		}
		return flag;
	}
	
	// 로그인
	public boolean loginMember(String id, String pwd) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			sql = "select id from tblMember where id = ? and pwd = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pwd);
			rs = pstmt.executeQuery();
			flag = rs.next();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return flag;
	}
	//회원정보가지고오기
	public MemberBean getMember(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MemberBean bean = null;
		try {
			con = pool.getConnection();
			String sql = "select * from tblmember where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				bean = new MemberBean();
				bean.setId(rs.getString("id"));
				bean.setPwd(rs.getString("pwd"));
				bean.setName(rs.getString("name"));
				bean.setGender(rs.getString("gender"));
				bean.setBirthday(rs.getString("birthday"));
				bean.setEmail(rs.getString("email"));
				bean.setZipcode(rs.getString("zipcode"));
				bean.setAddress(rs.getString("address"));
				bean.setExtraAddress(rs.getString("extraAddress"));
				bean.setDetailAddress(rs.getString("detailAddress"));
				String hobbys[] = new String[5];
				String hobby = rs.getString("hobby");
				for(int i=0;i<hobbys.length;i++) {
					hobbys[i] = hobby.substring(i, i+1);
				}
				bean.setHobby(hobbys);
				bean.setVisit(rs.getString("visit"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con);
		}
		return bean;
	}
	//회원정보수정
	public boolean updateMember(MemberBean bean) {
		Connection con = null;
		PreparedStatement pstmt = null;
		boolean flag = false;
		try {
			con = pool.getConnection();
			String sql = "update tblmember set pwd=?, name=?, gender=?, birthday=?,"
					+ "email=?, zipcode=?, address=?, extraAddress=?, detailAddress=?, hobby=?, visit=? where id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getPwd());
			pstmt.setString(2, bean.getName());
			pstmt.setString(3, bean.getGender());
			pstmt.setString(4, bean.getBirthday());
			pstmt.setString(5, bean.getEmail());
			pstmt.setString(6, bean.getZipcode());
			pstmt.setString(7, bean.getAddress());
			pstmt.setString(8, bean.getExtraAddress());
			pstmt.setString(9, bean.getDetailAddress());
			char hobby[] = {'0', '0', '0', '0', '0' };
			if(bean.getHobby() != null) {
				String hobbys[] = bean.getHobby();
				String list[] = {"인터넷", "여행", "게임", "영화", "운동" };
				for(int i=0;i<hobbys.length;i++) {
					for(int j=0;j<list.length;j++)
						if(hobbys[i].equals(list[j]))
							hobby[j] = '1';
					}
				}
				pstmt.setString(10, new String(hobby));
				pstmt.setString(11, bean.getVisit());
				pstmt.setString(12, bean.getId());
				int count = pstmt.executeUpdate();
				if(count > 0)
					flag = true;
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				pool.freeConnection(con, pstmt);
			}
			return flag;
		}
	//관리자 회원정보 가지고 오기(1)
	public Vector<MemberBean> getMemberList(String keyField, String keyWord,
			int start, int end) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		Vector<MemberBean> vlist = new Vector<MemberBean>();
		try {
			con = pool.getConnection();
			if(keyWord.equals("null") || keyWord.equals("")) {
				sql = "select * from tblmember order by logdate desc limit ?, ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, start);
				pstmt.setInt(2, end);
			} else {
				sql = "select * from tblmember where " + keyField + " like ? ";
				sql += "order by logdate desc limit ? , ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keyWord + "%");
				pstmt.setInt(2, start);
				pstmt.setInt(3, end);
			}
			rs = pstmt.executeQuery();
			while(rs.next()) {
				MemberBean bean = new MemberBean();
				bean.setId(rs.getString("id"));
				bean.setName(rs.getString("name"));
				bean.setLogdate(rs.getString("logdate"));
				bean.setVisit(rs.getString("visit"));
				vlist.add(bean);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return vlist;
	}
	//총 회원수
	public int getTotalCount(String keyField, String keyWord) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = null;
		int totalCount = 0;
		try {
			con = pool.getConnection();
			if(keyWord.equals("null") || keyWord.equals("")) {
				sql = "select count(id) from tblmember";
				pstmt = con.prepareStatement(sql);
			}else {
				sql = "select count(id) from tblmember where" + keyField + "like ? ";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, "%" + keyWord + "%");
			}
			rs = pstmt.executeQuery();
			if(rs.next()) {
				totalCount = rs.getInt(1); 
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return totalCount;
	}
}
