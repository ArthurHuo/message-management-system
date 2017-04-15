package org.mm.model;

import org.mm.utils.MessageListMode;

public class Page {
	private int pageNo = 1;
	private int pageSize = 2;
	private int rowCount;
	private int pageSum;
	private MessageListMode mode = MessageListMode.RECEIVE;
	
	public MessageListMode getMode() {
		return mode;
	}
	public void setMode(MessageListMode mode) {
		this.mode = mode;
	}
	public int getPageNo() {
		return pageNo;
	}
	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public int getRowCount() {
		return rowCount;
	}
	public void setRowCount(int rowCount) {
		this.rowCount = rowCount;
		this.pageSum = (this.rowCount%this.pageSize == 0)?(this.rowCount/this.pageSize):(this.rowCount/this.pageSize+1);
		if(this.pageNo>this.pageSum ){
			this.pageNo=this.pageSum;
			
		}
		if(this.pageSum<=0){
			this.pageNo=1;
		}
	}
	public int getPageSum() {
		return pageSum;
	}
	public void setPageSum(int pageSum) {
		this.pageSum = pageSum;
	}
	public int getStartIndex(){
		return (this.pageNo-1)*this.pageSize;
	}
}
