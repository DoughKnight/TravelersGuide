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
import java.util.concurrent.TimeUnit;
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
        String SQL = "SELECT userID, psw FROM Users WHERE firstname=\"" + fName + "\" and lastname=\"" + lName + "\";";
        stmt = conc.createStatement();
        rs = stmt.executeQuery(SQL);
        while (rs.next()) {
            if(password.equals(rs.getString(2))) {
                if(rs.getInt(1) == -1) {
                    System.out.println("Welcome administrator.");
                    System.out.println("List of admin options here, leading to functions.");
                }
                else {
                    System.out.println("Login success!");
                    System.out.println("List of regular choices here, leading to funcitons.");
                }
                return;
            }
        }
        System.out.println("Failure to login.");
    }

    private static void guestMenu(Scanner reader, Connection conc) {
        System.out.println("Just kidding! Guests have no privileges yet!");
    }

    /**
     * @param args the command line arguments
     */

    public static void travelersMainMenu(Connection connection) throws InterruptedException{
            Scanner reader = new Scanner(System.in);


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
            Integer menuOption = reader.nextInt();

            if(menuOption == 1){
                travelersUserMenu(connection);
            }

            if(menuOption == 2){
                travelersCountryMenu(connection);
            }

            if(menuOption == 3){
                travelersAdminMenu(connection);
            }

    }


    public static void travelersUserMenu(Connection connection) throws InterruptedException{
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
        Scanner reader = new Scanner(System.in);


        System.out.print(">> ");
        Integer menuOption = reader.nextInt();

        if(menuOption == 0){
            travelersMainMenu(connection);
        }

    }

    public static void travelersCountryMenu(Connection connection) throws InterruptedException{
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
        Scanner reader = new Scanner(System.in);


        System.out.print(">> ");
        Integer menuOption = reader.nextInt();

        if(menuOption == 0){
            travelersMainMenu(connection);
        }

    }

    public static void travelersAdminMenu(Connection connection) throws InterruptedException{
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
        Scanner reader = new Scanner(System.in);


        System.out.print(">> ");
        Integer menuOption = reader.nextInt();

        if(menuOption == 0){
            travelersMainMenu(connection);
        }
    }

    public static void main(String[] args) throws InterruptedException {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultSet = null;
        PreparedStatement pstmt = null;
        Scanner reader = new Scanner(System.in);

<<<<<<< HEAD
        try{
            connection = DriverManager.getConnection(DB_URL,DB_USER,DB_PASSWD);

            travelersMainMenu(connection);



//#11
//            try{System.out.print("Please enter in the city for the boundaries you wish to know: ");
//                String countryInput = reader.nextLine();
//                String SQL =
//                "SELECT name2 FROM Boundaries WHERE Boundaries.name1 = ?";
//                pstmt = connection.prepareStatement(SQL);
//                pstmt.setString(1, countryInput);
//                resultSet = pstmt.executeQuery();
//                while(resultSet.next()){
//                    System.out.printf("%s\t\n",resultSet.getString(1));
//                }
//
//                }
//            catch (SQLException ex){
//            }
// #3?
//            try{
//                System.out.print("Find what users are from which country: ");
//                String countryInput = reader.nextLine();
//                System.out.println(countryInput);
//                String SQL = "SELECT firstname,lastname,age FROM Users WHERE Users.country = ?";
//                pstmt = connection.prepareStatement(SQL);
//                pstmt.setString(1, countryInput);
//                resultSet = pstmt.executeQuery();
//                while(resultSet.next()){
//                    System.out.printf("%s\t%s\t%d\t\n",resultSet.getString(1),resultSet.getString(2),resultSet.getInt(3));
//                }
//                }
//            catch (SQLException ex){
//            }
// #15
//            try{
//                System.out.print("Create a new recommendation, enter in uID: ");
//                Integer uIDInput = reader.nextInt();
//                String whiteSpaec = reader.nextLine();
//                System.out.print("Enter in country: ");
//                String countryInput = reader.nextLine();
//                System.out.print("Enter in stars: ");
//                Integer starsInput = reader.nextInt();
//                whiteSpaec = reader.nextLine();
//                System.out.print("Enter in the recommendation: ");
//                String recInput = reader.nextLine();
//                String SQL =
//                "INSERT into Recommendation(userID, name,stars,opinion)" +  "VALUES (?,?,?,?)";
//                pstmt = connection.prepareStatement(SQL);
//                pstmt.setInt(1, uIDInput);
//                pstmt.setString(2,countryInput);
//                pstmt.setInt(3, starsInput);
//                pstmt.setString(4, recInput);
//                pstmt.executeUpdate();
//                //connection.commit();
//
//
//                }
//            catch (SQLException ex){
//            }

//            try{
//                System.out.println("Current Recommendations: ");
//               // statement = connection.createStatement();
//                String SQL = "SELECT userID,name,stars,opinion FROM Recommendation";
//                pstmt = connection.prepareStatement(SQL);
//                resultSet = pstmt.executeQuery();
//                while(resultSet.next()){
//                    System.out.printf("%d\t%s\t%d\t%s\t\n",resultSet.getInt(1),resultSet.getString(2),resultSet.getInt(3),resultSet.getString(4));
//                }
//                }
//            catch (SQLException ex){
//            }

=======
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
>>>>>>> c03b3399f287ff191b32826b077e632788a1fc50

            //statement = connection.createStatement();
            //resultSet = statement.executeQuery("SELECT name2 FROM Boundaries where Boundaries.name1 = ?");
            //while(resultSet.next()){
            //   System.out.printf("%d\t%d\t\n", resultSet.getInt(1), resultSet.getInt(2));
            //}
<<<<<<< HEAD
        }catch (SQLException ex){
        }finally{
                    try{
                    pstmt.close();
                    //statement.close();
                    connection.close();
                    }catch (SQLException ex){
                    }
                    }
                    }
        }
        // TODO code application logic here
=======
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

>>>>>>> c03b3399f287ff191b32826b077e632788a1fc50
