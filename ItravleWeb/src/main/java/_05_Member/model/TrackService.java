package _05_Member.model;

import java.util.ArrayList;
import java.util.List;

import _05_Member.model.dao.TrackDAOHibernate;

public class TrackService {
	private TrackDAOHibernate trackDAO = new TrackDAOHibernate();;

	public boolean newTrack(int memberId, int followMember) {// 新增追蹤
		trackDAO = new TrackDAOHibernate();
		TrackVO track = new TrackVO();
		List<TrackVO> list = null;
		list = trackDAO.findByMemberIdAndFollowMember(memberId, followMember);
		System.out.println(list);
		if (list.size() != 0) {
			System.out.println("已經在追蹤了");
			return false;
		}
		track.setMemberId(memberId);
		track.setFollowMember(followMember);
		trackDAO.insert(track);
		System.out.println("新增追蹤成功");
		return true;

	}

	public boolean deleteTrack(int memberId, int followMember) {// 取消追蹤
		trackDAO = new TrackDAOHibernate();
		List<TrackVO> list = null;
		list = trackDAO.findByMemberIdAndFollowMember(memberId, followMember);
		if (list.size() != 0) {
			int trackNo = list.get(0).getTrackNo();
			trackDAO.delete(trackNo);
			System.out.println("成功刪除追蹤");
			return true;
		}
		System.out.println("刪除追蹤失敗");
		return false;
	}

	public List<Integer> findTrack(int memberId) {// 查看個人追蹤一覽
		List<TrackVO> list = trackDAO.findByMemberId(memberId);
		List<Integer> listname = new ArrayList<Integer>();
		if (list != null) {
			System.out.println("Success");
			for (int i = 0; i < list.size(); i++) {
				int a = list.get(i).getFollowMember();
				listname.add(a);
			}
			return listname;
		}
		System.out.println("false");
		return null;
	}
}
