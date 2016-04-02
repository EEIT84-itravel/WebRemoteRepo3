package _04_Forum.model.dao;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;

import _00_Misc.HibernateUtil_H4_Ver1;
import _04_Forum.model.ForumVO;

public class ForumDAOHibernate {

	public static void main(String[] args) {

		ForumDAOHibernate dao = new ForumDAOHibernate();
		// select
		// ForumVO res = dao.select(1);
		// System.out.println(res);

		// selectAll
		 List<ForumVO> codes = dao.select();
		 for (ForumVO detail : codes) {
		 System.out.println(detail);
		 }

		// update
		// java.sql.Timestamp timestamp = new Timestamp( new Date().getTime());
		// ForumVO forumVO = dao.update(9, "forum_type06", "主題飲食", 2, timestamp,
		// "這是一篇類型為飲食的討論區文章", 666, 111);
		// System.out.println(forumVO);

		// insert
		// ForumVO f1 = new ForumVO();
		// f1.setForumTypeId("forum_type06");
		// f1.setForumTopic("主題飲食");
		// f1.setMemberId(4);
		// f1.setForumContent("這是一篇類型為飲食的討論區文章");
		// f1.setVisitorNum(666);
		// f1.setReplyNum(123);
		// ForumVO forumVO = dao.insert(f1);
		// System.out.println(forumVO);

		// delete
		System.out.println(dao.delete(6));
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
			return null;
		} finally {
			session.close();
		}
	}

	public ForumVO update(Integer forumId, String forumTypeId,
			String forumTopic, Integer memberId, java.sql.Timestamp forumTime,
			String forumContent, Integer visitorNum, Integer replyNum) {
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
		try {
			session.beginTransaction();
			ForumVO forumVO = (ForumVO) session.get(ForumVO.class, forumId);
			if (forumVO != null) {
				forumVO.setForumTypeId(forumTypeId);
				forumVO.setForumTopic(forumTopic);
				forumVO.setMemberId(memberId);
				forumVO.setForumTime(forumTime);
				forumVO.setForumContent(forumContent);
				forumVO.setVisitorNum(visitorNum);
				forumVO.setReplyNum(replyNum);
			}
			session.getTransaction().commit();
			return forumVO;
		} catch (RuntimeException e) {
			session.getTransaction().rollback();
			return null;
		} finally {
			session.close();
		}
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

	private static final String GET_ALL_STMT = "from ForumVO order by forumId";

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
