package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.NguoiDungDAO;

@WebServlet("/admin/khoataikhoan")
public class KhoaTaiKhoanServlet extends HttpServlet {
	private NguoiDungDAO dao = new NguoiDungDAO();

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			int id = Integer.parseInt(request.getParameter("id"));
			boolean trangThaiMoi = Integer.parseInt(request.getParameter("trangThaiMoi")) == 1;

			dao.capNhatTrangThai(id, trangThaiMoi);
			request.getSession().setAttribute("message", "Cập nhật trạng thái thành công.");
		} catch (Exception e) {
			e.printStackTrace();
			request.getSession().setAttribute("message", "Đã xảy ra lỗi khi cập nhật trạng thái.");
		}

		response.sendRedirect(request.getContextPath() + "/admin/nguoidung");
	}
}
