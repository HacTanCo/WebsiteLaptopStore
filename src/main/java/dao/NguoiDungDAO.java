package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.NguoiDung;
import util.KetNoiCSDL;

public class NguoiDungDAO {

	public NguoiDung dangNhap(String email, String matKhau) {
		NguoiDung nd = null;
		try {
			Connection cn = KetNoiCSDL.getConnection();
			String sql = "SELECT * FROM NguoiDung WHERE email = ? AND matKhau = ?";
			PreparedStatement ps = cn.prepareStatement(sql);
			ps.setString(1, email);
			ps.setString(2, matKhau);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				nd = new NguoiDung();
				nd.setMaNguoiDung(rs.getInt("maNguoiDung"));
				nd.setEmail(rs.getString("email"));
				nd.setMatKhau(rs.getString("matKhau"));
				nd.setHoTen(rs.getString("hoTen"));
				nd.setAdmin(rs.getBoolean("isAdmin"));
				nd.setTrangThai(rs.getBoolean("trangThai")); // true = hoạt động, false = khóa
			}
			rs.close();
			ps.close();
			cn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return nd;
	}

	public boolean kiemTraEmailTonTai(String email) {
		try {
			Connection conn = KetNoiCSDL.getConnection();
			String sql = "SELECT * FROM NguoiDung WHERE email = ?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, email);
			ResultSet rs = ps.executeQuery();
			return rs.next(); // Có bản ghi tức là email đã tồn tại
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	public void themNguoiDung(NguoiDung nd) {
		try {
			Connection conn = KetNoiCSDL.getConnection();
			String sql = "INSERT INTO NguoiDung (email, matKhau, hoTen, isAdmin) VALUES (?, ?, ?, ?)";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, nd.getEmail());
			ps.setString(2, nd.getMatKhau());
			ps.setString(3, nd.getHoTen());
			ps.setBoolean(4, nd.isAdmin());
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public List<NguoiDung> getAll() {
		List<NguoiDung> list = new ArrayList<NguoiDung>();
		try {
			Connection conn = KetNoiCSDL.getConnection();
			String sql = "SELECT * FROM NguoiDung";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				NguoiDung nd = new NguoiDung();
				nd.setMaNguoiDung(rs.getInt("maNguoiDung"));
				nd.setEmail(rs.getString("email"));
				nd.setMatKhau(rs.getString("matKhau"));
				nd.setHoTen(rs.getString("hoTen"));
				nd.setAdmin(rs.getBoolean("isAdmin"));
				nd.setTrangThai(rs.getBoolean("trangThai"));
				list.add(nd);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public void capNhatQuyenAdmin(int id, boolean isAdmin) {
		try {
			Connection conn = KetNoiCSDL.getConnection();
			String sql = "UPDATE NguoiDung SET isAdmin = ? WHERE maNguoiDung = ?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setBoolean(1, isAdmin);
			ps.setInt(2, id);
			ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void capNhatTrangThai(int maND, boolean trangThaiMoi) {
		String sql = "UPDATE NguoiDung SET trangThai = ? WHERE maNguoiDung = ?";
		try (Connection conn = KetNoiCSDL.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setBoolean(1, trangThaiMoi);
			stmt.setInt(2, maND);
			stmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public List<NguoiDung> timKiemNguoiDungPhanTrang(String keyword, String role, int offset, int limit) {

		try {
			Connection conn = KetNoiCSDL.getConnection();
			List<NguoiDung> list = new ArrayList<>();
			String sql = "SELECT * FROM NguoiDung WHERE email LIKE ?";

			if (role.equals("admin")) {
				sql += " AND isAdmin = 1";
			} else if (role.equals("user")) {
				sql += " AND isAdmin = 0";
			}

			sql += " ORDER BY maNguoiDung OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, "%" + keyword + "%");
			ps.setInt(2, offset);
			ps.setInt(3, limit);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				NguoiDung nd = new NguoiDung();
				nd.setMaNguoiDung(rs.getInt("maNguoiDung"));
				nd.setEmail(rs.getString("email"));
				nd.setHoTen(rs.getString("hoTen"));
				nd.setAdmin(rs.getBoolean("isAdmin"));
				nd.setTrangThai(rs.getBoolean("trangThai"));
				list.add(nd);
			}
			return list;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;

	}

	public int demNguoiDungPhanTrang(String keyword, String role) {

		try {
			Connection conn = KetNoiCSDL.getConnection();
			String sql = "SELECT COUNT(*) FROM NguoiDung WHERE email LIKE ?";

			if (role.equals("admin")) {
				sql += " AND isAdmin = 1";
			} else if (role.equals("user")) {
				sql += " AND isAdmin = 0";
			}
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, "%" + keyword + "%");
			ResultSet rs = ps.executeQuery();
			int count = 0;
			if (rs.next()) {
				count = rs.getInt(1);
			}
			return count;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;

	}

}
