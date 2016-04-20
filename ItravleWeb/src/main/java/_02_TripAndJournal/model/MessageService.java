package _02_TripAndJournal.model;

import java.util.List;

import _02_TripAndJournal.model.dao.MessageDAOHibernate;

public class MessageService {
	private MessageDAOHibernate messageDAOHibernate = new MessageDAOHibernate();

	public List<MessageVO> select() {
		List<MessageVO> result = null;
		result = messageDAOHibernate.getAll();
		return result;
	}
	//討論區回覆數
	public List<MessageVO> getAllNum() {		
		return messageDAOHibernate.getAllNum("type_id05");
	}
	
	
	public List<MessageVO> getForumMessage(Integer referenceNo){
		return messageDAOHibernate.getForumMessage(referenceNo);	    
	}
	//抓出某篇文章的回復人數
	public long getForumMessageNum(Integer referenceNo){
		return messageDAOHibernate.getForumMessageNum(referenceNo);	
	}

	public MessageVO selectOne(Integer messageId) {
		return messageDAOHibernate.selectmessageId(messageId);
	}

	public MessageVO insert(MessageVO vo) {
		MessageVO result = null;
		if (vo != null) {
			result = messageDAOHibernate.insert(vo);
		}
		return result;
	}

	public MessageVO update(MessageVO vo) {
		MessageVO result = null;
		if (vo != null) {
			result = messageDAOHibernate.update(vo);
		}
		return result;
	}

	public boolean delete(MessageVO vo) {
		boolean result = false;
		if (vo != null) {
			result = messageDAOHibernate.delete(vo.getMessageId());
		}
		return result;
	}

}
