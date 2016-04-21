package _05_Member.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import _02_TripAndJournal.model.JournalService;
import _02_TripAndJournal.model.JournalVO;
import _02_TripAndJournal.model.TripService;
import _02_TripAndJournal.model.TripVO;
import _05_Member.model.CollectionService;
@WebServlet("/_05_Member/member/findauthor.controller")
public class FindAuthorServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	TripService tripservice = new TripService();
	JournalService journalservice = new JournalService();
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		  //接收資料
		request.setCharacterEncoding("UTF-8");
		Integer memberId = null;
		String temp1 = request.getParameter("memberId");
		//轉換資料的型態 memberId
		if(temp1 != null && temp1.trim().length()!=0){
			memberId = Integer.parseInt(temp1);
		}else{
			System.out.println("缺少會員編號");
		}
		//處理資料
		List<TripVO> tripVO = tripservice.selectFromMember(memberId);
		List<JournalVO> journalVO = journalservice.selectMemberJournal(memberId);
		HttpSession session = request.getSession();
		session.setAttribute("tripVO", tripVO);
		session.setAttribute("journalVO", journalVO);
		//秀回畫面
		String path = request.getContextPath();
		response.sendRedirect(path+"/_05_Member/member/Author.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doGet(request, response);
	}

}
