package org.mm.model;

public class MessageLog {
	
	private int id;
	private Message message;
	private User Receiver;
	private boolean read;
	private boolean del;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public Message getMessage() {
		return message;
	}
	public void setMessage(Message message) {
		this.message = message;
	}
	public User getReceiver() {
		return Receiver;
	}
	public void setReceiver(User receiver) {
		Receiver = receiver;
	}
	public boolean isRead() {
		return read;
	}
	public void setRead(boolean read) {
		this.read = read;
	}
	public boolean isDel() {
		return del;
	}
	public void setDel(boolean del) {
		this.del = del;
	}
	
}
