package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.GioHangDAO;
import model.NguoiDung;

@WebServlet("/xoagiohang")
public class XoaGioHangServlet extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int maNguoiDung = ((NguoiDung) request.getSession().getAttribute("nd")).getMaNguoiDung();
		int maSanPham = Integer.parseInt(request.getParameter("maSanPham"));

		new GioHangDAO().xoaSanPhamKhoiGio(maNguoiDung, maSanPham);

		response.sendRedirect("xemgiohang.jsp");
	}
}
