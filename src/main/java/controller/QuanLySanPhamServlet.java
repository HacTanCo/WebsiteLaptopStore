package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.SanPhamDAO;
import model.NguoiDung;
import model.SanPham;

@WebServlet("/admin/sanpham")
public class QuanLySanPhamServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		NguoiDung nd = (NguoiDung) session.getAttribute("nd");

		if (nd == null) {
			resp.sendRedirect(req.getContextPath() + "/dangnhap");
			return;
		}
		String keyword = req.getParameter("keyword");

		if (keyword == null)
			keyword = "";

		int page = 1, limit = 10;
		if (req.getParameter("page") != null) {
			page = Integer.parseInt(req.getParameter("page"));
		}
		int offset = (page - 1) * limit;

		SanPhamDAO dao = new SanPhamDAO();
		List<SanPham> lst = dao.timKiemSanPhamAdmin(keyword, offset, limit);
		int tongSoSanPham = dao.demSanPhamTheoBoLocAdmin(keyword);
		int tongTrang = (int) Math.ceil((double) tongSoSanPham / limit);

		req.setAttribute("list", lst);
		req.setAttribute("trangHienTai", page);
		req.setAttribute("tongTrang", tongTrang);
		req.setAttribute("keyword", keyword);

		req.getRequestDispatcher("/admin/sanpham.jsp").forward(req, resp);
	}

}
