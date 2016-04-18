package _05_Member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import _02_TripAndJournal.model.JournalService;
import _02_TripAndJournal.model.JournalVO;

@WebServlet("/_05_Member/member/changejournalpost.controller")
public class ChangeJournalPostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	JournalService journalservice= new JournalService();
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//接收資料
		request.setCharacterEncoding("UTF-8");
		String temp = request.getParameter("journalId");
		JournalVO journalVO = new JournalVO();
		//轉換資料型態
		int journalId = 0;
		if(temp!=null && temp.trim().length()!=0){
			try {
				journalId = Integer.parseInt(temp);
			} catch (NumberFormatException e) {
				e.printStackTrace();
			}
		}
		journalVO = journalservice.select(journalId);
		if(journalVO.getPost()==true){
			journalVO.setPost(false);
		}else{
			journalVO.setPost(true);
		}
		boolean result = journalservice.update(journalVO);
		if(result == true){
			String path = request.getContextPath();
			response.sendRedirect(path+"/_05_Member/member/MemberJournal.jsp");
		}
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doGet(request, response);
	}

}
