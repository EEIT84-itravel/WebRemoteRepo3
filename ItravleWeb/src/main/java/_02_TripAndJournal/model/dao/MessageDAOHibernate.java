package _02_TripAndJournal.model.dao;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;

import _00_Misc.HibernateUtil_H4_Ver1;
import _02_TripAndJournal.model.MessageVO;

public class MessageDAOHibernate {

	private static final String GET_ALL_MESSAGE = "from MessageVO order by message_id";

	public MessageVO selectmessageId(Integer messageId) {
		MessageVO messageVo = null;
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
		try {
			session.beginTransaction();
			messageVo = (MessageVO) session.get(MessageVO.class, messageId);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		return messageVo;
	}
	//抓討論區之留言
	private static final String GET_ALL_FORUMMESSAGE = "from MessageVO where referenceNo=:referenceNo order by messageId";
	public List<MessageVO> getForumMessage(Integer referenceNo) {
		List<MessageVO> list = null;
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
		try {
			session.beginTransaction();
			Query query = session.createQuery(GET_ALL_FORUMMESSAGE);
			query.setParameter("referenceNo", referenceNo);
			list = query.list();
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		return list;
	}

	public List<MessageVO> getAll() {
		List<MessageVO> list = null;
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
		try {
			session.beginTransaction();
			Query query = session.createQuery(GET_ALL_MESSAGE);
			list = query.list();
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		return list;
	}

	public MessageVO update(MessageVO messageVO) {
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
		try {
			session.beginTransaction();
			session.update(messageVO);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		return messageVO;
	}

	public MessageVO insert(MessageVO messageVO) {
		Session session = HibernateUtil_H4_Ver1.getSessionFactory()
				.getCurrentSession();
		try {
			session.beginTransaction();
			session.save(messageVO);
			session.getTransaction().commit();
		} catch (RuntimeException ex) {
			session.getTransaction().rollback();
			throw ex;
		}
		return messageVO;
	}
    public boolean delete(Integer messageId){
    	Session session = HibernateUtil_H4_Ver1.getSessionFactory().getCurrentSession();
		try {
			session.beginTransaction();	
			MessageVO messageVo = new MessageVO();
			messageVo.setMessageId(messageId);
			session.delete(messageVo);
			session.getTransaction().commit();
			return true;
		} catch (Exception ex) {
			session.getTransaction().rollback();
			ex.printStackTrace();
		}
    	return false;
    }	
}
