package _02_TripAndJournal.model;

import java.util.LinkedList;
import java.util.List;

import _02_TripAndJournal.model.dao.TripDetailDAOHibernate;

public class TripDetailService {
	private TripDetailDAOHibernate tripDetailDAOHibernate;

	public TripDetailVO insert(TripDetailVO tripDetailVO) {
		TripDetailVO result = null;
		if (tripDetailVO != null) {
			tripDetailDAOHibernate = new TripDetailDAOHibernate();
			result = tripDetailDAOHibernate.insert(tripDetailVO);
		}
		return result;
	}
	
	public boolean insert(List<TripDetailVO> tripDetailVOs) {
		boolean result = false;
		if (tripDetailVOs != null) {
			tripDetailDAOHibernate = new TripDetailDAOHibernate();
			result = tripDetailDAOHibernate.insert(tripDetailVOs);
		}
		return result;
	}

	public List<TripDetailVO> select(int tripId) {
		List<TripDetailVO> result = null;
		if (tripId >= 1) {
			tripDetailDAOHibernate = new TripDetailDAOHibernate();
			result = tripDetailDAOHibernate.select(tripId);
		}
		return result;
	}

	// 只選取各行程之行程明細第一筆資料,用於顯示行程主圖之功能
	public List<TripDetailVO> getMainPics() {
		List<TripDetailVO> result = new LinkedList<TripDetailVO>();
		tripDetailDAOHibernate = new TripDetailDAOHibernate();
		List<TripDetailVO> temp = tripDetailDAOHibernate.select();
		for (TripDetailVO tripDetailVO : temp) {
			if ("type_id01".equals(tripDetailVO.getReferenceType())) {
				if (tripDetailVO.getWhichDay() == 1) {
					if (tripDetailVO.getTripOrder() == 1) {
						result.add(tripDetailVO);
					}
				}
			}
		}
		return result;
	}
	
}
