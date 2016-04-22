package _05_Member.model.dao;

import org.hibernate.Query;
import org.hibernate.Session;

import java.util.*;

import _00_Misc.HibernateUtil_H4_Ver1;
import _05_Member.model.CollectionVO;

public class CollectionDAOHibernate {

	private static final String GET_ALL_STMT = "from  CollectionVO order by  collectionNo";
	private static final String FIND_SIGHT_BY_MEMBERID = "from  CollectionVO where type_id =:type_id and memberId=:memberId";
	private static final String FIND_SIGHT_BY_MEMBERID_AND_REFERENCETYPE_AND_TYPEID = "from  CollectionVO where type_id =:type_id and memberId=:memberId and referenceType=:referenceType";

	private static final String FIND_BY_MEMBERID_AND_TYPEID = "from  CollectionVO where type_id =:type_id and memberId=:memberId";
	private static final String FIND_SIGHT_BY_TYPEID = "from  CollectionVO where type_id =:type_id";
	private static final String FIND_BY_REFERENCETYPE_AND_TYPEID = "from  CollectionVO where type_id =:type_id and referenceType=:referenceType";
	
	
	CollectionVO collectionVO = null;

	public CollectionVO insert(CollectionVO collectionVO) {
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();

		try {
			session.beginTransaction();
			session.save(collectionVO);
			session.getTransaction().commit();
		} catch (RuntimeException e) {
			session.getTransaction();
			throw e;

		}
		return collectionVO;
	}

	public CollectionVO update(CollectionVO collectionVO) {
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
		try {
			session.beginTransaction();
			session.update(collectionVO);
			session.getTransaction().commit();
		} catch (RuntimeException e) {
			session.getTransaction().rollback();
			throw e;

		}
		return collectionVO;

	}

	public Boolean delete(Integer CollectionNo) {
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
		try {
			session.beginTransaction();
			CollectionVO collectionVO = new CollectionVO();
			collectionVO.setCollectionNo(CollectionNo);
			session.delete(collectionVO);
			session.getTransaction().commit();
			return true;
		} catch (RuntimeException e) {
			session.getTransaction().rollback();
			return false;
		}
	}
	//從類型與參照編號找出相關收藏
	public List<CollectionVO> findByTypeIdAndReferenceType(String typeId,Integer referenceType){
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
			List<CollectionVO> list = null;
			try {
				session.beginTransaction();
				Query query = session
						.createQuery(FIND_BY_REFERENCETYPE_AND_TYPEID);
				query.setParameter("type_id", typeId);
				query.setParameter("referenceType", referenceType);
				list = query.list();
				session.getTransaction().commit();
			} catch (RuntimeException e) {
				session.getTransaction().rollback();
				throw e;
			}
			return list;
		
	}
	//找出同類型的總收藏數
	public List<CollectionVO> findByTypeId(String typeId){
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
			List<CollectionVO> list = null;
			try {
				session.beginTransaction();
				Query query = session
						.createQuery(FIND_SIGHT_BY_TYPEID);
				query.setParameter("type_id", typeId);
				list = query.list();
				session.getTransaction().commit();
			} catch (RuntimeException e) {
				session.getTransaction().rollback();
				throw e;
			}
			return list;
			}
	
	public List<CollectionVO> findBymemberIdAndsightIdAndtypeId(
			Integer referenceType, Integer memberId, String typeId) { // 尋找某個會員收藏某個類型的收藏編號
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
		List<CollectionVO> list = null;
		try {
			session.beginTransaction();
			Query query = session
					.createQuery(FIND_SIGHT_BY_MEMBERID_AND_REFERENCETYPE_AND_TYPEID);
			query.setParameter("type_id", typeId);
			query.setParameter("memberId", memberId);
			query.setParameter("referenceType", referenceType);
			list = query.list();
			session.getTransaction().commit();
		} catch (RuntimeException e) {
			session.getTransaction().rollback();
			throw e;
		}
		return list;
	}
	public List<CollectionVO> findJournalBymemberId(Integer memberId){ //會員的收藏遊記
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
		List<CollectionVO> list = null;
		try {
			session.beginTransaction();
			Query query = session
					.createQuery(FIND_BY_MEMBERID_AND_TYPEID);
			query.setParameter("type_id", "type_id03");
			query.setParameter("memberId", memberId);
			list = query.list();
			session.getTransaction().commit();
		} catch (RuntimeException e) {
			session.getTransaction().rollback();
			throw e;
		}
		return list;
	}
	//會員的收藏討論區
	public List<CollectionVO> findForumlBymemberId(Integer memberId){ //會員的收藏遊記
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
		List<CollectionVO> list = null;
		try {
			session.beginTransaction();
			Query query = session
					.createQuery(FIND_BY_MEMBERID_AND_TYPEID);
			query.setParameter("type_id", "type_id05");
			query.setParameter("memberId", memberId);
			list = query.list();
			session.getTransaction().commit();
		} catch (RuntimeException e) {
			session.getTransaction().rollback();
			throw e;
		}
		
		return list;
	}
	//會員的收藏行程    
	public List<CollectionVO> findTriplBymemberId(Integer memberId){ //會員的收藏遊記
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
		List<CollectionVO> list = null;
		try {
			session.beginTransaction();
			Query query = session
					.createQuery(FIND_BY_MEMBERID_AND_TYPEID);
			query.setParameter("type_id", "type_id02");
			query.setParameter("memberId", memberId);
			list = query.list();
			session.getTransaction().commit();
		} catch (RuntimeException e) {
			session.getTransaction().rollback();
			throw e;
		}
		
		return list;
	}
	public CollectionVO findByPrimaryKey(Integer CollectionNo) {
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
		try {
			session.beginTransaction();
			collectionVO = (CollectionVO) session.get(CollectionVO.class,
					CollectionNo);
			session.getTransaction().commit();
		} catch (RuntimeException e) {
			session.getTransaction().rollback();
			throw e;
		}
		return collectionVO;
	}

	public List<CollectionVO> getall() {
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();

		List<CollectionVO> list = null;
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
	public List<CollectionVO> findSightByMemberId(Integer memberId) {  //尋找某個會員收藏的"景點"
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();

		List<CollectionVO> list = null;
		try {
			session.beginTransaction();
			Query query = session.createQuery(FIND_SIGHT_BY_MEMBERID);
			query.setParameter("type_id", "type_id01");
			query.setParameter("memberId", memberId);
			list = query.list();
			session.getTransaction().commit();
		} catch (RuntimeException e) {
			session.getTransaction().rollback();
			throw e;
		}
		return list;
	}
}
