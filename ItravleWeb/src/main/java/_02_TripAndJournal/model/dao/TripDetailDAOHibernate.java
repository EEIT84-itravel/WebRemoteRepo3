package _02_TripAndJournal.model.dao;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;

import _00_Misc.HibernateUtil_H4_Ver1;
import _02_TripAndJournal.model.TripDetailVO;

public class TripDetailDAOHibernate {

	public static void main(String[] args) {
		TripDetailDAOHibernate dao = new TripDetailDAOHibernate();
		// TripDetailVO bean = dao.select(1);//Select
		// System.out.println(bean);

		// TripDetailVO bean = new TripDetailVO();
		// bean.setTdetailId(9);// Update保留 Insert不用
		// bean.setTripId(1);
		// bean.setTripOrder(4);
		// bean.setStayTime(java.sql.Time.valueOf("12:15:30"));
		// bean.setWhichDay(2);
		// bean.setReferenceType("type_id02");
		// bean.setReferenceNo(2);
		// bean.setNotes("交通時間:約20分鐘");
		// bean.setSightBudget(java.math.BigDecimal.valueOf(0));
		// System.out.println(dao.update(bean));

		// boolean b = dao.delete(9);// Delete
		// System.out.println(b);

		List<TripDetailVO> bean = dao.select();
		for (int i = 0; i < bean.size(); i++) {
			System.out.println(bean.get(i));
		}
	}

	public TripDetailVO select(Integer tdetailId) {
		TripDetailVO tripDetailVO = null;
		Session session = HibernateUtil_H4_Ver1.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			tripDetailVO = (TripDetailVO) session.get(TripDetailVO.class,
					tdetailId);
			session.getTransaction().commit();
		} catch (RuntimeException e) {
			session.getTransaction().rollback();
			throw e;
		}
		return tripDetailVO;
	}

	public TripDetailVO insert(TripDetailVO tripDetailVO) {
		Session session = HibernateUtil_H4_Ver1.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			session.save(tripDetailVO);
			session.getTransaction().commit();
		} catch (RuntimeException e) {
			session.getTransaction().rollback();
			throw e;
		}
		return tripDetailVO;
	}

	public TripDetailVO update(TripDetailVO tripDetailVO) {
		Session session = HibernateUtil_H4_Ver1.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			session.update(tripDetailVO);
			session.getTransaction().commit();
		} catch (RuntimeException e) {
			session.getTransaction().rollback();
			throw e;
		}
		return tripDetailVO;
	}

	public boolean delete(Integer tdetailId) {
		boolean b = false;
		Session session = HibernateUtil_H4_Ver1.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			TripDetailVO tripDetailVO = (TripDetailVO) session.get(
					TripDetailVO.class, tdetailId);
			session.delete(tripDetailVO);
			session.getTransaction().commit();
			b = true;
		} catch (RuntimeException e) {
			session.getTransaction().rollback();
			throw e;
		}
		return b;
	}

	public List<TripDetailVO> select() {
		List<TripDetailVO> list = null;
		Session session = HibernateUtil_H4_Ver1.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			Query query = session.createQuery("from TripDetailVO");
			list = query.list();
			session.getTransaction().commit();
		} catch (RuntimeException e) {
			session.getTransaction().rollback();
			throw e;
		}
		return list;
	}
}
