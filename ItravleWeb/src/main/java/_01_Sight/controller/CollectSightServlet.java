package _01_Sight.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import _01_Sight.model.SightService;
import _01_Sight.model.SightVO;
import _05_Member.model.CollectionService;
import _05_Member.model.CollectionVO;
import _05_Member.model.MemberVO;

@WebServlet("/_01_Sight/member/CollectSight.controller")
public class CollectSightServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		// 接收HTML Form資料
		HttpSession session = request.getSession();
		Integer memberId = ((MemberVO) session.getAttribute("user"))
				.getMemberId();
		String temp1 = request.getParameter("sightId");

		// 轉換HTML Form資料

		// 驗證HTML Form資料
		Map<String, String> error = new HashMap<String, String>();
		request.setAttribute("error", error);
		int sightId = 0;
		if (temp1 != null || temp1.trim().length() != 0) {
			sightId = Integer.parseInt(temp1);
		}

		// 呼叫Model(首頁畫面)
		CollectionVO collectionVO = new CollectionVO();
		CollectionService collectionService = new CollectionService();
		collectionVO.setMemberId(memberId);
		collectionVO.setTypeId("type_id01");// 景點
		collectionVO.setReferenceType(sightId);
		collectionService.collectionsight(collectionVO);

		// 根據Model執行結果顯示View
		request.getRequestDispatcher("/_05_Member/MemberSight.jsp").forward(
				request, response);
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		this.doGet(request, response);
	}

}
