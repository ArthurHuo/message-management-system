package org.mm.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.mm.model.Question;
import org.mm.model.User;
import org.mm.utils.DB;

public class UserDao {

	public void save(User user ) {
		Connection conn = DB.getConn();

		String sql = "insert into t_user(id,password,name,nick,mobile,question_id,answer) values(?,?,?,?,?,?,?)";
		
		PreparedStatement pstmt = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, user.getId());
			pstmt.setString(2, user.getPassword());
			pstmt.setString(3, user.getName());
			pstmt.setString(4, user.getNick());
			pstmt.setString(5, user.getMobile());
			pstmt.setString(6, user.getQuestion().getId());
			pstmt.setString(7, user.getQuestion().getAnswer());
	
			pstmt.executeUpdate();
//			conn.commit();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			DB.close(pstmt);
			DB.close(conn);
		}
					
	}
	
	public User get(String id){
		
		Connection conn=DB.getConn();
		
		String sql="select a.*,b.id q_id,b.title from t_user a join t_question b on a.question_id=b.id where a.id=?";
				
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		User user=null;
		
		try {
			pstmt=conn.prepareStatement(sql);
			
			pstmt.setString(1, id);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()){
				user=new User();
				user.setId(rs.getString("id"));
				user.setName(rs.getString("name"));
				user.setNick(rs.getString("nick"));
				user.setPassword(rs.getString("password"));
				user.setMobile(rs.getString("mobile"));
				
				Question q=new Question();
				q.setId(rs.getString("q_id"));
				q.setAnswer(rs.getString("answer"));
				q.setTitle(rs.getString("title"));
				user.setQuestion(q);
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return user;
	}
	
public List<User> quary(String keyStr){
		
		Connection conn=DB.getConn();
		
		String sql="select a.*,b.id q_id,b.title from t_user a join t_question b on a.question_id=b.id where a.id like ? or a.name like ?";
				
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<User> users = new ArrayList<User>();
		
		try {
			pstmt=conn.prepareStatement(sql);
			
			pstmt.setString(1, "%"+keyStr+"%");
			pstmt.setString(2, "%"+keyStr+"%");
			
			rs=pstmt.executeQuery();
			
			while(rs.next()){
				User user=new User();
				user.setId(rs.getString("id"));
				user.setName(rs.getString("name"));
				user.setNick(rs.getString("nick"));
				user.setPassword(rs.getString("password"));
				user.setMobile(rs.getString("mobile"));
				
				Question q=new Question();
				q.setId(rs.getString("q_id"));
				q.setAnswer(rs.getString("answer"));
				q.setTitle(rs.getString("title"));
				user.setQuestion(q);
				
				users.add(user);
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return users;
	}
	


public void resetPassword(String restPassword,String id){
	
	Connection conn=DB.getConn();
	
	String sql = "update t_user set password=? where id=?";
	
	
	PreparedStatement pstmt=null; 
	try {
		pstmt=conn.prepareStatement(sql);
			
		pstmt.setString(1, restPassword);
		pstmt.setString(2, id);
	
		
		pstmt.executeUpdate();
//		conn.commit();
	} catch (SQLException e) {
		e.printStackTrace();
	}finally{
		DB.close(pstmt);
		DB.close(conn);
	}
}

	public void update(User user){
		
		Connection conn=DB.getConn();
		
		String sql = "update t_user set password=?,name=?,nick=?,mobile=? where id=?";
		
		
		PreparedStatement pstmt=null; 
		try {
			pstmt=conn.prepareStatement(sql);
				
			pstmt.setString(1, user.getName());
			pstmt.setString(2, user.getPassword());
			pstmt.setString(3, user.getNick());
			pstmt.setString(4, user.getMobile());
			pstmt.setString(5, user.getId());
			
			pstmt.executeUpdate();
//			conn.commit();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DB.close(pstmt);
			DB.close(conn);
		}
	}
}
