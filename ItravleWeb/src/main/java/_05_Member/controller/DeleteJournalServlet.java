package _05_Member.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import _02_TripAndJournal.model.JournalService;
import _05_Member.model.CollectionService;

@WebServlet("/_05_Member/member/delmyjournal.controller")
public class DeleteJournalServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	JournalService journalservice = new JournalService();
	CollectionService collectionservice = new CollectionService();
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		//接收資料
		Integer journalId = null;
		String temp = request.getParameter("journalId");
		String typeId = "type_id03"; //遊記類型
		ArrayList<Integer> journalCollectionId = new ArrayList<Integer>();
		//轉換資料的型態 
				if(temp != null && temp.trim().length()!=0){
					journalId = Integer.parseInt(temp);
				}else{
					System.out.println("缺少遊記編號");
				}
				//處理資料
				if(journalId != null ){
					journalservice.deleteJournal(journalId);
				}
				//刪除相關收藏
				journalCollectionId = collectionservice.selectByReferenceTypeAndTypeId(journalId, typeId);
				if(journalCollectionId!=null && journalCollectionId.size()>0){
					for(int i= 0;i<journalCollectionId.size();i++){
						collectionservice.delSightCollection(journalCollectionId.get(i));
					}
				}
				 //秀回畫面
				String path = request.getContextPath();
				response.sendRedirect(path+"/_05_Member/member/MemberJournal.jsp");
				 return;
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		this.doGet(request, response);
	}

}
