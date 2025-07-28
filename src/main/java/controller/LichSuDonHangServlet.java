package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.DonHangDAO;
import model.DonHang;
import model.NguoiDung;

@WebServlet("/lichsudonhang")
public class LichSuDonHangServlet extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private DonHangDAO donHangDAO = new DonHangDAO();

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		NguoiDung nd = (NguoiDung) session.getAttribute("nd");

		if (nd == null) {
			response.sendRedirect("dangnhap");
			return;
		}

		List<DonHang> danhSach = donHangDAO.layDanhSachDonHangTheoNguoiDung(nd.getMaNguoiDung());
		request.setAttribute("danhSachDonHang", danhSach);

		request.getRequestDispatcher("lichsudonhang.jsp").forward(request, response);
	}
}
