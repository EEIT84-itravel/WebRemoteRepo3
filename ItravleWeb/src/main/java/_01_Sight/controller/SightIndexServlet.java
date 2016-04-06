package _01_Sight.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import _01_Sight.model.SightService;
import _01_Sight.model.SightVO;

@WebServlet("/_01_Sight/SightIndex.controller")
public class SightIndexServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		// 呼叫Model(首頁畫面)
		SightService sightService = new SightService();
		List<SightVO> sightVO = sightService.select();
		List<SightVO> watchNum = sightService.selectByWatchNum();
		request.setAttribute("sightVO", sightVO);
		request.setAttribute("watchNum", watchNum);
		request.getRequestDispatcher("/_01_Sight/SightIndex.jsp").forward(
				request, response);
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		this.doGet(request, response);
	}
}
