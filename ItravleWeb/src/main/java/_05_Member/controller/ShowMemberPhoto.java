package _05_Member.controller;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import _01_Sight.model.SightPicService;
import _01_Sight.model.SightPicVO;
import _05_Member.model.MemberService;
import _05_Member.model.MemberVO;

@WebServlet(urlPatterns = { "/_05_Member/ShowMemberPhoto.controller" },
initParams = { @WebInitParam(name = "defaultFile", value = "/img/noHead.JPG") })

public class ShowMemberPhoto extends HttpServlet{
	private static final long serialVersionUID = 1L;
	private byte[] defaultPhoto;
	@Override
	public void init() throws ServletException {
		FileInputStream fis = null;
		String defaultFile = this.getInitParameter("defaultFile");
		ServletContext application = this.getServletContext();
		String path = application.getRealPath(defaultFile);
		File file = new File(path);
		ByteArrayOutputStream bos = null;
		try {
			fis = new FileInputStream(file);
			bos = new ByteArrayOutputStream();
			byte[] buf = new byte[1024];
			for (int readNum; (readNum = fis.read(buf)) != -1;) {
				bos.write(buf, 0, readNum);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		defaultPhoto = bos.toByteArray();
	}
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// 接收資料
		request.setCharacterEncoding("UTF-8");
		String temp1 = request.getParameter("memberId");

		Map<String, String> error = new HashMap<String, String>();
		request.setAttribute("error", error);

		// 轉換資料
		int memberId = 0;
		if (temp1 != null && temp1.trim().length() != 0) {
			memberId = Integer.parseInt(temp1);
		}
		// 驗證資料-無

		// 呼叫Model
		MemberService memberDAO = new MemberService();
		MemberVO memberVO = memberDAO.selectById(memberId);
		byte[] bytes = null;
		if (memberVO != null) {
			if(memberVO.getPhoto()!=null){
			bytes = memberVO.getPhoto();
			}else{
			  bytes = defaultPhoto;	
			}
		} else {
			bytes = defaultPhoto;
		}
		OutputStream out = response.getOutputStream();
		if (bytes != null && bytes.length > 0) {
			response.setContentType("image/jpg");
			out.write(bytes);
			out.flush();
			out.close();
		}
	}
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		this.doGet(request, response);
	}
}
