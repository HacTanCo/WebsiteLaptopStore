package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

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

}
