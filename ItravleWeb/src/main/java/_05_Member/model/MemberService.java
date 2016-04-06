package _05_Member.model;


import java.util.List;

import _05_Member.model.dao.MemberDAOHibernate;

public class MemberService {
  private MemberDAOHibernate memberVo= new MemberDAOHibernate();
	public static void main(String[] args) {  //測試程式
		MemberService sercive = new MemberService();
		MemberVO bean = sercive.login("b12345", "222");
	}
 public MemberVO login(String memberAccount,String password){
	 List<MemberVO> bean = memberVo.findByAccount(memberAccount);
	 MemberVO memberbean = bean.get(0);
	 if(bean!=null){
		 String pass = memberbean.getPassword();
		 if(pass.equals(password)) {
			 System.out.println("Success");
				return memberbean;
			}
	 }
	 System.out.println("false");
	 return null;
 }
	
}
