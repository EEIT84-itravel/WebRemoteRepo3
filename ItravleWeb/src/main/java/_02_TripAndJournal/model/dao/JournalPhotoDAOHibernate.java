package _02_TripAndJournal.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;

import _00_Misc.HibernateUtil_H4_Ver1;
import _02_TripAndJournal.model.JournalDetailVO;
import _02_TripAndJournal.model.JournalPhotoVO;

public class JournalPhotoDAOHibernate {

	public JournalPhotoVO select(Integer journalPhotoId) {
		JournalPhotoVO vo = null;
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
		try {
			session.beginTransaction();
			vo = (JournalPhotoVO) session.get(JournalPhotoVO.class,
					journalPhotoId);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.beginTransaction().rollback();
		}
		return vo;
	}

	// 由遊記明細編號搜尋遊記照片
	private static final String SELECT_BY_JOURNALDETAILID = "from JournalPhotoVO where journalDetailId=:journalDetailId";

	public List<JournalPhotoVO> selectByJournalDetailId(int journalDetailId) {
		List<JournalPhotoVO> result = null;
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
		try {
			session.beginTransaction();
			Query query = session.createQuery(SELECT_BY_JOURNALDETAILID);
			query.setParameter("journalDetailId", journalDetailId);
			result = query.list();
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		return result;
	}

	// 查詢遊記主圖
	public JournalPhotoVO selectCover(List<JournalDetailVO> journalDetailVOs) {
		JournalPhotoVO result = null;
		for (JournalDetailVO vo : journalDetailVOs) {
			List<JournalPhotoVO> temps = selectByJournalDetailId(vo
					.getJournalDetailId());
			for (JournalPhotoVO temp : temps) {
				if (temp.getCover()) {
					result = temp;
				}
			}
		}
		return result;
	}

	public List<JournalPhotoVO> select() {
		List<JournalPhotoVO> result = null;
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
		try {
			session.beginTransaction();
			Query query = session.createQuery("from JournalPhotoVO");
			result = query.list();
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		return result;
	}

	// 修改資料
	public JournalPhotoVO update(JournalPhotoVO vo) {
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
	public JournalPhotoVO insert(JournalPhotoVO vo) {
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
	public boolean delete(Integer journalPhotoId) {
		if (this.select(journalPhotoId) != null) {
			Session session = HibernateUtil_H4_Ver1.getSessionFactory()
					.getCurrentSession();
			try {
				session.beginTransaction();
				JournalPhotoVO vo = (JournalPhotoVO) session.get(
						JournalPhotoVO.class, journalPhotoId);
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
