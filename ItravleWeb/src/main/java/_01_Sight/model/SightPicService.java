package _01_Sight.model;

import java.util.List;

import _01_Sight.model.dao.SightPicDAOHibernate;

public class SightPicService {
	SightPicDAOHibernate dao = new SightPicDAOHibernate();

	public List<SightPicVO> selectBySightId(Integer sightId) {
		return dao.selectBySightId(sightId);
	}

	public SightPicVO selectMainPic(Integer sightId) {
		SightPicVO sightPicVO = null;
		List<SightPicVO> sightPicVOs = dao.selectBySightId(sightId);
		for (SightPicVO temp : sightPicVOs) {
			if (temp.getMainPic()) {
				sightPicVO = temp;
			}
		}
		return sightPicVO;
	}

	public SightPicVO insert(SightPicVO sightPicVO) {
		SightPicVO result = null;
		if (sightPicVO != null) {
			result = dao.insert(sightPicVO);
		}
		return result;
	}
	public SightPicVO update(SightPicVO sightPicVO){
		SightPicVO result = null;
		if (sightPicVO != null) {
			result = dao.update(sightPicVO);
		}
		return result;
	}
}
