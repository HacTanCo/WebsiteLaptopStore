package model;

public class SanPham {
	private int maSanPham;
	private String tenSanPham;
	private double gia;
	private String hang, cpu, ram, oCung, manHinh, moTa, hinhAnh;

	public SanPham() {
		super();
		// TODO Auto-generated constructor stub
	}

	public SanPham(int maSanPham, String tenSanPham, double gia, String hang, String cpu, String ram, String oCung,
			String manHinh, String moTa, String hinhAnh) {
		super();
		this.maSanPham = maSanPham;
		this.tenSanPham = tenSanPham;
		this.gia = gia;
		this.hang = hang;
		this.cpu = cpu;
		this.ram = ram;
		this.oCung = oCung;
		this.manHinh = manHinh;
		this.moTa = moTa;
		this.hinhAnh = hinhAnh;
	}

	public int getMaSanPham() {
		return maSanPham;
	}

	public void setMaSanPham(int maSanPham) {
		this.maSanPham = maSanPham;
	}

	public String getTenSanPham() {
		return tenSanPham;
	}

	public void setTenSanPham(String tenSanPham) {
		this.tenSanPham = tenSanPham;
	}

	public double getGia() {
		return gia;
	}

	public void setGia(double gia) {
		this.gia = gia;
	}

	public String getHang() {
		return hang;
	}

	public void setHang(String hang) {
		this.hang = hang;
	}

	public String getCpu() {
		return cpu;
	}

	public void setCpu(String cpu) {
		this.cpu = cpu;
	}

	public String getRam() {
		return ram;
	}

	public void setRam(String ram) {
		this.ram = ram;
	}

	public String getoCung() {
		return oCung;
	}

	public void setoCung(String oCung) {
		this.oCung = oCung;
	}

	public String getManHinh() {
		return manHinh;
	}

	public void setManHinh(String manHinh) {
		this.manHinh = manHinh;
	}

	public String getMoTa() {
		return moTa;
	}

	public void setMoTa(String moTa) {
		this.moTa = moTa;
	}

	public String getHinhAnh() {
		return hinhAnh;
	}

	public void setHinhAnh(String hinhAnh) {
		this.hinhAnh = hinhAnh;
	}

}
