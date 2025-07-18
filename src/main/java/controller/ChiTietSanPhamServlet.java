package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.SanPhamDAO;
import model.SanPham;

@WebServlet("/chitietsanpham")
public class ChiTietSanPhamServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			int maSanPham = Integer.parseInt(request.getParameter("id"));
			SanPham sp = new SanPhamDAO().getById(maSanPham);
			request.setAttribute("sp", sp);
			request.getRequestDispatcher("chitietsanpham.jsp").forward(request, response);
		} catch (Exception e) {
			response.sendRedirect("trangchu"); // fallback nếu lỗi
		}
	}
}
