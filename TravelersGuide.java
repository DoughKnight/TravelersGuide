/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package travelersguide;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Scanner;

/**
 *
 * @author david
 */
public class TravelersGuide {

    static final String DB_URL = "jdbc:mysql://localhost:3306/TravelersGuide";
    static final String DB_DRV = "com.mysql.jdbc.Driver";
    static final String DB_USER = "root";
    static final String DB_PASSWD = "password";//"1frjxqsF4/t";

    private static void loginMenu(Scanner reader, Connection conc, Statement stmt, ResultSet rs) throws SQLException {
        System.out.print("First Name: ");
        String fName = reader.nextLine();
        System.out.print("Last name: ");
        String lName = reader.nextLine();
        System.out.print("Password: ");
        String password = reader.nextLine();
        String SQL = "SELECT password FROM Users WHERE firstname = " + fName + " and lastName = " + lName + ";";
        stmt = conc.createStatement();
        rs = stmt.executeQuery(SQL); //CREATES SQL EXCEPTION
        if (password.equals(rs.getString(2))) {
            System.out.print("Login success");
        } else {
            System.out.print("Failure to log in");
        }
    }

    private static void guestMenu(Scanner reader, Connection conc) {
        System.out.println("Just kidding! Guests have no privileges yet!");
    }

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultSet = null;
        PreparedStatement pstmt = null;
        Scanner reader = new Scanner(System.in);

        try {
            connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWD);
            System.out.println("----TravelersGuide----\nVersion: 0.8\nYour travel agent in a pocket! Please choose an option below.");
            while (true) {
                System.out.printf("1)Login\n2)Guest\n3)Exit\n>");
                String option = reader.nextLine();
                if (option.equals("1") || option.equals("Login")) {
                    loginMenu(reader, connection, statement, resultSet); //goto logged in menu
                } else if (option.equals("2") || option.equals("Guest")) {
                    guestMenu(reader, connection);
                } else if (option.equals("3") || option.equals("Exit")) {
                    break;
                }
            }

            try {

                System.out.print("Please enter in the city for the boundaries you wish to know: ");
                String countryInput = reader.nextLine();
                String SQL
                        = "SELECT name2 FROM Boundaries WHERE Boundaries.name1 = ?";
                pstmt = connection.prepareStatement(SQL);
                pstmt.setString(1, countryInput);
                resultSet = pstmt.executeQuery();
                while (resultSet.next()) {
                    System.out.printf("%s\t\n", resultSet.getString(1));
                }

            } catch (SQLException ex) {
                connection.close();
                System.out.println("Prepared Statement Failure");
            }

            try {
                System.out.print("Find what users are from which country: ");
                String countryInput = reader.nextLine();
                System.out.println(countryInput);
                String SQL = "SELECT firstname,lastname,age FROM Users WHERE Users.country = ?";
                pstmt = connection.prepareStatement(SQL);
                pstmt.setString(1, countryInput);
                resultSet = pstmt.executeQuery();
                while (resultSet.next()) {
                    System.out.printf("%s\t%s\t%d\t\n", resultSet.getString(1), resultSet.getString(2), resultSet.getInt(3));
                }
            } catch (SQLException ex) {
            }

            try {
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
                String SQL
                        = "INSERT into Recommendation(userID, name,stars,opinion)" + "VALUES (?,?,?,?)";
                pstmt = connection.prepareStatement(SQL);
                pstmt.setInt(1, uIDInput);
                pstmt.setString(2, countryInput);
                pstmt.setInt(3, starsInput);
                pstmt.setString(4, recInput);
                pstmt.executeUpdate();
                //connection.commit();

            } catch (SQLException ex) {
            }

            try {
                System.out.println("Current Recommendations: ");
                // statement = connection.createStatement();
                String SQL = "SELECT userID,name,stars,opinion FROM Recommendation";
                pstmt = connection.prepareStatement(SQL);
                resultSet = pstmt.executeQuery();
                while (resultSet.next()) {
                    System.out.printf("%d\t%s\t%d\t%s\t\n", resultSet.getInt(1), resultSet.getString(2), resultSet.getInt(3), resultSet.getString(4));
                }
            } catch (SQLException ex) {
            }

            //statement = connection.createStatement();
            //resultSet = statement.executeQuery("SELECT name2 FROM Boundaries where Boundaries.name1 = ?");
            //while(resultSet.next()){
            //   System.out.printf("%d\t%d\t\n", resultSet.getInt(1), resultSet.getInt(2));
            //}
        } catch (SQLException ex) {
        } finally {
            System.out.println("Failure to establish SQL connection.");
            try {
                pstmt.close();
                //statement.close();
                connection.close();
            } catch (SQLException ex) {
                System.out.println("Failure to close connection.");
            }
        }
    }
}
// TODO code application logic here

