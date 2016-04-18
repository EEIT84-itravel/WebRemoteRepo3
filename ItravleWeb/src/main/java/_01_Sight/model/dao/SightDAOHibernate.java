package _01_Sight.model.dao;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;

import _00_Misc.HibernateUtil_H4_Ver1;
import _01_Sight.model.SightPicVO;
import _01_Sight.model.SightVO;

public class SightDAOHibernate {

	// 進階搜尋測試
//	private static final String SEARCH = "from SightVO where region_id=:region_id and county_id=:county_id and sight_type_id=:sight_type_id";

//	public List<SightVO> search(SightVO sightVOp) {
//		List<SightVO> sightVO = null;
//		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
//				.getCurrentSession();
//		try {
//			session.beginTransaction();
//			StringBuilder sb = new StringBuilder();
//			String sWhere = "where";
//			  sb.append(" from SightVO ");
//			  if(null != sightVOp.getRegionId() && !"".equals(sightVOp.getRegionId())){
//			   sb.append(sWhere).append(" region_id=:region_id ");
//			   sWhere = "and";
//			  }
//			  if(null != sightVOp.getCountyId() && !"".equals(sightVOp.getCountyId())){
//				   sb.append(sWhere).append(" county_id=:county_id ");
//				   sWhere = "and";
//				  }
//			  if(null != sightVOp.getSightTypeId() && !"".equals(sightVOp.getSightTypeId())){
//				   sb.append(sWhere).append(" sight_type_id=:sight_type_id ");
//				   sWhere = "and";
//				  }
//			  Query query = session.createQuery(sb.toString());
//			  
//			  if(null != sightVOp.getRegionId() && !"".equals(sightVOp.getRegionId())){
//				  query.setParameter("region_id", sightVOp.getRegionId());
//				  }
//				  if(null != sightVOp.getCountyId() && !"".equals(sightVOp.getCountyId())){
//					  query.setParameter("county_id", sightVOp.getCountyId());
//					  }
//				  if(null != sightVOp.getSightTypeId() && !"".equals(sightVOp.getSightTypeId())){
//					  query.setParameter("sight_type_id", sightVOp.getSightTypeId());
//					  }
//				  sightVO = query.list();
//				   session.getTransaction().commit();
//		} catch (HibernateException e) {
//			session.getTransaction().rollback();
//			e.printStackTrace();
//		}
//		return sightVO;
//	}

	// 景點按瀏覽人次排列(首頁)
	private static final String GET_ALL_WATCHNUM = "from SightVO order by watchNum desc";

	public List<SightVO> selectByWatchNum() {
		List<SightVO> sightVOs = null;
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
		try {
			session.beginTransaction();
			Query query = session.createQuery(GET_ALL_WATCHNUM);
			sightVOs = query.list();
			session.getTransaction().commit();
		} catch (HibernateException e) {
			session.getTransaction().rollback();
			e.printStackTrace();
		}

		return sightVOs;
	}

	// 景點資訊超連結
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

	// 全部景點(首頁)
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

	private static final String SELECT_BY_TYPE = "from SightVO where sightTypeId=:sightTypeId order by score desc";

	public List<SightVO> selectByType(String sightType) {
		List<SightVO> sightVOs = null;
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
		try {
			session.beginTransaction();
			Query query = session.createQuery(SELECT_BY_TYPE);
			query.setParameter("sightTypeId", sightType);
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
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
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
