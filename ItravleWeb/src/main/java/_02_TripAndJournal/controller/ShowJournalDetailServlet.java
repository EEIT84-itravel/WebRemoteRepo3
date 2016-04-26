package _02_TripAndJournal.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import _02_TripAndJournal.model.JournalDetailService;
import _02_TripAndJournal.model.JournalDetailVO;
import _02_TripAndJournal.model.JournalService;
import _02_TripAndJournal.model.JournalVO;
import _02_TripAndJournal.model.MessageService;
import _02_TripAndJournal.model.MessageVO;
import _05_Member.model.CollectionService;
import _05_Member.model.FriendService;
import _05_Member.model.MemberVO;

@WebServlet("/_02_TripAndJournal/ShowJournalDetail.controller")
public class ShowJournalDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	//顯示單一遊記的servlet

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// 接收資料
		request.setCharacterEncoding("UTF-8");
		String temp1 = request.getParameter("journalId");

		Map<String, String> error = new HashMap<String, String>();
		request.setAttribute("error", error);

		// 轉換資料
		int journalId = 0;
		if (temp1 != null && temp1.trim().length() != 0) {
			try {
				journalId = Integer.parseInt(temp1);
			} catch (NumberFormatException e) {
				e.printStackTrace();
			}
		}
		// 驗證資料-無
		
		// 呼叫Model
		
		//根據遊記ID搜尋出該篇遊記所有的遊記detail
		JournalDetailService journalDetailService = new JournalDetailService();
		List<JournalDetailVO> journalDetailVO = journalDetailService.selectByJournalId(journalId);
		
		JournalService journalService = new JournalService();
		JournalVO journalVO = journalService.select(journalId);
		// 將瀏覽人次加1
		journalVO.setVisitorNum(journalVO.getVisitorNum() + 1);
		journalService.update(journalVO);
		
		//搜尋遊記相關留言
		MessageService messageService=new MessageService();
		List<MessageVO> messageVOs=messageService.selectJournalMessage(journalId);
		
		request.setAttribute("showJournalVO", journalVO);
		request.setAttribute("showJournalDetailVO", journalDetailVO);
		request.setAttribute("messageVOs", messageVOs);
		
		// 會員已登入且景點未收藏過會顯示景點收藏鈕
		boolean flag = false;
		CollectionService collectionService = new CollectionService();
		MemberVO user = (MemberVO) request.getSession().getAttribute("user");
		if (user != null&& collectionService.selectCollection(journalVO.getJournalId(),user.getMemberId(), "type_id03") == null) {
			flag = true;
		}
		request.setAttribute("flag", flag);
		//會員已登入且作者未收藏過會顯示作者收藏鈕
		boolean flagmember = false;
		FriendService friendservice= new FriendService();
		if(user != null && user.getMemberId()!=journalVO.getMemberId() && friendservice.isfriend(user.getMemberId(), journalVO.getMemberId())==false){
			flagmember = true;
		}
		System.out.println(flagmember);
		request.setAttribute("flagmember", flagmember);
				
		request.getRequestDispatcher("/_02_TripAndJournal/ShowJournal.jsp").forward(request, response);
	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}

}
