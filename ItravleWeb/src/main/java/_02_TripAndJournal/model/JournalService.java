package _02_TripAndJournal.model;

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
}
