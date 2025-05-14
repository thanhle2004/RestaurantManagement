package com.chilling.restaurant.utils;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBUtil {
    //Use Railway 
    //private static final String JDBC_URL = "jdbc:mysql://root:tLOhceyFeeHjIUgUXGmbmEgujpkNcaLw@trolley.proxy.rlwy.net:37733/railway";
    //private static final String JDBC_USER = "root";
    //private static final String JDBC_PASSWORD = "tLOhceyFeeHjIUgUXGmbmEgujpkNcaLw";
    
    //Use Local
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/restaurantdb"; 
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "123456"; 

    public static Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
    }
}
