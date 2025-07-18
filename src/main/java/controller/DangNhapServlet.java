package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.NguoiDungDAO;
import model.NguoiDung;

@WebServlet("/dangnhap")
public class DangNhapServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String email = request.getParameter("email");
		String matKhau = request.getParameter("matKhau");
		NguoiDungDAO dao = new NguoiDungDAO();
		NguoiDung nd = dao.dangNhap(email, matKhau);

		if (nd != null) {
			HttpSession session = request.getSession();
			session.setAttribute("nd", nd); // lưu toàn bộ người dùng vào session

			response.sendRedirect("trangchu");
		} else {
			request.setAttribute("err", "Email hoặc mật khẩu không đúng");
			request.getRequestDispatcher("dangnhap.jsp").forward(request, response);
		}
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.getRequestDispatcher("dangnhap.jsp").forward(req, resp);
	}
}
