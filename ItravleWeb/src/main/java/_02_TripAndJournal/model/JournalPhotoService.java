package _02_TripAndJournal.model;

import java.util.List;

import _02_TripAndJournal.model.dao.JournalPhotoDAOHibernate;

public class JournalPhotoService {
	private JournalPhotoDAOHibernate journalPhotoDAOHibernate;

	public JournalPhotoVO selectCover(List<JournalDetailVO> journalDetailVOs) {
		journalPhotoDAOHibernate = new JournalPhotoDAOHibernate();
		return journalPhotoDAOHibernate.selectCover(journalDetailVOs);
	}

}
