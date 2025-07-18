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

}
