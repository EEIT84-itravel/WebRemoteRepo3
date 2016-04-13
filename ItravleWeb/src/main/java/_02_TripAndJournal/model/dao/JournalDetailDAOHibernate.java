package _02_TripAndJournal.model.dao;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;

import _00_Misc.HibernateUtil_H4_Ver1;
import _02_TripAndJournal.model.JournalDetailVO;

public class JournalDetailDAOHibernate {

	// 單筆查詢
	public JournalDetailVO select(Integer journalDetailId) {
		JournalDetailVO vo = null;
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
		try {
			session.beginTransaction();
			vo = (JournalDetailVO) session.get(JournalDetailVO.class,
					journalDetailId);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.beginTransaction().rollback();
			throw ex;
		}
		return vo;
	}

	// 查全部
	public List<JournalDetailVO> select() {
		List<JournalDetailVO> result = null;
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
		try {
			session.beginTransaction();
			Query query = session.createQuery("from JournalDetailVO");
			result = query.list();
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		return result;
	}
	
	//由遊記編號搜尋遊記明細
	private static final String SELECT_BY_JOURNALID="from JournalDetailVO where journalId=:journalId";
	public List<JournalDetailVO> selectByJournalId(int journalId) {
		List<JournalDetailVO> result = null;
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
		try {
			session.beginTransaction();
			Query query = session.createQuery(SELECT_BY_JOURNALID);
			query.setParameter("journalId", journalId);
			result = query.list();
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		return result;
	}
	

	// 修改資料
	public JournalDetailVO update(JournalDetailVO vo) {
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
		try {
			session.beginTransaction();
			session.update(vo);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		return vo;
	}

	// 新增資料
	public JournalDetailVO insert(JournalDetailVO vo) {
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
		try {
			session.beginTransaction();
			session.saveOrUpdate(vo);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		return vo;
	}

	// 刪除資料
	public boolean delete(int journalDetailId) {
		if (this.select(journalDetailId) != null) {
			Session session = HibernateUtil_H4_Ver1.getSessionFactory()
					.getCurrentSession();
			try {
				session.beginTransaction();
				JournalDetailVO vo = (JournalDetailVO) session.get(
						JournalDetailVO.class, journalDetailId);
				session.delete(vo);
				session.getTransaction().commit();
			} catch (RuntimeException ex) {
				session.getTransaction().rollback();
				throw ex;
			}
			return true;
		} else {
			return false;
		}
	}

}
