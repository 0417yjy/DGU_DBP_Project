package eduBean;

public class Course {
	private String c_id;
	private int c_id_no;
	private String c_name;
	private int c_unit;
	private int t_max;
	private String p_id;
	private String p_name;

	public Course() {
		c_id = null;
		c_id_no = 0;
		c_name = null;
		c_unit = 0;
		t_max = 0;
		p_id = null;
		p_name = null;
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

	public void setCUnit(int c_unit) {
		this.c_unit = c_unit;
	}

	public void setTMax(int t_max) {
		this.t_max = t_max;
	}

	public void setPId(String p_id) {
		this.p_id = p_id;
	}
    
	public void setPName(String p_name) {
		this.p_name = p_name;
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

	public int getCUnit() {
		return c_unit;
	}

	public int getTMax() {
		return t_max;
	}

	public String getPId() {
		return p_id;
	}
    
	public String getPName() {
		return p_name;
	}

}
