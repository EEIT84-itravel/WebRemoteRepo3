package _02_TripAndJournal.controller;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

//import org.apache.tomcat.util.http.fileupload.UploadContext;

import _02_TripAndJournal.model.JournalDetailService;
import _02_TripAndJournal.model.JournalDetailVO;
import _02_TripAndJournal.model.JournalPhotoService;
import _02_TripAndJournal.model.JournalPhotoVO;

@WebServlet("/_02_TripAndJournal/member/JournalDetail.controller")
@MultipartConfig
public class JournalDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	HttpSession session;

	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");// 編碼

		String path = request.getContextPath();
		String[] sightOrders = request.getParameterValues("sightOrder");
		String[] whichDays = request.getParameterValues("whichDay");
		String[] sightIds = request.getParameterValues("sightId");
		String[] journalIds = request.getParameterValues("journalId");
		String[] journalDetailIds = request
				.getParameterValues("journalDetailId");
		String[] sightJournals = request.getParameterValues("sightJournal");
		String temp = request.getParameter("JournalPhotoId");
		String crud = request.getParameter("crud");

		Map<String, String> error = new HashMap<String, String>();
		request.setAttribute("error", error);

		JournalDetailService jds = new JournalDetailService();
		JournalDetailVO journalDetailVO = new JournalDetailVO();

		int x = 0;

		int journalPhotoId = 0;
		if ("Update".equals(crud)) {
			if (temp != null && temp.trim().length() != 0) {
				try {
					journalPhotoId = Integer.parseInt(temp);
				} catch (NumberFormatException e) {
					e.printStackTrace();
				}
			}
		}

		int sightOrder = 0;
		int whichDay = 0;
		int sightId = 0;
		int journalId = 0;
		int journalDetailId = 0;
		String sightJournal = null;
		// 跑for迴圈把值一個一個塞到VO裡面，塞完後insert再跑回圈
		for (x = 0; x < journalDetailIds.length; x++) {
			String obj1 = journalDetailIds[x];
			if (obj1 != null && obj1.trim().length() != 0) {
				try {
					journalDetailId = Integer.parseInt(obj1);
				} catch (NumberFormatException e) {
					e.printStackTrace();
				}
			}
			journalDetailVO.setJournalDetailId(journalDetailId);
			String obj2 = sightOrders[x];
			if (obj2 != null && obj2.trim().length() != 0) {
				try {
					sightOrder = Integer.parseInt(obj2);
				} catch (NumberFormatException e) {
					e.printStackTrace();
				}
			}
			journalDetailVO.setSightOrder(sightOrder);

			String obj3 = whichDays[x];
			if (obj3 != null && obj3.trim().length() != 0) {
				try {
					whichDay = Integer.parseInt(obj3);
				} catch (NumberFormatException e) {
					e.printStackTrace();
				}
			}
			journalDetailVO.setWhichDay(whichDay);

			String obj4 = sightIds[x];
			if (obj4 != null && obj4.trim().length() != 0) {
				try {
					sightId = Integer.parseInt(obj4);
				} catch (NumberFormatException e) {
					e.printStackTrace();
				}
			}
			journalDetailVO.setSightId(sightId);

			String obj5 = journalIds[x];
			if (obj5 != null && obj5.trim().length() != 0) {
				try {
					journalId = Integer.parseInt(obj5);
				} catch (NumberFormatException e) {
					e.printStackTrace();
				}
			}
			journalDetailVO.setJournalId(journalId);
			sightJournal = sightJournals[x];
			if (sightJournal == null || sightJournal.trim().length() == 0) {
				error.put("sightJournal", "請輸入您在此景點的遊記");
			}
			if (error != null && !error.isEmpty()) {
				request.getRequestDispatcher(
						"/_02_TripAndJournal/member/WriteJournal.jsp").forward(
						request, response);
				return;
			}
			journalDetailVO.setSightJournal(sightJournal);
			jds.insert(journalDetailVO);
		}

		Part filePart = request.getPart("journalPic");// 抓出圖片
		String fileName = filePart.getSubmittedFileName();
		InputStream is = filePart.getInputStream();
		JournalPhotoVO journalPhotoVO = new JournalPhotoVO();
		JournalPhotoService journalPhotoService = new JournalPhotoService();
		// 寫入圖片
		byte[] p = new byte[is.available()];
		is.read(p);
		is.close();
		journalPhotoVO.setJournalPhoto(p);

		String obj1 = journalDetailIds[0];
		if (obj1 != null && obj1.trim().length() != 0) {
			try {
				journalDetailId = Integer.parseInt(obj1);
			} catch (NumberFormatException e) {
				e.printStackTrace();
			}
		}
		journalPhotoVO.setJournalDetailId(journalDetailId);
		journalPhotoVO.setCover(true);
		if ("Update".equals(crud)) {
			if(journalPhotoId!=0){
			journalPhotoVO.setJournalPhotoId(journalPhotoId);
			journalPhotoService.update(journalPhotoVO);
			}else{
				journalPhotoService.update(journalPhotoVO);
			}
		} else if ("Insert".equals(crud)) {
			journalPhotoService.insert(journalPhotoVO);
		}
		response.sendRedirect(path
				+ "/_02_TripAndJournal/ShowJournalDetail.controller?journalId="
				+ journalId);
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		this.doGet(request, response);
	}

}
