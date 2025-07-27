package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.SanPhamDAO;
import model.SanPham;

@WebServlet("/admin/themsanpham")
public class ThemSanPhamServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		String tenSanPham = request.getParameter("tenSanPham");
		double gia = Double.parseDouble(request.getParameter("gia"));
		String hang = request.getParameter("hang");
		String cpu = request.getParameter("cpu");
		String ram = request.getParameter("ram");
		String oCung = request.getParameter("oCung");
		String manHinh = request.getParameter("manHinh");
		String moTa = request.getParameter("moTa");
		String hinhAnh = request.getParameter("hinhAnh");

		SanPham sp = new SanPham();
		sp.setTenSanPham(tenSanPham);
		sp.setGia(gia);
		sp.setHang(hang);
		sp.setCpu(cpu);
		sp.setRam(ram);
		sp.setoCung(oCung);
		sp.setManHinh(manHinh);
		sp.setMoTa(moTa);
		sp.setHinhAnh(hinhAnh);

		boolean kq = new SanPhamDAO().themSanPham(sp);

		if (kq) {
			request.setAttribute("thongBao", "Thêm sản phẩm thành công!");
			request.getRequestDispatcher("themsanpham.jsp").forward(request, response);
		} else {
			request.setAttribute("err", "Thêm sản phẩm thất bại!");
			request.getRequestDispatcher("themsanpham.jsp").forward(request, response);
		}

	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.sendRedirect("themsanpham.jsp");
	}

}
