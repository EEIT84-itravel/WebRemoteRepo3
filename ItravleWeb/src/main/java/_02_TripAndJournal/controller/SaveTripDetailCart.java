package _02_TripAndJournal.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.Date;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.LinkedList;
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


@WebServlet("/_02_TripAndJournal/member/SaveTripDetailCart.controller")
public class SaveTripDetailCart extends HttpServlet {
	// 報廢中，改成用畫面接值就不用這隻了
	// 本Servlet功能：由WriteTrip.jsp的"儲存行程"呼叫，把session裡的tripDetailCart存到DB
	private static final long serialVersionUID = 1L;
       
   	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 接收資料		
		request.setCharacterEncoding("UTF-8");
		// 轉換資料
		
		// 驗證資料
		
		// 呼叫Model
		HttpSession session = request.getSession(false);
		TripVO tripVO=(TripVO) session.getAttribute("tripVO");
		int tripId =tripVO.getTripId();
		@SuppressWarnings("unchecked")
		LinkedList<TripDetailVO> tripDetailCart=(LinkedList<TripDetailVO>) session.getAttribute("tripDetailCart");
		System.out.println(tripDetailCart);		
		TripDetailService service = new TripDetailService();
		List<TripDetailVO> TripDetailVOFromDB = service.select(tripId);
		
		//把DB裡的tripDetail刪除
		for(TripDetailVO tripDetailVO1 :TripDetailVOFromDB) {
			Integer tripDetailIdDB =tripDetailVO1.getTdetailId();
			service.delete(tripDetailIdDB);
		}
		
		//把cart裡的detail全部塞進去
		for(TripDetailVO tripDetailVO2 :tripDetailCart){			
			service.insert(tripDetailVO2);			
		}
		
		//修改trip的modifyTime
		TripService tripService = new TripService();
		java.util.Date now = new Date();
		long nowLong = now.getTime();
		java.sql.Timestamp sqlDate = new Timestamp(nowLong);
		tripVO.setModifyTime(sqlDate);
		tripService.update(tripVO);
		
		session.removeAttribute("tripDetailCart");					
		System.out.println("tripDetailCart已移除");

	}

}
