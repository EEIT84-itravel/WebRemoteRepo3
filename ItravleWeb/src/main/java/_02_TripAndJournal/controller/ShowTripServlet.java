package _02_TripAndJournal.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import _02_TripAndJournal.model.MessageService;
import _02_TripAndJournal.model.MessageVO;
import _02_TripAndJournal.model.TripDetailService;
import _02_TripAndJournal.model.TripDetailVO;
import _02_TripAndJournal.model.TripService;
import _02_TripAndJournal.model.TripVO;
import _05_Member.model.CollectionService;
import _05_Member.model.FriendService;
import _05_Member.model.MemberVO;

@WebServlet("/_02_TripAndJournal/ShowTrip.controller")
public class ShowTripServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	//顯示單一行程的servlet

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// 接收資料
		String temp1 = request.getParameter("tripId");
		System.out.println(temp1);

		Map<String, String> error = new HashMap<String, String>();
		request.setAttribute("error", error);

		// 驗證資料
		int tripId = 0;
		if (temp1 != null && temp1.trim().length() != 0) {
			try {
				tripId = Integer.parseInt(temp1);
			} catch (NumberFormatException e) {
				e.printStackTrace();
			}
		}

		// 轉換資料

		// 呼叫model
		
		TripService tripService = new TripService();
		TripVO tripVO = tripService.select(tripId);
		// 點一次就增加瀏覽人次
		tripVO.setWatchNum(tripVO.getWatchNum()+1);
		tripService.update(tripVO);
		System.out.println(tripVO);
		request.setAttribute("tripVO", tripVO);
		TripDetailService tripDetailService = new TripDetailService();
		List<TripDetailVO> result = tripDetailService.select(tripId);
		List<TripDetailVO> tripDetailVOs = new LinkedList<TripDetailVO>();
		//取出"景點"性質的tripDetailVO
		for(TripDetailVO tripDetailVO: result){
			if(tripDetailVO.getReferenceType().equals("type_id01")){
				tripDetailVOs.add(tripDetailVO);
			}
		}
		request.setAttribute("tripDetailVOs", tripDetailVOs);
		
		//搜尋行程相關留言
		MessageService messageService=new MessageService();
		List<MessageVO> messageVOs=messageService.selectTripMessage(tripId);
		request.setAttribute("messageVOs", messageVOs);
		
		// 會員已登入且行程未收藏過會顯示行程收藏鈕
		boolean flag = false;
		CollectionService collectionService = new CollectionService();
		MemberVO user = (MemberVO) request.getSession().getAttribute("user");
		if (user != null&& collectionService.selectCollection(tripVO.getTripId(),user.getMemberId(), "type_id02") == null) {
			flag = true;
			}
		request.setAttribute("flag", flag);
		//會員已登入且作者未收藏過會顯示作者收藏鈕
		boolean flagmember = false;
		FriendService friendservice= new FriendService();
		if(user != null && user.getMemberId()!=tripVO.getMemberId() && friendservice.isfriend(user.getMemberId(), tripVO.getMemberId())==false){
			flagmember = true;
		}
		request.setAttribute("flagmember", flagmember);
		// 根據結果選擇veiw
		request.getRequestDispatcher("/_02_TripAndJournal/Trip.jsp").forward(request, response);
	}
}
