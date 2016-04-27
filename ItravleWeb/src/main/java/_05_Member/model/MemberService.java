package _05_Member.model;

import java.util.ArrayList;
import java.util.List;

import _05_Member.model.dao.MemberDAOHibernate;

public class MemberService {
	private MemberDAOHibernate memberDAO = new MemberDAOHibernate();

	public MemberVO login(String memberAccount, String password) {
		List<MemberVO> bean = new ArrayList<MemberVO>();
		 bean = memberDAO.findByAccount(memberAccount);
		 MemberVO memberbean = new MemberVO();
		 if(bean != null &&bean.size()>0){
		 memberbean = bean.get(0);
		 }else{
			 memberbean = null;
		 }
		if (bean != null &&!bean.isEmpty()) {
			String pass = memberbean.getPassword();
			if (pass.equals(password)) {
				System.out.println("Success");
				return memberbean;
			}
			System.out.println("失敗");
			return null;
	 }
	 System.out.println("false");
	 return null;
 }
 public boolean registered(MemberVO membervo){ //註冊會員資料
	 if(membervo != null){
	memberDAO.insert(membervo);
	return true;
	 }
	 return false;
 }
 public boolean modify(MemberVO membervo){ //修改會員資料
	 if(membervo != null){
			memberDAO.update(membervo);
			return true;
			 }
			 return false;
	 
 }
 public List<MemberVO> selectAll(String memberAccount){
	 return memberDAO.findByAccount(memberAccount);
 }
	// ELjoin時使用
public List<MemberVO> getAll() {
	 return memberDAO.getall();
 }
 public List<MemberVO> selectAllByCellphone(String cellphone){
	 return memberDAO.findByCellphone(cellphone);
 }
 public MemberVO selectById(Integer memberId){
	 return memberDAO.findByPrimaryKey(memberId);
 }

}
