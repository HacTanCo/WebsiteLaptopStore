package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class KetNoiCSDL {
	public static Connection getConnection() throws Exception {
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
		return DriverManager.getConnection(
				"jdbc:sqlserver://localhost:1433;databaseName=WebsiteLaptopStore; user=sa; password=123;trustServerCertificate=true;");
	}

	public static void main(String[] args) throws Exception {
		Connection cn = KetNoiCSDL.getConnection();
		if (cn != null)
			System.out.println("Ket noi thanh cong");
		else
			System.out.println("Co loi");
	}
}