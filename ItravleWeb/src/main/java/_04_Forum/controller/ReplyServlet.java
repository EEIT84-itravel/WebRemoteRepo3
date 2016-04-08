package _04_Forum.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import _02_TripAndJournal.model.MessageService;
import _02_TripAndJournal.model.MessageVO;


@WebServlet("/_04_Forum/member/Reply.controller")
public class ReplyServlet extends HttpServlet {

    //回覆文章前驗證是否登入
 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	request.setCharacterEncoding("UTF-8");
	// 接收資料
	
	String temp1 = request.getParameter("forumId");
	
	// 轉換資料
	Map<String, String> error = new HashMap<String, String>();
	request.setAttribute("error", error);
	
	int forumId = 0;
	if(temp1 != null || temp1.trim().length() != 0 ){
		try {
			forumId = Integer.parseInt(temp1);
		} catch (NumberFormatException e) {
			e.printStackTrace();
		}
	}
	//把抓到的forumId存入Session
	HttpSession session = request.getSession();
	session.setAttribute("referenceNo", forumId);
	
	//驗證

//	if( error != null && !error.isEmpty()){
//		request.getRequestDispatcher("/_04_Forum/member/Reply.jsp").forward(request, response);
//		return;
//	}
//	
	//呼叫model
	MessageService ms = new MessageService();
	MessageVO messageVO = new MessageVO();
	

	if (error != null && !error.isEmpty()) {
		request.getRequestDispatcher("/_04_Forum/LookArticle.jsp").forward(
				request, response);
		return;
	} else {
		request.getRequestDispatcher("/_04_Forum/member/Reply.jsp")
				.forward(request, response);
	}	
	
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
		
	}

}
