/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.zerodech.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    
    private static final String URL = "jdbc:oracle:thin:@localhost:1521:ORCL";
    private static final String USER = "school";
    private static final String PASSWORD = "school";

   public static Connection getConnection() throws SQLException {
    System.out.println("DB USER = " + USER);
    System.out.println("DB PASSWORD = " + PASSWORD);
    return DriverManager.getConnection(URL, USER, PASSWORD);
}
}
