package _05_Member.model.dao;

import org.hibernate.Query;
import org.hibernate.Session;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.*;

import _00_Misc.HibernateUtil_H4_Ver1;
import _05_Member.model.MemberVO;

public class MemberDAOHibernate {

	private static final String GET_ALL_STMT = "from MemberVO order by memberId";
	private static final String FIND_BY_ACCOUNT = "from MemberVO where memberAccount=:memberAccount";
	MemberVO memberVO = null;


	public MemberVO findByPrimaryKey(Integer memberId) {

		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();

		try {
			session.beginTransaction();
			memberVO = (MemberVO) session.get(MemberVO.class, memberId);
			session.getTransaction().commit();
		} catch (RuntimeException e) {
			session.getTransaction().rollback();
			throw e;
		}

		return memberVO;
	}
	
    public List<MemberVO> findByAccount(String memberAccount){
    	List<MemberVO> list = null;
    	Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
    	try {
			session.beginTransaction();
			Query query = session.createQuery(FIND_BY_ACCOUNT);
			query.setParameter("memberAccount", memberAccount);
		    list = query.list();	
			session.getTransaction().commit();
		} catch (RuntimeException e) {
			session.getTransaction().rollback();
			throw e;
		}	
    	return list;
    }

	public MemberVO insert(MemberVO memberVO) {
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
		try {
			session.beginTransaction();
			session.save(memberVO);
			session.getTransaction().commit();
		} catch (RuntimeException e) {
			session.getTransaction();
			throw e;
		}
		return memberVO;
	}

	
	public MemberVO update(MemberVO memberVO) {
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();

		try {
			session.beginTransaction();
			session.update(memberVO);
			session.getTransaction().commit();
		} catch (RuntimeException e) {
			session.getTransaction().rollback();
			throw e;
		}
		return memberVO;
		
	}

	
	public boolean delete(Integer memberId) {
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();

		try {
			session.beginTransaction();
			MemberVO memberVO = new MemberVO();
			memberVO.setMemberId(memberId);
			session.delete(memberVO);
			session.getTransaction().commit();
			return true;
		} catch (RuntimeException e) {
			session.getTransaction().rollback();
			return false;
		}
	}

	public List<MemberVO> getall() {
		List<MemberVO> list = null;
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();

		try {
			session.beginTransaction();
			Query query = session.createQuery(GET_ALL_STMT);
			list = query.list();
			session.getTransaction().commit();
		} catch (RuntimeException e) {
			session.getTransaction().rollback();
			throw e;
		}
		return list;
	}

	public static void main(String[] args) throws IOException {

		MemberDAOHibernate dao = new MemberDAOHibernate();
		// selectAll
		// List <MemberVO> list = dao.getall();
		// for(MemberVO aMember: list ){
		// System.out.println(aMember);
		// }

		// select  by id
		// MemberVO res = dao.findByPrimaryKey(1);
		// System.out.println(res);
		// select  by 帳號
		// MemberVO res = dao.findByAccount("a12345");
		// System.out.println(res);
		// update
		// MemberVO res = dao.findByPrimaryKey(6);
		// res.setMemberAccount("a123456");
		// dao.update(res);
		// System.out.println(res);

		// insert
		// MemberVO res = dao.findByPrimaryKey(1);
		// dao.insert(res);
		// System.out.println(res);
		
		//insert photo
		// File imageFile = new File("src/main/resources/img/candy.jpg");
		// InputStream is = new FileInputStream(imageFile);
		// byte[] p = new byte[is.available()];
		// is.read(p);
		// is.close();
		// MemberVO res = dao.findByPrimaryKey(1);
		// res.setPhoto(p);
		// System.out.println(dao.insert(res));
		
		// delete
		//dao.delete(6);
		
		//用帳號查一筆會員
		// List<MemberVO> list = dao.findByAccount("a12345");
		// for(MemberVO member : list){
		// System.out.println(member);
		// }
	}

}
