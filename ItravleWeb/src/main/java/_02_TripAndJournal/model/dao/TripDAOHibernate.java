package _02_TripAndJournal.model.dao;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;

import _00_Misc.HibernateUtil_H4_Ver1;
import _02_TripAndJournal.model.TripVO;

public class TripDAOHibernate {
		// 照瀏覽人次排序
		public List<TripVO> selectOrderByWatch() {
			List<TripVO> list = null;
			Session session = HibernateUtil_H4_Ver1.getSessionFactory().getCurrentSession();
			try {
				session.beginTransaction();
				Query query = session.createQuery("from TripVO order by watchNum desc");
				list = query.list();
				session.getTransaction().commit();
			} catch (RuntimeException e) {
				session.getTransaction().rollback();
				throw e;
			}
			return list;
		}
	
	

	// selectFromMemberID
	private String SELECT_FROM_MEMBERID = "from TripVO where memberId=:memberId";

	public List<TripVO> selectFromMember(Integer memberId) {
		List<TripVO> result = null;
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
		try {
			session.beginTransaction();
			Query query = session.createQuery(SELECT_FROM_MEMBERID);
			query.setParameter("memberId", memberId);
			result = query.list();
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}

		return result;
	}

	// select
	public TripVO select(Integer tripId) {
		TripVO tripVO = null;
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
		try {
			session.beginTransaction();
			tripVO = (TripVO) session.get(TripVO.class, tripId);
			session.getTransaction().commit();
		} catch (RuntimeException e) {
			session.getTransaction().rollback();
			throw e;
		}
		return tripVO;
	}

	// select datediff
	private final String SELECT_DATE_DIFF = "SELECT DateDiff(Day,trip_start_date,trip_end_date)+1 FROM trip where trip_id = ?";

	public int selectDateDiff(Integer tripId) {
		int result;
		List<Integer> list = null;
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
		try {
			session.beginTransaction();
			SQLQuery query = session.createSQLQuery(SELECT_DATE_DIFF);
			query.setParameter(0, tripId);
			list = query.list();
			result = list.get(0);
			session.getTransaction().commit();
		} catch (RuntimeException e) {
			session.getTransaction().rollback();
			throw e;
		}
		return result;
	}

	// insert
	public TripVO insert(TripVO tripVO) {
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
		try {
			session.beginTransaction();
			session.save(tripVO);
			session.getTransaction().commit();
		} catch (RuntimeException e) {
			session.getTransaction().rollback();
			throw e;
		}
		return tripVO;
	}

	// update
	public TripVO update(TripVO tripVO) {
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
		try {
			session.beginTransaction();
			session.update(tripVO);
			session.getTransaction().commit();
		} catch (RuntimeException e) {
			session.getTransaction().rollback();
			throw e;
		}
		return tripVO;
	}

	// delete
	public boolean delete(Integer tripId) {
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
		try {
			session.beginTransaction();
			TripVO tripVO = (TripVO) session.get(TripVO.class, tripId);
			session.delete(tripVO);
			session.getTransaction().commit();
			return true;
		} catch (RuntimeException e) {
			session.getTransaction().rollback();
		}
		return false;
	}

	// select all
	public List<TripVO> select() {
		List<TripVO> list = null;
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
		try {
			session.beginTransaction();
			Query query = session.createQuery("from TripVO");
			list = query.list();
			session.getTransaction().commit();
		} catch (RuntimeException e) {
			session.getTransaction().rollback();
			throw e;
		}
		return list;
	}
}
