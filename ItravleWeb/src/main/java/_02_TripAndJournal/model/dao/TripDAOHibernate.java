package _02_TripAndJournal.model.dao;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;

import _00_Misc.HibernateUtil_H4_Ver1;
import _02_TripAndJournal.model.TripVO;

public class TripDAOHibernate {

	public static void main(String[] args) {
		 TripDAOHibernate dao = new TripDAOHibernate();//Select
		 TripVO bean = dao.select(5);
		 System.out.println(bean);

		// TripDAOHibernate dao = new TripDAOHibernate();
		// TripVO bean = new TripVO();
		// bean.setTripId(1);// Update保留 Insert不用
		// bean.setPost(true);
		// bean.setModifyTime(new Timestamp(new Date().getTime()));
		// bean.setMemberId(1);
		// bean.setTripName("台南微旅行");
		// bean.setTripStartDate(java.sql.Date.valueOf("2016-03-21"));
		// bean.setTripEndDate(java.sql.Date.valueOf("2016-03-22"));
		// bean.setStartTime(java.sql.Time.valueOf("20:50:00"));
		// bean.setTotalBudget(java.math.BigDecimal.valueOf(300));
		// bean.setRegionId("region03");
		// bean.setWatchNum(99);
		// bean.setTransFormId("trans_form01");
		// bean.setTripIntro("DIY熔岩巧克力蛋糕");
		// System.out.println(dao.update(bean));

		// TripDAOHibernate dao = new TripDAOHibernate();//Delete
		// boolean b = dao.delete(8);
		// System.out.println(b);

		// TripDAOHibernate dao = new TripDAOHibernate();//Select All
		// List<TripVO> bean = dao.select();
		// for (int i = 0; i < bean.size(); i++) {
		// System.out.println(bean.get(i));
		// }
	}

	// select
	public TripVO select(Integer tripId) {
		TripVO tripVO = null;
		Session session = HibernateUtil_H4_Ver1.getSessionFactory().getCurrentSession();
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

	// insert
	public TripVO insert(TripVO tripVO) {
		Session session = HibernateUtil_H4_Ver1.getSessionFactory().getCurrentSession();
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
		Session session = HibernateUtil_H4_Ver1.getSessionFactory().getCurrentSession();
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
		boolean b = false;
		Session session = HibernateUtil_H4_Ver1.getSessionFactory().getCurrentSession();
		TripVO tripVO;
		try {
			session.beginTransaction();
			tripVO = (TripVO) session.get(TripVO.class, tripId);
			session.delete(tripVO);
			session.getTransaction().commit();
			b = true;
		} catch (RuntimeException e) {
			session.getTransaction().rollback();
			throw e;
		}
		return b;
	}

	// select all
	public List<TripVO> select() {
		List<TripVO> list = null;
		Session session = HibernateUtil_H4_Ver1.getSessionFactory().getCurrentSession();
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
