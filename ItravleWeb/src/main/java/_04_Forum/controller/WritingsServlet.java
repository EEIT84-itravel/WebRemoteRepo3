package _04_Forum.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import _04_Forum.model.ForumService;
import _04_Forum.model.ForumVO;

@WebServlet("/_04_Forum/member/WritingsServlet.controller")
public class WritingsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ForumService fs = new ForumService();
	private ForumVO forumVO = new ForumVO();

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		// 接收資料
		String forumTypeId = request.getParameter("forumTypeId");
		String forumTopic = request.getParameter("forumTopic");
		String forumContent = request.getParameter("forumContent");
		String temp1 = request.getParameter("forumId");
		String temp2 = request.getParameter("visit");
		String crud = request.getParameter("crud");
		System.out.println(crud);
		// 轉換資料
		// 新增文章不進行資料轉換
		int forumId = 0;
		if (!"NewArticle".equals(crud)) {
			if (temp1 != null || temp1.trim().length() != 0) {
				try {
					forumId = Integer.parseInt(temp1);
				} catch (NumberFormatException e) {
					e.printStackTrace();
				}
			}
		}
		int visitorNum = 0;
		if (!"NewArticle".equals(crud) && !"Delete".equals(crud)) {
			if (temp2 != null || temp2.trim().length() != 0) {
				try {
					visitorNum = Integer.parseInt(temp2);
				} catch (NumberFormatException e) {
					e.printStackTrace();
				}
			}
		}

		Map<String, String> error = new HashMap<String, String>();
		request.setAttribute("error", error);
		// 驗證資料
		if (forumTopic == null || forumTopic.trim().length() == 0) {
			error.put("forumTopic", "請輸入您的文章主題");
		} else if (forumTopic.trim().length() > 40) {
			error.put("forumTopic", "文章主題必須少於40個字");
		}
		if (forumContent == null || forumContent.trim().length() == 0) {
			error.put("forumContent", "請輸入文章內容");
		}
		// 塞資料
		forumVO.setMemberId(3);// 暫時寫死會員id
		forumVO.setForumTypeId(forumTypeId);
		forumVO.setForumTopic(forumTopic);
		forumVO.setForumContent(forumContent);
		forumVO.setForumTime(new Timestamp(new Date().getTime()));
		String path = request.getContextPath();
		// 執行方法
		if ("NewArticle".equals(crud)) {
			ForumVO result = fs.insert(forumVO);
			if (result == null) {
				error.put("forumTopic", "新增失敗");
				response.sendRedirect(path + "/_04_Forum/member/Article.jsp");
				return;
			} else {
                HttpSession session = request.getSession();
				session.setAttribute("forumVO", result);
			}
			response.sendRedirect(path + "/_04_Forum/LookArticle.jsp");
		} else if ("UpdateArticle".equals(crud)) {
			forumVO.setForumId(forumId);
			forumVO.setVisitorNum(visitorNum);
			System.out.println(forumId);
			ForumVO result = fs.update(forumVO);
			if (result == null) {
				error.put("forumTopic", "修改失敗");
				response.sendRedirect(path
						+ "/_04_Forum/member/ModifyArticle.jsp");
				return;
			} else {
				request.setAttribute("forumVO", result);
			}
			response.sendRedirect(path
					+ "/_04_Forum/ShowArticle.controller?forumId=" + forumId);
		} else if ("Delete".equals(crud)) {
			forumVO.setForumId(forumId);
			boolean result = fs.delete(forumVO);
			if (result == false) {
				error.put("forumTopic", "刪除失敗");
				response.sendRedirect(path + "/_04_Forum/LookArticle.jsp");
				return;
			} else {
				response.sendRedirect(path + "/_04_Forum/ForumIndex.jsp");
			}
		}
	}
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		this.doGet(request, response);
	}

}
