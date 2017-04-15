package org.mm.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.mm.model.Message;
import org.mm.model.MessageLog;
import org.mm.model.Page;
import org.mm.model.User;
import org.mm.utils.DB;

public class MessageDao {

	public void save(Message m) {
		Connection conn = DB.getConn();

		String sql = "insert into t_message(title,content,sender,receiver,send_time,is_del) values(?,?,?,?,now(),'0')";

		PreparedStatement pstmt = null;

		try {
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, m.getTitle());
			pstmt.setString(2, m.getContent());
			pstmt.setString(3, m.getSender().getId());
			pstmt.setString(4, m.getReceiver());

			pstmt.executeUpdate();
			// conn.commit();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			DB.close(pstmt);
			DB.close(conn);
		}
	}

	public int getMaxId() {
		Connection conn = DB.getConn();

		String sql = "select max(id) from t_message";

		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				return rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		return 0;
	}
	
	public Message get(int id){
		Connection conn=DB.getConn();
		String sql = "select * from t_message where id=?";
		
		
		
		PreparedStatement pstmt=null; //PreparedStatement CallableStatement
		ResultSet rs=null;
		Message m=null;
		try {
			
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, id);
			rs=pstmt.executeQuery();
			if(rs.next()){
				m=new Message();
				m.setId(id);
				m.setTitle(rs.getString("title"));
				m.setContent(rs.getString("content"));
				m.setReceiver(rs.getString("receiver"));
				User user=new User();
				user.setId(rs.getString("sender"));
				m.setSender(user);
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		
		return m;
	}
	
	public void updateDelFlag(int[] ids,String flag){
		Connection conn=DB.getConn();
		String sql = "update t_message set is_del=? where id=?";
		
		
		
		PreparedStatement pstmt=null; //PreparedStatement CallableStatement
		try {
			pstmt=conn.prepareStatement(sql);
			for(int id:ids){
				pstmt.setString(1,flag);
				pstmt.setInt(2,id);
				pstmt.addBatch();
			}

			pstmt.executeBatch();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DB.close(pstmt);
			DB.close(conn);
		}
	}
	
	public List<MessageLog> query(User receiver,Page page){
		Connection conn=DB.getConn();
	
		String sql = "select a.id ,a.is_read,a.del,b.sender,b.id msg_id,b.title,b.content,b.send_time ,b.receiver ,c.name";
		sql+="	from t_message_log a ";
		sql+=" join t_message b on a.message_id=b.id ";
		sql+=" join t_user c on b.sender=c.id ";


		sql += "  where b.sender='"+receiver.getId()+"' and is_del='0'";

				
//		System.out.println(sql);
		page.setRowCount(getRowCount(sql));

		sql += "  order by id desc ";
		sql += " limit ?,?";
		
		PreparedStatement pstmt=null; //PreparedStatement CallableStatement
		ResultSet rs=null;
		List<MessageLog> logs=new ArrayList();
		try {
			pstmt=conn.prepareStatement(sql);
	
			pstmt.setInt(1, page.getStartIndex());
			pstmt.setInt(2, page.getPageSize());
			rs=pstmt.executeQuery();
			while(rs.next()){
				MessageLog log=new MessageLog();
				log.setId(rs.getInt("id"));
				log.setRead(rs.getString("is_read").equals("1")?true:false);
				log.setDel(rs.getString("del").equals("1")?true:false);
				//设置消息的接收着
				log.setReceiver(receiver);
				//设置Message对象
				
				Message m=new Message();
				m.setId(rs.getInt("msg_id"));
				m.setTitle(rs.getString("title"));
				m.setContent(rs.getString("content"));
				m.setSendTime(rs.getTimestamp("send_time"));
				//设置发送者对象
				
				User sender=new User();
				sender.setId(rs.getString("sender"));
				sender.setName(rs.getString("name"));
				
				m.setSender(sender);
				m.setSender(sender);
				m.setReceiver(rs.getString("receiver"));
			
				log.setMessage(m);
				
				
				logs.add(log);
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		
		return logs;
	}
	
	public int getRowCount(String sql){
		Connection conn=DB.getConn();
		String sqlAll = "select count(*) "+sql.substring(sql.indexOf("from"));
//		System.out.println(sqlAll);
		PreparedStatement pstmt=null; //PreparedStatement CallableStatement
		ResultSet rs=null;
		try {
			pstmt=conn.prepareStatement(sqlAll);
			rs=pstmt.executeQuery();
			if(rs.next()){
				return rs.getInt(1);
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		
		return 0;
	}

}
