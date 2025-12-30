package com.library.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    // Apne MySQL ka sahi details yahan bharein
    private static final String URL = "jdbc:mysql://localhost:3306/library_db"; // database naam check karein
    private static final String USER = "root"; // apna username
    private static final String PASS = "Shivay32006"; // apna password

    public static Connection getConnection() {
        try {
            // Driver load karna Tomcat 10+ ke liye zaroori hai
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, USER, PASS);
        } catch (Exception e) {
            System.out.println("Database Connection Failed: " + e.getMessage());
            e.printStackTrace();
            return null; // Isiliye aapko null error aa raha hai
        }
    }
}