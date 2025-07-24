package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.NguoiDungDAO;
import model.NguoiDung;

@WebServlet("/dangky")
public class DangKyServlet extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		String email = request.getParameter("email");
		String hoTen = request.getParameter("hoTen");
		String matKhau = request.getParameter("matKhau");
		String nhapLai = request.getParameter("nhapLaiMatKhau");

		NguoiDungDAO dao = new NguoiDungDAO();

		if (!matKhau.equals(nhapLai)) {
			request.setAttribute("err", "Mật khẩu không khớp!");
			request.getRequestDispatcher("dangky.jsp").forward(request, response);
			return;
		}

		if (dao.kiemTraEmailTonTai(email)) {
			request.setAttribute("err", "Email đã được sử dụng!");
			request.getRequestDispatcher("dangky.jsp").forward(request, response);
			return;
		}

		NguoiDung nd = new NguoiDung(0, email, matKhau, hoTen, false, true);
		dao.themNguoiDung(nd);

		request.setAttribute("success", "Đăng ký thành công! Mời bạn đăng nhập.");
		request.getRequestDispatcher("dangky.jsp").forward(request, response);
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.getRequestDispatcher("dangky.jsp").forward(req, resp);
	}

}
