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

	public static void main(String[] ages) {
		TrackDAOHibernate dao = new TrackDAOHibernate();

		// selectAll
		// List <TrackVO> list = dao.getall();
		// for(TrackVO aMember: list ){
		// System.out.println(aMember);
		// }

		// select
		// TrackVO res = dao.findByPrimaryKey(1);
		// System.out.println(res);
        // 用帳號查追蹤
		//List<TrackVO> res = dao.findByMemberId(1);
		//System.out.println(res);
		//用帳號跟被追蹤作者查一筆
		//List<TrackVO> res = dao.findByMemberIdAndFollowMember(1,2);
		//System.out.println(res);
		// update
		// TrackVO res = dao.findByPrimaryKey(1);
		// res.setMemberId(1);
		// dao.update(res);
		// System.out.println(res);

		// insert
		//TrackVO res = new TrackVO();
		//res.setFollowMember(4);
		//res.setMemberId(1);
		//dao.insert(res);
		// TrackVO res = dao.findByPrimaryKey(1);
		// dao.insert(res);
		// System.out.println(res);

		// delete
		// dao.delete(3);

	}

}
