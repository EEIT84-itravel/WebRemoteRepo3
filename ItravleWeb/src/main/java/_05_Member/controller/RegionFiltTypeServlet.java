package _05_Member.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import _01_Sight.model.SightService;
import _01_Sight.model.SightVO;
import _05_Member.model.CollectionService;
import _05_Member.model.CollectionVO;


@WebServlet("/_05_Member/member/RegionFiltType.controller")
public class RegionFiltTypeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	CollectionService collectionService = new CollectionService();
	SightService sightService = new SightService();
	
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		//接收資料
		String regionId = request.getParameter("regionId");
		String temp = request.getParameter("memberId"); //取得memberId(字串型態)
		Integer memberId = null;
		ArrayList<Integer> sightID = new ArrayList<Integer>();
		ArrayList<SightVO> sightVO1 = new ArrayList<SightVO>();
		//轉換資料型態
		if (temp != null && temp.trim().length()!=0) {//memberId轉換型態成int
			memberId = Integer.parseInt(temp);
		}else{
			System.out.println("缺少memberId");
		}
		
		//處理資料
		if(regionId.equals("region00")){ //個人全部景點
			List<CollectionVO> collectionVO = collectionService.selectByMemberId(memberId);
               if(collectionVO != null){
            	   for (int i = 0; i < collectionVO.size(); i++) {
   		 			int a = collectionVO.get(i).getReferenceType();
   		 			sightID.add(a);
   		 		}
               }
               if(sightID != null){//若有查到景點ID，抓出表中景點資訊
            	   for (int i = 0; i < sightID.size(); i++) {
   		 			SightVO temp1 = sightService.selectById(sightID.get(i)); 
   		 			sightVO1.add(temp1);
   		 		}
               }
               
               if(sightVO1 != null){//將景點資訊傳回頁面
            	request.setAttribute("sightVO1", sightVO1);
   				request.getRequestDispatcher("/_05_Member/member/MemberSight.jsp").forward(request, response);
   				return;
               }
		}else{//依照景點地區查詢
			
			
			List<CollectionVO> collectionVO = collectionService.selectByMemberId(memberId);
            if(collectionVO != null){
         	   for (int i = 0; i < collectionVO.size(); i++) {
		 			int a = collectionVO.get(i).getReferenceType();
		 			sightID.add(a);
		 		}
            }
            if(sightID != null){//若有查到景點ID，抓出表中景點資訊
         	   for (int i = 0; i < sightID.size(); i++) {
		 			SightVO temp1 = sightService.selectById(sightID.get(i)); 
		 			String b = temp1.getRegionId();
		 			if(regionId.equals(b)){
		 			sightVO1.add(temp1);
		 			}
		 		}
            }
            System.out.println(sightVO1);
            if(!sightVO1.isEmpty()){//將景點資訊傳回頁面
         	request.setAttribute("sightVO1", sightVO1);
				
            }else{
            	request.setAttribute("noSightVO", "noSightVO");
				
            }
            request.getRequestDispatcher("/_05_Member/member/MemberSight.jsp").forward(request, response);
			return;
		}
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		this.doGet(request, response);
	}

}
