package _02_TripAndJournal.model;

import java.util.List;

import _02_TripAndJournal.model.dao.JournalDetailDAOHibernate;

public class JournalDetailService {
	private JournalDetailDAOHibernate journalDetailDAOHibernate;

	// 由遊記編號搜尋遊記明細
	public List<JournalDetailVO> selectByJournalId(int journalId) {
		journalDetailDAOHibernate = new JournalDetailDAOHibernate();
		return journalDetailDAOHibernate.selectByJournalId(journalId);
	}


	public JournalDetailVO insert(JournalDetailVO vo){
		journalDetailDAOHibernate = new JournalDetailDAOHibernate();
		return journalDetailDAOHibernate.insert(vo);
	}



	public List<JournalDetailVO> getAll(){
		journalDetailDAOHibernate = new JournalDetailDAOHibernate();
		return journalDetailDAOHibernate.select();
	}

}
