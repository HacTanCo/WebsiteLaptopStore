package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.NguoiDungDAO;
import model.NguoiDung;

@WebServlet("/admin/nguoidung")
public class QuanLyNguoiDungServlet extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private NguoiDungDAO dao = new NguoiDungDAO();

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		NguoiDung nd = (NguoiDung) session.getAttribute("nd");

		if (nd == null) {
			response.sendRedirect(request.getContextPath() + "/dangnhap");
			return;
		}
		// Lấy các tham số từ form tìm kiếm
		String keyword = request.getParameter("keyword"); // tìm theo email
		String role = request.getParameter("role"); // lọc theo quyền

		if (keyword == null)
			keyword = "";
		if (role == null)
			role = "";

		// Xử lý phân trang
		int page = 1;
		int limit = 8;
		if (request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}
		int offset = (page - 1) * limit;

		// Gọi DAO để lấy danh sách người dùng theo tìm kiếm & phân trang
		NguoiDungDAO dao = new NguoiDungDAO();
		List<NguoiDung> list = dao.timKiemNguoiDungPhanTrang(keyword, role, offset, limit);
		int tongSoNguoiDung = dao.demNguoiDungPhanTrang(keyword, role);
		int tongTrang = (int) Math.ceil((double) tongSoNguoiDung / limit);

		// Đẩy dữ liệu ra view
		request.setAttribute("list", list);
		request.setAttribute("trangHienTai", page);
		request.setAttribute("tongTrang", tongTrang);

		// Trả lại keyword và role để giữ lại dữ liệu tìm kiếm
		request.setAttribute("keyword", keyword);
		request.setAttribute("role", role);

		request.getRequestDispatcher("/admin/nguoidung.jsp").forward(request, response);
	}

}
