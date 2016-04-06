package _01_Sight.model;

import java.util.List;
import _01_Sight.model.dao.SightDAOHibernate;

public class SightService {
	private SightDAOHibernate dao = new SightDAOHibernate();
	
	public List<SightVO> selectByWatchNum(){
		List<SightVO> result = null;
		result = dao.selectByWatchNum();		
		return result;
	}//新增(按瀏覽人次排列)
	
	public List<SightVO> select(){
		List<SightVO> result = null;
		result = dao.selectAll();		
		return result;
	}
	
	public List<SightVO> selectByType(String sightType) {
		List<SightVO> result = null;
		result = dao.selectByType(sightType);		
		return result;
	}

}
