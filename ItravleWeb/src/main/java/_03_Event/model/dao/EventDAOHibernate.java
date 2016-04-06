package _03_Event.model.dao;

import _00_Misc.HibernateUtil_H4_Ver1;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import _03_Event.model.EventVO;
import org.hibernate.Query;
import org.hibernate.Session;

public class EventDAOHibernate {

	public static void main(String[] args) throws IOException {

		 EventDAOHibernate dao = new EventDAOHibernate();
		 EventVO vo = new EventVO();
		System.out.println(dao.select(6));
		File imageFile = new File("src/main/webapp/images/cat.jpg");		
		InputStream is = new FileInputStream(imageFile);
		byte[] p = new byte[is.available()];
		is.read(p);
		is.close();
		//vo.setEventId(5);
//		vo.setEventPhoto(p);
//		vo.setEventTopic("聖誕節");
//		vo.setEventContent("一年一度聖誕節");
//		vo.setEventStartDate(java.sql.Date.valueOf("2011-02-02"));
//		vo.setEventEndDate(java.sql.Date.valueOf("2011-02-10"));
//		vo.setSightId(3);
//		System.out.println(dao.insert(vo));
		//System.out.println(dao.update(vo));
	}

	/**
	 * 只是向数据库中插入一张图片
	 */
//	public EventVO insertPhoto(String photo) {
//		EventVO vo = new EventVO();
//		try {
//			Session session = HibernateUtil.getSessionFactory()
//					.getCurrentSession();
//			session.beginTransaction();
//			FileInputStream in = new FileInputStream(photo);
//			byte[] p = new byte[in.available()];
//			in.read(p);
//			in.close();
//			vo.setEventPhoto(p);
//			session.save(vo);
//			session.getTransaction().commit();
//		} catch (RuntimeException ex) {
//		    session.get
//		}
//	}

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
			Query query = session.createQuery("from EventVO");
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
