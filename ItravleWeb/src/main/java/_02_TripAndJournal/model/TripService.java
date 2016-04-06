package _02_TripAndJournal.model;

import java.util.List;

import _02_TripAndJournal.model.dao.TripDAOHibernate;

public class TripService {
	private TripDAOHibernate tripDAOHibernate;

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
}
