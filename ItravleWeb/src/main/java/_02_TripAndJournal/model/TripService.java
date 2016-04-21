package _02_TripAndJournal.model;

import java.util.ArrayList;
import java.util.List;

import _02_TripAndJournal.model.dao.JournalDAOHibernate;
import _02_TripAndJournal.model.dao.TripDAOHibernate;

public class TripService {
	private TripDAOHibernate tripDAOHibernate;
	
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
