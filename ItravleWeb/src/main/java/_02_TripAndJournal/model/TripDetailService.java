package _02_TripAndJournal.model;

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
}
