package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.DonHangDAO;
import model.DonHang;

@WebServlet("/admin/donhang")
public class QuanLyDonHangServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		DonHangDAO dao = new DonHangDAO();
		List<DonHang> lst = dao.getAll();
		req.setAttribute("danhSachDonHang", lst);
		req.getRequestDispatcher("/admin/donhang.jsp").forward(req, resp);
	}

}
