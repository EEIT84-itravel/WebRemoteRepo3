package _05_Member.controller;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import java.util.regex.Pattern;

import _05_Member.model.MemberService;
import _05_Member.model.MemberVO;

@WebServlet(
		urlPatterns={"/_05_Member/registered.controller"}
)
@MultipartConfig 
public class RegisteredServlet extends HttpServlet {
	private MemberService memberService = new MemberService();
	public static final Pattern EMAIL_PATTERN = Pattern
		      .compile("^\\w+\\.*\\w+@(\\w+\\.){1,5}[a-zA-Z]{2,3}$");
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	//接收註冊人的資料
		request.setCharacterEncoding("UTF-8");
		String lastName = request.getParameter("lastName");
		String firstName = request.getParameter("firstName");
		String nickname = request.getParameter("nickname");
		String memberAccount = request.getParameter("memberAccount");
		String password = request.getParameter("password");
		String email = request.getParameter("email");
		String birth = request.getParameter("birth");
		String cellphone = request.getParameter("cellphone");
		Part filePart = request.getPart("photo"); // Retrieves <input type="file" name="file">
		String fileName = filePart.getSubmittedFileName();
		InputStream is = filePart.getInputStream();
		Map<String, String> error = new HashMap<String, String>();
		request.setAttribute("error", error);
		
		// 轉換HTML Form資料
		java.sql.Date birthday = null;
		if (birth != null && birth.trim().length() != 0) {
			// yyyy-[m]m-[d]d
			try {
				birthday = Date.valueOf(birth);
			} catch (IllegalArgumentException e) {
				error.put("birth", "日期格式錯誤");
			}
		}
		//檢查使用者輸入資料
		if (lastName == null || lastName.trim().length() == 0) {
			error.put("lastName","姓氏欄必須輸入");
		}
		if (firstName == null || firstName.trim().length() == 0) {
			error.put("firstName","名字欄必須輸入");
		}
		if (memberAccount == null || memberAccount.trim().length() == 0) {
			error.put("memberAccount","帳號欄必須輸入");
		}
		if (password == null || password.trim().length() == 0) {
			error.put("password","密碼欄必須輸入");
		}
		if (nickname == null || nickname.trim().length() == 0) {
			error.put("nickname","暱稱欄必須輸入");
		}
		if (email == null || email.trim().length() == 0) {
			error.put("email","信箱欄必須輸入");
		}else if(EMAIL_PATTERN.matcher(email).matches()!=true){
			error.put("email","格式錯誤！");
		}
		if (birth == null || birth.trim().length() == 0) {
			error.put("birth","生日欄必須輸入");
		}
		if (cellphone == null || cellphone.trim().length() == 0) {
			error.put("cellphone","電話欄必須輸入");
		}
		if (error != null && !error.isEmpty()) {
			request.getRequestDispatcher(
					"/index.jsp").forward(request,
					response);
			return;
		}
		//System.out.println(lastName + firstName + memberAccount+password+email+birthday+cellphone);//測試有沒有抓到東西
		//呼叫Model
		MemberVO member = new MemberVO();
		member.setLastName(lastName);
		member.setFirstName(firstName);
		member.setNickname(nickname);
		member.setMemberAccount(memberAccount);
		member.setPassword(password);
		member.setEmail(email);
		member.setBirth(birthday);
		member.setCellphone(cellphone);
		byte[] p = new byte[is.available()];
		is.read(p);
		is.close();
		member.setPhoto(p);
		System.out.println(member);
		
		boolean result = memberService.registered(member);
		if(result == true){
			HttpSession session = request.getSession();
			session.setAttribute("user", member);
			
			String path = request.getContextPath();
			response.sendRedirect(path+"/_05_Member/RegisteredSuccess.jsp");
		}
	}
	
	@Override
	protected void doPost(HttpServletRequest req,
			HttpServletResponse resp) throws ServletException, IOException {
		this.doGet(req, resp);
	}

}
