package _01_Sight.controller;

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
import _05_Member.model.MemberService;
import _05_Member.model.MemberVO;

@WebServlet("/_01_Sight/member/SightReplyServlet.controller")
public class SightReplyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// 接收HTML Form資料
		request.setCharacterEncoding("UTF-8");
		Map<String, String> error = new HashMap<String, String>();
		request.setAttribute("error", error);
		String temp1 = request.getParameter("sightID");//景點ID,referenceNo
		String content=request.getParameter("reply");//回覆內容
		
		// 轉換HTML Form資料
		int referenceNo = 0;
		if (temp1 != null && temp1.trim().length() != 0) {
			try {
				referenceNo = Integer.parseInt(temp1);
			} catch (IllegalArgumentException e) {
				error.put("sightID", "景點ID必須是數字");
			}
		}else{
			error.put("reply", "請填入留言內容");
		}
		if (error != null && !error.isEmpty()) {
			request.getRequestDispatcher("/_01_Sight/Sight.controller?sightId="+referenceNo).forward(
					request, response);
			return;
		}
		//呼叫model
		MessageService messageService=new MessageService();
		MessageVO messageVO=new MessageVO();
		messageVO.setMessageType("type_id01");//類型=景點
		HttpSession session=request.getSession();
		MemberVO user=(MemberVO)session.getAttribute("user");
		messageVO.setMemberId(user.getMemberId());// 由session抓取現在登入者
		messageVO.setContent(content);//內容
		messageVO.setReferenceNo(referenceNo);//參照編號(此為景點ID)
		MessageVO result=messageService.insert(messageVO);
		if(result!=null){
			String path=request.getContextPath();
			response.sendRedirect(path+"/_01_Sight/Sight.controller?sightId="+referenceNo);
		}else{
			error.put("reply", "留言失敗");
			request.getRequestDispatcher("/_01_Sight/Sight.controller?sightId="+referenceNo).forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
