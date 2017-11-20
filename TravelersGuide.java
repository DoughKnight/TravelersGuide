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
    static final String DB_PASSWD = "1frjxqsF4/t";
    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultSet = null;
        PreparedStatement pstmt = null;
        Scanner reader = new Scanner(System.in);
        
        try{
            connection = DriverManager.getConnection(DB_URL,DB_USER,DB_PASSWD);
             
            try{System.out.print("Please enter in the city for the boundaries you wish to know: ");
                String countryInput = reader.nextLine(); 
                String SQL = 
                "SELECT name2 FROM Boundaries WHERE Boundaries.name1 = ?";
                pstmt = connection.prepareStatement(SQL);
                pstmt.setString(1, countryInput);
                resultSet = pstmt.executeQuery();
                while(resultSet.next()){
                    System.out.printf("%s\t\n",resultSet.getString(1));                 
                }
                
                }
            catch (SQLException ex){                
            }
            
            try{ 
                System.out.print("Find what users are from which country: ");
                String countryInput = reader.nextLine();
                System.out.println(countryInput);
                String SQL = "SELECT firstname,lastname,age FROM Users WHERE Users.country = ?";
                pstmt = connection.prepareStatement(SQL);
                pstmt.setString(1, countryInput);
                resultSet = pstmt.executeQuery();
                while(resultSet.next()){
                    System.out.printf("%s\t%s\t%d\t\n",resultSet.getString(1),resultSet.getString(2),resultSet.getInt(3));
                }
                }
            catch (SQLException ex){                
            }
            
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
                pstmt = connection.prepareStatement(SQL);
                pstmt.setInt(1, uIDInput);
                pstmt.setString(2,countryInput);
                pstmt.setInt(3, starsInput);
                pstmt.setString(4, recInput);
                pstmt.executeUpdate();
                //connection.commit();
               
                
                }
            catch (SQLException ex){                
            }
            
            try{          
                System.out.println("Current Recommendations: ");
               // statement = connection.createStatement();
                String SQL = "SELECT userID,name,stars,opinion FROM Recommendation";
                pstmt = connection.prepareStatement(SQL);
                resultSet = pstmt.executeQuery();
                while(resultSet.next()){
                    System.out.printf("%d\t%s\t%d\t%s\t\n",resultSet.getInt(1),resultSet.getString(2),resultSet.getInt(3),resultSet.getString(4));
                }
                }
            catch (SQLException ex){                
            }
                   
            
            //statement = connection.createStatement();
            //resultSet = statement.executeQuery("SELECT name2 FROM Boundaries where Boundaries.name1 = ?");
            //while(resultSet.next()){
             //   System.out.printf("%d\t%d\t\n", resultSet.getInt(1), resultSet.getInt(2));
            //}
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
    
   
