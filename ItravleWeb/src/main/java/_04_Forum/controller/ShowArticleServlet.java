package _04_Forum.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import _04_Forum.model.ForumService;
import _04_Forum.model.ForumVO;

@WebServlet("/_04_Forum/ShowArticle.controller")
public class ShowArticleServlet extends HttpServlet {
	
	

//	@Override
//	public void init() throws ServletException {
//	
//		String article = this.getInitParameter("forumId");
//		ServletContext application = this.getServletContext();
//		String path = application.getRealPath(article);
//		
//		
//	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// 接收資料
		request.setCharacterEncoding("UTF-8");
		String temp1 = request.getParameter("forumId");

		Map<String, String> error = new HashMap<String, String>();
		request.setAttribute("error", error);

		// 轉換資料
		int forumId = 0;
		if (temp1 != null && temp1.trim().length() != 0) {
			forumId = Integer.parseInt(temp1);
		}
		// 驗證資料-無
		// 呼叫Model
				ForumService fs = new ForumService();
				ForumVO forumVO = fs.selectOne(forumId);
				if(forumVO != null) {
					request.setAttribute("forumVO", forumVO);	
				    request.getRequestDispatcher("/_04_Forum/LookArticle.jsp").forward(request, response);
				}
				
				
//				byte[] bytes = null;
//				if (sightPicVO != null) {
//					bytes = sightPicVO.getPic();
//				} else {
//					bytes = defaultPhoto;
//				}
//				OutputStream out = response.getOutputStream();
//				if (bytes != null && bytes.length > 0) {
//					response.setContentType("image/jpg");
//					out.write(bytes);
//					out.flush();
//					out.close();			
//				}

	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
