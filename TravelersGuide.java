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
public class TravelersGuide {

	static final String DB_URL = "jdbc:mysql://localhost:3306/TravelersGuide";
	static final String DB_DRV = "com.mysql.jdbc.Driver";
	static final String DB_USER = "root";
	static final String DB_PASSWD = "password";// "1frjxqsF4/t";

	private static void loginMenu(Scanner reader, Connection conc,
			Statement stmt, ResultSet rs) throws InterruptedException,
			SQLException {
		System.out.print("First Name: ");
		String fName = reader.nextLine();
		System.out.print("Last name: ");
		String lName = reader.nextLine();
		System.out.print("Password: ");
		String password = reader.nextLine();
		String SQL = "SELECT userID, psw FROM Users WHERE firstname=\"" + fName
				+ "\" and lastname=\"" + lName + "\";";
		stmt = conc.createStatement();
		rs = stmt.executeQuery(SQL);

		while (rs.next()) {
			if (password.equals(rs.getString(2))) {
				if (rs.getInt(1) == -1) {
					// TODO: Send admin to admin menus as well
					System.out.println("Welcome administrator.");
					System.out
							.println("List of admin options here, leading to functions.");
					travelersMainMenu(reader, conc, stmt, rs);
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

	private static void guestMenu(Scanner reader, Connection conc,
			Statement stmt, ResultSet rs) throws InterruptedException,
			SQLException {
		// TODO Remove login on guestmenu, or remove guest entirely
		String SQL = "SELECT userID, psw FROM Users WHERE firstname=\""
				+ "Admin" + "\" and lastname=\"" + "Istrator" + "\";";
		stmt = conc.createStatement();
		rs = stmt.executeQuery(SQL);
		travelersMainMenu(reader, conc, stmt, rs);
	}

	public static void travelersMainMenu(Scanner reader, Connection conc,
			Statement stmt, ResultSet rs) throws InterruptedException,
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
			travelersUserMenu(reader, conc, stmt, rs);
		}
		if (option.equals("2")) {
			travelersCountryMenu(reader, conc, stmt, rs);
		}
		if (option.equals("3")) {
			travelersAdminMenu(reader, conc, stmt, rs);
		}

	}

	public static void travelersUserMenu(Scanner reader, Connection conc,
			Statement stmt, ResultSet rs) throws InterruptedException,
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
		System.out.println("* 6. View Connections           *");
		System.out.println("* 7. Add Recommendation         *");
		System.out.println("* 8. View Recommendations       *");
		System.out.println("* 9. View Distance to Country   *");
		System.out.println("* 10. View Distance to User     *");
		System.out.println("*                               *");
		System.out.println("* 0. Return to Main Menu        *");
		System.out.println("*********************************");
		System.out.println("");

		while (true) {

			System.out.printf(">> ");
			String option = reader.nextLine();

			// TODO: Uncomment functions as they are added.

			if (option.equals("1")) {
				// funcUser1(reader, conc, stmt, rs);
			} else if (option.equals("2")) {
				funcUser2(reader, conc, stmt, rs);
			} else if (option.equals("3")) {
				// funcUser3(reader, conc, stmt, rs);
			} else if (option.equals("4")) {
				// funcUser4(reader, conc, stmt, rs);
			} else if (option.equals("5")) {
				// funcUser5(reader, conc, stmt, rs);
			} else if (option.equals("6")) {
				// funcUser6(reader, conc, stmt, rs);
			} else if (option.equals("7")) {
				funcUser7(reader, conc, stmt, rs);
			} else if (option.equals("8")) {
				funcUser8(reader, conc, stmt, rs);
			} else if (option.equals("9")) {
				// funcUser9(reader, conc, stmt, rs);
			} else if (option.equals("10")) {
				// funcUser10(reader, conc, stmt, rs);
			} else if (option.equals("0")) {
				travelersMainMenu(reader, conc, stmt, rs);
				break;
			} else {
				travelersUserMenu(reader, conc, stmt, rs);
				break;
			}
		}

	}

	public static void travelersCountryMenu(Scanner reader, Connection conc,
			Statement stmt, ResultSet rs) throws InterruptedException,
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
		System.out.println("* 6. View Recommended Countries *");
		System.out.println("* 7. View Distance from Country *");
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
				// funcCountry1(reader, conc, stmt, rs);
			} else if (option.equals("2")) {
				// funcCountry2(reader, conc, stmt, rs);
			} else if (option.equals("3")) {
				// funcCountry3(reader, conc, stmt, rs);
			} else if (option.equals("4")) {
				// funcCountry4(reader, conc, stmt, rs);
			} else if (option.equals("5")) {
				funcCountry5(reader, conc, stmt, rs);
			} else if (option.equals("6")) {
				// funcCountry6(reader, conc, stmt, rs);
			} else if (option.equals("7")) {
				// funcCountry7(reader, conc, stmt, rs);
			} else if (option.equals("8")) {
				// ffuncCountry8(reader, conc, stmt, rs);
			} else if (option.equals("9")) {
				// funcCountry9(reader, conc, stmt, rs);
			} else if (option.equals("10")) {
				// funcCountry10(reader, conc, stmt, rs);
			} else if (option.equals("0")) {
				travelersMainMenu(reader, conc, stmt, rs);
				break;
			} else {
				travelersCountryMenu(reader, conc, stmt, rs);
				break;
			}
		}

	}

	public static void travelersAdminMenu(Scanner reader, Connection conc,
			Statement stmt, ResultSet rs) throws InterruptedException,
			SQLException {
		System.out.println("");
		System.out.println("*********************************");
		System.out.println("*         Admin Menu            *");
		System.out.println("*                               *");
		System.out.println("* 1. View All Users             *");
		System.out.println("* 2. Add/Delete Users           *");
		System.out.println("* 3. View all Connections       *");
		System.out.println("* 4. View all Recommendations   *");
		System.out.println("*                               *");
		System.out.println("* 0. Return to Main Menu        *");
		System.out.println("*********************************");
		System.out.println("");

		System.out.print(">> ");
		Integer menuOption = reader.nextInt();

		if (menuOption == 0) {
			travelersMainMenu(reader, conc, stmt, rs);
		}
	}

	private static void funcUser2(Scanner reader, Connection conc,
			Statement stmt, ResultSet rs) throws SQLException {
		System.out.print("Find what users are from which country: ");
		String countryInput = reader.nextLine();
		System.out.println(countryInput);
		String SQL = "SELECT firstname,lastname,age FROM Users WHERE Users.country = ?";
		PreparedStatement pstmt = conc.prepareStatement(SQL);
		pstmt.setString(1, countryInput);
		rs = pstmt.executeQuery();
		while (rs.next()) {
			System.out.printf("%s\t%s\t%d\t\n", rs.getString(1),
					rs.getString(2), rs.getInt(3));
		}
		pstmt.close();
	}

	private static void funcUser7(Scanner reader, Connection conc,
			Statement stmt, ResultSet rs) throws SQLException {
		System.out.print("Create a new recommendation, enter in uID: ");
		Integer uIDInput = reader.nextInt();
		String whiteSpaec = reader.nextLine();
		System.out.print("Enter in country: ");
		String countryInput = reader.nextLine();
		System.out.print("Enter in stars: ");
		Integer starsInput = reader.nextInt();
		whiteSpaec = reader.nextLine();
		System.out.print("Enter in the recommendation: ");
		String recInput = reader.nextLine();
		String SQL = "INSERT into Recommendation(userID, name,stars,opinion)"
				+ "VALUES (?,?,?,?)";
		PreparedStatement pstmt = conc.prepareStatement(SQL);
		pstmt.setInt(1, uIDInput);
		pstmt.setString(2, countryInput);
		pstmt.setInt(3, starsInput);
		pstmt.setString(4, recInput);
		pstmt.executeUpdate();
	}

	private static void funcUser8(Scanner reader, Connection conc,
			Statement stmt, ResultSet rs) throws SQLException {
		System.out.println("Current Recommendations: ");
		// statement = connection.createStatement();
		String SQL = "SELECT userID,name,stars,opinion FROM Recommendation";
		PreparedStatement pstmt = conc.prepareStatement(SQL);
		rs = pstmt.executeQuery();
		while (rs.next()) {
			System.out.printf("%d\t%s\t%d\t%s\t\n", rs.getInt(1),
					rs.getString(2), rs.getInt(3), rs.getString(4));
		}
	}

	private static void funcCountry5(Scanner reader, Connection conc,
			Statement stmt, ResultSet rs) throws SQLException {
		System.out
				.print("Please enter in the country for the boundaries you wish to know: ");
		String countryInput = reader.nextLine();
		String SQL = "SELECT name2 FROM Boundaries WHERE Boundaries.name1 = ?";
		PreparedStatement pstmt = conc.prepareStatement(SQL);
		pstmt.setString(1, countryInput);
		rs = pstmt.executeQuery();
		while (rs.next()) {
			System.out.printf("%s\t\n", rs.getString(1));
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
					loginMenu(reader, connection, statement, resultSet);
				} else if (option.equals("2") || option.equals("Guest")) {
					guestMenu(reader, connection, statement, resultSet);
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

