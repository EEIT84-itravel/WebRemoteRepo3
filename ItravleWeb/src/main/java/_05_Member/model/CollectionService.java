package _05_Member.model;

import java.util.List;


import _05_Member.model.dao.CollectionDAOHibernate;

public class CollectionService {
    private CollectionDAOHibernate dao = new CollectionDAOHibernate();
    
    //某會員搜尋他的收藏景點
	public List<CollectionVO> selectByMemberId(Integer memberId){
		List<CollectionVO> result = null;
		result = dao.findSightByMemberId(memberId);
		return result;
	}
}
