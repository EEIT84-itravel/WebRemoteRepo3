package _01_Sight.model.dao;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;

import _00_Misc.HibernateUtil_H4_Ver1;
import _01_Sight.model.SightVO;

public class SightDAOHibernate {

	public static void main(String[] args) {
		SightDAOHibernate dao = new SightDAOHibernate();
		SightVO sightVO = dao.findByPrimaryKey(1);
		System.out.println("findByPrimaryKey測試: " + sightVO);

		// sightVO.setDel(true);
//		sightVO.setDel(false);
//		java.util.Date now = new Date();
//		long nowLong = now.getTime();
//		java.sql.Timestamp sqlDate = new Timestamp(nowLong);
//		sightVO.setModifyTime(sqlDate);
//		SightVO sightVOupdate = dao.update(sightVO);
//		System.out.println("update測試: " + sightVOupdate);

//		SightVO sightVO2 = new SightVO();
//		sightVO2.setSightName("testsight");
//		sightVO2.setRegionId("region01");
//		sightVO2.setCountyId("county01");
//		sightVO2.setSightTypeId("sight_type01");		
//		java.sql.Time open= java.sql.Time.valueOf("09:00:00");
//		sightVO2.setOpenTime(open);
//		java.sql.Time close = java.sql.Time.valueOf("21:00:00");
//		sightVO2.setCloseIime(close);
//		java.sql.Time spend = java.sql.Time.valueOf("03:00:00");
//		sightVO2.setSpendHour(spend);
//		sightVO2.setPlayPeriod("sight_time05");
//		sightVO2.setScore(0F);
//		sightVO2.setLongitude(121.56455F);
//		sightVO2.setLatitude(25.033602F);
//		java.util.Date now2 = new Date();
//		long nowLong2 = now2.getTime();
//		java.sql.Timestamp sqlDate2 = new Timestamp(nowLong2);
//		sightVO2.setCreateTime(sqlDate2);
//		sightVO2.setCreator(1);
//		sightVO2.setModifyTime(sqlDate2);
//		sightVO2.setModifier(2);
//		SightVO sightVOinsert = dao.insert(sightVO2);
//		System.out.println("insert測試: " + sightVOinsert);
		
//		boolean sightVOdelete = dao.delete(12); 
//		System.out.println("delete測試: " + sightVOdelete);

		List<SightVO> sightVOs = dao.selectAll();
		System.out.println("selectAll測試: " + sightVOs);
	}

	public SightVO findByPrimaryKey(Integer sightId) {
		SightVO sightVO = null;
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
		try {
			session.beginTransaction();
			sightVO = (SightVO) session.get(SightVO.class, sightId);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		return sightVO;
	}

	private static final String GET_ALL_STMT = "from SightVO order by sightId";

	public List<SightVO> selectAll() {
		List<SightVO> sightVOs = null;
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
		try {
			session.beginTransaction();
			Query query = session.createQuery(GET_ALL_STMT);
			sightVOs = query.list();
			session.getTransaction().commit();
		} catch (HibernateException e) {
			session.getTransaction().rollback();
			e.printStackTrace();
		}

		return sightVOs;
	}

	public SightVO update(SightVO sightVO) {
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
		try {
			session.beginTransaction();
			session.saveOrUpdate(sightVO);
			session.getTransaction().commit();
		} catch (Exception e) {
			session.getTransaction().rollback();
			e.printStackTrace();
		}
		return sightVO;
	}

	public SightVO insert(SightVO sightVO) {
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
		try {
			session.beginTransaction();
			session.save(sightVO);
			session.getTransaction().commit();
		} catch (Exception e) {
			session.getTransaction().rollback();
			e.printStackTrace();
		}

		return sightVO;
	}
	
	public boolean delete(Integer sightId) {
		Session session = HibernateUtil_H4_Ver1.getSessionFactory().getCurrentSession();		
		try {
			session.beginTransaction();
			SightVO sightVO = new SightVO();
			sightVO.setSightId(sightId);
			session.delete(sightVO);			
			session.getTransaction().commit();	
			return true;
		} catch (Exception e) {
			session.getTransaction().rollback();
			e.printStackTrace();
		}		
		return false;
	}

}
