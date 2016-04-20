package _02_TripAndJournal.model;

import java.util.List;

import _02_TripAndJournal.model.dao.JournalDAOHibernate;

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
	public JournalVO update(JournalVO journalVO) {
		JournalVO result = null;
		if (journalVO != null) {
			journalDAOHibernate = new JournalDAOHibernate();
			result = journalDAOHibernate.update(journalVO);
		}
		return result;
	}
	
	public JournalVO select(Integer journalId) {
		JournalVO result = null;
		if (journalId >= 0) {
			journalDAOHibernate = new JournalDAOHibernate();
			result = journalDAOHibernate.select(journalId);
		}
		return result;
	}
	
	// ELjoin時使用
	public List<JournalVO> getAll() {
		journalDAOHibernate = new JournalDAOHibernate();
		return journalDAOHibernate.select();
	}
}
