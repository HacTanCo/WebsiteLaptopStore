package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.NguoiDungDAO;

@WebServlet("/admin/capquyen")
public class CapQuyenServlet extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private NguoiDungDAO dao = new NguoiDungDAO();

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			int maND = Integer.parseInt(request.getParameter("id"));
			boolean isAdmin = Boolean.parseBoolean(request.getParameter("isAdmin"));
			dao.capNhatQuyenAdmin(maND, isAdmin);
			request.getSession().setAttribute("message", "Cập nhật quyền thành công!");
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			request.getSession().setAttribute("message", "Đã xảy ra lỗi khi cập nhật quyền.");
		}
		response.sendRedirect(request.getContextPath() + "/admin/nguoidung");
	}
}
