package _01_Sight.model;

import java.util.List;

import _01_Sight.model.dao.SightDAOHibernate;

public class SightService {
	private SightDAOHibernate dao = new SightDAOHibernate();
	
	public List<SightVO> select(){
		List<SightVO> result = null;
		result = dao.selectAll();
		
		return result;
	}
}
