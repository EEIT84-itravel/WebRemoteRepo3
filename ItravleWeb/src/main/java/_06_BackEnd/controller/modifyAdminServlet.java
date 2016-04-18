package _06_BackEnd.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import _05_Member.model.MemberService;
import _05_Member.model.MemberVO;

@WebServlet("/_06_BackEnd/backend/modifyAdmin.controller")
public class modifyAdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 接收HTML Form資料
		request.setCharacterEncoding("UTF-8");
		Map<String, String> error = new HashMap<String, String>();
		request.setAttribute("error", error);

		String temp1 = request.getParameter("memberId");//會員ID
		String temp2 = request.getParameter("admin");//會員權限
		System.out.println(temp2);
		
		// 轉換HTML Form資料
				int memberId = 0;
				if (temp1 != null && temp1.trim().length() != 0) {
					try {
						memberId = Integer.parseInt(temp1);
					} catch (IllegalArgumentException e) {
						error.put("memberId", "會員ID必須是數字");
					}
				}
				boolean admin = false;
				if (temp2 != null && temp2.trim().length() != 0) {
					if (temp2.equals("true")) {
						admin = true;//管理員
					} else {
						admin = false;//普通會員
					}
				}
				if (error != null && !error.isEmpty()) {
					request.getRequestDispatcher(
							"/_06_BackEnd/backend/AllMember.jsp#/_06_BackEnd/backend/AllMember.jsp").forward(
							request, response);
					return;
				}
				//呼叫model
				MemberService memberService=new MemberService();
				MemberVO memberVO=memberService.selectById(memberId);
				memberVO.setAdmin(admin);
				if(memberService.modify(memberVO)){
					String path = request.getContextPath();
					response.sendRedirect(path
							+ "/_06_BackEnd/backend/AllMember.jsp");
				}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
