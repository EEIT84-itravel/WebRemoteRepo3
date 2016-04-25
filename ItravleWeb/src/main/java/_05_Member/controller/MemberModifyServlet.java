package _05_Member.controller;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Date;
import java.sql.Timestamp;
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
		urlPatterns={"/_05_Member/member/membermodify.controller"}
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
				HttpSession session=request.getSession();
				MemberVO memberVO =(MemberVO)session.getAttribute("user");
				int memberId = memberVO.getMemberId();
				String lastName = request.getParameter("lastName");
				String firstName = request.getParameter("firstName");
				String password = request.getParameter("password");
				String nickname = request.getParameter("nickname");
				String email = request.getParameter("email");
				String birth = request.getParameter("birth");
				String cellphone = request.getParameter("cellphone2");
				Part filePart = request.getPart("photo1"); // Retrieves <input type="file" name="file">
				String fileName = filePart.getSubmittedFileName();
				InputStream is = filePart.getInputStream();
				Map<String, String> error = new HashMap<String, String>();
				Map<String, String> modify = new HashMap<String, String>();
				request.setAttribute("error", error);
				request.setAttribute("modify", modify);
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
					modify.put("message", "修改失敗");
					session.setAttribute("modify", modify);
					request.getRequestDispatcher(
							"/_05_Member/member/MemberModify.jsp").forward(request,
							response);
					return;
				}
				//呼叫Model
				MemberVO member = memberService.selectById(memberId);
				member.setLastName(lastName);
				member.setFirstName(firstName);
				member.setNickname(nickname);
				member.setPassword(password);
				member.setEmail(email);
				member.setBirth(birthday);
				member.setCellphone(cellphone);
				member.setModifier(memberId);
				java.util.Date now=new java.util.Date();
				java.sql.Timestamp sqlTime= new Timestamp(now.getTime());
				member.setModiftyTime(sqlTime);
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
				System.out.println(member);
				
				boolean result = memberService.modify(member);
				if(result == true){
					session.removeAttribute("user");
					session.setAttribute("user", member);
					modify.put("message", "修改成功");
					session.setAttribute("modify", modify);
					String path = request.getContextPath();
					response.sendRedirect(path+"/_05_Member/member/MemberModify.jsp");
				}
	}
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		this.doGet(request, response);
	}

}
