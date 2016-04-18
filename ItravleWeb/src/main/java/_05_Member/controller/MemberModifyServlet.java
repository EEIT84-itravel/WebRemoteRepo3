package _05_Member.controller;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import _05_Member.model.MemberVO;
import _05_Member.model.MemberService;
@WebServlet(
		urlPatterns={"/_05_Member/membermodify.controller"}
)
@MultipartConfig 
public class MemberModifyServlet extends HttpServlet {
	private MemberService memberService = new MemberService();
	private static final long serialVersionUID = 1L;
	public static final Pattern EMAIL_PATTERN = Pattern
		      .compile("^\\w+\\.*\\w+@(\\w+\\.){1,5}[a-zA-Z]{2,3}$");
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//接收註冊人的資料
				request.setCharacterEncoding("UTF-8");
				String temp = request.getParameter("memberId");
				int memberId = 0;
				if(temp!=null && temp.trim().length()!=0){
					try {
						memberId = Integer.parseInt(temp);
					} catch (NumberFormatException e) {
						e.printStackTrace();
					}
				}
				String memberAccount = request.getParameter("memberAccount");
				String lastName = request.getParameter("lastName");
				String firstName = request.getParameter("firstName");
				String password = request.getParameter("password");
				String nickname = request.getParameter("nickname");
				String email = request.getParameter("email");
				String birth = request.getParameter("birth");
				String cellphone = request.getParameter("cellphone");
				Part filePart = request.getPart("photo1"); // Retrieves <input type="file" name="file">
				String fileName = filePart.getSubmittedFileName();
				InputStream is = filePart.getInputStream();
				Map<String, String> error = new HashMap<String, String>();
				request.setAttribute("error", error);
				System.out.println(memberId+lastName +","+ firstName+","+password+","+email+","+cellphone+","+filePart);//測試有沒有抓到東西	
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
							"/_05_Member/MemberModify.jsp").forward(request,
							response);
					return;
				}
				//呼叫Model
				MemberVO member = new MemberVO();
				member.setMemberId(memberId);
				member.setMemberAccount(memberAccount);
				member.setLastName(lastName);
				member.setFirstName(firstName);
				member.setNickname(nickname);
				member.setPassword(password);
				member.setEmail(email);
				member.setBirth(birthday);
				member.setCellphone(cellphone);
				byte[] p = new byte[is.available()];
				if(p.length != 0){
				is.read(p);
				is.close();
				member.setPhoto(p);
				}else{
					byte[] bytes = null;
					bytes = memberService.selectById(memberId).getPhoto();
					member.setPhoto(bytes);
					} 
				
//				java.sql.Timestamp timestamp = new Timestamp( new
//							 java.util.Date().getTime());
//				member.setModiftyTime(timestamp);   //資料庫有預設   
				System.out.println(member);
				
				boolean result = memberService.modify(member);
				if(result == true){
					HttpSession session = request.getSession();
					session.setAttribute("user", member);
					
					String path = request.getContextPath();
					response.sendRedirect(path+"/_05_Member/MemberModify.jsp");
				}
	}
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doGet(request, response);
	}

}