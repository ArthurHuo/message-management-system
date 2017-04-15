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

public class MessageLogDao {
	
	public void save(MessageLog log) {
		Connection conn = DB.getConn();

		String sql = "insert into t_message_log(message_id,receiver,is_read,del) values(?,?,'0','0')";

		PreparedStatement pstmt = null;

		try {
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, log.getMessage().getId());
			pstmt.setString(2, log.getReceiver().getId());

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
	
	public int getRowCount(String sql,String title){
		Connection conn=DB.getConn();
		String sqlAll = "select count(*) "+sql.substring(sql.indexOf("from"));
				
		PreparedStatement pstmt=null; //PreparedStatement CallableStatement
		ResultSet rs=null;
		try {
			pstmt=conn.prepareStatement(sqlAll);
			pstmt.setString(1, "%"+title+"%");
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
	
	public List<MessageLog> query(User receiver ,Page page, String title){
		Connection conn=DB.getConn();
		String sql = "select a.id ,a.is_read,a.del,b.sender,b.id msg_id,b.title,b.content,b.send_time ,b.receiver ,c.name";
		sql+="	from t_message_log a ";
		sql+=" join t_message b on a.message_id=b.id ";
		sql+=" join t_user c on b.sender=c.id ";

		switch(page.getMode()){
			case LIST:sql += "  where a.receiver='"+receiver.getId()+"' and title like ? "; break;
			case RECEIVE:sql += "  where a.receiver='"+receiver.getId()+"' and title like ?  and is_read='0' and del='0' "; break;
			case INBOX:sql += "  where a.receiver='"+receiver.getId()+"' and title like ? and del='0'"; break;
			case OUTBOX:sql += "  where a.receiver='"+receiver.getId()+"' and title like ? and del='1'"; break;
		}
				
//		System.out.println(sql);
		page.setRowCount(getRowCount(sql,title));
		sql += "  order by id desc ";
		sql += " limit ?,?";
		
		PreparedStatement pstmt=null; //PreparedStatement CallableStatement
		ResultSet rs=null;
		List<MessageLog> logs=new ArrayList();
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, "%"+title+"%");
			pstmt.setInt(2, page.getStartIndex());
			pstmt.setInt(3, page.getPageSize());
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
	
	public void updateDelFlag(int[] ids,String flag){
		Connection conn=DB.getConn();
		String sql = "update t_message_log set del=? where id=?";
		
		
		
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
	
	public void delete(int[] ids){
		Connection conn=DB.getConn();
		String sql = "delete from  t_message_log  where id=?";
		
		
		
		PreparedStatement pstmt=null; //PreparedStatement CallableStatement
		try {
			pstmt=conn.prepareStatement(sql);
			for(int id:ids){
				pstmt.setInt(1,id);
				pstmt.addBatch();//添加到一批中
			}
			//统一执行，批处理，提高数据更新效率
			//原来多次连接化解为一次连接
			pstmt.executeBatch();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DB.close(pstmt);
			DB.close(conn);
		}
	}
	
	public void updateReadFlag(int id,String flag){
		Connection conn=DB.getConn();
		String sql = "update t_message_log set is_read=? where id=?";
		
		
		
		PreparedStatement pstmt=null; //PreparedStatement CallableStatement
		try {
			pstmt=conn.prepareStatement(sql);
			
				pstmt.setString(1,flag);
				pstmt.setInt(2,id);
				
			
			
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DB.close(pstmt);
			DB.close(conn);
		}
	}
	
	public MessageLog get(int id){
		Connection conn=DB.getConn();
		String sql = "select a.id ,a.is_read,a.del,b.sender,b.id msg_id,b.title,b.content,b.send_time ,b.receiver ,c.name";
		sql+="	from t_message_log a ";
		sql+=" join t_message b on a.message_id=b.id ";
		sql+=" join t_user c on b.sender=c.id ";
		
		sql+=" where a.id=? ";
			
		PreparedStatement pstmt=null; //PreparedStatement CallableStatement
		ResultSet rs=null;
		MessageLog log=null;
		try {
			pstmt=conn.prepareStatement(sql);
			
			pstmt.setInt(1, id);
			rs=pstmt.executeQuery();
			if(rs.next()){
				log=new MessageLog();
				log.setId(rs.getInt("id"));
				log.setRead(rs.getString("is_read").equals("1")?true:false);
				log.setDel(rs.getString("del").equals("1")?true:false);
				
				
				Message m=new Message();
				m.setId(rs.getInt("msg_id"));
				m.setTitle(rs.getString("title"));
				m.setContent(rs.getString("content"));
				m.setSendTime(rs.getTimestamp("send_time"));

				
				User sender=new User();
				sender.setId(rs.getString("sender"));
				sender.setName(rs.getString("name"));
				
				m.setSender(sender);
				m.setSender(sender);
				m.setReceiver(rs.getString("receiver"));
			
				log.setMessage(m);
				
				
				
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			DB.close(rs);
			DB.close(pstmt);
			DB.close(conn);
		}
		
		return log;
	}
	
}
