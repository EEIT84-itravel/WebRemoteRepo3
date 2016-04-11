package _02_TripAndJournal.controller;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import _02_TripAndJournal.model.JournalDetailService;
import _02_TripAndJournal.model.JournalDetailVO;
import _02_TripAndJournal.model.JournalPhotoService;
import _02_TripAndJournal.model.JournalPhotoVO;

@WebServlet(urlPatterns = { "/_01_Sight/ShowSightMainPic2.controller" },
initParams = { @WebInitParam(name = "defaultFile", value = "/img/x.png") })
public class ShowJournalMainPic extends HttpServlet {
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
		String temp1 = request.getParameter("journalId");

		Map<String, String> error = new HashMap<String, String>();
		request.setAttribute("error", error);

		// 轉換資料
		int journalId = 0;
		if (temp1 != null && temp1.trim().length() != 0) {
			journalId = Integer.parseInt(temp1);
		}
		// 驗證資料-無

		// 呼叫Model
		JournalDetailService jds = new JournalDetailService();
		List<JournalDetailVO> journalDetailVOs = jds.selectByJournalId(journalId);
		JournalPhotoService jps=new JournalPhotoService();
		JournalPhotoVO  journalPhotoVO=jps.selectCover(journalDetailVOs);
		byte[] bytes = null;
		if (journalPhotoVO != null) {
			bytes = journalPhotoVO.getJournalPhoto();
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
		doGet(request, response);
	}

}
