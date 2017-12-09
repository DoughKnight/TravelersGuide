/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
//package travelersguide;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Scanner;
import java.util.concurrent.TimeUnit;

/**
 *
 * @author david
 */
public class TravelersGuide{

	static final String DB_URL = "jdbc:mysql://localhost:3306/TravelersGuide";
	static final String DB_DRV = "com.mysql.jdbc.Driver";
	static final String DB_USER = "root";
	static final String DB_PASSWD = "password";// "1frjxqsF4/t";
	static String user_userID = "";
	static String user_Language = "";
	static String user_Country ="";

	private static void loginMenu(Connection conc, Scanner reader,
			Statement stmt, ResultSet rs) throws InterruptedException,
			SQLException {
		System.out.print("First Name: ");
		String fName = reader.nextLine();
		System.out.print("Last name: ");
		String lName = reader.nextLine();
		System.out.print("Password: ");
		String password = reader.nextLine();
		String SQL = "SELECT userID, psw, language, country FROM Users WHERE firstname=\"" + fName
				+ "\" and lastname=\"" + lName + "\";";
		stmt = conc.createStatement();
		rs = stmt.executeQuery(SQL);

		while (rs.next()) {
			if (password.equals(rs.getString(2))) {
				user_userID = rs.getString(1);
				user_Language = rs.getString(3);
				user_Country = rs.getString(4);
				if (rs.getInt(1) == -1) {
					// TODO: Send admin to admin menus as well
					System.out.println("Welcome administrator.");
					System.out
							.println("List of admin options here, leading to functions.");
					travelersMainMenu(conc, reader);
				} else {
					System.out.println("Login success!");
					System.out
							.println("List of regular choices here, leading to functions.");
				}
				return;
			}
		}
		System.out.println("Failure to login.");
	}

	private static void guestMenu(Connection conc, Scanner reader,
			Statement stmt, ResultSet rs) throws InterruptedException,
			SQLException {
		// TODO Remove login on guestmenu, or remove guest entirely
		String SQL = "SELECT userID, psw FROM Users WHERE firstname=\""
				+ "Admin" + "\" and lastname=\"" + "Istrator" + "\";";
		stmt = conc.createStatement();
		rs = stmt.executeQuery(SQL);
		travelersMainMenu(conc, reader);
	}

	public static void travelersMainMenu(Connection conc, Scanner reader
			) throws InterruptedException,
			SQLException {

		System.out.println("*********************************");
		System.out.println("*                               *");
		System.out.println("*                               *");
		System.out.println("*Welcome to the Travelers' Guide*");
		System.out.println("*                               *");
		System.out.println("*                               *");
		System.out.println("*********************************");

		TimeUnit.SECONDS.sleep(1);
		System.out.println("");
		System.out.println("");
		System.out.println("********************************");
		System.out.println("*  Select your data category:  *");
		System.out.println("********************************");
		System.out.println("");
		System.out.println("********************************");
		System.out.println("*              *               *");
		System.out.println("*   1. Users   *  2. Countries *");
		System.out.println("*              *               *");
		System.out.println("********************************");
		System.out.println("");
		System.out.print(">> ");

		String option = reader.nextLine();
		if (option.equals("1")) {
			travelersUserMenu(conc, reader,user_userID,user_Language,user_Country);
		}
		if (option.equals("2")) {
			travelersCountryMenu(conc, reader, user_userID,user_Language,user_Country);
		}
		if (option.equals("3")) {
			travelersAdminMenu(conc, reader);
		}

	}

	public static void travelersUserMenu(Connection conc, Scanner reader,
			 String userID, String language, String country) throws InterruptedException,
			SQLException {

		System.out.println("");
		System.out.println("*********************************");
		System.out.println("*         User Menu             *");
		System.out.println("*                               *");
		System.out.println("* 1. View All Users             *");
		System.out.println("* 2. View Users in Country      *");
		System.out.println("* 3. View Users w/ Same Language*");
		System.out.println("* 4. Add Connection             *");
		System.out.println("* 5. Delete Connection          *");
		System.out.println("* 6. View Own Connections       *");
		System.out.println("* 7. Add Recommendation         *");
		System.out.println("* 8. View Recommendations       *");
		System.out.println("* 9. Reset Password             *");
		System.out.println("*                               *");
		System.out.println("* 0. Return to Main Menu        *");
		System.out.println("*********************************");
		System.out.println("");

		while (true) {

			System.out.printf(">> ");
			String option = reader.nextLine();

			// TODO: Uncomment functions as they are added.

			if (option.equals("1")) {
				// funcUser1(conc, reader, );
			} else if (option.equals("2")) {
				//funcUser2(conc, reader, );
			} else if (option.equals("3")) {
				// funcUser3(conc, reader, );
			} else if (option.equals("4")) {
				// funcUser4(conc, reader, );
			} else if (option.equals("5")) {
				// funcUser5(conc, reader, );
			} else if (option.equals("6")) {
				// funcUser6(conc, reader, );
			} else if (option.equals("7")) {
				//funcUser7(conc, reader, );
			} else if (option.equals("8")) {
				//funcUser8(conc, reader, );
			} else if (option.equals("9")) {
				// funcUser9(conc, reader, );
			} else if (option.equals("0")) {
				travelersMainMenu(conc, reader);
				break;
			} else {
				travelersUserMenu(conc, reader,user_userID,user_Language,user_Country);
				break;
			}
		}

	}

	public static void travelersCountryMenu(Connection conc, Scanner reader,
			String userID, String language, String country) throws InterruptedException,
			SQLException {
		System.out.println("");
		System.out.println("*********************************");
		System.out.println("*         Country Menu          *");
		System.out.println("*                               *");
		System.out.println("* 1. View All Countries         *");
		System.out.println("* 2. Search for Country(s)      *");
		System.out.println("* 3. Compare Data b/w Countries *");
		System.out.println("* 4. View Distances to Others   *");
		System.out.println("* 5. View Bordering Countries   *");
		System.out.println("* 6. View Distance from Country *");
		System.out.println("* 7. View Distance from C to C  *");
		System.out.println("* 8. View Distance from User    *");
		System.out.println("*                               *");
		System.out.println("* 0. Return to Main Menu        *");
		System.out.println("*********************************");
		System.out.println("");

		while (true) {

			System.out.printf(">> ");
			String option = reader.nextLine();

			// TODO: Uncomment functions as they are added.

			if (option.equals("1")) {
				// funcCountry1(conc, reader;
			} else if (option.equals("2")) {
				// funcCountry2(conc, reader;
			} else if (option.equals("3")) {
				// funcCountry3(conc, reader;
			} else if (option.equals("4")) {
				// funcCountry4(conc, reader;
			} else if (option.equals("5")) {
                                // funcCountry5(reader,conc
			} else if (option.equals("6")) {
				// funcCountry6(conc, reader;
			} else if (option.equals("7")) {
				// funcCountry7(conc, reader;
			} else if (option.equals("8")) {
				// ffuncCountry8(conc, reader,;
			} else if (option.equals("0")) {
				travelersMainMenu(conc, reader);
				break;
			} else {
				travelersCountryMenu(conc, reader,user_userID,user_Language,user_Country);
				break;
			}
		}

	}

	public static void travelersAdminMenu(Connection conc, Scanner reader
			) throws InterruptedException,
			SQLException {
		System.out.println("");
		System.out.println("*********************************");
		System.out.println("*         Admin Menu            *");
		System.out.println("*                               *");
		System.out.println("* 1. View All Users             *");
		System.out.println("* 2. Add Users                  *");
		System.out.println("* 3. Delete User                *");
		System.out.println("* 3. View all Connections       *");
		System.out.println("* 4. View all Recommendations   *");
		System.out.println("*                               *");
		System.out.println("* 0. Return to Main Menu        *");
		System.out.println("*********************************");
		System.out.println("");

		System.out.print(">> ");
		Integer menuOption = reader.nextInt();

		if (menuOption == 0) {
			travelersMainMenu(conc, reader);
		}
	}

	/**
	 * @param args
	 *            the command line arguments
	 */
	public static void main(String[] args) throws InterruptedException,
			SQLException {
		Connection connection = null;
		Statement statement = null;
		ResultSet resultSet = null;
		PreparedStatement pstmt = null;
		Scanner reader = new Scanner(System.in);

		try {
			connection = DriverManager
					.getConnection(DB_URL, DB_USER, DB_PASSWD);
			System.out
					.println("----TravelersGuide----\nVersion: 0.8\nYour travel agent in a pocket! Please choose an option below.");
			while (true) {
				System.out.printf("1)Login\n2)Guest\n3)Exit\n>");
				String option = reader.nextLine();
				if (option.equals("1") || option.equals("Login")) {
					loginMenu(connection,reader,statement,resultSet);
				} else if (option.equals("2") || option.equals("Guest")) {
					guestMenu(connection,reader,statement,resultSet);
				} else if (option.equals("3") || option.equals("Exit")) {
					if (statement != null)
						statement.close();
					if (connection != null)
						connection.close();
					System.exit(0);
					break;
				}
			}
		} catch (SQLException ex) {
		} finally {
			System.out.println("Failure to establish SQL connection.");
			try {
				if (pstmt != null)
					pstmt.close();
				if (connection != null)
					connection.close();
			} catch (SQLException ex) {
				System.out.println("Failure to close connection.");
			}
		}
	}
}
// TODO code application logic here
