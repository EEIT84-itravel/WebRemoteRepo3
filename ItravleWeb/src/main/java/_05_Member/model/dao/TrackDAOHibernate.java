package _05_Member.model.dao;

import org.hibernate.Query;
import org.hibernate.Session;

import java.util.*;

import _00_Misc.HibernateUtil_H4_Ver1;
import _05_Member.model.TrackVO;

public class TrackDAOHibernate {

	private static final String GET_ALL_STMT = "from TrackVO order by  trackNo";
	private static final String GET_TRACK = "from TrackVO where memberId=:memberId";
	private static final String FIND_ONETRACK = "from TrackVO where memberId=:memberId and followMember=:followMember";
	TrackVO trackVO = null;

	public TrackVO insert(TrackVO trackVO) {
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
		try {
			session.beginTransaction();
			session.save(trackVO);
			session.getTransaction().commit();
		} catch (RuntimeException e) {
			session.getTransaction();
			throw e;
		}
		return trackVO;
	}

	public TrackVO update(TrackVO trackVO) {
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();

		try {
			session.beginTransaction();
			session.update(trackVO);
			session.getTransaction().commit();
		} catch (RuntimeException e) {
			session.getTransaction().rollback();
			throw e;
		}
		return trackVO;
	}

	public Boolean delete(Integer trackNo) {
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();

		try {
			session.beginTransaction();
			TrackVO tracknVO = new TrackVO();
			tracknVO.setTrackNo(trackNo);
			session.delete(tracknVO);
			session.getTransaction().commit();
			return true;
		} catch (RuntimeException e) {
			session.getTransaction().rollback();
			return false;
		}
	}

	public TrackVO findByPrimaryKey(Integer TrackNo) {
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
		try {
			session.beginTransaction();
			trackVO = (TrackVO) session.get(TrackVO.class, TrackNo);
			session.getTransaction().commit();
		} catch (RuntimeException e) {
			session.getTransaction().rollback();
			throw e;
		}
		return trackVO;
	}
	public List<TrackVO> findByMemberId(Integer memberId){	
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
		List<TrackVO> list = null;
		try {
			session.beginTransaction();
			Query query = session.createQuery(GET_TRACK);
			query.setParameter("memberId", memberId);
			list = query.list();
			session.getTransaction().commit();
		} catch (RuntimeException e) {
			session.getTransaction().rollback();
			throw e;
		}
		return list;
	}
	public List<TrackVO> findByMemberIdAndFollowMember(Integer memberId,Integer followMember){	
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
		List<TrackVO> list = null;
		try {
			session.beginTransaction();
			Query query = session.createQuery(FIND_ONETRACK);
			query.setParameter("memberId", memberId);
			query.setParameter("followMember", followMember);
			list = query.list();
			session.getTransaction().commit();
		} catch (RuntimeException e) {
			session.getTransaction().rollback();
			throw e;
		}
		return list;
	}

	public List<TrackVO> getall() {

		List<TrackVO> list = null;
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
		try {
			session.beginTransaction();
			Query query = session.createQuery(GET_ALL_STMT);
			list = query.list();
			session.getTransaction().commit();
		} catch (RuntimeException e) {
			session.getTransaction().rollback();
			throw e;
		}
		return list;

	}
}
