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

@WebServlet("/_02_TripAndJournal/member/UpdateTripDetailOrder.controller")
public class UpdateTripDetailOrder extends HttpServlet {
	// 本Servlet功能：由WriteTrip.jsp交換tripDetail順序時呼叫，把session裡的Cart叫出來，交換順序
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	HttpSession session;

	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		System.out.println("call UpdateTripDetailOrder.controller");
		// 接收資料
		String temp1 = request.getParameter("oldIndex");
		String temp2 = request.getParameter("newIndex");
		System.out.println("temp1:" + temp1);
		System.out.println("temp2:" + temp2);
		// 驗證資料：不用驗證？

		// 轉換HTML Form資料
		int oldIndex = 0;
		if (temp1 != null && temp1.trim().length() != 0) {
			try {
				oldIndex = Integer.parseInt(temp1);
				System.out.println("oldIndex:" + oldIndex);
			} catch (NumberFormatException e) {
				e.printStackTrace();
			}
		}

		int newIndex = 0;
		if (temp2 != null && temp2.trim().length() != 0) {
			try {
				newIndex = Integer.parseInt(temp2);
				System.out.println("newIndex:" + newIndex);
			} catch (NumberFormatException e) {
				e.printStackTrace();
			}
		}

		// 呼叫Model
		session = request.getSession(false);
		List<TripDetailVO> tripDetailCart;

		if (session != null) {
			try {
				tripDetailCart = (LinkedList<TripDetailVO>) session.getAttribute("tripDetailCart");
				if (tripDetailCart != null) {
					System.out.println("session裡的tripDetailCart=" + tripDetailCart);
					TripDetailVO tripDetailVO1 = tripDetailCart.remove(oldIndex);
					tripDetailCart.add(newIndex, tripDetailVO1);
					Iterator<TripDetailVO> it = tripDetailCart.iterator();
					int newTripOrder = 1;
					while (it.hasNext()) {
						TripDetailVO tripDetailVO = it.next();
						tripDetailVO.setTripOrder(newTripOrder);
						newTripOrder = newTripOrder + 2;
					}
					session.setAttribute("tripDetailCart", tripDetailCart);
					System.out.println("修改過的tripDetailCart=" + tripDetailCart);
				} else {

				}
			} catch (ClassCastException e) {
				System.out.println("Object cast to List<TripDetailVO> ClassCastException");
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
