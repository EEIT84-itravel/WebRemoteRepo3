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

import _05_Member.model.CollectionService;
import _05_Member.model.CollectionVO;
import _05_Member.model.MemberVO;

@WebServlet("/_04_Forum/member/CollectionForum.controller")
public class CollectionForumServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		Integer memberId = ((MemberVO) session.getAttribute("user"))
				.getMemberId();
		String temp1 = request.getParameter("referenceType");// 參照編號
		String typeId = request.getParameter("typeId");// 參照類型

		// 轉換HTML Form資料

		// 驗證HTML Form資料
		Map<String, String> error = new HashMap<String, String>();
		request.setAttribute("error", error);

		int referenceType = 0;
		if (temp1 != null || temp1.trim().length() != 0) {
			referenceType = Integer.parseInt(temp1);
		}

		// 呼叫Model(首頁畫面)
		CollectionVO collectionVO = new CollectionVO();
		CollectionService collectionService = new CollectionService();
		if ("type_id05".equals(typeId)) {// 類型為行程
			collectionVO.setMemberId(memberId);
			collectionVO.setTypeId(typeId);
			collectionVO.setReferenceType(referenceType);
			collectionService.collectiontrip(collectionVO);
			// 根據Model執行結果顯示View
			String path = request.getContextPath();
			response.sendRedirect(path
					+ "/_04_Forum/ShowArticle.controller?forumId="
					+ referenceType);
		}
	}

}
