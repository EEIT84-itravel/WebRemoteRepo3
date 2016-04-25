package _02_TripAndJournal.controller;

import java.io.IOException;
import java.sql.Time;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import _02_TripAndJournal.model.TripDetailService;
import _02_TripAndJournal.model.TripDetailVO;
import _02_TripAndJournal.model.TripService;
import _02_TripAndJournal.model.TripVO;

@WebServlet("/_02_TripAndJournal/member/TripDetail2.controller")
public class TripDetail2 extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		this.doPost(request, response);
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// 接收資料
		request.setCharacterEncoding("UTF-8");// 編碼

		HttpSession session = request.getSession(false);
		int tripId=0;
		TripVO tripVO=null;
		if (session != null) {
			tripVO = (TripVO) session.getAttribute("tripVO");
			tripId = tripVO.getTripId();
		} else {
			//回登入
		}
		
		String[] temp1 = request.getParameterValues("stayTime");
		String[] temp2 = request.getParameterValues("sightId");
		String[] notes = request.getParameterValues("notes");
		String[] temp3 = request.getParameterValues("sightBudget");
		for (int i = 0; i < temp1.length; i++) {
			System.out.println(temp1[i]);
		}

		for (int i = 0; i < temp2.length; i++) {
			System.out.println(temp2[i]);
		}

		for (int i = 0; i < notes.length; i++) {
			System.out.println(notes[i]);
		}

		for (int i = 0; i < temp3.length; i++) {
			System.out.println(temp3[i]);
		}

		// 驗證資料

		// 轉換資料
		// 用sightId決定有幾個tripDetail
		int tripDetailLen = temp2.length;
		java.sql.Time[] stayTime = new java.sql.Time[tripDetailLen];
		for (int i = 0; i < tripDetailLen; i++) {
			if (temp1[i] != null && temp1[i].trim().length() != 0) {
				try {
					stayTime[i] = Time.valueOf(temp1[i]);
				} catch (NumberFormatException e) {
					e.printStackTrace();
				}
			}
		}

		int[] referenceNo = new int[tripDetailLen];
		for (int i = 0; i < tripDetailLen; i++) {
			if (temp2[i] != null && temp2[i].trim().length() != 0) {
				try {
					referenceNo[i] = Integer.parseInt(temp2[i]);
				} catch (NumberFormatException e) {
					e.printStackTrace();
				}
			}
		}
		java.math.BigDecimal[] sightBudget = new java.math.BigDecimal[tripDetailLen];
		for (int i = 0; i < tripDetailLen; i++) {			
			if (temp3[i] != null && temp3[i].trim().length() != 0) {
				double temp4 = Double.parseDouble(temp3[i]);
				sightBudget[i] = java.math.BigDecimal.valueOf(temp4);
			}
		}

		// 呼叫model
		int tripOrder=1;
		List<TripDetailVO> tripDetailVOs = new ArrayList<>();
		for (int i = 0; i < tripDetailLen; i++) {
			TripDetailVO tripDetailVO = new TripDetailVO();
			tripDetailVO.setTripId(tripId);
			tripDetailVO.setTripOrder(tripOrder);
			tripDetailVO.setStayTime(stayTime[i]);
			tripDetailVO.setWhichDay(1); //先寫死
			tripDetailVO.setReferenceType("type_id01");	//先寫死
			tripDetailVO.setReferenceNo(referenceNo[i]);
			tripDetailVO.setNotes(notes[i]);
			tripDetailVO.setSightBudget(sightBudget[i]);
			tripDetailVOs.add(tripDetailVO);
			tripOrder= tripOrder+2;			
		}	
		//抓出資料庫中同一個tripId的detail，刪除
		TripDetailService service = new TripDetailService();
		List<TripDetailVO> TripDetailVOFromDB = service.select(tripId);
		for(TripDetailVO temp :TripDetailVOFromDB) {
			int tempTdetailId=temp.getTdetailId();
			service.delete(tempTdetailId);
		}
		boolean result =service.insert(tripDetailVOs);
		//修改trip的modifyTime
		TripService tripService = new TripService();
		java.util.Date now = new Date();
		long nowLong = now.getTime();
		java.sql.Timestamp sqlDate = new Timestamp(nowLong);
		tripVO.setModifyTime(sqlDate);
		tripService.update(tripVO);
				
		// 根據結果選擇view
		if(result) {
			//儲存成功回到會員行程列表
			request.getRequestDispatcher("/_05_Member/member/MemberTrip.jsp").forward(request, response);
		} else {
			//失敗回到排行程頁(是空的)
			String path = request.getContextPath();
			response.sendRedirect(path + "/_02_TripAndJournal/member/WriteTrip.jsp");
		}
		
		
	}

}
