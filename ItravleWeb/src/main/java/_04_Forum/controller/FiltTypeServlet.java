package _04_Forum.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import _04_Forum.model.ForumService;
import _04_Forum.model.ForumVO;


@WebServlet("/_04_Forum/FiltType.controller")
public class FiltTypeServlet extends HttpServlet {
       
	//**判斷討論區所要篩選的主題為何**
	
	private static final long serialVersionUID = 1L;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String forum_type = request.getParameter("forumTypeId");
				
		ForumService fs = new ForumService();
		List<ForumVO> forum01 = null;
		if(forum_type.equals("forum_type00")){
			forum01 = fs.select();
		}else{
	     forum01 = fs.getForumType(forum_type);
		}
		
		if(forum01 != null){
			request.setAttribute("forumVO1s", forum01);
			request.getRequestDispatcher("/_04_Forum/ForumIndex.jsp").forward(request, response);
			return;
		}		
	}	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doGet(request, response);
	}

}
