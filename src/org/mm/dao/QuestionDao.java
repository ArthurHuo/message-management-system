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

public class QuestionDao {
	public List<Question> query(){
Connection conn=DB.getConn();
		
		String sql="select * from t_question";
				
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		User user=null;
		List<Question> ql = new ArrayList<Question>();
		try {
			pstmt=conn.prepareStatement(sql);
			
		
			rs=pstmt.executeQuery();
			
			while(rs.next()){
				Question q=new Question();
				q.setId(rs.getString("id"));
				q.setTitle(rs.getString("title"));
				ql.add(q);
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return ql;
	}
}
