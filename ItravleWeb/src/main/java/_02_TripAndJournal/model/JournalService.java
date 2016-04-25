package _02_TripAndJournal.model;

import java.util.ArrayList;
import java.util.List;

import _02_TripAndJournal.model.dao.JournalDAOHibernate;
import _05_Member.model.dao.CollectionDAOHibernate;

public class JournalService {
	private JournalDAOHibernate journalDAOHibernate;

	// 搜尋後按照收藏人次排
	public List<JournalVO> searchByCollectNum() {
		journalDAOHibernate = new JournalDAOHibernate();
		List<JournalVO> journalVOs = new ArrayList<JournalVO>();
		journalVOs = journalDAOHibernate.selectOrderByWatch();// 由進階查詢撈出的景點
		List<JournalVO> result = new ArrayList<JournalVO>();// 要放排序結果的List
		CollectionDAOHibernate collectionDAOHibernate = new CollectionDAOHibernate();
		List<Integer> list = collectionDAOHibernate
				.selectCountSight("type_id03");
		for (Integer journalId : list) { // 把景點ID List照順序拿出來
			for (JournalVO journalVO : journalVOs) {
				if (journalVO.getJournalId() == journalId) {// 如果景點ID在搜尋出的景點中
					result.add(select(journalId));// 就塞到result中
				}
			}
		}
		for (JournalVO temp : journalVOs) {// 把查詢出的結果一隻一隻抓出來
			if (!result.contains(temp)) {
				result.add(temp);// 如果result中沒有這隻 就塞在list後面
			}
		}
		return result;
	}

	// 照最後更新時間排序
	public List<JournalVO> selectOrderByModifyTime() {
		journalDAOHibernate = new JournalDAOHibernate();
		return journalDAOHibernate.selectOrderByModifyTime();
	}

	// 照瀏覽人次排序
	public List<JournalVO> selectOrderByWatch() {
		journalDAOHibernate = new JournalDAOHibernate();
		return journalDAOHibernate.selectOrderByWatch();
	}

	// 查詢遊記中包含特定景點的遊記 傳回JournalVO的List
	public List<JournalVO> getSightJournal(Integer sightId) {
		List<JournalVO> result = new ArrayList<JournalVO>();
		JournalDetailService journalDetailService = new JournalDetailService();
		JournalService journalService = new JournalService();
		List<JournalDetailVO> journalDetailVOs = journalDetailService.getAll();
		for (JournalDetailVO journalDetailVO : journalDetailVOs) {
			if (journalDetailVO.getSightId() == sightId) {// 參照編號為景點編號
				JournalVO journalVO = journalService.select(journalDetailVO
						.getJournalId());// 由detail查出遊記ID
				if (!result.contains(journalVO)) {// 如果result中沒有那筆遊記
					result.add(journalVO);
				}
			}
		}
		return result;
	}

	public JournalVO insert(JournalVO journalVO) {
		JournalVO result = null;
		if (journalVO != null) {
			journalDAOHibernate = new JournalDAOHibernate();
			result = journalDAOHibernate.insert(journalVO);
		}
		return result;
	}
	public JournalVO updateIntro(JournalVO journalVO) {
		JournalVO result = null;
		if (journalVO != null) {
			journalDAOHibernate = new JournalDAOHibernate();
			result = journalDAOHibernate.update(journalVO);
		}
		return result;
	}

	public boolean update(JournalVO journalVO) {
		journalDAOHibernate = new JournalDAOHibernate();
		if (journalVO != null) {
			journalDAOHibernate.update(journalVO);
			return true;
		}
		return false;

	}

	public JournalVO select(Integer journalId) {
		JournalVO result = null;
		if (journalId >= 0) {
			journalDAOHibernate = new JournalDAOHibernate();
			result = journalDAOHibernate.select(journalId);
		}
		return result;
	}

	// 會員尋找他寫的遊記
	public List<JournalVO> selectMemberJournal(Integer memberId) {
		List<JournalVO> result = null;
		journalDAOHibernate = new JournalDAOHibernate();
		result = journalDAOHibernate.selectByMemberId(memberId);
		return result;
	}

	// 查詢遊記相關明細編號
	public ArrayList<Integer> selectDetail(Integer journalId) {
		ArrayList<Integer> result = new ArrayList<Integer>();
		JournalDetailService journaldetailservice = new JournalDetailService();
		List<JournalDetailVO> journaldetailVO = journaldetailservice
				.selectByJournalId(journalId);
		if (journaldetailVO != null && journaldetailVO.size() > 0) {
			for (int i = 0; i < journaldetailVO.size(); i++) {
				result.add(journaldetailVO.get(i).getJournalDetailId());
			}
		}
		return result;
	}

	// 從遊記ID查出遊記
	public JournalVO selectMemberCollectionJournal(Integer journal_id) {
		JournalVO result = null;
		journalDAOHibernate = new JournalDAOHibernate();
		result = journalDAOHibernate.select(journal_id);
		return result;
	}
	//刪除一筆遊記
	public boolean deleteJournal(Integer journalId){
		journalDAOHibernate = new JournalDAOHibernate();
		if(journalId!=null){
			journalDAOHibernate.delete(journalId);
		return true;
		}
		return false;
	}
	// ELjoin時使用
	public List<JournalVO> getAll() {
		journalDAOHibernate = new JournalDAOHibernate();
		return journalDAOHibernate.select();
	}

	// 取得所有狀態為"已發佈"的行程
	public List<JournalVO> getAllPost() {
		List<JournalVO> result = new ArrayList<JournalVO>();
		journalDAOHibernate = new JournalDAOHibernate();
		List<JournalVO> all = journalDAOHibernate.select();
		for (JournalVO vo : all) {
			if (vo.getPost() == true) {
				result.add(vo);
			}
		}
		return result;
	}
}
