package _06_BackEnd.controller;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Time;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import _01_Sight.model.SightPicService;
import _01_Sight.model.SightPicVO;
import _01_Sight.model.SightService;
import _01_Sight.model.SightVO;
import _05_Member.model.MemberVO;

@WebServlet("/_06_BackEnd/backEnd/BackendSight.controller")
@MultipartConfig
public class BackendSightServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// 接收HTML Form資料
		request.setCharacterEncoding("UTF-8");
		Map<String, String> error = new HashMap<String, String>();
		request.setAttribute("error", error);

		String temp = request.getParameter("sightId");
		String action = request.getParameter("action");

		// 轉換HTML Form資料
		int sightId = 0;
		if (temp != null && temp.trim().length() != 0) {
			try {
				sightId = Integer.parseInt(temp);
			} catch (IllegalArgumentException e) {
				error.put("sightId", "景點ID必須是數字");
			}
		}

		// 呼叫Model
		SightService sightService = new SightService();
		SightPicService sightPicService = new SightPicService();
		SightVO sightVO;
		SightPicVO sightPicVO;
		SightVO result;
		SightPicVO resultPic;

		if ("getOne".equals(action)) {// 來自AllSight.jsp篩選一隻sightVO為了update
			sightVO = sightService.findByPrimaryKey(sightId);
			request.setAttribute("sightVO", sightVO);

			request.getRequestDispatcher("/_06_BackEnd/backend/UpdateSight.jsp")
					.forward(request, response);
		}

		if ("update".equals(action)) { // 來自UpdateSight.jsp 接收修改後資料
			String sightName = request.getParameter("sightName");// 景點名稱
			if (sightName == null || sightName.trim().length() == 0) {
				error.put("sightName", "景點名稱必須輸入");
			}
			String regionId = request.getParameter("regionId");// 地區
			if (regionId == null || regionId.trim().length() == 0) {
				error.put("regionId", "請選擇地區");
			}
			String countyId = request.getParameter("countyId");// 縣市
			if (countyId == null || countyId.trim().length() == 0) {
				error.put("countyId", "請選擇縣市");
			}
			String sightTypeId = request.getParameter("sightTypeId");// 景點類型
			if (sightTypeId == null || sightTypeId.trim().length() == 0) {
				error.put("sightTypeId", "請選擇景點類型");
			}
			String ticket = request.getParameter("ticket");// 門票,可null
			String temp1 = request.getParameter("openTime");// 開門時間
			java.sql.Time openTime = null;
			if (temp1 != null && temp1.trim().length() != 0) {
				try {
					openTime = Time.valueOf(temp1);
				} catch (Exception e) {
					e.printStackTrace();
					error.put("openTime", "開門時間格式錯誤");
				}
			} else {
				error.put("openTime", "開門時間必須輸入");
			}
			String temp2 = request.getParameter("closeIime");// 關門時間
			java.sql.Time closeIime = null;
			if (temp2 != null && temp2.trim().length() != 0) {
				try {
					closeIime = Time.valueOf(temp2);
				} catch (Exception e) {
					e.printStackTrace();
					error.put("closeIime", "關門時間格式錯誤");
				}
			} else {
				error.put("closeIime", "關門時間必須輸入");
			}
			String playPeriod = request.getParameter("playPeriod");// 建議旅行時段
			if (playPeriod == null || playPeriod.trim().length() == 0) {
				error.put("playPeriod", "建議旅行時段必須輸入");
			}
			String temp4 = request.getParameter("longitude");// 經度
			Float longitude = null;
			if (temp4 != null && temp4.trim().length() != 0) {
				try {
					longitude = Float.parseFloat(temp4);
				} catch (Exception e) {
					e.printStackTrace();
					error.put("longitude", "經度請輸入數字");
				}
			} else {
				error.put("longitude", "經度必須輸入");
			}
			String temp5 = request.getParameter("latitude");// 緯度
			Float latitude = null;
			if (temp5 != null && temp5.trim().length() != 0) {
				try {
					latitude = Float.parseFloat(temp5);
				} catch (Exception e) {
					e.printStackTrace();
					error.put("latitude", "緯度請輸入數字");
				}
			} else {
				error.put("latitude", "緯度必須輸入");
			}
			String phone = request.getParameter("phone");// 電話,可null
			String addr = request.getParameter("addr");// 地址,可null
			String temp6 = request.getParameter("del");// 是否隱藏,true:隱藏與前端相反
			boolean del = false;
			if (temp6 != null && temp6.trim().length() != 0) {
				if (temp6.equals("true")) {
					del = false;
				} else {
					del = true;
				}
			}
			String trans = request.getParameter("trans");// 交通方式,可null
			String intro = request.getParameter("intro"); // 簡介
			Part filePart = request.getPart("pic"); // Retrieves <input type="file" name="pic">
			InputStream is = filePart.getInputStream();

			if (error != null && !error.isEmpty()) {
				request.getRequestDispatcher(
						"/_06_BackEnd/backend/UpdateSight.jsp").forward(
						request, response);
				return;
			}

			sightVO = sightService.findByPrimaryKey(sightId);
			sightVO.setSightName(sightName);
			sightVO.setIntro(intro);
			sightVO.setRegionId(regionId);
			sightVO.setCountyId(countyId);
			sightVO.setSightTypeId(sightTypeId);
			sightVO.setTicket(ticket);
			sightVO.setOpenTime(openTime);
			sightVO.setCloseIime(closeIime);
			java.sql.Time spend = java.sql.Time.valueOf("03:00:00");
			sightVO.setSpendHour(spend);//放棄欄位 寫死
			sightVO.setPlayPeriod(playPeriod);
			sightVO.setLongitude(longitude);
			sightVO.setLatitude(latitude);
			java.util.Date now2 = new Date();
			long nowLong2 = now2.getTime();
			java.sql.Timestamp sqlDate2 = new Timestamp(nowLong2);
			sightVO.setModifyTime(sqlDate2);// 寫死更新時間
			HttpSession session=request.getSession();
			MemberVO memberVO=(MemberVO)session.getAttribute("admin");
			sightVO.setModifier(memberVO.getMemberId()); // 由session抓取現在登入的管理員
			sightVO.setPhone(phone);
			sightVO.setAddr(addr);
			sightVO.setDel(del);
			sightVO.setTrans(trans);
			result = sightService.update(sightVO);

			sightPicVO = sightPicService.selectMainPic(sightId);

			byte[] p = new byte[is.available()];
			if (p.length != 0) {
				is.read(p);
				is.close();
				sightPicVO.setPic(p);
			} else {
				byte[] bytes = sightPicVO.getPic();
				sightPicVO.setPic(bytes);
			}
			resultPic = sightPicService.update(sightPicVO);
			if (result != null) {
				if (resultPic != null) {
					String path = request.getContextPath();
					response.sendRedirect(path
							+ "/_06_BackEnd/backend/AllSight.jsp#tabs-1");
				}
			}
		}

		if ("insert".equals(action)) { // 來自NewSight.jsp 接收新增資料
			String sightName = request.getParameter("sightName");// 景點名稱
			if (sightName == null || sightName.trim().length() == 0) {
				error.put("sightName", "景點名稱必須輸入");
			}
			String regionId = request.getParameter("regionId");// 地區
			if (regionId == null || regionId.trim().length() == 0) {
				error.put("regionId", "請選擇地區");
			}
			String countyId = request.getParameter("countyId");// 縣市
			if (countyId == null || countyId.trim().length() == 0) {
				error.put("countyId", "請選擇縣市");
			}
			String sightTypeId = request.getParameter("sightTypeId");// 景點類型
			if (sightTypeId == null || sightTypeId.trim().length() == 0) {
				error.put("sightTypeId", "請選擇景點類型");
			}
			String ticket = request.getParameter("ticket");// 門票,可null
			String temp1 = request.getParameter("openTime");// 開門時間
			java.sql.Time openTime = null;
			if (temp1 != null && temp1.trim().length() != 0) {
				try {
					openTime = Time.valueOf(temp1 + ":00");
				} catch (Exception e) {
					e.printStackTrace();
					error.put("openTime", "開門時間格式錯誤");
				}
			} else {
				error.put("openTime", "開門時間必須輸入");
			}
			String temp2 = request.getParameter("closeIime");// 關門時間
			java.sql.Time closeIime = null;
			if (temp2 != null && temp2.trim().length() != 0) {
				try {
					closeIime = Time.valueOf(temp2 + ":00");
				} catch (Exception e) {
					e.printStackTrace();
					error.put("closeIime", "關門時間格式錯誤");
				}
			} else {
				error.put("closeIime", "關門時間必須輸入");
			}
			String playPeriod = request.getParameter("playPeriod");// 建議旅行時段
			if (playPeriod == null || playPeriod.trim().length() == 0) {
				error.put("playPeriod", "建議旅行時段必須輸入");
			}
			String temp4 = request.getParameter("longitude");// 經度
			Float longitude = null;
			if (temp4 != null && temp4.trim().length() != 0) {
				try {
					longitude = Float.parseFloat(temp4);
				} catch (Exception e) {
					e.printStackTrace();
					error.put("longitude", "經度請輸入數字");
				}
			} else {
				error.put("longitude", "經度必須輸入");
			}
			String temp5 = request.getParameter("latitude");// 緯度
			Float latitude = null;
			if (temp5 != null && temp5.trim().length() != 0) {
				try {
					latitude = Float.parseFloat(temp5);
				} catch (Exception e) {
					e.printStackTrace();
					error.put("latitude", "緯度請輸入數字");
				}
			} else {
				error.put("latitude", "緯度必須輸入");
			}
			String phone = request.getParameter("phone");// 電話,可null
			String addr = request.getParameter("addr");// 地址,可null
			String temp6 = request.getParameter("del");// 是否隱藏,true:隱藏與前端相反
			boolean del = false;
			if (temp5 != null && temp5.trim().length() != 0) {
				if (temp6.equals("true")) {
					del = false;
				} else {
					del = true;
				}
			}
			String trans = request.getParameter("trans");// 交通方式,可null
			String intro = request.getParameter("intro"); // 簡介
			Part filePart = request.getPart("pic"); // Retrieves <input
													// type="file" name="pic">
			InputStream is = filePart.getInputStream();

			if (error != null && !error.isEmpty()) {
				request.getRequestDispatcher(
						"/_06_BackEnd/backend/NewSight.jsp").forward(request,
						response);
				return;
			}

			sightVO = new SightVO();
			sightVO.setSightName(sightName);
			sightVO.setRegionId(regionId);
			sightVO.setIntro(intro);
			sightVO.setCountyId(countyId);
			sightVO.setSightTypeId(sightTypeId);
			sightVO.setTicket(ticket);
			sightVO.setOpenTime(openTime);
			sightVO.setCloseIime(closeIime);
			java.sql.Time spend = java.sql.Time.valueOf("03:00:00");
			sightVO.setSpendHour(spend);//放棄欄位 寫死
			sightVO.setPlayPeriod(playPeriod);
			sightVO.setScore(1F);// 寫死評分
			sightVO.setLongitude(longitude);
			sightVO.setLatitude(latitude);
			java.util.Date now2 = new Date();
			long nowLong2 = now2.getTime();
			java.sql.Timestamp sqlDate2 = new Timestamp(nowLong2);
			sightVO.setCreateTime(sqlDate2);// 寫死
			HttpSession session=request.getSession();
			MemberVO memberVO=(MemberVO)session.getAttribute("admin");
			sightVO.setCreator(memberVO.getMemberId());  //由Session抓取
			sightVO.setModifyTime(sqlDate2);// 寫死
			sightVO.setModifier(memberVO.getMemberId());  //由Session抓取
			sightVO.setPhone(phone);
			sightVO.setAddr(addr);
			sightVO.setDel(del);
			sightVO.setTrans(trans);
			result = sightService.insert(sightVO);

			java.util.List<SightVO> sightVOs = new ArrayList<SightVO>();
			sightVOs = sightService.getAll();
			int id = 0;
			for (SightVO tempSight : sightVOs) {
				if (tempSight.getSightName().equals(sightName)) {
					id = tempSight.getSightId();
				}
			}

			sightPicVO = new SightPicVO();
			sightPicVO.setSightId(id);
			byte[] p = new byte[is.available()];
			is.read(p);
			is.close();
			sightPicVO.setPic(p);
			sightPicVO.setMainPic(true);// 只傳一張圖,先寫死
			resultPic = sightPicService.insert(sightPicVO);

			if (result != null) {
				if (resultPic != null) {
					String path = request.getContextPath();
					response.sendRedirect(path
							+ "/_06_BackEnd/backend/AllSight.jsp#tabs-1");
				}
			}
		}
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
