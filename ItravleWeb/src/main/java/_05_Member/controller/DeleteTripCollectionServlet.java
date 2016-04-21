package _05_Member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import _05_Member.model.CollectionService;


@WebServlet("/_05_Member/member/deltrip.controller")
public class DeleteTripCollectionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	CollectionService collectionservice = new CollectionService();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		//接收資料
		Integer memberId = null;
		Integer referenceType = null;
		Integer collectionNo = null;
		String temp = request.getParameter("referenceType");
		String temp1 = request.getParameter("memberId");
		String typeId = request.getParameter("typeId");
		//轉換資料的型態 
		if(temp != null && temp.trim().length()!=0){
			referenceType = Integer.parseInt(temp);
		}else{
			System.out.println("缺少行程編號");
		}
		if(temp1 != null && temp1.trim().length()!=0){
			memberId = Integer.parseInt(temp1);
		}else{
			System.out.println("缺少會員編號");
		}
		//處理資料
		//找到收藏編號
		collectionNo = collectionservice.selectCollection(referenceType, memberId, typeId);
		if(collectionNo != null){
			//刪除收藏編號
			collectionservice.delSightCollection(collectionNo);
		}
		 //秀回畫面
		String path = request.getContextPath();
		response.sendRedirect(path+"/_05_Member/member/MemberCollectionTrip.jsp");
		 return;
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {	
		this.doGet(request, response);
	}

}
