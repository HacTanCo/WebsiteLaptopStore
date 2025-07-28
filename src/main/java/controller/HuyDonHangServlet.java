package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.DonHangDAO;

@WebServlet("/huydonhang")
public class HuyDonHangServlet extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			int maDonHang = Integer.parseInt(request.getParameter("maDonHang"));
			DonHangDAO dao = new DonHangDAO();
			dao.huyDonHang(maDonHang);
			response.sendRedirect("lichsudonhang");
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
}
