package _02_TripAndJournal.model;

import _02_TripAndJournal.model.dao.TripDAOHibernate;

public class TripService {
private TripDAOHibernate tripDAOHibernate;
	
	public TripVO insert(TripVO tripVO){
		TripVO result=null;
		if(tripVO!=null){
			tripDAOHibernate=new TripDAOHibernate();
			result=tripDAOHibernate.insert(tripVO);
		}
		return result;
	}

}
