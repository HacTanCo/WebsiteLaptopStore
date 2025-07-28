package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.DonHangDAO;
import model.ChiTietDonHang;

@WebServlet("/admin/chitietdonhang")
public class ChiTietDonHangServlet extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private DonHangDAO donHangDAO = new DonHangDAO();

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int maDonHang = Integer.parseInt(request.getParameter("maDonHang"));
		List<ChiTietDonHang> chiTietList = donHangDAO.getChiTietDonHangById(maDonHang);

		request.setAttribute("chiTietList", chiTietList);
		request.setAttribute("maDonHang", maDonHang);
		request.getRequestDispatcher("/admin/chitietdonhang.jsp").forward(request, response);
	}
}
