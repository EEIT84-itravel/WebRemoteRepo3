package _02_TripAndJournal.model;

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
	
	public List<TripDetailVO> select(int tripId) {
		List<TripDetailVO> result = null;
		if(tripId>=1) {
			tripDetailDAOHibernate = new TripDetailDAOHibernate();
			result= tripDetailDAOHibernate.select(tripId);
		}
		return result;
	}
}
