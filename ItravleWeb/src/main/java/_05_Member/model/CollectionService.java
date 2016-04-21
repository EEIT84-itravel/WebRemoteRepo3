package _05_Member.model;

import java.util.ArrayList;
import java.util.List;










import _02_TripAndJournal.model.TripService;
import _02_TripAndJournal.model.TripVO;
import _04_Forum.model.ForumService;
import _04_Forum.model.ForumVO;
import _05_Member.model.dao.CollectionDAOHibernate;

public class CollectionService {
    private CollectionDAOHibernate dao = new CollectionDAOHibernate();
    private TripService tripservice = new TripService();
    private ForumService forumservice = new ForumService();
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
	//會員找他的收藏行程  並且是找已經發布狀態的
	public ArrayList<TripVO> selectTripCollectionByMemberId(Integer memberId){
		List<CollectionVO> result = null;//所有收藏行程
		ArrayList<Integer> tripID = new ArrayList<Integer>();
		result = dao.findTriplBymemberId(memberId);
		if(result!=null  && result.size() > 0){
			for(int i = 0 ; i<result.size(); i++){
				tripID.add(result.get(i).getReferenceType());
			}
		}
		
		List<TripVO> list = new ArrayList<TripVO>();
		ArrayList<TripVO> tripVO = new ArrayList<TripVO>();
		if(tripID!=null &&tripID.size()>0){
		for(int i = 0 ; i<tripID.size();i++){
			list.add(i, tripservice.select(tripID.get(i)));
		}
		}
		if(list!=null&& list.size()>0){
		for(int i = 0 ;i<list.size();i++){
			if(list.get(i).getPost()==true){
				tripVO.add(list.get(i));
			}
		}
		}
		return tripVO;
	}
	//會員尋找他的收藏討論區
	public ArrayList<ForumVO> selectFourmCollectionByMemberId(Integer memberId){
		List<CollectionVO> result = null;//所有收藏討論區
		ArrayList<Integer> fourmID = new ArrayList<Integer>();
		result = dao.findForumlBymemberId(memberId);
		if(result!=null  && result.size() > 0){
			for(int i = 0 ; i<result.size(); i++){
				fourmID.add(result.get(i).getReferenceType());
			}
		}
		
		
		ArrayList<ForumVO> forumVO = new ArrayList<ForumVO>();
		if(fourmID!=null &&fourmID.size()>0){
		for(int i = 0 ; i<fourmID.size();i++){
			forumVO.add(i, forumservice.selectOne(fourmID.get(i)));
		}
		}
		return forumVO;
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
