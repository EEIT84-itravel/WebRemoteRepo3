package _05_Member.model.dao;

import org.hibernate.Query;
import org.hibernate.Session;
import java.util.*;

import _00_Misc.HibernateUtil_H4_Ver1;
import _05_Member.model.MemberVO;

public class MemberDAOHibernate {

	private static final String GET_ALL_STMT = "from MemberVO order by memberId";
	private static final String FIND_BY_ACCOUNT = "from MemberVO where memberAccount=:memberAccount";
	private static final String FIND_BY_CELLPHONE = "from MemberVO where cellphone=:cellphone";
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
    public List<MemberVO> findByCellphone(String cellphone){
    	List<MemberVO> list = null;
    	Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
    	try {
			session.beginTransaction();
			Query query = session.createQuery(FIND_BY_CELLPHONE);
			query.setParameter("cellphone", cellphone);
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
}
