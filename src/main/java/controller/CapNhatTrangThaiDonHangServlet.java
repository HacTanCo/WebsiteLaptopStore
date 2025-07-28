package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.DonHangDAO;

@WebServlet("/admin/capnhattrangthaidonhang")
public class CapNhatTrangThaiDonHangServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		int maDonHang = Integer.parseInt(request.getParameter("maDonHang"));
		String trangThai = request.getParameter("trangThai");

		DonHangDAO dao = new DonHangDAO();
		dao.capNhatTrangThai(maDonHang, trangThai);

		request.getSession().setAttribute("message", "Cập nhật trạng thái đơn hàng thành công!");
		response.sendRedirect(request.getContextPath() + "/admin/donhang");
	}

}
