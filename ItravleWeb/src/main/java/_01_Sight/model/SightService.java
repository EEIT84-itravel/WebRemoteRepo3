package _01_Sight.model;


import java.util.Arrays;
import java.util.List;

import _00_Misc.model.CodeVO;
import _01_Sight.model.dao.SightDAOHibernate;

public class SightService {
	private SightDAOHibernate dao = new SightDAOHibernate();

	// 進階搜尋測試
	public List<SightVO> search(SightVO sightVOp) {
		return dao.search(sightVOp);
	}

	// 景點資訊超連結
	public SightVO findByPrimaryKey(Integer sightId) {
		return dao.findByPrimaryKey(sightId);
	}

	// 景點按瀏覽人次排列(首頁)
	public List<SightVO> selectByWatchNum() {
		return dao.selectByWatchNum();
	}

	// 全部景點(首頁)
	public List<SightVO> select() {
		return dao.selectAll();
	}
	//EL使用.all呼叫
	public List<SightVO> getAll(){
		return dao.selectAll();
	}

	public List<SightVO> selectByType(String sightType) {
		List<SightVO> result = null;
		result = dao.selectByType(sightType);
		return result;
	}

}
