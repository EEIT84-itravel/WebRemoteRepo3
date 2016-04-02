package _02_TripAndJournal.model.dao;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import _00_Misc.HibernateUtil_H4_Ver1;
import _02_TripAndJournal.model.JournalVO;

import org.hibernate.Query;
import org.hibernate.Session;

public class JournalDAOHibernate {

	public static void main(String[] args) {
		JournalDAOHibernate dao = new JournalDAOHibernate();
		// System.out.println(dao.select(1));
		// List<JournalVO> vo = dao.select();
		// System.out.println(vo);
		JournalVO bean = new JournalVO();
		bean.setJournalId(7);
		bean.setMemberId(3);
		bean.setJournalName("呵呵哈哈ㄏff f f f f f ");
		bean.setJournalIntro("今天天氣很溫和，很適");
		bean.setBeginTime(new java.sql.Date(0));
		bean.setEndTime(java.sql.Date.valueOf("2016-01-25"));
		bean.setRegionId("region02");
		bean.setVisitorNum(1);
		java.util.Date now = new Date();
		long nowtime = now.getTime();
		java.sql.Date rightnow = new java.sql.Date(nowtime);
		java.sql.Timestamp timestamp = new Timestamp(new Date().getTime());
		bean.setModifyTime(timestamp);
		// System.out.println(dao.insert(bean));
		System.out.println(dao.update(bean));

		// dao.delete(10);

	}

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
