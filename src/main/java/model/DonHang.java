package model;

import java.util.Date;

public class DonHang {
	private int maDonHang;
	private int maNguoiDung;
	private Date ngayDat;
	private double tongTien;
	private String trangThai;

	public DonHang() {
	}

	public DonHang(int maDonHang, int maNguoiDung, Date ngayDat, double tongTien, String trangThai) {
		this.maDonHang = maDonHang;
		this.maNguoiDung = maNguoiDung;
		this.ngayDat = ngayDat;
		this.tongTien = tongTien;
		this.trangThai = trangThai;
	}

	public int getMaDonHang() {
		return maDonHang;
	}

	public void setMaDonHang(int maDonHang) {
		this.maDonHang = maDonHang;
	}

	public int getMaNguoiDung() {
		return maNguoiDung;
	}

	public void setMaNguoiDung(int maNguoiDung) {
		this.maNguoiDung = maNguoiDung;
	}

	public Date getNgayDat() {
		return ngayDat;
	}

	public void setNgayDat(Date ngayDat) {
		this.ngayDat = ngayDat;
	}

	public double getTongTien() {
		return tongTien;
	}

	public void setTongTien(double tongTien) {
		this.tongTien = tongTien;
	}

	public String getTrangThai() {
		return trangThai;
	}

	public void setTrangThai(String trangThai) {
		this.trangThai = trangThai;
	}
}
