package _06_BackEnd.controller;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Time;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import _01_Sight.model.SightPicVO;
import _01_Sight.model.SightService;
import _01_Sight.model.SightVO;

@WebServlet("/_06_BackEnd/controller/BackendSight.controller")
@MultipartConfig 
public class BackendSightServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// 接收HTML Form資料
		request.setCharacterEncoding("UTF-8");
		Map<String, String> error = new HashMap<String, String>();
		request.setAttribute("error", error);
		
		String temp = request.getParameter("sightId");
		String action = request.getParameter("action");

		String sightName=request.getParameter("sightName");//景點名稱
		if (sightName == null || sightName.trim().length() == 0) {
			error.put("sightName","景點名稱必須輸入");
		}
		String regionId=request.getParameter("regionId");//地區
		if (regionId == null || regionId.trim().length() == 0) {
			error.put("regionId","地區必須輸入");
		}
		String countyId=request.getParameter("countyId");//縣市
		if (countyId == null || countyId.trim().length() == 0) {
			error.put("countyId","縣市必須輸入");
		}
		String sightTypeId=request.getParameter("sightTypeId");//景點類型
		if (sightTypeId == null || sightTypeId.trim().length() == 0) {
			error.put("sightTypeId","景點類型必須輸入");
		}
		String ticket=request.getParameter("ticket");//門票,可null
		String temp1=request.getParameter("openTime");//開門時間
		java.sql.Time openTime=null;
		if(temp1!=null&&temp1.trim().length()!=0){
			try {
				openTime=Time.valueOf(temp1);
			} catch (Exception e) {
				e.printStackTrace();
				error.put("openTime", "開門時間格式錯誤");
			}
		}else{
			error.put("openTime","開門時間必須輸入");
		}
		String temp2=request.getParameter("closeIime");//關門時間
		java.sql.Time closeIime=null;
		if(temp2!=null&&temp2.trim().length()!=0){
			try {
				closeIime=Time.valueOf(temp2);
			} catch (Exception e) {
				e.printStackTrace();
				error.put("closeIime", "關門時間格式錯誤");
			}
		}else{
			error.put("closeIime","關門時間必須輸入");
		}
		String temp3=request.getParameter("spendHour");//建議停留時間
		java.sql.Time spendHour=null;
		if(temp3!=null&&temp3.trim().length()!=0){
			try {
				spendHour=Time.valueOf(temp3);
			} catch (Exception e) {
				e.printStackTrace();
				error.put("spendHour", "建議停留時間格式錯誤");
			}
		}else{
			error.put("spendHour","建議停留時間必須輸入");
		}
		String playPeriod=request.getParameter("playPeriod");//建議旅行時段
		if (playPeriod == null || playPeriod.trim().length() == 0) {
			error.put("playPeriod","建議旅行時段必須輸入");
		}
		String temp4=request.getParameter("longitude");//經度
		Float longitude=null;
		if(temp4!=null&&temp4.trim().length()!=0){
			try {
				longitude=Float.parseFloat(temp4);
			} catch (Exception e) {
				e.printStackTrace();
				error.put("longitude", "經度請輸入數字");
			}
		}else{
			error.put("longitude","經度必須輸入");
		}
		String temp5=request.getParameter("latitude");//緯度
		Float latitude=null;
		if(temp5!=null&&temp5.trim().length()!=0){
			try {
				latitude=Float.parseFloat(temp5);
			} catch (Exception e) {
				e.printStackTrace();
				error.put("latitude", "緯度請輸入數字");
			}
		}else{
			error.put("latitude","緯度必須輸入");
		}
		String phone=request.getParameter("phone");//電話,可null
		String addr=request.getParameter("addr");//地址,可null
		String trans=request.getParameter("trans");//交通方式,可null
		String intro=request.getParameter("intro"); //簡介
	/*	Part filePart = request.getPart("pic"); // Retrieves <input type="file" name="pic">
		String fileName = filePart.getSubmittedFileName();
		InputStream is = filePart.getInputStream();*/

		// 轉換HTML Form資料
		int sightId = 0;
		if (temp != null && temp.trim().length() != 0) {
			try {
				sightId = Integer.parseInt(temp);
			} catch (IllegalArgumentException e) {
				error.put("sightId", "景點ID必須是數字");
			}
		}
		

		// 呼叫Model
		SightService sightService = new SightService();
		SightVO sightVO;
		SightPicVO sightPicVO;
		
		if ("getOne".equals(action)) {// 來自AllSight.jsp篩選一隻sightVO為了update
			sightVO= sightService.findByPrimaryKey(sightId);
			request.setAttribute("sightVO", sightVO);
			
			request.getRequestDispatcher("/_06_BackEnd/backend/UpdateSight.jsp").forward(request, response);
		}
		if ("update".equals(action)) {//來自UpdateSight.jsp 接收修改後資料
			if (error != null && !error.isEmpty()) {
				request.getRequestDispatcher(
						"/_06_BackEnd/backend/UpdateSight.jsp").forward(request,
						response);
				return;
			}
			
			sightVO=new SightVO();

		}
		if ("insert".equals(action)) {//來自NewSight.jsp 接收新增資料
			if (error != null && !error.isEmpty()) {
				request.getRequestDispatcher(
						"/_06_BackEnd/backend/NewSight.jsp").forward(request,
						response);
				return;
			}
			
			sightVO=new SightVO();
			

		}

	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
