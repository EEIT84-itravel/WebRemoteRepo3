package _05_Member.model;

import java.util.ArrayList;
import java.util.List;





import _02_TripAndJournal.model.JournalVO;
import _02_TripAndJournal.model.dao.JournalDAOHibernate;
import _05_Member.model.dao.CollectionDAOHibernate;

public class CollectionService {
    private CollectionDAOHibernate dao = new CollectionDAOHibernate();
    //會員收藏景點
    public CollectionVO collectionsight(CollectionVO collectionVO){
    	return dao.insert(collectionVO);
    }
    
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
	//會員尋找他的收藏遊記
	public ArrayList<Integer> selectjournalByMemberId(Integer memberId){
		List<CollectionVO> result = null;//所有收藏遊記
		ArrayList<Integer> journalID = new ArrayList<Integer>();
		result = dao.findJournalBymemberId(memberId);
		if(result!=null  && result.size() > 0){
			for(int i = 0 ; i<result.size(); i++){
				journalID.add(result.get(i).getReferenceType());
			}
		}
		return journalID;
		
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
