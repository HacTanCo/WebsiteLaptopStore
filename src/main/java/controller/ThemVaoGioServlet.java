package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.GioHangDAO;
import model.NguoiDung;

@WebServlet("/themvaogio")
public class ThemVaoGioServlet extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		NguoiDung nd = (NguoiDung) session.getAttribute("nd");

		if (nd == null) {
			response.sendRedirect("dangnhap");
			return;
		}

		int maNguoiDung = nd.getMaNguoiDung();
		int maSanPham = Integer.parseInt(request.getParameter("id"));

		new GioHangDAO().themSanPham(maNguoiDung, maSanPham);

		response.sendRedirect("trangchu");
	}
}
