package _04_Forum.model.dao;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;

import _00_Misc.HibernateUtil_H4_Ver1;
import _02_TripAndJournal.model.JournalVO;
import _02_TripAndJournal.model.MessageVO;
import _04_Forum.model.ForumVO;

public class ForumDAOHibernate {
	//抓討論區之類型分類
		private static final String GET_ALL_FORUMTYPE = "from ForumVO where forumTypeId=:forumTypeId";
		private static final String FIND_BY_MEMBERID = "from ForumVO where memberId=:memberId";
		public List<ForumVO> getForumType(String forumTypeId) {
			List<ForumVO> list = null;
			Session session = HibernateUtil_H4_Ver1.getSessionFactory()
					.getCurrentSession();
			try {
				session.beginTransaction();
				Query query = session.createQuery(GET_ALL_FORUMTYPE);
				query.setParameter("forumTypeId", forumTypeId);
				list = query.list();
				session.getTransaction().commit();
			} catch (RuntimeException ex) {
				session.getTransaction().rollback();
				throw ex;
			}
			return list;
		}
	

	public ForumVO insert(ForumVO forumVO) {
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
		try {
			session.beginTransaction();
			session.save(forumVO);
			session.getTransaction().commit();
			return forumVO;
		} catch (RuntimeException e) {
			session.getTransaction().rollback();
		}
		return forumVO;
	}
	
	public ForumVO update(ForumVO forumVO) {
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
		try {
			session.beginTransaction();
			session.saveOrUpdate(forumVO);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		return forumVO;
	}
	public List<ForumVO> selectByMemberId(Integer memberId){
		List<ForumVO> list = null;
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
		try {
			session.beginTransaction();
			Query query = session.createQuery(FIND_BY_MEMBERID);
			query.setParameter("memberId", memberId);
			list = query.list();
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		return list;
	}
	

	public ForumVO select(Integer forumId) {
		ForumVO forumVO = null;
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
		try {
			session.beginTransaction();
			forumVO = (ForumVO) session.get(ForumVO.class, forumId);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		return forumVO;
	}

	private static final String GET_ALL_STMT = "from ForumVO order by forumTime desc";

	public List<ForumVO> select() {
		List<ForumVO> list = null;
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
		try {
			session.beginTransaction();
			Query query = session.createQuery(GET_ALL_STMT);
			list = query.list();
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		return list;
	}

	public boolean delete(Integer forumId) {
		Session session = null;
		session = HibernateUtil_H4_Ver1.getSessionFactory().getCurrentSession();
		session.beginTransaction();
		Query query = session
				.createQuery("delete from ForumVO where forumId=?");
		query.setParameter(0, forumId);
		int delete = query.executeUpdate();
		if (delete != 0) {
			session.getTransaction().commit();
			return true;
		} else {
			session.getTransaction().rollback();
			return false;
		}
	}
}
