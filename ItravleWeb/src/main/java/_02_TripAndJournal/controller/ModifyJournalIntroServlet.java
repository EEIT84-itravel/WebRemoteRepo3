package _02_TripAndJournal.controller;

import java.io.IOException;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import _02_TripAndJournal.model.JournalService;
import _02_TripAndJournal.model.JournalVO;


@WebServlet("/_02_TripAndJournal/member/ModifyJournalIntro.controller")
public class ModifyJournalIntroServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		Map<String, String> error = new HashMap<String, String>();
		request.setAttribute("error", error);

		//接收資料
		String journalName = request.getParameter("journalName");
		String regionId = request.getParameter("regionId");
		String journalIntro = request.getParameter("journalIntro");
		String temp1 = request.getParameter("journalStartDate");
		String temp2 = request.getParameter("journalEndDate");
		String temp3 = request.getParameter("journalId");
		String temp4 = request.getParameter("memberId");
        		
		//轉換型態
		java.sql.Date journalStartDate = null;
		if (temp1 != null && temp1.trim().length() != 0) {
				journalStartDate = Date.valueOf(temp1);
		}
		java.sql.Date journalEndDate = null;
		if (temp2 != null && temp2.trim().length() != 0) {		
				journalEndDate = Date.valueOf(temp2);			
		}
		int journalId = 0;
		if (temp3 != null || temp3.trim().length() != 0) {
			try {
				journalId = Integer.parseInt(temp3);
			} catch (NumberFormatException e) {
				e.printStackTrace();
			}
		}
		
		int memberId = 0;
		if (temp4 != null || temp4.trim().length() != 0) {
			try {
				memberId = Integer.parseInt(temp4);
			} catch (NumberFormatException e) {
				e.printStackTrace();
			}
		}
		//錯誤處理
		if(journalName==null || journalName.trim().length()==0){
			error.put("journalName", "請輸入遊記名稱");
		}
		if(journalIntro==null || journalIntro.trim().length()==0){
			error.put("journalIntro", "請輸入遊記簡介");
		}
		if (error != null && !error.isEmpty()) {
			request.getRequestDispatcher("/_02_TripAndJournal/member/WriteJournal.jsp")
					.forward(request, response);
			return;
		}
		//呼叫model
		JournalVO journalVO = new JournalVO();
		JournalService js = new JournalService();
		journalVO.setMemberId(memberId);
		journalVO.setBeginTime(journalStartDate);
		journalVO.setEndTime(journalEndDate);
		journalVO.setJournalId(journalId);
		journalVO.setJournalIntro(journalIntro);
		journalVO.setJournalName(journalName);
		journalVO.setModifyTime(new Timestamp(new Date(0).getTime()));
		journalVO.setRegionId(regionId);
		journalVO.setPost(false);
		journalVO.setVisitorNum(0);
		JournalVO result = js.updateIntro(journalVO);
		request.setAttribute("journalVO", result);
		request.getRequestDispatcher("/_02_TripAndJournal/member/WriteJournal.jsp")
		.forward(request, response);
return;
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}
}
