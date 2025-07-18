package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

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
			}
			rs.close();
			ps.close();
			cn.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return nd;
	}

}
