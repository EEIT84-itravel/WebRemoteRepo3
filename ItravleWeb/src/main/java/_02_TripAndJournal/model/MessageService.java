package _02_TripAndJournal.model;

import java.util.ArrayList;
import java.util.List;

import _02_TripAndJournal.model.dao.MessageDAOHibernate;

public class MessageService {
	private MessageDAOHibernate messageDAOHibernate = new MessageDAOHibernate();
	public List<MessageVO> selectSightMessage(int referenceNo) {
		List<MessageVO> list = null;
		List<MessageVO> result = new ArrayList<MessageVO>();
		list=messageDAOHibernate.getTypeMessage("type_id01");
		for(MessageVO vo:list){
			if(vo.getReferenceNo()==referenceNo){
				result.add(vo);
			}
		}
		return result;
	}
	public List<MessageVO> selectTripMessage(int referenceNo) {
		List<MessageVO> list = null;
		List<MessageVO> result = new ArrayList<MessageVO>();
		list=messageDAOHibernate.getTypeMessage("type_id02");
		for(MessageVO vo:list){
			if(vo.getReferenceNo()==referenceNo){
				result.add(vo);
			}
		}
		return result;
	}
	
	public List<MessageVO> selectJournalMessage(int referenceNo) {
		List<MessageVO> list = null;
		List<MessageVO> result = new ArrayList<MessageVO>();
		list=messageDAOHibernate.getTypeMessage("type_id03");
		for(MessageVO vo:list){
			if(vo.getReferenceNo()==referenceNo){
				result.add(vo);
			}
		}
		return result;
	}
	
	
	public List<MessageVO> select() {
		List<MessageVO> result = null;
		result = messageDAOHibernate.getAll();
		return result;
	}
	//討論區回覆數
	public List<MessageVO> getAllNum() {		
		return messageDAOHibernate.getAllNum("type_id05");
	}

	public List<MessageVO> getForumMessage(int referenceNo){
		return messageDAOHibernate.getForumMessage(referenceNo);	    
	}
	//抓出某篇文章的回復人數
	public long getForumMessageNum(int referenceNo){
		return messageDAOHibernate.getForumMessageNum(referenceNo);	
	}

	public MessageVO selectOne(int messageId) {
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
