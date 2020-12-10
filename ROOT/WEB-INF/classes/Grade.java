package eduBean;

public class Grade {
	private String c_id;
	private int c_id_no;
	private String c_name;
	private String s_id;
	private String s_name;
	private int e_score;
	private String e_grade;

	public Grade() {
		c_id = null;
		c_id_no = 0;
		c_name = null;
		s_id = null;
		s_name = null;
		e_score = 0;
		e_grade = null;
	}

	public void setCId(String c_id) {
		this.c_id = c_id;
	}

	public void setCIdNo(int c_id_no) {
		this.c_id_no = c_id_no;
	}

	public void setCName(String c_name) {
		this.c_name = c_name;
	}

	public void setSId(String s_id) {
		this.s_id = s_id;
	}

	public void setSName(String s_name) {
		this.s_name = s_name;
	}

	public void setEScore(int e_score) {
		this.e_score = e_score;
	}

	public void setEGrade(String e_grade) {
		this.e_grade = e_grade;
	}

	public String getCId() {
		return c_id;
	}

	public int getCIdNo() {
		return c_id_no;
	}

	public String getCName() {
		return c_name;
	}

	public String getSId() {
		return s_id;
	}

	public String getSName() {
		return s_name;
	}

	public int getEScore() {
		return e_score;
	}

	public String getEGrade() {
		return e_grade;
	}
}
