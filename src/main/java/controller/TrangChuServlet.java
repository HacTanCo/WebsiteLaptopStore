package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.GioHangDAO;
import dao.SanPhamDAO;
import model.NguoiDung;
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
		// hiện số trong giỏ hàng ở trang chủ
		NguoiDung nd = (NguoiDung) request.getSession().getAttribute("nd");
		if (nd != null) {
			GioHangDAO gioHangDAO = new GioHangDAO();
			int soSanPhamTrongGio = gioHangDAO.demSoSanPhamTrongGio(nd.getMaNguoiDung());
			request.setAttribute("soSanPhamTrongGio", soSanPhamTrongGio);
		}
		int page = 1;
		int limit = 8;
		if (request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}
		int offset = (page - 1) * limit;

		// Lấy dữ liệu đã lọc
		String keyword = request.getParameter("keyword");
		String cpu = request.getParameter("cpu");
		String ram = request.getParameter("ram");
		String minPrice = request.getParameter("minPrice");
		String maxPrice = request.getParameter("maxPrice");

		SanPhamDAO dao = new SanPhamDAO();
		List<SanPham> dsSanPham = dao.timKiemSanPham(keyword, cpu, ram, minPrice, maxPrice, offset, limit);

		// Đếm tổng sản phẩm để phân trang
		int tongSanPham = dao.demSanPhamTheoBoLoc(keyword, cpu, ram, minPrice, maxPrice);
		int tongTrang = (int) Math.ceil(tongSanPham * 1.0 / limit);

		// Set thuộc tính cho trang JSP
		request.setAttribute("danhSachSanPham", dsSanPham);
		request.setAttribute("trangHienTai", page);
		request.setAttribute("tongTrang", tongTrang);

		request.getRequestDispatcher("trangchu.jsp").forward(request, response);
	}
}
