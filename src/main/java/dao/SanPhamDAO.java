package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.SanPham;
import util.KetNoiCSDL;

public class SanPhamDAO {
	public List<SanPham> getAll() {
		List<SanPham> list = new ArrayList<>();
		try {
			Connection cn = KetNoiCSDL.getConnection();
			String sql = "SELECT * FROM SanPham";
			PreparedStatement ps = cn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				list.add(new SanPham(rs.getInt("maSanPham"), rs.getString("tenSanPham"), rs.getDouble("gia"),
						rs.getString("hang"), rs.getString("cpu"), rs.getString("ram"), rs.getString("oCung"),
						rs.getString("manHinh"), rs.getString("moTa"), rs.getString("hinhAnh")));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public SanPham getById(int maSanPham) {
		try (Connection cn = KetNoiCSDL.getConnection()) {
			String sql = "SELECT * FROM SanPham WHERE maSanPham = ?";
			PreparedStatement ps = cn.prepareStatement(sql);
			ps.setInt(1, maSanPham);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				return new SanPham(rs.getInt("maSanPham"), rs.getString("tenSanPham"), rs.getDouble("gia"),
						rs.getString("hang"), rs.getString("cpu"), rs.getString("ram"), rs.getString("oCung"),
						rs.getString("manHinh"), rs.getString("moTa"), rs.getString("hinhAnh"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;

	}

	public List<SanPham> getSanPhamTheoTrang(int page, int soSanPhamMoiTrang) {
		List<SanPham> list = new ArrayList<SanPham>();
		int offset = (page - 1) * soSanPhamMoiTrang;
		try {
			Connection cn = KetNoiCSDL.getConnection();
			String sql = "SELECT * FROM SanPham ORDER BY maSanPham OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
			PreparedStatement ps = cn.prepareStatement(sql);
			ps.setInt(1, offset);
			ps.setInt(2, soSanPhamMoiTrang);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				list.add(new SanPham(rs.getInt("maSanPham"), rs.getString("tenSanPham"), rs.getDouble("gia"),
						rs.getString("hang"), rs.getString("cpu"), rs.getString("ram"), rs.getString("oCung"),
						rs.getString("manHinh"), rs.getString("moTa"), rs.getString("hinhAnh")));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public int demSanPham() {
		int count = 0;
		try {
			Connection conn = KetNoiCSDL.getConnection();
			String sql = "SELECT COUNT(*) FROM SanPham";
			PreparedStatement ps = conn.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}

	public List<SanPham> timKiemSanPham(String keyword, String cpu, String ram, String minPrice, String maxPrice,
			int offset, int limit) {
		List<SanPham> list = new ArrayList<>();
		try {
			Connection conn = KetNoiCSDL.getConnection();
			StringBuilder sql = new StringBuilder("SELECT * FROM SanPham WHERE 1=1");

			if (keyword != null && !keyword.isEmpty()) {
				sql.append(" AND tenSanPham LIKE ?");
			}
			if (cpu != null && !cpu.isEmpty()) {
				sql.append(" AND cpu LIKE ?");
			}
			if (ram != null && !ram.isEmpty()) {
				sql.append(" AND ram = ?");
			}
			if (minPrice != null && !minPrice.isEmpty()) {
				sql.append(" AND gia >= ?");
			}
			if (maxPrice != null && !maxPrice.isEmpty()) {
				sql.append(" AND gia <= ?");
			}

			sql.append(" ORDER BY maSanPham OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

			PreparedStatement ps = conn.prepareStatement(sql.toString());

			int index = 1;
			if (keyword != null && !keyword.isEmpty()) {
				ps.setString(index++, "%" + keyword + "%");
			}
			if (cpu != null && !cpu.isEmpty()) {
				ps.setString(index++, "%" + cpu + "%");
			}
			if (ram != null && !ram.isEmpty()) {
				ps.setString(index++, ram);
			}
			if (minPrice != null && !minPrice.isEmpty()) {
				ps.setInt(index++, Integer.parseInt(minPrice));
			}
			if (maxPrice != null && !maxPrice.isEmpty()) {
				ps.setInt(index++, Integer.parseInt(maxPrice));
			}
			ps.setInt(index++, offset);
			ps.setInt(index++, limit);

			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				list.add(new SanPham(rs.getInt("maSanPham"), rs.getString("tenSanPham"), rs.getDouble("gia"),
						rs.getString("hang"), rs.getString("cpu"), rs.getString("ram"), rs.getString("oCung"),
						rs.getString("manHinh"), rs.getString("moTa"), rs.getString("hinhAnh")));
			}
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public int demSanPhamTheoBoLoc(String keyword, String cpu, String ram, String minPrice, String maxPrice) {
		int count = 0;
		try {
			Connection conn = KetNoiCSDL.getConnection();

			StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM SanPham WHERE 1=1");

			if (keyword != null && !keyword.isEmpty()) {
				sql.append(" AND tenSanPham LIKE ?");
			}
			if (cpu != null && !cpu.isEmpty()) {
				sql.append(" AND cpu LIKE ?");
			}
			if (ram != null && !ram.isEmpty()) {
				sql.append(" AND ram = ?");
			}
			if (minPrice != null && !minPrice.isEmpty()) {
				sql.append(" AND gia >= ?");
			}
			if (maxPrice != null && !maxPrice.isEmpty()) {
				sql.append(" AND gia <= ?");
			}

			PreparedStatement ps = conn.prepareStatement(sql.toString());

			int index = 1;
			if (keyword != null && !keyword.isEmpty()) {
				ps.setString(index++, "%" + keyword + "%");
			}
			if (cpu != null && !cpu.isEmpty()) {
				ps.setString(index++, "%" + cpu + "%");
			}
			if (ram != null && !ram.isEmpty()) {
				ps.setString(index++, ram);
			}
			if (minPrice != null && !minPrice.isEmpty()) {
				ps.setInt(index++, Integer.parseInt(minPrice));
			}
			if (maxPrice != null && !maxPrice.isEmpty()) {
				ps.setInt(index++, Integer.parseInt(maxPrice));
			}

			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}

			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return count;
	}

	public List<SanPham> timKiemSanPhamAdmin(String keyword, int offset, int limit) {
		List<SanPham> list = new ArrayList<>();
		try {
			Connection conn = KetNoiCSDL.getConnection();
			StringBuilder sql = new StringBuilder("SELECT * FROM SanPham WHERE 1=1");

			if (keyword != null && !keyword.isEmpty()) {
				sql.append(" AND tenSanPham LIKE ?");
			}

			sql.append(" ORDER BY maSanPham OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

			PreparedStatement ps = conn.prepareStatement(sql.toString());

			int index = 1;
			if (keyword != null && !keyword.isEmpty()) {
				ps.setString(index++, "%" + keyword + "%");
			}

			ps.setInt(index++, offset);
			ps.setInt(index++, limit);

			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				list.add(new SanPham(rs.getInt("maSanPham"), rs.getString("tenSanPham"), rs.getDouble("gia"),
						rs.getString("hang"), rs.getString("cpu"), rs.getString("ram"), rs.getString("oCung"),
						rs.getString("manHinh"), rs.getString("moTa"), rs.getString("hinhAnh")));
			}
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public int demSanPhamTheoBoLocAdmin(String keyword) {
		int count = 0;
		try {
			Connection conn = KetNoiCSDL.getConnection();

			StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM SanPham WHERE 1=1");

			if (keyword != null && !keyword.isEmpty()) {
				sql.append(" AND tenSanPham LIKE ?");
			}

			PreparedStatement ps = conn.prepareStatement(sql.toString());

			int index = 1;
			if (keyword != null && !keyword.isEmpty()) {
				ps.setString(index++, "%" + keyword + "%");
			}

			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}

			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return count;
	}

	public boolean themSanPham(SanPham sp) {
		try (Connection conn = KetNoiCSDL.getConnection()) {
			String sql = "INSERT INTO SanPham (tenSanPham, gia, hang, cpu, ram, oCung, manHinh, moTa, hinhAnh) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, sp.getTenSanPham());
			ps.setDouble(2, sp.getGia());
			ps.setString(3, sp.getHang());
			ps.setString(4, sp.getCpu());
			ps.setString(5, sp.getRam());
			ps.setString(6, sp.getoCung());
			ps.setString(7, sp.getManHinh());
			ps.setString(8, sp.getMoTa());
			ps.setString(9, sp.getHinhAnh());
			return ps.executeUpdate() > 0;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	public void capNhatSanPham(SanPham sp) {
		try {
			Connection cn = KetNoiCSDL.getConnection();
			String sql = "UPDATE SanPham SET tenSanPham=?, gia=?, hang=?, cpu=?, ram=?, oCung=?, manHinh=?, moTa=?, hinhAnh=? WHERE maSanPham=?";
			PreparedStatement ps = cn.prepareStatement(sql);
			ps.setString(1, sp.getTenSanPham());
			ps.setDouble(2, sp.getGia());
			ps.setString(3, sp.getHang());
			ps.setString(4, sp.getCpu());
			ps.setString(5, sp.getRam());
			ps.setString(6, sp.getoCung());
			ps.setString(7, sp.getManHinh());
			ps.setString(8, sp.getMoTa());
			ps.setString(9, sp.getHinhAnh());
			ps.setInt(10, sp.getMaSanPham());
			ps.executeUpdate();
			ps.close();
			cn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public boolean xoaSanPham(int maSanPham) {
		String sql = "DELETE FROM SanPham WHERE maSanPham = ?";
		try (Connection conn = KetNoiCSDL.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setInt(1, maSanPham);
			int rows = stmt.executeUpdate();
			return rows > 0;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

}
