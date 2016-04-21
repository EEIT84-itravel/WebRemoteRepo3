package _02_TripAndJournal.model;

import java.util.ArrayList;
import java.util.List;

import _02_TripAndJournal.model.dao.JournalDAOHibernate;
import _02_TripAndJournal.model.dao.TripDAOHibernate;

public class JournalService {
	private JournalDAOHibernate journalDAOHibernate;

	public JournalVO insert(JournalVO journalVO) {
		JournalVO result = null;
		if (journalVO != null) {
			journalDAOHibernate = new JournalDAOHibernate();
			result = journalDAOHibernate.insert(journalVO);
		}
		return result;
	}
	public boolean update(JournalVO journalVO){
		journalDAOHibernate = new JournalDAOHibernate();
		 if( journalVO != null){
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
	//會員尋找他寫的遊記
	public List<JournalVO> selectMemberJournal(Integer memberId){
		List<JournalVO> result = null;
		journalDAOHibernate = new JournalDAOHibernate();
		result = journalDAOHibernate.selectByMemberId(memberId);
		return result;
	}
	//查詢遊記相關明細編號
	public ArrayList<Integer> selectDetail(Integer journalId){
		ArrayList<Integer> result = new ArrayList<Integer>();
		JournalDetailService journaldetailservice = new JournalDetailService();
		List<JournalDetailVO> journaldetailVO = journaldetailservice.selectByJournalId(journalId);
		if(journaldetailVO != null && journaldetailVO.size()>0){
			for (int i = 0; i < journaldetailVO.size(); i++) {
				result.add(journaldetailVO.get(i).getJournalDetailId());
			}
		}
		return result;
	}
	//從遊記ID查出遊記
	public JournalVO selectMemberCollectionJournal(Integer journal_id){
		JournalVO result = null;
		journalDAOHibernate = new JournalDAOHibernate();
		result = journalDAOHibernate.select(journal_id);
		return result;
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
