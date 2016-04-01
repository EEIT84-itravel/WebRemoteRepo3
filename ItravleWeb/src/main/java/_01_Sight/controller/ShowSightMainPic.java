package _01_Sight.controller;

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

@WebServlet(urlPatterns = { "/_01_Sight/ShowSightMainPic.controller" }, initParams = { @WebInitParam(name = "defaultFile", value = "/img/x.png") })
public class ShowSightMainPic extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private File defaultPhoto;

	@Override
	public void init() throws ServletException {
		String defaultFile = this.getInitParameter("defaultFile");
		ServletContext application = this.getServletContext();
		String path = application.getRealPath(defaultFile);
		defaultPhoto = new File(path);
	}

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// 接收資料
		request.setCharacterEncoding("UTF-8");
		String temp1 = request.getParameter("sightId");

		Map<String, String> error = new HashMap<String, String>();
		request.setAttribute("error", error);

		// 轉換資料
		int sightId = 0;
		if (temp1 != null && temp1.trim().length() != 0) {
			sightId = Integer.parseInt(temp1);
		}
		// 驗證資料-無

		// 呼叫Model
		SightPicService sps = new SightPicService();
		SightPicVO sightPicVO = sps.selectMainPic(sightId);
		byte[] bytes = null;
		if (sightPicVO != null) {
			bytes = sightPicVO.getPic();
		} else {
			// bytes = new FileInputStream(defaultPhoto);
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
		doGet(request, response);
	}

}
