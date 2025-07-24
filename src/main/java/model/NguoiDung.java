package model;

public class NguoiDung {
	private int maNguoiDung;
	private String email;
	private String matKhau;
	private String hoTen;
	private boolean isAdmin;
	private boolean trangThai;

	public NguoiDung() {
	}

	public NguoiDung(int maNguoiDung, String email, String matKhau, String hoTen, boolean isAdmin, boolean trangThai) {
		super();
		this.maNguoiDung = maNguoiDung;
		this.email = email;
		this.matKhau = matKhau;
		this.hoTen = hoTen;
		this.isAdmin = isAdmin;
		this.trangThai = trangThai;
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

	public boolean isTrangThai() {
		return trangThai;
	}

	public void setTrangThai(boolean trangThai) {
		this.trangThai = trangThai;
	}

}
