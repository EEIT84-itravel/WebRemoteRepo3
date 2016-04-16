package _01_Sight.model.dao;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;

import _00_Misc.HibernateUtil_H4_Ver1;
import _01_Sight.model.SightPicVO;
import _01_Sight.model.SightVO;

public class SightPicDAOHibernate {

	public SightPicVO findByPrimaryKey1(Integer sightPicId) {
		SightPicVO sightPicVO = null;
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
		try {
			session.beginTransaction();
			sightPicVO = (SightPicVO) session.get(SightPicVO.class, sightPicId);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		return sightPicVO;
	}

	private static final String GET_ALL_STMT = "from SightPicVO order by sightPicId";

	public List<SightPicVO> selectAll() {
		List<SightPicVO> sightPicVOs = null;
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
		try {
			session.beginTransaction();
			Query query = session.createQuery(GET_ALL_STMT);
			sightPicVOs = query.list();
			session.getTransaction().commit();
		} catch (HibernateException e) {
			session.getTransaction().rollback();
			e.printStackTrace();
		}
		return sightPicVOs;
	}

	private static final String SELECT_BY_SIGHT_ID = "from SightPicVO where sightId=:sightId";

	public List<SightPicVO> selectBySightId(Integer sightId) {
		List<SightPicVO> sightPicVOs = null;

		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
		try {
			session.beginTransaction();
			Query query = session.createQuery(SELECT_BY_SIGHT_ID);
			query.setParameter("sightId", sightId);
			sightPicVOs = query.list();
			session.getTransaction().commit();
		} catch (HibernateException e) {
			session.getTransaction().rollback();
			e.printStackTrace();
		}
		return sightPicVOs;
	}

	public SightPicVO update(SightPicVO sightPicVO) {
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
		try {
			session.beginTransaction();
			session.saveOrUpdate(sightPicVO);
			session.getTransaction().commit();
		} catch (Exception e) {
			session.getTransaction().rollback();
			e.printStackTrace();
		}
		return sightPicVO;
	}

	public SightPicVO insert(SightPicVO sightPicVO) {
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
		try {
			session.beginTransaction();
			session.save(sightPicVO);
			session.getTransaction().commit();
		} catch (Exception e) {
			session.getTransaction().rollback();
			e.printStackTrace();
		}
		return sightPicVO;
	}
}
