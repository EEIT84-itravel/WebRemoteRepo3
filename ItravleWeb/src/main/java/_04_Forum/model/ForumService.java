package _04_Forum.model;

import java.util.List;
import _04_Forum.model.dao.ForumDAOHibernate;

public class ForumService {

	private ForumDAOHibernate fDao = new ForumDAOHibernate();	

	 public List<ForumVO> select() {
	 List<ForumVO> result = null;
	 result = fDao.select();
	 return result;
	 }
	 
	 public ForumVO selectOne(Integer forumId){
		 return fDao.select(forumId);
	 }
	 
	 public List<ForumVO> getForumType(String forumTypeId) {
		return fDao.getForumType(forumTypeId);	 
	 }
//	public List<ForumVO> select(ForumVO vo) {
//		List<ForumVO> result = null;
//		if(vo!=null && vo.getForumId()!=0) {
//			ForumVO temp = fDao.select(vo.getForumId());
//			if(temp!=null) {
//				result = new ArrayList<ForumVO>();
//				result.add(temp);
//			}
//		} else {
//			result = fDao.select(); 
//		}
//		return result;
//	}
    //會員找自己的討論區
	public List<ForumVO> selectMemberForum(Integer memberId){
		List<ForumVO> result = null;
		result = fDao.selectByMemberId(memberId);
		return result;
	}
	 
	public ForumVO insert(ForumVO vo) {
		ForumVO result = null;
		if (vo != null) {
			result = fDao.insert(vo);
		}
		return result;
	}

	public ForumVO update(ForumVO vo) {
		ForumVO result = null;
		if (vo != null) {
			result = fDao.update(vo);
		}
		return result;
	}

	public boolean delete(ForumVO vo) {
		boolean result = false;
		if (vo != null) {
			result = fDao.delete(vo.getForumId());
		}
		return result;
	}
}
