package _04_Forum.model;

import java.util.ArrayList;
import java.util.List;

import _04_Forum.model.dao.ForumDAOHibernate;

public class ForumService {

	private ForumDAOHibernate fDao;

	public List<ForumVO> select() {
		List<ForumVO> result = null;
		result = fDao.select();
		return result;
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
			result = fDao.update(vo.getForumId(), vo.getForumTypeId(),
					vo.getForumTopic(), vo.getMemberId(), vo.getForumTime(),
					vo.getForumContent(), vo.getVisitorNum(), vo.getReplyNum());
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
