package _01_Sight.controller;

import java.io.IOException;
import java.sql.Time;
import java.sql.Timestamp;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/SightServlet")
public class SightServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		this.doGet(request, response);
	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		//接收HTML Form資料
//		private Integer sightId;     //景點編號
//		 String sightName = request.getParameter("sightName"); 	 //名稱
//		 String regionId = request.getParameter("regionId"); 	 //地區編號
//		 String countyId = request.getParameter("countyId");     //縣市編號
//		 String sightTypeId = request.getParameter("sightTypeId");	 //景點類型編號
//		 String ticket = request.getParameter("ticket");	 	 //門票
//		private Time openTime; 		 //開門時間
//		private Time closeIime;		 //關門時間
//		private Time spendHour;		 //建議停留時間
//		private String playPeriod;	 //建議旅行時段	
//		private Float score;		 //評分
//		private Float longitude;	 //經度
//		private Float latitude;		 //緯度
//		private Integer watchNum;  	 //瀏覽人次
//		private Integer collectNum;	 //收藏人次
//		 String phone = request.getParameter("phone"); 		 //電話
//		 String addr = request.getParameter("addr");		 //地址
//		 String trans = request.getParameter("trans");		 //交通方式
//		private Integer creator;	 //新增者
//		private Timestamp createTime;//新增時間
//		private Integer modifier;	 //修改人
//		private Timestamp modifyTime;//上次更新時間
//		private boolean del;
	}

}
