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

		// 接收HTML Form資料
		String region = request.getParameter("regionId");// 地區
		String county = request.getParameter("countyId");// 縣市
		String sightType = request.getParameter("sightType");// 類型
		String keyWord=request.getParameter("keyWord");//關鍵字查詢

		// 轉換HTML Form資料

		// 驗證HTML Form資料

		// 呼叫Model(首頁畫面)
		SightService sightService = new SightService();

		SightVO sightVO2 = new SightVO();
		sightVO2.setRegionId(region);
		sightVO2.setCountyId(county);
		sightVO2.setSightTypeId(sightType);
		sightVO2.setSightName(keyWord);

		// 根據Model執行結果顯示View
		List<SightVO> sightVOp = sightService.search(sightVO2);
		request.setAttribute("sightVOs", sightVOp);
		request.setAttribute("regionId", region);// 回傳選擇的地區
		request.setAttribute("countyId", county);// 回傳選擇的縣市
		request.setAttribute("sightType", sightType);// 回傳選擇的類型
		request.setAttribute("keyWord", keyWord);// 回傳關鍵字
		request.getRequestDispatcher("/_01_Sight/SightIndex.jsp").forward(
				request, response);
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		this.doGet(request, response);
	}
}
