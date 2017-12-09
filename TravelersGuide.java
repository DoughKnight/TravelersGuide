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
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
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
	static final String DB_PASSWD =  "1frjxqsF4/t"; //password
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
					System.out.println("List of regular choices here, leading to functions.");
                                        travelersMainMenu(conc, reader);
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

			if (option.equals("1")) {
				funcUser1(conc);
			} else if (option.equals("2")) {
				funcUser2(conc, reader);
			} else if (option.equals("3")) {
                                funcUser3(conc,user_Language);
			} else if (option.equals("4")) {
				funcUser4(conc, reader,user_userID );
			} else if (option.equals("5")) {
				funcUser5(conc, reader,user_userID );
			} else if (option.equals("6")) {
				funcUser6(conc,user_userID );
			} else if (option.equals("7")) {
				funcUser7(conc, reader);
			} else if (option.equals("8")) {
				funcUser8(conc);
			} else if (option.equals("9")) {
				funcUser9(conc, reader,user_userID);
			} else if (option.equals("0")) {
				travelersMainMenu(conc, reader);
				break;
			} else {
				travelersUserMenu(conc, reader,user_userID,user_Language,user_Country);
				break;
			}
		}

	}

        private static void funcUser1(Connection connection){
     try{
         System.out.println("Users: ");
         String SQL = "Select firstname, lastname from Users Order by firstname ASC";
         PreparedStatement pstmt = connection.prepareStatement(SQL);
         ResultSet resultSet = pstmt.executeQuery();

         while(resultSet.next()){
                System.out.printf("%-9s %-9s ",resultSet.getString(1),resultSet.getString(2));
                if(resultSet.next()){
                    System.out.printf("%-9s %-9s ",resultSet.getString(1),resultSet.getString(2));
                    if(resultSet.next()){
                        System.out.printf("%-9s %-9s ",resultSet.getString(1),resultSet.getString(2));
                        if(resultSet.next()){
                            System.out.printf("%-9s %-9s ",resultSet.getString(1),resultSet.getString(2));
                         }
                    }

                }
                System.out.println("");
            }

     }catch (SQLException ex){

     }


    }
        private static void funcUser2(Connection connection, Scanner reader){
        try{
            System.out.print("Which country do you wish to find users?: ");
            String country = reader.nextLine();
            String SQL = "Select firstname,lastname from Users where country = '" + country +"'";
            PreparedStatement pstmt = connection.prepareStatement(SQL);
            ResultSet resultSet = pstmt.executeQuery();

            while(resultSet.next()){
                System.out.printf("%-9s %-9s ",resultSet.getString(1),resultSet.getString(2));
                if(resultSet.next()){
                    System.out.printf("%-9s %-9s ",resultSet.getString(1),resultSet.getString(2));
                    if(resultSet.next()){
                        System.out.printf("%-9s %-9s ",resultSet.getString(1),resultSet.getString(2));
                        if(resultSet.next()){
                            System.out.printf("%-9s %-9s ",resultSet.getString(1),resultSet.getString(2));
                         }
                    }

                }
                System.out.println("");
            }
        }catch(SQLException ex){

        }
    }
        private static void funcUser3(Connection connection, String language){
        try{
            System.out.println("Users who also speak " + language + ": ");
            String SQL = "Select firstname,lastname from Users as subUsers WHERE EXISTS (Select firstname, lastname from Users where subUsers.language = '"+ language +"') order by firstname";
            PreparedStatement pstmt = connection.prepareStatement(SQL);
            ResultSet resultSet = pstmt.executeQuery();

            while(resultSet.next()){
                System.out.printf("%-9s %-9s ",resultSet.getString(1),resultSet.getString(2));
                if(resultSet.next()){
                    System.out.printf("%-9s %-9s ",resultSet.getString(1),resultSet.getString(2));
                    if(resultSet.next()){
                        System.out.printf("%-9s %-9s ",resultSet.getString(1),resultSet.getString(2));
                        if(resultSet.next()){
                            System.out.printf("%-9s %-9s ",resultSet.getString(1),resultSet.getString(2));
                         }
                    }

                }
                System.out.println("");
            }
        }catch(SQLException ex){
            System.out.println(ex.getMessage());
        }
    }
        private static void funcUser4(Connection connection, Scanner reader, String userID) throws InterruptedException{
        try{
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
        Date today = Calendar.getInstance().getTime();


        System.out.print("What is the user ID that you want to connect with?:  ");
        String uID = reader.nextLine();
        String SQL = "Insert into Connection(userID1,userID2,meetDate)VALUES (?,?,?)";
        PreparedStatement pstmt = connection.prepareStatement(SQL);
        pstmt.setString(1,userID);
        pstmt.setString(2,uID);
        pstmt.setString(3, df.format(today));
        pstmt.executeUpdate();
        for(int i = 0; i < 4; i++){
            TimeUnit.SECONDS.sleep(1);
            System.out.print(". ");
        }
        System.out.println("Insertion completed!");

        }catch(SQLException ex){
            System.out.println(ex.getMessage());
        }
    }
        private static void funcUser5(Connection connection, Scanner reader, String userID) throws InterruptedException{
        try{

            String SQL = "Select userID1,userID2,meetDate from Connection where " + userID + " = userID1 order by userID2 DESC";
            PreparedStatement pstmt = connection.prepareStatement(SQL);
            ResultSet resultSet = pstmt.executeQuery();

            System.out.println("Current Connections: ");
            String count = "";
            while(resultSet.next()){
                System.out.printf("%-7s %-7s %12s \n",resultSet.getString(1),resultSet.getString(2),resultSet.getString(3));

              }



        }catch(SQLException ex){
            System.out.println(ex.getMessage());
        }

        try{
            System.out.print("Which connection do you want to delete? Please enter the userID of the conflicting person: ");
            String inputID = reader.nextLine();
            System.out.print("Do you want to delete?(y/n): ");
            String yn = reader.nextLine();
            if(yn.equals("y")){
                String SQL = "Delete from Connection where " + userID + " = userID1 and " + inputID + " = userID2";
                PreparedStatement pstmt2 = connection.prepareStatement(SQL);
                pstmt2.executeUpdate();
                for(int i = 0; i < 4; i++){
                    TimeUnit.SECONDS.sleep(1);
                    System.out.print(". ");
                }
                System.out.println("Deletion completed!");
            }else{}

        }catch(SQLException ex){
            System.out.println(ex.getMessage());
        }
    }
        private static void funcUser6(Connection connection,String userID){
       try{
            System.out.println("Current Connections: ");
            String SQL = "Select user.firstname, user.lastname, con.meetDate from Connection as con, Users as user Where con.userID1 = " + userID + " and con.userID2 = user.userID";
            PreparedStatement pstmt = connection.prepareStatement(SQL);
            ResultSet resultSet = pstmt.executeQuery();

            while(resultSet.next()){
                System.out.printf("%-7s %-10s %-12s\n",resultSet.getString(1),resultSet.getString(2),resultSet.getString(3));
              }
        }catch(SQLException ex){

        }

        try{
            String SQL = "Select count(userID1) FROM Connection where userID1 = '" + userID + "' Group By userID1";
            PreparedStatement pstmt1 = connection.prepareStatement(SQL);
            ResultSet resultSet = pstmt1.executeQuery();
            if(resultSet.next()){
                System.out.println(resultSet.getString(1) + " total connections.");
            }
        }catch(SQLException ex){
            System.out.println(ex.getMessage());
        }
    }
        private static void funcUser7(Connection connection,Scanner reader){
        try{
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
                String SQL =
                "INSERT into Recommendation(userID, name,stars,opinion)" +  "VALUES (?,?,?,?)";
                PreparedStatement pstmt = connection.prepareStatement(SQL);
                pstmt.setInt(1, uIDInput);
                pstmt.setString(2,countryInput);
                pstmt.setInt(3, starsInput);
                pstmt.setString(4, recInput);
                pstmt.executeUpdate();
                //connection.commit();


                }
            catch (SQLException ex){
            }

    }
        private static void funcUser8(Connection connection){
        try{
                System.out.println("Current Recommendations: ");
                String SQL = "SELECT userID,name,stars,opinion FROM Recommendation";
                PreparedStatement pstmt = connection.prepareStatement(SQL);
                ResultSet resultSet = pstmt.executeQuery();
                System.out.println("userID	Country         Stars	Opinion	");
                while(resultSet.next()){
                    System.out.printf("%d\t%s\t        %d\t%s\t\n",resultSet.getInt(1),resultSet.getString(2),resultSet.getInt(3),resultSet.getString(4));
                }
                }
            catch (SQLException ex){
            }
    }
        private static void funcUser9(Connection connection, Scanner reader, String userID) throws InterruptedException{
        System.out.print("Please type in new password: ");String password = reader.nextLine();

        try{
            String SQL = "UPDATE Users SET psw = '" + password  + "' WHERE userID = " + userID;
            PreparedStatement pstmt = connection.prepareStatement(SQL);
            pstmt.executeUpdate();
            for(int i = 0; i < 4; i++){
                TimeUnit.SECONDS.sleep(1);
                System.out.print(". ");
            }
            System.out.println("Password updated!");
        }catch(SQLException ex){
            System.out.println(ex.getMessage());
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
		System.out.println("* 3. Compare Data b/w Countries?*");
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
				funcCountry1(conc);
			} else if (option.equals("2")) {
				funcCountry2(conc, reader);
			} else if (option.equals("3")) {
				funcCountry3(conc, reader);
			} else if (option.equals("4")) {
				funcCountry4(conc, reader,user_Country);
			} else if (option.equals("5")) {
                                funcCountry5(conc,reader);
			} else if (option.equals("6")) {
				funcCountry6(conc, reader,user_Country);
			} else if (option.equals("7")) {
				funcCountry7(conc, reader);
			} else if (option.equals("8")) {
				funcCountry8(conc, reader,user_Country);
			} else if (option.equals("0")) {
				travelersMainMenu(conc, reader);
				break;
			} else {
				travelersCountryMenu(conc, reader,user_userID,user_Language,user_Country);
				break;
			}
		}

	}

        private static void funcCountry1(Connection connection){
        try{
            System.out.println("Countries:");
            String SQL = "Select name from Country";
            PreparedStatement pstmt = connection.prepareStatement(SQL);
            ResultSet resultSet = pstmt.executeQuery();
            while(resultSet.next()){
                System.out.printf("%-30s ",resultSet.getString(1));
                if(resultSet.next()){
                    System.out.printf("%-30s ",resultSet.getString(1));

                    if(resultSet.next()){
                        System.out.printf("%-30s ",resultSet.getString(1));

                        if(resultSet.next()){
                            System.out.printf("%-30s ",resultSet.getString(1));

                         }
                    }

                }
                System.out.println("");
            }
        }catch (SQLException ex){
            System.out.println(ex.getMessage());
        }
    }
        private static void funcCountry2(Connection connection, Scanner reader){
        System.out.print("Please enter the name of the country you're searching for: ");
        String country = reader.nextLine();
       try{
        String SQL = "SELECT * FROM Country WHERE Country.name = '" + country +"'";
        PreparedStatement pstmt = connection.prepareStatement(SQL);
        ResultSet resultSet = pstmt.executeQuery();
        while(resultSet.next()){
            System.out.println("Name: " + resultSet.getString(1) + " Location: (" + resultSet.getInt(3) + "," + resultSet.getInt(4) +") Area: " + resultSet.getInt(5) + "km squared.");
            String[] desc = resultSet.getString(2).split("\\.");
            System.out.print("Description: ");
            for (String sent : desc){
                if((sent + ".").equals(" .")){
                    break;
                }else{
                    System.out.println(sent + ".");
                }

            }
        }

           }catch (SQLException ex){
               System.out.println(ex.getMessage());
           }
    }
        private static void funcCountry3(Connection connection, Scanner reader){

    }
        private static void funcCountry4(Connection connection, Scanner reader, String userCountry){
      try{
          System.out.println("Country         Distance(less than 1000km)");
          String SQL = "SELECT Dest.name, " + "TRUNCATE((SQRT(POWER((Dest.longitude - userCountry.longitude), 2) + POWER((Dest.latitude - userCountry.latitude), 2))),4) as dist "
                     + "From Country as Dest, " + " (SELECT longitude, latitude, name FROM Country where '" + userCountry + "' = Country.name) as userCountry "
                     + "Where userCountry.name <> Dest.name "
                     + "having dist < 10 "
                     + "order by dist";
          PreparedStatement pstmt = connection.prepareStatement(SQL);
          ResultSet resultSet = pstmt.executeQuery();
          while(resultSet.next()){
              System.out.printf("%-10s\t%.2f km\n", resultSet.getString(1),(resultSet.getFloat(2) * 100));
          }

      }catch (SQLException ex){

      }
    }
        private static void funcCountry5(Connection connection, Scanner reader){
            try{System.out.print("Please enter in the city for the boundaries you wish to know: ");
                String countryInput = reader.nextLine();
                String SQL =
                "SELECT name2 FROM Boundaries WHERE Boundaries.name1 = ?";
                PreparedStatement pstmt = connection.prepareStatement(SQL);
                pstmt.setString(1, countryInput);
                ResultSet resultSet = pstmt.executeQuery();
                while(resultSet.next()){
                    System.out.printf("%s\t\n",resultSet.getString(1));
                }

                }
            catch (SQLException ex){
            }
}

        private static void funcCountry6(Connection connection,Scanner reader,String userCountry){
    try{
        System.out.print("Please enter in the country you wish to reach: ");
        String inputCountry = reader.nextLine();

        System.out.print("Distance from "+ userCountry + " to " + inputCountry + ": ");
        String SQL = "SELECT TRUNCATE((SQRT(POWER((dest.longitude - origin.longitude), 2) + POWER((dest.latitude - origin.latitude), 2))),4) as dist "
                        + "FROM Country as origin, Country as dest "
                        + "WHERE origin.name <> dest.name "
                        + "AND origin.name = '" + userCountry + "' "
                        + "AND dest.name = '"+ inputCountry + "' ";
                PreparedStatement pstmt = connection.prepareStatement(SQL);
                ResultSet resultSet = pstmt.executeQuery();
                while(resultSet.next()){
                    System.out.printf("%.2f km\n",(resultSet.getFloat(1) * 100));
                }
                }
            catch (SQLException ex){
            }
    }
        private static void funcCountry7(Connection connection, Scanner reader){
         try{
                System.out.print("Please enter in the two countries separated by space: ");
                String[] input = reader.nextLine().split(" ");
                System.out.print("Distance from " + input[0] + " to " + input[1] + ": ");
                String SQL = "SELECT TRUNCATE((SQRT(POWER((dest.longitude - origin.longitude), 2) + POWER((dest.latitude - origin.latitude), 2))),4) as dist "
                        + "FROM Country as origin, Country as dest "
                        + "WHERE origin.name <> dest.name "
                        + "AND origin.name = '" + input[0] + "' "
                        + "AND dest.name = '"+ input[1] + "' ";
                PreparedStatement pstmt = connection.prepareStatement(SQL);
                ResultSet resultSet = pstmt.executeQuery();
                while(resultSet.next()){
                    System.out.printf("%.2f km\n",(resultSet.getFloat(1) * 100));
                }
                }
            catch (SQLException ex){
            }
    }
        private static void funcCountry8(Connection connection,Scanner reader,String userCountry){
         try{
                System.out.print("Who do you want to reach?: ");
                String[] input = reader.nextLine().split(" ");
                System.out.print("Distance to " + input[0] + " " + input[1] + ": ");
               // statement = connection.createStatement();
                String SQL = "SELECT TRUNCATE((SQRT(POWER((destUserCountry.longitude - userCountry.longitude), 2) + POWER((destUserCountry.latitude - userCountry.latitude), 2))),4) as dist "
                        + "FROM (SELECT longitude, latitude FROM Country, Users WHERE Users.firstname = '" + input[0] + "' AND Users.lastname = '" + input[1] + "' AND Users.country = Country.name) as destUserCountry, "
                        + "(SELECT longitude, latitude FROM Country WHERE '" + userCountry + "' = Country.name) as userCountry";
                PreparedStatement pstmt = connection.prepareStatement(SQL);
                ResultSet resultSet = pstmt.executeQuery();
                while(resultSet.next()){
                    System.out.printf("%.2f"+" km\n",(resultSet.getFloat(1) * 100));
                }
                }
            catch (SQLException ex){
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
		Integer option = reader.nextInt();

                if (option.equals("1")) {
                    funcAdmin1(conc,reader);
		} else if (option.equals("2")) {
                    funcAdmin2(conc, reader);
		} else if (option.equals("3")) {
                    funcAdmin3(conc,reader);
		} else if (option.equals("4")) {
                    funcAdmin4(conc,reader);
		} else if (option.equals("5")) {
                    funcAdmin5(conc,reader);
                }else if (option == 0) {
			travelersMainMenu(conc, reader);
		}
	}

        private static void funcAdmin1(Connection connection, Scanner reader){
     try{
         System.out.println("UserID    Name                  Age   Language  Country                   E-mail                         Password     ");
         String SQL = "Select userID, firstname, lastname, age,language,country, email, psw from Users Order by userID ASC";
         PreparedStatement pstmt = connection.prepareStatement(SQL);
         ResultSet resultSet = pstmt.executeQuery();
         while(resultSet.next()){
                System.out.printf("%-9s %-9s %-11s %-5s %-9s %-25s %-30s %-20s \n",resultSet.getString(1),resultSet.getString(2),resultSet.getString(3),resultSet.getString(4),resultSet.getString(5),resultSet.getString(6),resultSet.getString(7),resultSet.getString(8));
                }
            }catch (SQLException ex){
        }
     }
        private static void funcAdmin2(Connection connection, Scanner reader) throws InterruptedException{
     System.out.println("Creating User...");
     System.out.print("Enter in new uID: "); String uID = reader.nextLine();
     System.out.print("Enter in first and last name: ");String[] name = reader.nextLine().split(" ");
     System.out.print("Enter in age: ");String age = reader.nextLine();
     System.out.print("Enter in country of origin: ");String country = reader.nextLine();
     System.out.print("Enter in primary language: ");String language = reader.nextLine();
     System.out.print("Enter in email: ");String email = reader.nextLine();
     System.out.print("Enter in password: ");String password = reader.nextLine();

     try{
         String SQL = "Insert into Users(userID,firstname,lastname,psw,age,email,language,country) VALUES(?,?,?,?,?,?,?,?)";
         PreparedStatement pstmt = connection.prepareStatement(SQL);
         pstmt.setString(1, uID);
         pstmt.setString(2,name[0]);
         pstmt.setString(3, name[1]);
         pstmt.setString(4, password);
         pstmt.setString(5,age);
         pstmt.setString(6,email);
         pstmt.setString(7,language);
         pstmt.setString(8,country);
         pstmt.executeUpdate();

         for(int i = 0; i < 4; i++){
            TimeUnit.SECONDS.sleep(1);
            System.out.print(". ");
        }
        System.out.println("Insertion completed!");

     }catch(SQLException ex){

     }

 }
        private static void funcAdmin3(Connection connection, Scanner reader) throws InterruptedException{
     try{
         System.out.println("UserID    Name                  Age   Language  Country                   E-mail                         Password     ");
         String SQL = "Select userID, firstname, lastname, age,language,country, email, psw from Users Order by userID ASC";
         PreparedStatement pstmt = connection.prepareStatement(SQL);
         ResultSet resultSet = pstmt.executeQuery();
         while(resultSet.next()){
                System.out.printf("%-9s %-9s %-11s %-5s %-9s %-25s %-30s %-20s \n",resultSet.getString(1),resultSet.getString(2),resultSet.getString(3),resultSet.getString(4),resultSet.getString(5),resultSet.getString(6),resultSet.getString(7),resultSet.getString(8));
                }
            }catch (SQLException ex){
        }


     try{
        System.out.print("Which user do you wish to delete? Please enter in their userID: "); String delete = reader.nextLine();
        String SQL = "Delete from Users where userID = " + delete;
        PreparedStatement pstmt2 = connection.prepareStatement(SQL);
        pstmt2.executeUpdate();
        for(int i = 0; i < 4; i++){
            TimeUnit.SECONDS.sleep(1);
            System.out.print(". ");
        }
        System.out.println("Deletion completed!");

     }catch(SQLException ex){
    }
 }
        private static void funcAdmin4(Connection connection, Scanner reader){
     try{
            System.out.println("Current Connections: ");
            String SQL = "Select firstname, lastname, meetDate from Connection left join TravelersGuide.Users on Users.userID = userID1 or Users.userID = userID2 order by meetDate DESC";
            PreparedStatement pstmt = connection.prepareStatement(SQL);
            ResultSet resultSet = pstmt.executeQuery();

            while(resultSet.next()){
                System.out.printf("%-7s %-10s ",resultSet.getString(1),resultSet.getString(2));
                if(resultSet.next()){
                    System.out.printf("%-7s %-10s  %12s\n",resultSet.getString(1),resultSet.getString(2),resultSet.getString(3));
                }
              }
        }catch(SQLException ex){

        }

}
        private static void funcAdmin5(Connection connection, Scanner reader){
    try{
        String SQL = "Select * from Recommendation";
        PreparedStatement pstmt = connection.prepareStatement(SQL);
        ResultSet resultSet = pstmt.executeQuery();
        System.out.println("userID    Country   Stars    Opinion              Last Updated");
        while(resultSet.next()){
            System.out.printf("%-9s %-9s %-8s %-20s %-10s", resultSet.getString(1), resultSet.getString(2),resultSet.getString(3),resultSet.getString(4),resultSet.getString(5));
        }

    }catch(SQLException ex){

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
