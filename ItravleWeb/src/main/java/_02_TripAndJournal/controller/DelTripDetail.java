package _02_TripAndJournal.controller;

import java.io.IOException;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import _02_TripAndJournal.model.TripDetailVO;

@WebServlet("/_02_TripAndJournal/member/DelTripDetail.controller")
public class DelTripDetail extends HttpServlet {
	// 本Servlet功能：由WriteTrip.jsp按刪除時呼叫，利用tripOrder把單一筆tripOrder刪除
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	HttpSession session;

	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		System.out.println("--------------------DelTripDetail--------------------");
		
		// 接收資料
		request.setCharacterEncoding("UTF-8");
		String temp1 = request.getParameter("tripOrder");
		
		// 轉換資料
		int tripOrder = 0;
		if (temp1 != null && temp1.trim().length() != 0) {
			try {
				tripOrder = Integer.parseInt(temp1);
				System.out.println("tripOrder:" + tripOrder);
			} catch (NumberFormatException e) {
				e.printStackTrace();
			}
		}

		// 呼叫Model
		session = request.getSession(false);
		List<TripDetailVO> tripDetailCart;

		if (session != null) {
			try {
				tripDetailCart = (LinkedList<TripDetailVO>) session
						.getAttribute("tripDetailCart");
				if (tripDetailCart != null) {
					System.out.println("session裡的tripDetailCart="
							+ tripDetailCart);
					Iterator<TripDetailVO> it = tripDetailCart.iterator();
					while (it.hasNext()) {
						TripDetailVO tripDetailVO = it.next();
						int tripOrderInCart = tripDetailVO.getTripOrder();
						if (tripOrderInCart == tripOrder) {
							tripDetailCart.remove(tripDetailVO);
							break;
						}
					}
					int newTripOrder = 1;
					for (TripDetailVO vo : tripDetailCart) {
						vo.setTripOrder(newTripOrder);
						newTripOrder = newTripOrder + 2;
					}
					
					session.setAttribute("tripDetailCart", tripDetailCart);
					System.out.println("修改過的tripDetailCart=" + tripDetailCart);
				} else {

				}
			} catch (ClassCastException e) {
				System.out
						.println("Object cast to List<TripDetailVO> ClassCastException");
				e.printStackTrace();
			}
		} else {
			// 請使用者登入
			System.out.println("導向登入頁面(未完成)");
		}

		String path = request.getContextPath();
		response.sendRedirect(path + "/_02_TripAndJournal/member/WriteTrip.jsp");

	}

}
