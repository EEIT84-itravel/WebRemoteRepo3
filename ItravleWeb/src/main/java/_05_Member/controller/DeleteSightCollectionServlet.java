package _05_Member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import _05_Member.model.CollectionService;
import _05_Member.model.MemberVO;

@WebServlet("/_05_Member/member/delsight.controller")
public class DeleteSightCollectionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    CollectionService collectionservice = new CollectionService();
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		//接收資料
		Integer referenceType = null;
		Integer collectionNo = null;
		String temp = request.getParameter("referenceType");
		HttpSession session=request.getSession();
		MemberVO memberVO =(MemberVO)session.getAttribute("user");
		Integer memberId=memberVO.getMemberId();
		String typeId = request.getParameter("typeId");
		String regionId = request.getParameter("regionId");//紀錄刪除時所選擇的畫面的地區
		System.out.println(regionId);
		//轉換資料的型態 sightId memberId
		if(temp != null && temp.trim().length()!=0){
			referenceType = Integer.parseInt(temp);
		}else{
			System.out.println("缺少景點編號");
		}
		//處理資料
		//找到收藏編號
		collectionNo = collectionservice.selectCollection(referenceType, memberId, typeId);
		if(collectionNo != null){
			collectionservice.delSightCollection(collectionNo);
		}
		 //依照當初刪除時所選的地區頁面回傳回去再查詢並秀出畫面
		 request.getRequestDispatcher("/_05_Member/member/RegionFiltType.controller?regionId="+regionId+"&memberId="+memberId).forward(request,
		 response);
		 return;
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doGet(request, response);
	}

}
