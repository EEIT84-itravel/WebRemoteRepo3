package _03_Event.model;

import java.util.ArrayList;
import java.util.List;

import _03_Event.model.dao.EventDAOHibernate;
import _04_Forum.model.ForumVO;

public class EventService {
	private EventDAOHibernate eDAO = new EventDAOHibernate();
	
	//新增活動
	public EventVO insert(EventVO vo){
		EventVO result = null;
		if(vo != null){
			result = eDAO.insert(vo);
		}
		return result;
	}
	//修改活動
	public EventVO update(EventVO vo){
		EventVO result = null;
		if(vo != null){
			result = eDAO.update(vo);
		}
		return result;
	}
	//刪除活動
	public boolean delete(EventVO vo){
		boolean result = false;
		if(vo != null){
			result = eDAO.delete(vo.getEventId());
		}
		return result;
	}
     //查全部活動
	 public List<EventVO> select() {
	 List<EventVO> result = null;
	 result = eDAO.select();
	 return result;
	 }
	//查詢單一活動
	 public EventVO selectOne(Integer eventId){
		 return eDAO.select(eventId);
	 }
	 
	 //查詢與單一景點相關活動
	 public List<EventVO> selectEventBySightId(int sightId) {
		 List<EventVO> result = new ArrayList<>();
		 List<EventVO> eventVOs = eDAO.select();
		 for(EventVO eventVO:eventVOs){
			 if(eventVO.getSightId()==sightId){
				 result.add(eventVO);
			 }
		 }
		 return result;
	 }

}
