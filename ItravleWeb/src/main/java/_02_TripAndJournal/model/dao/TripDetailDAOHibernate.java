package _02_TripAndJournal.model.dao;

import java.util.Iterator;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;

import _00_Misc.HibernateUtil_H4_Ver1;
import _02_TripAndJournal.model.TripDetailVO;

public class TripDetailDAOHibernate {

	public TripDetailVO select(Integer tdetailId) {
		TripDetailVO tripDetailVO = null;
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
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
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
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
	
	public boolean insert(List<TripDetailVO> tripDetailVOs) {
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
		try {
			session.beginTransaction();
			Iterator<TripDetailVO> it = tripDetailVOs.iterator();
			while (it.hasNext()) {
				TripDetailVO tripDetailVO = it.next();
				session.save(tripDetailVO);
				System.out.println("insert 成功");
			}			
			session.getTransaction().commit();
		} catch (RuntimeException e) {
			session.getTransaction().rollback();
			return false;			
		}
		return true;
	}
	


	public TripDetailVO update(TripDetailVO tripDetailVO) {
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
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
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
		try {
			session.beginTransaction();
			TripDetailVO tripDetailVO = (TripDetailVO) session.get(
					TripDetailVO.class, tdetailId);
			session.delete(tripDetailVO);
			session.getTransaction().commit();
			return true;
		} catch (RuntimeException e) {
			session.getTransaction().rollback();
		}
		return false;
	}

	public List<TripDetailVO> select() {
		List<TripDetailVO> list = null;
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
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

	private static final String SELECT_BY_TRIPID = "from TripDetailVO where tripId=:tripId";

	public List<TripDetailVO> select(int tripId) {
		List<TripDetailVO> list = null;
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
		try {
			session.beginTransaction();
			Query query = session.createQuery(SELECT_BY_TRIPID);
			query.setParameter("tripId", tripId);
			list = query.list();
			session.getTransaction().commit();
		} catch (Exception e) {
			session.getTransaction().rollback();
			e.printStackTrace();
		}
		return list;
	}
}
