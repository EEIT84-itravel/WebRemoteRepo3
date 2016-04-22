package _05_Member.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import _02_TripAndJournal.model.TripService;
import _05_Member.model.CollectionService;


@WebServlet("/_05_Member/member/delmytrip.controller")
public class DeleteTripServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	TripService tripservice = new TripService();
	CollectionService collectionservice = new CollectionService();
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		//接收資料
		Integer tripId = null;
		String temp = request.getParameter("tripId");
		String typeId = "type_id02"; //行程類型
		ArrayList<Integer> tripCollectionId = new ArrayList<Integer>();
		//轉換資料的型態 
		if(temp != null && temp.trim().length()!=0){
			tripId = Integer.parseInt(temp);
		}else{
			System.out.println("缺少行程編號");
		}
		//處理資料
		if(tripId != null ){
			tripservice.deleteTrip(tripId);
		}
		//刪除相關收藏
		tripCollectionId = collectionservice.selectByReferenceTypeAndTypeId(tripId, typeId);
		if(tripCollectionId!=null && tripCollectionId.size()>0){
			for(int i= 0;i<tripCollectionId.size();i++){
				collectionservice.delSightCollection(tripCollectionId.get(i));
			}
		}
		 //秀回畫面
		String path = request.getContextPath();
		response.sendRedirect(path+"/_05_Member/member/MemberTrip.jsp");
		 return;
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		this.doGet(request, response);
	}

}
