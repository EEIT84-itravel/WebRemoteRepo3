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

@WebServlet("/_01_Sight/Sight.controller")
public class SightServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		// 接收HTML Form資料
		String temp1 = request.getParameter("sightId"); // 景點編號
		// String sightName = request.getParameter("sightName"); //名稱
		// String regionId = request.getParameter("regionId"); //地區編號
		// String countyId = request.getParameter("countyId"); //縣市編號
		// String sightTypeId = request.getParameter("sightTypeId"); //景點類型編號
		// String ticket = request.getParameter("ticket"); //門票
		// private Time openTime; //開門時間
		// private Time closeIime; //關門時間
		// private Time spendHour; //建議停留時間
		// private String playPeriod; //建議旅行時段
		//String score = request.getParameter("score"); //評分
		// private Float longitude; //經度
		// private Float latitude; //緯度
		// private Integer watchNum; //瀏覽人次
		// private Integer collectNum; //收藏人次
		// String phone = request.getParameter("phone"); //電話
		// String addr = request.getParameter("addr"); //地址
		// String trans = request.getParameter("trans"); //交通方式
		// private Integer creator; //新增者
		// private Timestamp createTime;//新增時間
		// private Integer modifier; //修改人
		// private Timestamp modifyTime;//上次更新時間
		// private boolean del;

		// 驗證HTML Form資料
		Map<String, String> error = new HashMap<String, String>();
		request.setAttribute("error", error);
		int sightId = 0;
		if (temp1 != null || temp1.trim().length() != 0) {
			sightId = Integer.parseInt(temp1);
		}
		// if (error != null && !error.isEmpty()) {
		// request.getRequestDispatcher(
		// "/_01_Sight/SightIndex.jsp").forward(request,
		// response);
		// return;
		// }

		// 呼叫Model
		SightService sightService = new SightService();
		SightVO sightVO = sightService.findByPrimaryKey(sightId);

		// 進階搜尋測試
		// SightVO sightVOp = new SightVO();
		// sightVOp.setRegionId("regionId");
		// sightVOp.setCountyId("countyId");
		// sightVOp.setSightTypeId("sightTypeId");
		// sightVOp.setTicket("ticket");
		// sightVOp.setPlayPeriod("playPeriod");
		// List<SightVO> a = sightService.search(sightVOp);
		// 根據Model執行結果顯示View
		if (sightVO == null) {
			error.put("sightId", "此景點不存在");
			request.getRequestDispatcher("/_01_Sight/SightIndex.jsp").forward(
					request, response);
		} else {
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
