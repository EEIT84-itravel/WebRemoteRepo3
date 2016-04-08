package _04_Forum.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import _04_Forum.model.ForumService;
import _04_Forum.model.ForumVO;

@WebServlet("/_04_Forum/Forum.controller")
public class ForumServlet extends HttpServlet {
	private ForumService forumService = new ForumService();

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		// 接收資料
		// String temp1 = request.getParameter("forumId");

		String temp = request.getParameter("memberId");
		String forumAction = request.getParameter("forumAction");
		String forumSelect = request.getParameter("select");

		// 轉換資料
		Map<String, String> error = new HashMap<String, String>();
		request.setAttribute("error", error);

		// ForumVO vo = new ForumVO();
		// List<ForumVO> forumVO = forumService.select();
		// request.setAttribute("ForumVO", forumVO);
		// 登入後才能發表文章
		// if ("Submit".equals(forumAction)) {
		// if (temp == null && temp.trim().length() == 0) {
		// error.put("memberId", "請先登入會員");
		// }
		// }

		if (error != null && !error.isEmpty()) {
			request.getRequestDispatcher("/_04_Forum/ForumIndex.jsp").forward(
					request, response);
			return;
		} else {
			request.getRequestDispatcher("/_04_Forum/member/Article.jsp")
					.forward(request, response);
		}

		// if("select".equals(forumAction)){
		// List<ForumVO> result = forumService.select();
		// request.setAttribute("select", result);
		// request.getRequestDispatcher(
		// "/_04_Forum/LookArticle.jsp").forward(request, response);
		// }

	}

	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		this.doGet(req, resp);
	}
}
