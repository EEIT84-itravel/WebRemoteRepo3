package _02_TripAndJournal.model.dao;

import java.util.List;

import _00_Misc.HibernateUtil_H4_Ver1;
import _02_TripAndJournal.model.JournalVO;

import org.hibernate.Query;
import org.hibernate.Session;

public class JournalDAOHibernate {

	// 單筆查詢
	public JournalVO select(int journal_id) {
		JournalVO vo = null;
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
		try {
			session.beginTransaction();
			vo = (JournalVO) session.get(JournalVO.class, journal_id);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.beginTransaction().rollback();
		}
		return vo;
	}

	// 查全部
	public List<JournalVO> select() {
		List<JournalVO> result = null;
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
		try {
			session.beginTransaction();
			Query query = session.createQuery("from JournalVO");
			result = query.list();
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		return result;
	}

	// 修改資料
	public JournalVO update(JournalVO vo) {
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

	// 新增資料
	public JournalVO insert(JournalVO vo) {
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
		try {
			session.beginTransaction();
			session.save(vo);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		return vo;
	}

	// 刪除資料
	public boolean delete(Integer JournalId) {
		if (this.select(JournalId) != null) {
			Session session = HibernateUtil_H4_Ver1.getSessionFactory()
					.getCurrentSession();
			try {
				session.beginTransaction();
				JournalVO vo = (JournalVO) session.get(JournalVO.class,
						JournalId);
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
