package _01_Sight.model;

import java.util.List;

import _01_Sight.model.dao.SightPicDAOHibernate;

public class SightPicService {
	SightPicDAOHibernate dao = new SightPicDAOHibernate();

	public static void main(String[] args) {
	}

	public SightPicVO selectBySightId(Integer sightId) {
		SightPicVO sightPicVO = null;
		List<SightPicVO> sightPicVOs = dao.selectBySightId(sightId);
		if (!sightPicVOs.isEmpty()) {
			sightPicVO = sightPicVOs.get(0);
		}
		return sightPicVO;
	}
}
