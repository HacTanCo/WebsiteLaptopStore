package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.SanPhamDAO;

@WebServlet("/admin/xoasanpham")
public class XoaSanPhamServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		try {
			int maSanPham = Integer.parseInt(request.getParameter("maSanPham"));
			SanPhamDAO dao = new SanPhamDAO();
			boolean xoaThanhCong = dao.xoaSanPham(maSanPham);

			if (xoaThanhCong) {
				session.setAttribute("message", "Xóa sản phẩm thành công!");
			} else {
				session.setAttribute("message", "Không thể xóa sản phẩm. Vui lòng thử lại.");
			}
		} catch (Exception e) {
			e.printStackTrace();
			session.setAttribute("message", "Đã xảy ra lỗi khi xóa sản phẩm.");
		}
		response.sendRedirect(request.getContextPath() + "/admin/sanpham");
	}
}
