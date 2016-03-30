package _01_Sight.model;

import java.util.ArrayList;
import java.util.List;
import _01_Sight.model.dao.SightDAOHibernate;

public class SightService {
	private SightDAOHibernate dao = new SightDAOHibernate();

	public List<SightVO> select() {
		List<SightVO> result = new ArrayList<SightVO>();
		result = dao.selectAll();
		return result;
	}
}
