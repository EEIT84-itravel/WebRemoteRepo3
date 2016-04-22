package _02_TripAndJournal.model;

import java.util.ArrayList;
import java.util.List;

import _02_TripAndJournal.model.dao.TripDAOHibernate;
import _02_TripAndJournal.model.dao.TripDetailDAOHibernate;
import _05_Member.model.dao.CollectionDAOHibernate;

public class TripService {
	private TripDAOHibernate tripDAOHibernate;
	// 搜尋後按照收藏人次排
	public List<TripVO> searchByCollectNum() {
		tripDAOHibernate=new TripDAOHibernate();
		List<TripVO> tripVOs = new ArrayList<TripVO>();
		tripVOs = tripDAOHibernate.selectOrderByWatch();// 由進階查詢撈出的景點
		List<TripVO> result = new ArrayList<TripVO>();// 要放排序結果的List
		CollectionDAOHibernate collectionDAOHibernate = new CollectionDAOHibernate();
		List<Integer> list = collectionDAOHibernate.selectCountSight("type_id02");
		for (Integer tripId : list) { // 把景點ID List照順序拿出來
			for (TripVO tripVO : tripVOs) {
				if (tripVO.getTripId() == tripId) {// 如果景點ID在搜尋出的景點中
					result.add(select(tripId));// 就塞到result中
				}
			}
		}
		for (TripVO temp : tripVOs) {// 把查詢出的結果一隻一隻抓出來
			if(!result.contains(temp)){
					result.add(temp);// 如果result中沒有這隻 就塞在list後面
				}
			}
		return result;
	}
	
	// 照最後更新時間排序
	public List<TripVO> selectOrderByModifyTime() {
		tripDAOHibernate=new TripDAOHibernate();
		return tripDAOHibernate.selectOrderByModifyTime();
	}
	
	// 照瀏覽人次排序
	public List<TripVO> selectOrderByWatch() {
		tripDAOHibernate=new TripDAOHibernate();
		return tripDAOHibernate.selectOrderByWatch();
	}
	
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
	//會員刪除行程
	public boolean deleteTrip(Integer tripId){
		tripDAOHibernate = new TripDAOHibernate();
		if(tripId!=null){
			tripDAOHibernate.delete(tripId);
		return true;
		}
		return false;
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
