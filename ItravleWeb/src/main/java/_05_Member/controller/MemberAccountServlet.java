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
		urlPatterns={"/_05_Member/memberAccount.controller"}
)
public class MemberAccountServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		try {
			Thread.sleep(450);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
			this.textText(request, response);
		
	}
	private void textText(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/plain; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		StringBuilder output = new StringBuilder();
		String memberAccount = request.getParameter("memberAccount");
		
		if(memberAccount==null || memberAccount.trim().length()==0) {
			output.append("帳號是必要欄位");
		}
		if(output!=null && output.length()!=0) {
			out.print(output);
			out.close();
			return;
		}
		MemberVO bean = new MemberVO();
		bean.setMemberAccount(memberAccount);
		MemberService service = new MemberService();
		List<MemberVO> results = service.selectAll(memberAccount);
		if(results.isEmpty()){
			if(memberAccount.length()>15)
			{
			output.append("不能超過15個字符！");
			}else if (!memberAccount.matches("^(?=.*\\d)(?=.*[a-zA-Z]).{1,15}$")){
				output.append("格式錯誤!");
			}else{
			output.append("此帳號可使用");
			}
		}else {
			output.append("此帳號已有人使用");
		}
		out.print(output);
		out.close();
		return;
	}
	

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doGet(request, response);
	}

}
