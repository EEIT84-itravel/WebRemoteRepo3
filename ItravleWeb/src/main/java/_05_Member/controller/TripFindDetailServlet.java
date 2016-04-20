package _05_Member.controller;

import java.io.IOException;
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
       
@WebServlet("/_05_Member/member/tripfinddetail.controller")
public class TripFindDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private TripDetailService tripdetailservice = new TripDetailService();
	private TripService tripservice = new TripService();
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		        //接收資料
				request.setCharacterEncoding("UTF-8");
				String temp = request.getParameter("tripId");
				List<TripDetailVO> tripdetailVO = new LinkedList<TripDetailVO>();
				TripVO tripVO = new TripVO();
				//轉換資料型態
				int tripId = 0;
				if(temp!=null && temp.trim().length()!=0){
					try {
						tripId = Integer.parseInt(temp);
					} catch (NumberFormatException e) {
						e.printStackTrace();
					}
				}
				tripVO = tripservice.select(tripId);
				List<TripDetailVO> result  = tripdetailservice.select(tripId);
				 //取出"景點"性質的tripDetailVO 
				for(TripDetailVO temp2: result){ 
					   if(temp2.getReferenceType().equals("type_id01")){ 
						   tripdetailVO.add(temp2); 
					   } 
					  }
				if(tripdetailVO != null && tripdetailVO.size()>0){
					HttpSession session = request.getSession();
					session.setAttribute("tripDetailCart", tripdetailVO);
					session.setAttribute("tripVO", tripVO);
				}
				
				String path = request.getContextPath();
				response.sendRedirect(path+"/_02_TripAndJournal/member/WriteTrip.jsp");
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doGet(request, response);
	}

}
