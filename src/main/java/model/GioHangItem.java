package model;

public class GioHangItem {
	private SanPham sanPham;
	private int soLuong;

	public GioHangItem(SanPham sanPham, int soLuong) {
		this.sanPham = sanPham;
		this.soLuong = soLuong;
	}

	public SanPham getSanPham() {
		return sanPham;
	}

	public void setSanPham(SanPham sanPham) {
		this.sanPham = sanPham;
	}

	public int getSoLuong() {
		return soLuong;
	}

	public void setSoLuong(int soLuong) {
		this.soLuong = soLuong;
	}

	public double getTongTien() {
		return sanPham.getGia() * soLuong;
	}
}
