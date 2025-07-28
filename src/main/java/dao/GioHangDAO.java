package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.GioHangItem;
import model.SanPham;
import util.KetNoiCSDL;

public class GioHangDAO {

	public void themSanPham(int maNguoiDung, int maSanPham) {
		try (Connection conn = KetNoiCSDL.getConnection()) {
			String sqlCheck = "SELECT soLuong FROM GioHang WHERE maNguoiDung = ? AND maSanPham = ?";
			PreparedStatement psCheck = conn.prepareStatement(sqlCheck);
			psCheck.setInt(1, maNguoiDung);
			psCheck.setInt(2, maSanPham);
			ResultSet rs = psCheck.executeQuery();

			if (rs.next()) {
				int soLuong = rs.getInt("soLuong") + 1;
				String sqlUpdate = "UPDATE GioHang SET soLuong = ? WHERE maNguoiDung = ? AND maSanPham = ?";
				PreparedStatement psUpdate = conn.prepareStatement(sqlUpdate);
				psUpdate.setInt(1, soLuong);
				psUpdate.setInt(2, maNguoiDung);
				psUpdate.setInt(3, maSanPham);
				psUpdate.executeUpdate();
			} else {
				String sqlInsert = "INSERT INTO GioHang (maNguoiDung, maSanPham, soLuong) VALUES (?, ?, ?)";
				PreparedStatement psInsert = conn.prepareStatement(sqlInsert);
				psInsert.setInt(1, maNguoiDung);
				psInsert.setInt(2, maSanPham);
				psInsert.setInt(3, 1);
				psInsert.executeUpdate();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public List<GioHangItem> layGioHangTheoNguoiDung(int maNguoiDung) {
		List<GioHangItem> ds = new ArrayList<>();
		try (Connection conn = KetNoiCSDL.getConnection()) {
			String sql = """
					SELECT SanPham.*, GioHang.soLuong
					FROM GioHang JOIN SanPham ON SanPham.maSanPham = GioHang.maSanPham
					WHERE GioHang.maNguoiDung = ?
					""";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, maNguoiDung);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				SanPham sp = new SanPham(rs.getInt("maSanPham"), rs.getString("tenSanPham"), rs.getDouble("gia"),
						rs.getString("hang"), rs.getString("cpu"), rs.getString("ram"), rs.getString("oCung"),
						rs.getString("manHinh"), rs.getString("moTa"), rs.getString("hinhAnh"));
				GioHangItem item = new GioHangItem(sp, rs.getInt("soLuong"));
				ds.add(item);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ds;
	}

	public int demSoSanPhamTrongGio(int maNguoiDung) {
		int soLuong = 0;
		try {
			Connection conn = KetNoiCSDL.getConnection();
			String sql = "SELECT COUNT(*) FROM GioHang WHERE maNguoiDung = ?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, maNguoiDung);
			ResultSet rs = ps.executeQuery();
			if (rs.next())
				soLuong = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return soLuong;
	}

	// Cập nhật số lượng sản phẩm trong giỏ
	public void capNhatSoLuong(int maNguoiDung, int maSanPham, int soLuong) {
		String sql = "UPDATE GioHang SET soLuong = ? WHERE maNguoiDung = ? AND maSanPham = ?";
		try (Connection conn = KetNoiCSDL.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, soLuong);
			ps.setInt(2, maNguoiDung);
			ps.setInt(3, maSanPham);
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// Xóa sản phẩm khỏi giỏ
	public void xoaSanPhamKhoiGio(int maNguoiDung, int maSanPham) {
		String sql = "DELETE FROM GioHang WHERE maNguoiDung = ? AND maSanPham = ?";
		try (Connection conn = KetNoiCSDL.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, maNguoiDung);
			ps.setInt(2, maSanPham);
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// Xóa khỏi giỏ hàng sau khi mua
	public void xoaGioHang(int maNguoiDung) {
		String sql = "DELETE FROM GioHang WHERE maNguoiDung = ?";

		try (Connection conn = KetNoiCSDL.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setInt(1, maNguoiDung);
			ps.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public int laySoLuong(int maNguoiDung, int maSanPham) {
		int soLuong = 0;
		String sql = "SELECT soLuong FROM GioHang WHERE maNguoiDung = ? AND maSanPham = ?";
		try (Connection conn = KetNoiCSDL.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, maNguoiDung);
			ps.setInt(2, maSanPham);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				soLuong = rs.getInt("soLuong");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return soLuong;
	}

}
