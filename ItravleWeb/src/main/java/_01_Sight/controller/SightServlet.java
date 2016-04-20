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
import _05_Member.model.CollectionService;
import _05_Member.model.MemberVO;

@WebServlet("/_01_Sight/Sight.controller")
public class SightServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

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

		// 根據Model執行結果顯示View
		if (sightVO == null) {
			error.put("sightId", "此景點不存在");
			request.getRequestDispatcher("/_01_Sight/SightIndex.jsp").forward(
					request, response);
		} else {
			boolean flag = false;
			CollectionService collectionService = new CollectionService();
			MemberVO user = (MemberVO) request.getSession()
					.getAttribute("user");
			// 會員已登入且景點未收藏過會顯示景點收藏鈕
			if (user != null
					&& collectionService.selectCollection(sightVO.getSightId(),
							user.getMemberId(), "type_id01") == null) {
				flag = true;
			}
			request.setAttribute("flag", flag);
			request.setAttribute("sightVO", sightVO);
			request.setAttribute("openTime", sightVO.getOpenTime().toString()
					.substring(0, 5));
			request.setAttribute("closeTime", sightVO.getCloseIime().toString()
					.substring(0, 5));
			request.setAttribute(
					"trans1",
					sightVO.getTrans().substring(0,
							sightVO.getTrans().indexOf(",")));
			request.setAttribute(
					"trans2",
					sightVO.getTrans().substring(
							sightVO.getTrans().indexOf(",") + 1));
			request.getRequestDispatcher("/_01_Sight/SightInformation.jsp")
					.forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		this.doGet(request, response);
	}
}
