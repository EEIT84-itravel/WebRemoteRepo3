package _05_Member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import _05_Member.model.MemberService;

@WebServlet(
		urlPatterns={"/_05_Member/registered.controller"}
)
public class RegisteredServlet extends HttpServlet {
	private MemberService memberService = new MemberService();
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	//接收註冊人的資料
		
	}

	@Override
	protected void doPost(HttpServletRequest req,
			HttpServletResponse resp) throws ServletException, IOException {
		this.doGet(req, resp);
	}

}
