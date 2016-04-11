package _05_Member.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import _05_Member.model.MemberService;
import _05_Member.model.MemberVO;

@WebServlet(
		urlPatterns={"/_05_Member/cellphone.controller"}
)
public class CellphoneServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			Thread.sleep(450);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}	
		this.textText2(request, response);
	}
	private void textText2(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/plain; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		StringBuilder output = new StringBuilder();
		String cellphone = request.getParameter("cellphone");
		
		if(cellphone==null || cellphone.trim().length()==0) {
			output.append("電話是必要欄位");
		}
		if(output!=null && output.length()!=0) {
			out.print(output);
			out.close();
			return;
		}
		MemberVO bean = new MemberVO();
		bean.setCellphone(cellphone);
		MemberService service = new MemberService();
		List<MemberVO> results = service.selectAllByCellphone(cellphone);
		if(results.isEmpty()){
			if(!cellphone.matches("^(?=.*\\d).{9,10}$"))
			{
			output.append("格式錯誤!");
			}else{
			output.append("此電話可使用");
			}
		}else {
			output.append("此電話已有人使用");
		}
		out.print(output);
		out.close();
		return;
	}
	

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		this.doGet(request, response);
	}

}
