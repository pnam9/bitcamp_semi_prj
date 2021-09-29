package dto;

import java.io.Serializable;

public class MemberDto implements Serializable{
	
	private String id;
	private String pwd;
	private String name;
	private String birth;
	private String gender;
	private String email;
	private String addr;
	private int auth;	//3.일반회원 1.관리자

public MemberDto() {
	
}

public MemberDto(String id, String pwd, String name, String birth, String gender, String email, String addr, int auth) {
	super();
	this.id = id;
	this.pwd = pwd;
	this.name = name;
	this.birth = birth;
	this.gender = gender;
	this.email = email;
	this.addr = addr;
	this.auth = auth;
}

public String getId() {
	return id;
}

public void setId(String id) {
	this.id = id;
}

public String getPwd() {
	return pwd;
}

public void setPwd(String pwd) {
	this.pwd = pwd;
}

public String getName() {
	return name;
}

public void setName(String name) {
	this.name = name;
}

public String getBirth() {
	return birth;
}

public void setBirth(String birth) {
	this.birth = birth;
}

public String getGender() {
	return gender;
}

public void setGender(String gender) {
	this.gender = gender;
}

public String getEmail() {
	return email;
}

public void setEmail(String email) {
	this.email = email;
}

public String getAddr() {
	return addr;
}

public void setAddr(String addr) {
	this.addr = addr;
}

public int getAuth() {
	return auth;
}

public void setAuth(int auth) {
	this.auth = auth;
}

@Override
public String toString() {
	return "MemberDto [id=" + id + ", pwd=" + pwd + ", name=" + name + ", birth=" + birth + ", gender=" + gender
			+ ", email=" + email + ", addr=" + addr + ", auth=" + auth + "]";
}

}