package model;

public class NguoiDung {
	private int maNguoiDung;
	private String email;
	private String matKhau;
	private String hoTen;
	private boolean isAdmin;

	public NguoiDung() {
	}

	public NguoiDung(int maNguoiDung, String email, String matKhau, String hoTen, boolean isAdmin) {
		super();
		this.maNguoiDung = maNguoiDung;
		this.email = email;
		this.matKhau = matKhau;
		this.hoTen = hoTen;
		this.isAdmin = isAdmin;
	}

	public int getMaNguoiDung() {
		return maNguoiDung;
	}

	public void setMaNguoiDung(int maNguoiDung) {
		this.maNguoiDung = maNguoiDung;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getMatKhau() {
		return matKhau;
	}

	public void setMatKhau(String matKhau) {
		this.matKhau = matKhau;
	}

	public String getHoTen() {
		return hoTen;
	}

	public void setHoTen(String hoTen) {
		this.hoTen = hoTen;
	}

	public boolean isAdmin() {
		return isAdmin;
	}

	public void setAdmin(boolean isAdmin) {
		this.isAdmin = isAdmin;
	}

}
