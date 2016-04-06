package _05_Member.model.dao;

import org.hibernate.Query;
import org.hibernate.Session;

import java.util.*;

import _00_Misc.HibernateUtil_H4_Ver1;
import _05_Member.model.CollectionVO;
import _05_Member.model.FriendVO;

public class FriendDAOHibernate {

	private static final String GET_ALL_STMT = "from  FriendVO order by  friendNo";
	private static final String FIND_BY_MEMBERID = "from FriendVO where memberId=:memberId";
	private static final String FIND_BY_FRIENDID = "from FriendVO where friendId=:friendId";
	private static final String FIND_BY_MEMBERID_AND_FRIENDNO = "from FriendVO where memberId=:memberId and friendId=:friendId";
	FriendVO friendVO = null;

	public FriendVO insert(FriendVO friendVO) {
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();

		try {
			session.beginTransaction();
			session.save(friendVO);
			session.getTransaction().commit();
		} catch (RuntimeException e) {
			session.getTransaction();
			throw e;

		}
		return friendVO;

	}

	public FriendVO update(FriendVO friendVO) {
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();

		try {
			session.beginTransaction();
			session.update(friendVO);
			session.getTransaction().commit();
		} catch (RuntimeException e) {
			session.getTransaction().rollback();
			throw e;

		}
		return friendVO;
	}

	public Boolean delete(Integer FriendNo) {
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();

		try {
			session.beginTransaction();
			FriendVO friendVO = new FriendVO();
			friendVO.setFriendNo(FriendNo);
			session.delete(friendVO);
			session.getTransaction().commit();
			return true;
		} catch (RuntimeException e) {
			session.getTransaction().rollback();
			return false;
		}
	}

	public FriendVO findByPrimaryKey(Integer FriendNo) {
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
		try {
			session.beginTransaction();
			friendVO = (FriendVO) session.get(FriendVO.class, FriendNo);
			session.getTransaction().commit();
		} catch (RuntimeException e) {
			session.getTransaction().rollback();
			throw e;
		}
		return friendVO;
	}

	public List<FriendVO> selectbyMemberId(Integer memberId){
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
		List<FriendVO> list = null;
		try {
			session.beginTransaction();
			Query query = session.createQuery(FIND_BY_MEMBERID);
			query.setParameter("memberId", memberId);
		    list = query.list();	
			session.getTransaction().commit();
		} catch (RuntimeException e) {
			session.getTransaction().rollback();
			throw e;
		}	
		return list;
	}

	public List<FriendVO> selectbyMemberIdAndFriendId(Integer memberId,Integer friendId){
		List<FriendVO> list = null;
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
		try {
			session.beginTransaction();
			Query query = session.createQuery(FIND_BY_MEMBERID_AND_FRIENDNO);
			query.setParameter("memberId", memberId);
			query.setParameter("friendId", friendId);
		    list = query.list();	
			session.getTransaction().commit();
		} catch (RuntimeException e) {
			session.getTransaction().rollback();
			throw e;
		}	
		return list;
	}
	public List<FriendVO> selectbyFriendId(Integer memberId){
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
		List<FriendVO> list = null;
		try {
			session.beginTransaction();
			Query query = session.createQuery(FIND_BY_FRIENDID);
			query.setParameter("friendId", memberId);
		    list = query.list();	
			session.getTransaction().commit();
		} catch (RuntimeException e) {
			session.getTransaction().rollback();
			throw e;
		}	
		return list;
	}
	
	public List<FriendVO> getall() {
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();

		List<FriendVO> list = null;
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
	
	public ArrayList<Integer>  findFriendToId(Integer memberId){ 
		List<FriendVO> list = this.selectbyFriendId(memberId);
		 ArrayList<Integer> listname = new ArrayList<Integer>();
		 if(list!=null){
			// System.out.println("Success");
			 for(int i = 0; i < list.size();i++){
				 if(list.get(i).getIsfriend() == true){
				 int a = list.get(i).getMemberId();
				 listname.add(a);
				 }
			 }
			 return listname;
		 }
		 System.out.println("false");
		 return null;
		
	}
	public static void main(String[] args) {

		FriendDAOHibernate dao = new FriendDAOHibernate();
		// selectAll
		// List <FriendVO> list = dao.getall();
		// for(FriendVO aMember: list ){
		// System.out.println(aMember);
		// }

		// select
		// FriendVO res = dao.findByPrimaryKey(1);
		// System.out.println(res);
		
		//從帳號與好友(會員)編號找到該筆資料的好友編號
		// List<FriendVO> res = dao.selectbyMemberIdAndFriendId(1,4);
		// for(FriendVO friend : res){
		// System.out.println(friend);
		// }
		// update
		// FriendVO res = dao.findByPrimaryKey(6);
		// res.setFriendId(3);
		// dao.update(res);
		// System.out.println(res);

		// insert
		// FriendVO res = dao.findByPrimaryKey(1);
		// dao.insert(res);
		//FriendVO res1 = dao.findByPrimaryKey(5);
		//System.out.println(res1);

		// delete
		// System.out.println(dao.delete(13));

	}
}
