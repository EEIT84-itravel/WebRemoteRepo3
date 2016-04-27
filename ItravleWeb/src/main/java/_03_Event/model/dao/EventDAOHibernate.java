package _03_Event.model.dao;

import _00_Misc.HibernateUtil_H4_Ver1;
import java.util.List;
import _03_Event.model.EventVO;
import org.hibernate.Query;
import org.hibernate.Session;

public class EventDAOHibernate {

	public EventVO select(Integer eventId) {
		EventVO vo = null;
		Session session = HibernateUtil_H4_Ver1.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			vo = (EventVO) session.get(EventVO.class, eventId);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			throw ex;
		}
		return vo;
	}
	public List<EventVO> select() {
		List<EventVO> result = null;
		Session session = HibernateUtil_H4_Ver1.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			Query query = session.createQuery("from EventVO order by eventId desc");
			result = query.list();
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		return result;
	}
	public EventVO update(EventVO vo) {
		Session session = HibernateUtil_H4_Ver1.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			session.update(vo);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		return vo;
	}

	public EventVO insert(EventVO vo) {
		Session session = HibernateUtil_H4_Ver1.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();
			session.saveOrUpdate(vo);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		return vo;
	}

	public boolean delete(Integer eventId) {
		if (this.select(eventId) != null) {
			Session session = HibernateUtil_H4_Ver1.getSessionFactory()
					.getCurrentSession();
			try {
				session.beginTransaction();
				EventVO vo = (EventVO) session.get(EventVO.class, eventId);
				session.delete(vo);
				session.getTransaction().commit();
			} catch (RuntimeException ex) {
				session.getTransaction().rollback();
				throw ex;
			}
			return true;
		} else {
			return false;
		}
	}

}
