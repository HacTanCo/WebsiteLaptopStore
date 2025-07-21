package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.DonHangDAO;
import dao.GioHangDAO;
import model.GioHangItem;
import model.NguoiDung;

@WebServlet("/dathang")
public class DatHangServlet extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private GioHangDAO gioHangDAO = new GioHangDAO();
	private DonHangDAO donHangDAO = new DonHangDAO();

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 1. Lấy người dùng từ session

		HttpSession session = request.getSession();
		NguoiDung nd = (NguoiDung) session.getAttribute("nd");

		if (nd == null) {
			response.sendRedirect("dangnhap");
			return;
		}

		int maNguoiDung = nd.getMaNguoiDung();

		// 2. Lấy giỏ hàng từ DB
		List<GioHangItem> gioHang = gioHangDAO.layGioHangTheoNguoiDung(maNguoiDung);

		if (gioHang == null || gioHang.isEmpty()) {
			session.setAttribute("thongBao", "Giỏ hàng trống, không thể đặt hàng!");
			response.sendRedirect("xemgiohang.jsp");
			return;
		}

		// 3. Tính tổng tiền
		double tongTien = 0;
		for (GioHangItem item : gioHang) {
			double donGia = item.getSanPham().getGia();
			int soLuong = item.getSoLuong();
			tongTien += donGia * soLuong;
		}

		// 4. Tạo đơn hàng và chi tiết đơn hàng
		int maDonHang = donHangDAO.taoDonHang(maNguoiDung, tongTien, gioHang);

		// 5. Chuyển hướng
		if (maDonHang > 0) {
			session.setAttribute("thongBao", "Đặt hàng thành công! Mã đơn: " + maDonHang);
			response.sendRedirect("donhang-thanhcong.jsp");
		} else {
			session.setAttribute("thongBao", "Đặt hàng thất bại!");
			response.sendRedirect("xemgiohang.jsp");
		}
	}
}
