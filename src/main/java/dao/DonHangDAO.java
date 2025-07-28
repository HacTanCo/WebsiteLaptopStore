package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.ChiTietDonHang;
import model.DonHang;
import model.GioHangItem;
import util.KetNoiCSDL;

public class DonHangDAO {
	public int taoDonHang(int maNguoiDung, Double tongTien, List<GioHangItem> gioHang) {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		int maDonHang = -1;

		try {
			conn = KetNoiCSDL.getConnection();
			conn.setAutoCommit(false); // bắt đầu transaction

			// 1. Thêm vào bảng DonHang
			String sqlInsertDonHang = "INSERT INTO DonHang (maNguoiDung, ngayDat, tongTien) VALUES (?, GETDATE(), ?); SELECT SCOPE_IDENTITY();";
			ps = conn.prepareStatement(sqlInsertDonHang);
			ps.setInt(1, maNguoiDung);
			ps.setDouble(2, tongTien);
			rs = ps.executeQuery();
			if (rs.next()) {
				maDonHang = rs.getInt(1); // lấy mã đơn hàng vừa thêm
			}
			rs.close();
			ps.close();

			// 2. Thêm từng chi tiết đơn hàng
			String sqlInsertCT = "INSERT INTO ChiTietDonHang (maDonHang, maSanPham, soLuong, donGia) VALUES (?, ?, ?, ?)";
			ps = conn.prepareStatement(sqlInsertCT);
			for (GioHangItem item : gioHang) {
				ps.setInt(1, maDonHang);
				ps.setInt(2, item.getSanPham().getMaSanPham());
				ps.setInt(3, item.getSoLuong());
				ps.setDouble(4, item.getSanPham().getGia());
				ps.addBatch();
			}
			ps.executeBatch();
			ps.close();

			// 3. Xóa giỏ hàng
			String sqlXoaGio = "DELETE FROM GioHang WHERE maNguoiDung = ?";
			ps = conn.prepareStatement(sqlXoaGio);
			ps.setInt(1, maNguoiDung);
			ps.executeUpdate();

			conn.commit(); // tất cả thành công
		} catch (Exception e) {
			e.printStackTrace();
			try {
				if (conn != null)
					conn.rollback(); // rollback nếu lỗi
			} catch (SQLException ex) {
				ex.printStackTrace();
			}
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.setAutoCommit(true);
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return maDonHang;
	}

	public List<DonHang> layDanhSachDonHangTheoNguoiDung(int maNguoiDung) {
		List<DonHang> danhSach = new ArrayList<DonHang>();
		String sql = "SELECT * FROM DonHang WHERE maNguoiDung = ? ORDER BY ngayDat ASC";

		try (Connection conn = KetNoiCSDL.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setInt(1, maNguoiDung);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				DonHang dh = new DonHang();
				dh.setMaDonHang(rs.getInt("maDonHang"));
				dh.setMaNguoiDung(rs.getInt("maNguoiDung"));
				dh.setNgayDat(rs.getTimestamp("ngayDat"));
				dh.setTongTien(rs.getDouble("tongTien"));
				dh.setTrangThai(rs.getString("trangThai"));
				danhSach.add(dh);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return danhSach;
	}

	public List<DonHang> getAll() {
		List<DonHang> list = new ArrayList<>();
		String sql = "SELECT * FROM DonHang ORDER BY maDonHang ASC";

		try (Connection conn = KetNoiCSDL.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {

			while (rs.next()) {
				DonHang dh = new DonHang();
				dh.setMaDonHang(rs.getInt("maDonHang"));
				dh.setMaNguoiDung(rs.getInt("maNguoiDung"));
				dh.setNgayDat(rs.getTimestamp("ngayDat"));
				dh.setTongTien(rs.getDouble("tongTien"));
				dh.setTrangThai(rs.getString("trangThai"));

				list.add(dh);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	public List<ChiTietDonHang> getChiTietDonHangById(int maDonHang) {
		List<ChiTietDonHang> ds = new ArrayList<>();
		String sql = "SELECT c.maDonHang, c.maSanPham, s.tenSanPham, c.soLuong, c.donGia " + "FROM ChiTietDonHang c "
				+ "JOIN SanPham s ON c.maSanPham = s.maSanPham " + "WHERE c.maDonHang = ?";

		try (Connection conn = KetNoiCSDL.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, maDonHang);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				ChiTietDonHang ct = new ChiTietDonHang();
				ct.setMaDonHang(rs.getInt("maDonHang"));
				ct.setMaSanPham(rs.getInt("maSanPham"));
				ct.setTenSanPham(rs.getString("tenSanPham"));
				ct.setSoLuong(rs.getInt("soLuong"));
				ct.setDonGia(rs.getDouble("donGia"));
				ds.add(ct);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ds;
	}

	public void capNhatTrangThai(int maDonHang, String trangThai) {
		String sql = "UPDATE DonHang SET trangThai = ? WHERE maDonHang = ?";
		try (Connection conn = KetNoiCSDL.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

			stmt.setString(1, trangThai);
			stmt.setInt(2, maDonHang);
			stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void huyDonHang(int maDonHang) throws Exception {
		try {
			Connection conn = KetNoiCSDL.getConnection();
			String sql = "UPDATE DonHang SET trangThai = N'Đã hủy' WHERE maDonHang = ?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, maDonHang);
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
