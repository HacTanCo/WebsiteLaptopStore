package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.SanPhamDAO;
import model.SanPham;

@WebServlet("/trangchu")
public class TrangChuServlet extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

//	@Override
//	protected void doGet(HttpServletRequest request, HttpServletResponse response)
//			throws ServletException, IOException {
//		SanPhamDAO dao = new SanPhamDAO();
//		List<SanPham> list = dao.getAll();
//		request.setAttribute("danhSachSanPham", list);
//		request.getRequestDispatcher("trangchu.jsp").forward(request, response);
//	}
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int page = 1;
		int limit = 8;
		if (request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}

		SanPhamDAO dao = new SanPhamDAO();
		List<SanPham> danhSachSanPham = dao.getSanPhamTheoTrang(page, limit);
		int tongSanPham = dao.demSanPham();
		int tongTrang = (int) Math.ceil(tongSanPham * 1.0 / limit);

		request.setAttribute("danhSachSanPham", danhSachSanPham);
		request.setAttribute("trangHienTai", page);
		request.setAttribute("tongTrang", tongTrang);

		request.getRequestDispatcher("trangchu.jsp").forward(request, response);
	}
}
