package eduBean;

import java.sql.*;
import java.util.*;
import javax.sql.*;
import oracle.jdbc.driver.*;
import oracle.jdbc.pool.*;
import eduBean.*;

public class GradeMgr {

	private OracleConnectionPoolDataSource ocpds = null;
	private PooledConnection pool = null;

	public GradeMgr() {
		try{
			ocpds = new OracleConnectionPoolDataSource();

			ocpds.setURL("jdbc:oracle:thin:@210.94.199.20:1521:DBLAB");
			ocpds.setUser("FE2015112135");  // 본인 아이디(ex.FE0000000000)
			ocpds.setPassword("FE2015112135");  // 본인 패스워드(ex.FE0000000000)

			pool = ocpds.getPooledConnection();
		} catch(Exception e) {
			System.out.println("Error : Connection Failed");
		}
	}
	
	// 현재 년도/학기에 담당하고 있는 강의과목의 학생 성적 조회
	public Vector getScoreList(String p_id, int nYear, int nSemester) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Vector vecList = new Vector();

		try {
			conn = pool.getConnection();

			String mySQL = "select e.c_id as cid, e.c_id_no as cid_no, c.c_name as cname, e.s_id as sid, s.s_name as sname, e.e_score as escore, e.e_grade as egrade"
						+  " from enroll e"
						+  " inner join teach t "
						+  "  inner join professor p on p.p_id=t.p_id and p.p_id=?"
						+  " on e.c_id=t.c_id and e.c_id_no=t.c_id_no and e.e_year=t.t_year and e.e_semester=t.t_semester and e.e_year=? and e.e_semester=?"
						+  " inner join course c on c.c_id=e.c_id and c.c_id_no=t.c_id_no"
						+  " inner join student s on s.s_id=e.s_id";
			pstmt = conn.prepareStatement(mySQL);
			pstmt.setString(1, p_id);
			pstmt.setInt(2, nYear);
			pstmt.setInt(3, nSemester);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				Grade tr = new Grade();
				tr.setCId(rs.getString("cid"));
				tr.setCIdNo(rs.getInt("cid_no"));
				tr.setCName(rs.getString("cname"));
				tr.setSId(rs.getString("sid"));
				tr.setSName(rs.getString("sname"));
				tr.setEScore(rs.getInt("escore"));
				tr.setEGrade(rs.getString("egrade"));
				vecList.add(tr);
			}
			pstmt.close();
			conn.close();
		} catch(Exception ex) {
			System.out.println("Exception" + ex);
		}
		return vecList;
	}
	
	// 성적등록
	public String setScore(String score, String sid, String cid, int cidno, int year, int semester) {
		String sMessage = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		try {
			conn = pool.getConnection();
			cstmt = conn.prepareCall("{call INSERTGRADE(?, ?, ?, ?, ?, ?, ?)}");
			cstmt.setString(1, score);
			cstmt.setString(2, sid);
			cstmt.setString(3, cid);
			cstmt.setInt(4, cidno);
			cstmt.setInt(5, year);
			cstmt.setInt(6, semester);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.execute();
			sMessage = cstmt.getString(7);
		} catch(SQLException ex) {
			if(ex.getErrorCode() == 20002) {
				sMessage = Integer.toString(ex.getErrorCode());
			}else if(ex.getErrorCode() == 20003) {
				sMessage = Integer.toString(ex.getErrorCode());
			}			
			System.out.println("Exception" + ex);
		}
		return sMessage;		
	}
	
	// 현재 년도 조회
	public int getCurrentYear() {
		int nYear = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		
		try {
			conn = pool.getConnection();

			cstmt = conn.prepareCall("{? = call Date2GradeYear(SYSDATE)}");
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
	
	// 현재 학기 조회
	public int getCurrentSemester() {
		int nSemester=0;
		Connection conn = null;
		CallableStatement cstmt = null;

		try {
			conn = pool.getConnection();

			cstmt = conn.prepareCall("{? = call Date2GradeSemester(SYSDATE)}");
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
}
