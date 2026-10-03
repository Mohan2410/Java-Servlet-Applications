package com.bean;

import java.io.Serializable;

public class EmpBean implements Serializable{
	private String empid;
	private String empfname;
	private String emplname;
	private int esal;
	private String eaddr;
	
	public EmpBean() {
		
	}

	public String getEmpid() {
		return empid;
	}

	public void setEmpid(String empid) {
		this.empid = empid;
	}

	public String getEmpfname() {
		return empfname;
	}

	public void setEmpfname(String empfname) {
		this.empfname = empfname;
	}

	public String getEmplname() {
		return emplname;
	}

	public void setEmplname(String emplname) {
		this.emplname = emplname;
	}

	public int getEsal() {
		return esal;
	}

	public void setEsal(int esal) {
		this.esal = esal;
	}

	public String getEaddr() {
		return eaddr;
	}

	public void setEaddr(String eaddr) {
		this.eaddr = eaddr;
	}
}
