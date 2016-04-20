package _06_BackEnd.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import _01_Sight.model.SightService;
import _01_Sight.model.SightVO;

@WebServlet("/_06_BackEnd/backEnd/SightCountyServlet.view")
public class SightCountyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/plain; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		StringBuilder output = new StringBuilder();
		String countyId = request.getParameter("countyId");
		if(countyId==null || countyId.trim().length()==0) {
			output.append("縣市是必要欄位");
		} 
		if(output!=null && output.length()!=0) {
			out.print(output);
			out.close();
			return;
		}
		
		SightService service=new SightService();
		List<SightVO> result=service.selectByCounty(countyId);
		
		if(result==null || result.isEmpty()) {
			output.append("此區不存在景點");
		} else {
			for(SightVO temp:result){
				output.append(temp.getSightId()+",");
				output.append(temp.getSightName()+",");
			}
		}
		out.print(output);
		out.close();
		return;
	
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
