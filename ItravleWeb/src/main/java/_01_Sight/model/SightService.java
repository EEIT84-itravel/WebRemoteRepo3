package _01_Sight.model;

import java.util.ArrayList;
import java.util.List;

import _01_Sight.model.dao.SightDAOHibernate;
import _05_Member.model.dao.CollectionDAOHibernate;

public class SightService {
	private SightDAOHibernate dao = new SightDAOHibernate();
	
	//景點按照景點Id排序 後台用
	public List<SightVO> selectAllbySightId() {
		return dao.selectAllbySightId();
	}

	// 搜尋後按照收藏人次排
	public List<SightVO> searchByCollectNum(SightVO sightVOp) {
		List<SightVO> sightVOs = new ArrayList<SightVO>();
		sightVOs = dao.search(sightVOp);// 由進階查詢撈出的景點
		List<SightVO> result = new ArrayList<SightVO>();// 要放排序結果的List
		CollectionDAOHibernate collectionDAOHibernate = new CollectionDAOHibernate();
		List<Integer> list = collectionDAOHibernate.selectCountSight("type_id01");
		for (Integer sightId : list) { // 把景點ID List照順序拿出來
			for (SightVO sightVO : sightVOs) {
				if (sightVO.getSightId() == sightId) {// 如果景點ID在搜尋出的景點中
					result.add(findByPrimaryKey(sightId));// 就塞到result中
				}
			}
		}
		for (SightVO temp : sightVOs) {// 把查詢出的結果一隻一隻抓出來
			if(!result.contains(temp)){
					result.add(temp);// 如果result中沒有這隻 就塞在list後面
				}
			}
		return result;
	}

	// 進階搜尋測試
	public List<SightVO> search(SightVO sightVOp) {
		return dao.search(sightVOp);
	}

	// 搜尋後按最後更新時間排
	public List<SightVO> searchByModifyTime(SightVO sightVOp) {
		return dao.searchByModifyTime(sightVOp);
	}

	// 景點資訊超連結
	public SightVO findByPrimaryKey(Integer sightId) {
		return dao.findByPrimaryKey(sightId);
	}

	// 全部景點(首頁)
	public List<SightVO> select() {
		return dao.selectAll();
	}

	// EL使用.all呼叫
	public List<SightVO> getAll() {
		return dao.selectAll();
	}

	public List<SightVO> selectByType(String sightType) {
		List<SightVO> result = null;
		result = dao.selectByType(sightType);
		return result;
	}

	public SightVO selectById(Integer sightId) {
		SightVO result = null;
		result = dao.findByPrimaryKey(sightId);
		return result;
	}

	public SightVO insert(SightVO sightVO) {
		SightVO result = null;
		if (sightVO != null) {
			result = dao.insert(sightVO);
		}
		return result;
	}

	public SightVO update(SightVO sightVO) {
		SightVO result = null;
		if (sightVO != null) {
			result = dao.update(sightVO);
		}
		return result;
	}

	// 依縣市搜尋景點
	public List<SightVO> selectByCounty(String countyId) {
		return dao.selectByCounty(countyId);
	}

}
