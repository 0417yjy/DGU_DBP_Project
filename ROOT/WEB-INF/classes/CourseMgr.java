package eduBean;
import java.sql.*;
import java.util.*;
import javax.sql.*;
import oracle.jdbc.driver.*;
import oracle.jdbc.pool.*;
import eduBean.*;

public class CourseMgr {
	private OracleConnectionPoolDataSource ocpds = null;
	private PooledConnection pool = null;

	public CourseMgr() {
		try{
			ocpds = new OracleConnectionPoolDataSource();

			ocpds.setURL("jdbc:oracle:thin:@210.94.199.20:1521:DBLAB");
			ocpds.setUser("FE2015112135");   // 본인 아이디(ex.FE0000000000)
			ocpds.setPassword("FE2015112135");  // 본인 패스워드(ex.FE0000000000)

			pool = ocpds.getPooledConnection();
		} catch(Exception e) {
			System.out.println("Error : Connection Failed");
		}
	}
	// 해당 년도 조회
	public int getCurrentYear() {
		int nYear=0;
		Connection conn = null;
		CallableStatement cstmt = null;
		try {
			conn = pool.getConnection();

			cstmt = conn.prepareCall("{? = call Date2EnrollYear(SYSDATE)}");
			cstmt.registerOutParameter(1, java.sql.Types.INTEGER);
			cstmt.execute();
			nYear = cstmt.getInt(1);

			cstmt.close();
			conn.close();		
		} catch (Exception ex) {
			System.out.println("Exception" + ex);
		}
		return nYear;
	}
	
	// 해당 학기 조회
	public int getCurrentSemester() {
		int nSemester=0;
		Connection conn = null;
		CallableStatement cstmt = null;

		try {
			conn = pool.getConnection();

			cstmt = conn.prepareCall("{? = call Date2EnrollSemester(SYSDATE)}");
			cstmt.registerOutParameter(1, java.sql.Types.INTEGER);
			cstmt.execute();
			nSemester = cstmt.getInt(1);

			cstmt.close();
			conn.close();
		} catch (Exception ex) {
			System.out.println("Exception" + ex);
		}
		return nSemester;
	}
    
	// 개설신청현황 조회
	public Vector getCourseList() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Vector vecList = new Vector();

		try {
			CallableStatement cstmt1 = null;
			CallableStatement cstmt2 = null;
			conn = pool.getConnection();

			cstmt1 = conn.prepareCall("{? = call Date2EnrollYear(SYSDATE)}");
			cstmt1.registerOutParameter(1, java.sql.Types.INTEGER);
			cstmt1.execute();
			int nYear = cstmt1.getInt(1);

			cstmt2 = conn.prepareCall("{? = call Date2EnrollSemester(SYSDATE)}");
			cstmt2.registerOutParameter(1, java.sql.Types.INTEGER);
			cstmt2.execute();
			int nSemester = cstmt2.getInt(1);

			String mySQL = "select c.c_id as cid, c.c_id_no as cid_no, c.c_name as cname, c.c_unit as cunit, t.p_id as pid, p.p_name as pname"
						+  " from course c"
						+  "  left join teach t"
						+  "   inner join professor p on p.p_id=t.p_id"
						+  "  on c.c_id=t.c_id and c.c_id_no=t.c_id_no and t_year=? and t_semester=?"
						+  " ORDER BY CID";
			pstmt = conn.prepareStatement(mySQL);
			pstmt.setInt(1, nYear);
			pstmt.setInt(2, nSemester);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				Course en = new Course();
				en.setCId(rs.getString("cid"));
				en.setCIdNo(rs.getInt("cid_no"));
				en.setCName(rs.getString("cname"));
				en.setCUnit(rs.getInt("cunit"));
				en.setPId(rs.getString("pid"));
				en.setPName(rs.getString("pname"));
				vecList.add(en);
			}
			pstmt.close();
			conn.close();

		} catch (Exception ex) {
			System.out.println("Exception" + ex);
		}
		return vecList;
	}
	
	// 강좌개설신청
	public void insertTeach(String p_id, String c_id, int c_id_no) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		CallableStatement cstmt1 = null;
		CallableStatement cstmt2 = null;

		try {
			conn = pool.getConnection();

			cstmt1 = conn.prepareCall("{? = call Date2EnrollYear(SYSDATE)}");
			cstmt1.registerOutParameter(1, java.sql.Types.INTEGER);
			cstmt1.execute();
			int nYear = cstmt1.getInt(1);

			cstmt2 = conn.prepareCall("{? = call Date2EnrollSemester(SYSDATE)}");
			cstmt2.registerOutParameter(1, java.sql.Types.INTEGER);
			cstmt2.execute();
			int nSemester = cstmt2.getInt(1);

			String mySQL = "insert into teach values (?, ?, ?, ?, ?, NULL, NULL, 5)";
			pstmt = conn.prepareStatement(mySQL);
			pstmt.setString(1, p_id);
			pstmt.setString(2, c_id);
			pstmt.setInt(3, c_id_no);
			pstmt.setInt(4, nYear);
			pstmt.setInt(5, nSemester);
			pstmt.executeUpdate();

			pstmt.close();
			conn.close();
		} catch (Exception ex) {
			System.out.println("Exception" + ex);
		}
	}
    
	// 강좌개설신청 취소
	public String deleteTeach(String p_id, String c_id, int c_id_no) {
		Connection conn = null;
		CallableStatement cstmt = null;
		String Result = null;

		try {
			conn = pool.getConnection();
			cstmt = conn.prepareCall("{call DELETETEACH(?, ?, ?, ?)}");
			cstmt.setString(1, p_id);
			cstmt.setString(2, c_id);
			cstmt.setInt(3, c_id_no);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.execute();
			Result = cstmt.getString(4);
		} catch (Exception ex) {
			System.out.println("Exception" + ex);
		}
        
		return Result;
	}
}
