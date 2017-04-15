package org.mm.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DB {
	
	//获得数据库连接
		public static Connection getConn(){
			//注册mysql的jdbc驱动
			try {
				Class.forName("com.mysql.jdbc.Driver");
			} catch (ClassNotFoundException e) {
				
				e.printStackTrace();
			}
			//创建数据库连接对象
//			String ip="localhost";
//			String dbName="mms";
//			String url="jdbc:mysql://"+ip+"/"+dbName;//此处是mysql jdbc连接的协议 
			String url = "jdbc:mysql://localhost/mms";
			Connection conn=null;
			try {
				conn=DriverManager.getConnection(url,"root","ruangong");
//				conn=DriverManager.getConnection(url,"root","910316");
				//打开事务手动提交
//				conn.setAutoCommit(false);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
			return conn;
		}
		
		public static  void close(ResultSet rs){
			if(rs!=null){
				try {
					rs.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		
		public static void close(PreparedStatement pstmt){
			if(pstmt!=null){
				try {
					pstmt.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		
		public static void close(Connection  conn){
			if(conn!=null){
				try {
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		
		public  static void commit(Connection  conn){
			if(conn!=null){
				try {
					conn.commit();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		
		public static  void rollback(Connection  conn){
			if(conn!=null){
				try {
					conn.rollback();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
}
