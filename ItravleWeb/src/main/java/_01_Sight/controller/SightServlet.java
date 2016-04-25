package _01_Sight.controller;

import java.io.IOException;
import java.sql.Time;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import antlr.StringUtils;
import _00_Misc.model.CodeService;
import _00_Misc.model.CodeVO;
import _01_Sight.model.SightService;
import _01_Sight.model.SightVO;
import _02_TripAndJournal.model.JournalService;
import _02_TripAndJournal.model.JournalVO;
import _02_TripAndJournal.model.MessageService;
import _02_TripAndJournal.model.MessageVO;
import _02_TripAndJournal.model.TripService;
import _02_TripAndJournal.model.TripVO;
import _05_Member.model.CollectionService;
import _05_Member.model.MemberService;
import _05_Member.model.MemberVO;

@WebServlet("/_01_Sight/Sight.controller")
public class SightServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
//查詢單一景點資料
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		// 接收HTML Form資料
		String temp1 = request.getParameter("sightId"); // 景點編號

		// 驗證HTML Form資料
		Map<String, String> error = new HashMap<String, String>();
		request.setAttribute("error", error);
		int sightId = 0;
		if (temp1 != null || temp1.trim().length() != 0) {
			sightId = Integer.parseInt(temp1);
		}

		// 呼叫Model
		SightService sightService = new SightService();
		SightVO sightVO = sightService.findByPrimaryKey(sightId);
		//將瀏覽人次加1
		sightVO.setWatchNum(sightVO.getWatchNum()+1);
		SightVO result=sightService.update(sightVO);
		//查詢景點相關留言
		MessageService messageService=new MessageService();
		List<MessageVO> messageVOs=messageService.selectSightMessage(sightId);
		//查詢景點相關行程
		TripService tripService=new TripService();
		List<TripVO> tripVOs= tripService.getSightTrip(sightId);
		//查詢景點相關遊記
		JournalService journalService=new JournalService();
		List<JournalVO> journalVOs=journalService.getSightJournal(sightId);
		

		// 根據Model執行結果顯示View
		if (result == null) {
			error.put("sightId", "此景點不存在");
			request.getRequestDispatcher("/_01_Sight/SightIndex.jsp").forward(
					request, response);
		} else {
			boolean flag = false;
			CollectionService collectionService = new CollectionService();
			MemberVO user = (MemberVO) request.getSession().getAttribute("user");
			// 會員已登入且景點未收藏過會顯示景點收藏鈕
			if (user != null&& collectionService.selectCollection(sightVO.getSightId(),user.getMemberId(), "type_id01") == null) {
				flag = true;
			}
			request.setAttribute("flag", flag);
			request.setAttribute("sightVO", result);
			request.setAttribute("messageVOs", messageVOs);
			request.setAttribute("tripVOs", tripVOs);
			request.setAttribute("journalVOs", journalVOs);
			request.setAttribute("openTime", result.getOpenTime().toString().substring(0, 5));
			request.setAttribute("closeTime", result.getCloseIime().toString().substring(0, 5));
			request.setAttribute("trans",result.getTrans());
			request.getRequestDispatcher("/_01_Sight/SightInformation.jsp").forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		this.doGet(request, response);
	}
}
