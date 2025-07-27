package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.SanPhamDAO;
import model.SanPham;

@WebServlet("/admin/suasanpham")
public class SuaSanPhamServlet extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private SanPhamDAO dao = new SanPhamDAO();

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int maSanPham = Integer.parseInt(request.getParameter("maSanPham"));
		SanPham sp = new SanPhamDAO().getById(maSanPham);
		request.setAttribute("giaFormatted", String.format("%.2f", sp.getGia()));
		request.setAttribute("sp", sp);
		request.getRequestDispatcher("suasanpham.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		try {
			int maSanPham = Integer.parseInt(request.getParameter("maSanPham"));
			String tenSanPham = request.getParameter("tenSanPham");
			double gia = Double.parseDouble(request.getParameter("gia"));
			String hang = request.getParameter("hang");
			String cpu = request.getParameter("cpu");
			String ram = request.getParameter("ram");
			String oCung = request.getParameter("oCung");
			String manHinh = request.getParameter("manHinh");
			String moTa = request.getParameter("moTa");
			String hinhAnh = request.getParameter("hinhAnh");

			// Tạo đối tượng sản phẩm
			SanPham sp = new SanPham();
			sp.setMaSanPham(maSanPham);
			sp.setTenSanPham(tenSanPham);
			sp.setGia(gia);
			sp.setHang(hang);
			sp.setCpu(cpu);
			sp.setRam(ram);
			sp.setoCung(oCung);
			sp.setManHinh(manHinh);
			sp.setMoTa(moTa);
			sp.setHinhAnh(hinhAnh);

			SanPhamDAO spDAO = new SanPhamDAO();
			spDAO.capNhatSanPham(sp);

			request.setAttribute("thongBao", "Cập nhật sản phẩm thành công.");
			request.getRequestDispatcher("suasanpham.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("err", "Có lỗi xảy ra khi cập nhật sản phẩm.");
			request.getRequestDispatcher("suasanpham.jsp").forward(request, response);
		}
	}

}
