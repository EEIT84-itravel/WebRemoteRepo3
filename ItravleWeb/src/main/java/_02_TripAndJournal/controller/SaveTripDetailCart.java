package _02_TripAndJournal.controller;

import java.io.IOException;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.LinkedList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import _02_TripAndJournal.model.TripDetailService;
import _02_TripAndJournal.model.TripDetailVO;


@WebServlet("/_02_TripAndJournal/member/SaveTripDetailCart.controller")
public class SaveTripDetailCart extends HttpServlet {
	// 本Servlet功能：由WriteTrip.jsp的"儲存行程"呼叫，把session裡的tripDetailCart存到DB
	private static final long serialVersionUID = 1L;
       
   	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 接收資料
		String temp = request.getParameter("tripId");
		System.out.println(temp);
		
		// 轉換資料
		
		// 驗證資料
		
		// 呼叫Model
		HttpSession session = request.getSession(false);
		LinkedList<TripDetailVO> tripDetailCart=(LinkedList<TripDetailVO>) session.getAttribute("tripDetailCart");
		System.out.println(tripDetailCart);
		TripDetailService service = new TripDetailService();
		
		//交易
		
		Iterator<TripDetailVO> it =tripDetailCart.iterator();
		while (it.hasNext()) {
			TripDetailVO tripDetailVO=it.next();
			service.insert(tripDetailVO);
			System.out.println("insert 成功");
		}
		Enumeration<String> e=session.getAttributeNames();
		while(e.hasMoreElements()) {
			String name =(String) e.nextElement();
			System.out.println("session attribute names:" +name);
		}		
		
		session.removeAttribute("tripDetailCart");					
		System.out.println("tripDetailCart已移除");


	}

}
