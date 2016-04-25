package _01_Sight.model.dao;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.hibernate.Criteria;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;

import _00_Misc.HibernateUtil_H4_Ver1;
import _01_Sight.model.SightPicVO;
import _01_Sight.model.SightVO;
import _02_TripAndJournal.model.dao.TripDAOHibernate;
import _05_Member.model.CollectionVO;

public class SightDAOHibernate {

	// 進階搜尋,照瀏覽人次排序
	public List<SightVO> search(SightVO sightVOp) {
		List<SightVO> sightVO = null;
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
		try {
			session.beginTransaction();
			StringBuilder sb = new StringBuilder();
			String sWhere = "where";
			sb.append(" from SightVO ");
			if (null != sightVOp.getRegionId()
					&& !"".equals(sightVOp.getRegionId())) {
				sb.append(sWhere).append(" region_id=:region_id ");
				sWhere = "and";
			}
			if (null != sightVOp.getCountyId()
					&& !"".equals(sightVOp.getCountyId())) {
				sb.append(sWhere).append(" county_id=:county_id ");
				sWhere = "and";
			}
			if (null != sightVOp.getSightTypeId()
					&& !"".equals(sightVOp.getSightTypeId())) {
				sb.append(sWhere).append(" sight_type_id=:sight_type_id ");
				sWhere = "and";
			}
			if (null != sightVOp.getSightName()
					&& !"".equals(sightVOp.getSightName())) {
				sb.append(sWhere).append(" sightName like :keyWord ");
				sWhere = "and";
			}
			sb.append(" order by watchNum desc");
			Query query = session.createQuery(sb.toString());

			if (null != sightVOp.getRegionId()
					&& !"".equals(sightVOp.getRegionId())) {
				query.setParameter("region_id", sightVOp.getRegionId());
			}
			if (null != sightVOp.getCountyId()
					&& !"".equals(sightVOp.getCountyId())) {
				query.setParameter("county_id", sightVOp.getCountyId());
			}
			if (null != sightVOp.getSightTypeId()
					&& !"".equals(sightVOp.getSightTypeId())) {
				query.setParameter("sight_type_id", sightVOp.getSightTypeId());
			}
			if (null != sightVOp.getSightName()
					&& !"".equals(sightVOp.getSightName())) {
				query.setParameter("keyWord", "%" + sightVOp.getSightName()
						+ "%");
			}
			sightVO = query.list();
			session.getTransaction().commit();
		} catch (HibernateException e) {
			session.getTransaction().rollback();
			e.printStackTrace();
		}
		return sightVO;
	}

	// 搜尋後按最後更新時間排
	public List<SightVO> searchByModifyTime(SightVO sightVOp) {
		List<SightVO> sightVO = null;
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
		try {
			session.beginTransaction();
			StringBuilder sb = new StringBuilder();
			String sWhere = "where";
			sb.append(" from SightVO ");
			if (null != sightVOp.getRegionId()
					&& !"".equals(sightVOp.getRegionId())) {
				sb.append(sWhere).append(" region_id=:region_id ");
				sWhere = "and";
			}
			if (null != sightVOp.getCountyId()
					&& !"".equals(sightVOp.getCountyId())) {
				sb.append(sWhere).append(" county_id=:county_id ");
				sWhere = "and";
			}
			if (null != sightVOp.getSightTypeId()
					&& !"".equals(sightVOp.getSightTypeId())) {
				sb.append(sWhere).append(" sight_type_id=:sight_type_id ");
				sWhere = "and";
			}
			if (null != sightVOp.getSightName()
					&& !"".equals(sightVOp.getSightName())) {
				sb.append(sWhere).append(" sightName like :keyWord ");
				sWhere = "and";
			}
			sb.append(" order by modifyTime desc");
			Query query = session.createQuery(sb.toString());

			if (null != sightVOp.getRegionId()
					&& !"".equals(sightVOp.getRegionId())) {
				query.setParameter("region_id", sightVOp.getRegionId());
			}
			if (null != sightVOp.getCountyId()
					&& !"".equals(sightVOp.getCountyId())) {
				query.setParameter("county_id", sightVOp.getCountyId());
			}
			if (null != sightVOp.getSightTypeId()
					&& !"".equals(sightVOp.getSightTypeId())) {
				query.setParameter("sight_type_id", sightVOp.getSightTypeId());
			}
			if (null != sightVOp.getSightName()
					&& !"".equals(sightVOp.getSightName())) {
				query.setParameter("keyWord", "%" + sightVOp.getSightName()
						+ "%");
			}
			sightVO = query.list();
			session.getTransaction().commit();
		} catch (HibernateException e) {
			session.getTransaction().rollback();
			e.printStackTrace();
		}
		return sightVO;
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
	private static final String GET_ALL_STMT_ORDER_BY_WN = "from SightVO order by watchNum desc";

	public List<SightVO> selectAll() {
		List<SightVO> sightVOs = null;
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
		try {
			session.beginTransaction();
			Query query = session.createQuery(GET_ALL_STMT_ORDER_BY_WN);
			sightVOs = query.list();
			session.getTransaction().commit();
		} catch (HibernateException e) {
			session.getTransaction().rollback();
			e.printStackTrace();
		}
		return sightVOs;
	}
	
	//全部景點依照景點ID排序(後台用
	private static final String GET_ALL_STMT = "from SightVO order by sightId desc";

	public List<SightVO> selectAllbySightId() {
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

	// 依縣市搜尋,後台用
	private static final String SELECT_BY_COUNTY = "from SightVO where countyId=:countyId";

	public List<SightVO> selectByCounty(String countyId) {
		List<SightVO> sightVOs = null;
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
		try {
			session.beginTransaction();
			Query query = session.createQuery(SELECT_BY_COUNTY);
			query.setParameter("countyId", countyId);
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
