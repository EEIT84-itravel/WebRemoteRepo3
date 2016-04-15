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
	//以會員編號、景點編號、類型編號搜尋某筆收藏
	public Integer selectCollection(Integer referenceType,Integer memberId,String typeId){
		List<CollectionVO> result = dao.findBymemberIdAndsightIdAndtypeId(referenceType, memberId, typeId);
		Integer a  = null;
		if(result.size() > 0){
		  	a = result.get(0).getCollectionNo();
		}
		return a;
	}
	//刪除收藏
	public boolean delSightCollection(Integer collectionNo){
		CollectionVO result = dao.findByPrimaryKey(collectionNo);
		if(result != null){
			dao.delete(collectionNo);
			return true;
		}
		return false;
	}
}
