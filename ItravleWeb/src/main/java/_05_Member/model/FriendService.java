package _05_Member.model;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import _05_Member.model.FriendVO;
import _05_Member.model.dao.FriendDAOHibernate;

public class FriendService {
	private FriendDAOHibernate friendDAO = new FriendDAOHibernate();

	public ArrayList<Integer> findFriend(Integer memberId){  //找朋友名單
		List<FriendVO> list = new ArrayList<FriendVO>();
		 list = friendDAO.selectbyMemberId(memberId);
		 for(FriendVO VO: list){
			 System.out.println(VO);
		 }
		 ArrayList<Integer> listname = new ArrayList<Integer>();
		 if(!list.isEmpty()){
			 for(int i = 0; i < list.size();i++){
				 if((list.get(i)).getIsfriend()){
				 int a = list.get(i).getFriendId();
				 listname.add(a);
				 }
			 }
		 }
		 return listname;
	 }
    //某個繪員是否是你的好友
	public boolean isfriend(Integer memberId,Integer memberId2){
		List<FriendVO> list = new ArrayList<FriendVO>();
		 list = friendDAO.selectbyMemberIdAndFriendId(memberId,memberId2);
		 if(!list.isEmpty()){
			 return true;
		 }
		return false; 
	}
	public ArrayList<Integer> findNotFriend(Integer memberId) { // 找黑名單名單
		List<FriendVO> list = friendDAO.selectbyMemberId(memberId);
		ArrayList<Integer> listname = new ArrayList<Integer>();
		if (list != null) {
			System.out.println("Success");
			for (int i = 0; i < list.size(); i++) {
				if (list.get(i).getIsfriend() == false) {
					int a = list.get(i).getFriendId();
					listname.add(a);
				}
			}
			return listname;
		}
		System.out.println("false");
		return null;
	}

	public Boolean newFriend(Integer memberId, Integer friendId) { // 增加好友
		FriendVO newfriendVo = new FriendVO();
		ArrayList<Integer> list = this.findFriend(memberId);
		ArrayList<Integer> listbad = this.findNotFriend(memberId);
		for (int i = 0; i < list.size(); i++) {
			if (list.get(i).equals(friendId) == true) {
				System.out.println("已經是好友");
				return false;
			}
		}
		for (int i = 0; i < listbad.size(); i++) {
			if (listbad.get(i).equals(friendId) == true) {
				System.out.println("已經在黑名單");
				return false;
			}
		}
		newfriendVo.setMemberId(memberId);
		newfriendVo.setFriendId(friendId);
		newfriendVo.setIsfriend(true);
		friendDAO.insert(newfriendVo);
		// System.out.println("新增好友成功");
		return true;
	}

	public Boolean newBadFriend(Integer memberId, Integer friendId) { // 增加黑名單
		FriendVO newfriendVo = new FriendVO();
		ArrayList<Integer> list = this.findFriend(memberId);
		ArrayList<Integer> listbad = this.findNotFriend(memberId);
		for (int i = 0; i < list.size(); i++) {
			if (list.get(i).equals(friendId) == true) {
				// System.out.println("已經是好友");
				return false;
			}
		}
		for (int i = 0; i < listbad.size(); i++) {
			if (listbad.get(i).equals(friendId) == true) {
				// System.out.println("已經在黑名單");
				return false;
			}
		}
		newfriendVo.setMemberId(memberId);
		newfriendVo.setFriendId(friendId);
		newfriendVo.setIsfriend(false);
		friendDAO.insert(newfriendVo);
		// System.out.println("新增黑名單成功");
		return true;
	}

	public Boolean updateBadFriendToNew(Integer memberId, Integer friendId) { // 將黑名單改為好友
		FriendVO upfriendVo = new FriendVO();
		List<FriendVO> list = friendDAO.selectbyMemberIdAndFriendId(memberId,
				friendId);
		int friendno = list.get(0).getFriendNo();
		upfriendVo.setFriendNo(friendno);
		upfriendVo.setFriendId(friendId);
		upfriendVo.setMemberId(memberId);
		upfriendVo.setIsfriend(true);
		friendDAO.update(upfriendVo);
		List<FriendVO> listafter = friendDAO.selectbyMemberIdAndFriendId(
				memberId, friendId);
		if (listafter.get(0).getIsfriend() == true) {
			// System.out.println("成功從黑名單改為好友");
			return true;
		} else {
			// System.out.println("改為好友不成功");
			return false;
		}
	}

	public Boolean updateFriendToBAD(Integer memberId, Integer friendId) { // 將好友改為黑名單
		FriendVO upfriendVo = new FriendVO();
		List<FriendVO> list = friendDAO.selectbyMemberIdAndFriendId(memberId,
				friendId);
		int friendno = list.get(0).getFriendNo();
		upfriendVo.setFriendNo(friendno);
		upfriendVo.setFriendId(friendId);
		upfriendVo.setMemberId(memberId);
		upfriendVo.setIsfriend(false);
		friendDAO.update(upfriendVo);
		List<FriendVO> listafter = friendDAO.selectbyMemberIdAndFriendId(
				memberId, friendId);
		if (listafter.get(0).getIsfriend() == false) {
			// System.out.println("成功從好友改為黑名單");
			return true;
		} else {
			// System.out.println("改為黑名單不成功");
			return false;
		}
	}

	// 尋找對方尚未確認好友FindNotyetFriend
	public Set<Integer> findNotyetFriend(Integer memberId) {
		Set<Integer> result = new HashSet<Integer>();// 待確認名單
		List<Integer> EachOtherlist = this.findEachOtherFriend(memberId); // 互相是好友
		// System.out.println("互相是好友"+EachOtherlist);
		List<Integer> Myfriendlist = this.findFriend(memberId);// 自己的好友
		// System.out.println("自己的好友"+Myfriendlist);
		int a = EachOtherlist.size();// 互相是好友的陣列長度
		int b = Myfriendlist.size();// 自己的好友的陣列長度
		if (b > a || a == b) {
			result.clear();
			result.addAll(Myfriendlist);
			result.removeAll(EachOtherlist);
			// System.out.println("對方尚未加你為好友："+result);
		} else {
			result.clear();
			result.addAll(EachOtherlist);
			result.removeAll(Myfriendlist);
			// System.out.println("對方尚未加你為好友："+result);
		}
		return result;
	}

	// 尋找對方加你為好友但你尚未確認FindNotyetFriendByMe
	public Set<Integer> findNotyetFriendByMe(Integer memberId) {
		Set<Integer> result = new HashSet<Integer>();// 待確認名單
		List<Integer> Myfriendlist = this.findFriend(memberId);// 自己的好友
		// System.out.println(Myfriendlist+"自己的好友");
		List<Integer> friendlistByMe = friendDAO.findFriendToId(memberId);// friend有自己的
		// System.out.println(friendlistByMe+"friend有自己的");
		int a = friendlistByMe.size();// friend有自己的陣列長度
		int b = Myfriendlist.size();// 自己的好友的陣列長度
		if (b > a || a == b) {
			result.clear();
			result.addAll(friendlistByMe);
			result.removeAll(Myfriendlist);
			// System.out.println("你尚未加對方為好友："+result);
		} else {
			result.clear();
			result.addAll(Myfriendlist);
			result.removeAll(friendlistByMe);
			// System.out.println("你尚未加對方為好友："+result);
		}
		return result;
	}

	// 互相是好友
	public ArrayList<Integer> findEachOtherFriend(Integer memberId) {
		ArrayList<Integer> friendlist = this.findFriend(memberId);// 自己的好友名單
		List<FriendVO> friendIdlist = friendDAO.selectbyFriendId(memberId);
		ArrayList<Integer> friendlist2 = new ArrayList<Integer>(); // 自己被加好友的名單
		// friendlist、friendlist2不同處=Notyetlist(待確認)內容
		// friendlist2與尚未被對方加入好友的名單(Notyetlist)取差集=對方邀請你成為好友的待確認名單(list3)
		ArrayList<Integer> list3 = new ArrayList<Integer>();// 互相是好友
		for (int i = 0; i < friendIdlist.size(); i++) {
			int a = friendIdlist.get(i).getMemberId();
			friendlist2.add(a);
		}
		if (friendlist2.size() > friendlist.size()
				|| friendlist2.size() == friendlist.size()) {// 開始比對
			for (int i = 0; i < friendlist2.size(); i++) {
				for (int i2 = 0; i2 < friendlist.size(); i2++) {
					if (friendlist2.get(i).equals(friendlist.get(i2)) == true) {
						list3.add(friendlist2.get(i));
					}
				}
			}
		} else {
			for (int i = 0; i < friendlist.size(); i++) {
				for (int i2 = 0; i2 < friendlist2.size(); i2++) {
					if (friendlist.get(i).equals(friendlist2.get(i2)) == true) {
						list3.add(friendlist.get(i));
					}
				}
			}
			// System.out.println(list3);
		}
		return list3;
	}

	public boolean delFriend(Integer memberId, Integer friendId) { // 刪除好友
		FriendVO newfriendVo = new FriendVO();
		List<FriendVO> list = friendDAO.selectbyMemberIdAndFriendId(memberId,
				friendId);
		if (list.size() > 0) {
			if (list.get(0).getIsfriend() == true) {
				int delid = list.get(0).getFriendNo();
				friendDAO.delete(delid);
				// System.out.println("刪除成功");
				return true;
			}
		}
		// System.out.println("刪除失敗");
		return false;
	}

	public boolean delBadFriend(Integer memberId, Integer friendId) { // 刪除黑名單
		FriendVO newfriendVo = new FriendVO();
		List<FriendVO> list = friendDAO.selectbyMemberIdAndFriendId(memberId,
				friendId);
		if (list.size() > 0) {
			if (list.get(0).getIsfriend() == false) {
				int delid = list.get(0).getFriendNo();
				friendDAO.delete(delid);
				// System.out.println("刪除成功");
				return true;
			}
		}
		// System.out.println("刪除失敗");
		return false;
	}
	
}
