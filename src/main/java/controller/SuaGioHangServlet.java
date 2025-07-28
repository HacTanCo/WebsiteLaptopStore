package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.GioHangDAO;
import model.NguoiDung;

@WebServlet("/suagiohang")
public class SuaGioHangServlet extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int maNguoiDung = ((NguoiDung) request.getSession().getAttribute("nd")).getMaNguoiDung();
		int maSanPham = Integer.parseInt(request.getParameter("maSanPham"));
		String thaoTac = request.getParameter("thaoTac");

		GioHangDAO dao = new GioHangDAO();
		int soLuongHienTai = dao.laySoLuong(maNguoiDung, maSanPham);

		if ("tang".equals(thaoTac)) {
			dao.capNhatSoLuong(maNguoiDung, maSanPham, soLuongHienTai + 1);
		} else if ("giam".equals(thaoTac)) {
			if (soLuongHienTai > 1) {
				dao.capNhatSoLuong(maNguoiDung, maSanPham, soLuongHienTai - 1);
			} else {
				dao.xoaSanPhamKhoiGio(maNguoiDung, maSanPham); // nếu giảm về 0 thì xoá
			}
		}

		response.sendRedirect("xemgiohang.jsp");
	}

}
