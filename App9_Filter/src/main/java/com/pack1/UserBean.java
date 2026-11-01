package com.pack1;

import java.io.Serializable;

public class UserBean implements Serializable{
	private String uname;
	private String upwd;
	private String ufname;
	private String ulname;
	private String umailid;
	private String upnone;
	
	public UserBean() {
		
	}
	public String getUname() {
		return uname;
	}
	public void setUname(String uname) {
		this.uname = uname;
	}
	public String getUpwd() {
		return upwd;
	}
	public void setUpwd(String upwd) {
		this.upwd = upwd;
	}
	public String getUfname() {
		return ufname;
	}
	public void setUfname(String ufname) {
		this.ufname = ufname;
	}
	public String getUlname() {
		return ulname;
	}
	public void setUlname(String ulname) {
		this.ulname = ulname;
	}
	public String getUmailid() {
		return umailid;
	}
	public void setUmailid(String umailid) {
		this.umailid = umailid;
	}
	public String getUpnone() {
		return upnone;
	}
	public void setUpnone(String upnone) {
		this.upnone = upnone;
	}
	
}
