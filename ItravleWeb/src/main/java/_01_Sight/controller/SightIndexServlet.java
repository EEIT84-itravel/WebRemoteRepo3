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

import _01_Sight.model.SightService;
import _01_Sight.model.SightVO;

@WebServlet("/_01_Sight/SightIndex.controller")
public class SightIndexServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		Map<String, String> error = new HashMap<String, String>();
		request.setAttribute("error", error);

		// 接收HTML Form資料
		String region = request.getParameter("regionId");// 地區
		String county = request.getParameter("countyId");// 縣市
		String sightType = request.getParameter("sightType");// 類型
		String keyWord = request.getParameter("keyWord");// 關鍵字查詢

		SightVO sightVO2 = new SightVO();
		sightVO2.setRegionId(region);
		sightVO2.setCountyId(county);
		sightVO2.setSightTypeId(sightType);
		sightVO2.setSightName(keyWord);

		List<SightVO> sightVOs = null;
		// 呼叫model
		SightService sightService = new SightService();

		sightVOs = sightService.search(sightVO2);
		if (sightVOs.isEmpty()) {
			error.put("noneSearch", "查無此筆資訊");
		}
		if (error != null && !error.isEmpty()) {
			request.getRequestDispatcher("/_01_Sight/SightIndex.jsp").forward(
					request, response);
			return;
		}
		
		request.setAttribute("sightVOSearch", sightVOs);
		// 根據Model執行結果顯示View
		request.getRequestDispatcher("/_01_Sight/SightIndex.jsp").forward(
				request, response);
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		this.doGet(request, response);
	}
}
