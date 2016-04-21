package _02_TripAndJournal.model;

import java.util.ArrayList;
import java.util.List;

import _02_TripAndJournal.model.dao.JournalDAOHibernate;
import _02_TripAndJournal.model.dao.TripDAOHibernate;
import _02_TripAndJournal.model.dao.TripDetailDAOHibernate;

public class TripService {
	private TripDAOHibernate tripDAOHibernate;
	
	//查詢行程中包含特定景點的行程 傳回tripVO的List
	public List<TripVO> getSightTrip(Integer sightId){
		List<TripVO> result=new ArrayList<TripVO>();
		TripDetailDAOHibernate tripDetailDAOHibernate =new TripDetailDAOHibernate();
		TripDAOHibernate tripDAOHibernate=new TripDAOHibernate();
		List<TripDetailVO> tripDetailVOs =tripDetailDAOHibernate.select();
		for(TripDetailVO tripDetailVO:tripDetailVOs){
			if("type_id01".equals(tripDetailVO.getReferenceType())){//類型為景點
				if(tripDetailVO.getReferenceNo()==sightId){//參照編號為景點編號
					TripVO tripVO=tripDAOHibernate.select(tripDetailVO.getTripId());//由detail查出遊記ID
					if(!result.contains(tripVO)){//如果result中沒有那筆遊記
						result.add(tripVO);
					}
				}
			}
		}
		return result;
	}
	
	public boolean update(TripVO tripVO){
		tripDAOHibernate = new TripDAOHibernate();
		 if( tripVO != null){
			 tripDAOHibernate.update(tripVO);
				return true;
				 }
				 return false;
	}

	public TripVO insert(TripVO tripVO) {
		TripVO result = null;
		if (tripVO != null) {
			tripDAOHibernate = new TripDAOHibernate();
			result = tripDAOHibernate.insert(tripVO);
		}
		return result;
	}

	public int selectDateDiff(Integer tripId) {
		int result = 0;
		if (tripId > 0) {
			tripDAOHibernate = new TripDAOHibernate();
			result = tripDAOHibernate.selectDateDiff(tripId);
		}
		return result;
	}
    //從會員找行程
	public List<TripVO> selectFromMember(Integer memberId) {
		List<TripVO> result = null;
		if (memberId >= 0) {
			tripDAOHibernate = new TripDAOHibernate();
			result = tripDAOHibernate.selectFromMember(memberId);
		}
		return result;
	}

	public TripVO select(Integer tripId) {
		TripVO result = null;
		if (tripId >= 0) {
			tripDAOHibernate = new TripDAOHibernate();
			result = tripDAOHibernate.select(tripId);
		}
		return result;
	}
	
	//取得所有行程
	public List<TripVO> getAll() {
		tripDAOHibernate = new TripDAOHibernate();
		return tripDAOHibernate.select();
	}
	
	//取得所有狀態為"已發佈"的行程
	public List<TripVO> getAllPost() {
		List<TripVO> result = new ArrayList<TripVO>();
		tripDAOHibernate = new TripDAOHibernate();
		List<TripVO> all =tripDAOHibernate.select();
		for(TripVO vo: all){
			if(vo.getPost()==true) {
				result.add(vo);
			}
		}
		return result;
	}
}
