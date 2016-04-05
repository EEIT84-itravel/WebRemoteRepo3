package _04_Forum.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import _04_Forum.model.ForumService;
import _04_Forum.model.ForumVO;


@WebServlet("/_04_Forum/member/Reply.controller")
public class ReplyServlet extends HttpServlet {

       
 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	request.setCharacterEncoding("UTF-8");
	// 接收資料
	
	String messageType = request.getParameter("messageType");
	String content =request.getParameter("content");
	String reply = request.getParameter("reply");
    
	// 轉換資料
	Map<String, String> error = new HashMap<String, String>();
	request.setAttribute("error", error);
	
	//驗證
	if(content == null || content.trim().length() == 0){
		error.put("content","請輸入您要回覆的內容" );
	}
	if( error != null && !error.isEmpty()){
		request.getRequestDispatcher("/_04_Forum/member/Reply.jsp").forward(request, response);
		return;
	}
	
	//呼叫model
	ForumService fs = new ForumService();
	ForumVO forumVO = new ForumVO();
	
//	if("reply".equals(reply)){
//		request.getRequestDispatcher("/_04_Forum/member/Reply.jsp").forward(request, response);
//		return;
//	}
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
