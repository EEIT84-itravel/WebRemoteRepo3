package _00_Misc;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import _05_Member.model.MemberVO;

@WebFilter(urlPatterns = { "/_00_Misc/member/*", "/_01_Sight/member/*",
		"/_02_TripAndJournal/member/*", "/_03_Event/member/*",
		"/_04_Forum/member/*", "/_05_Member/member/*" })
public class LoginFilter implements Filter {
	@Override
	public void destroy() {
	}

	@Override
	public void doFilter(ServletRequest req, ServletResponse resp,
			FilterChain chain) throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) req;
		HttpServletResponse response = (HttpServletResponse) resp;
		// 先取出session物件
		HttpSession session = request.getSession(false);
		// 紀錄目前請求的RequestURI,以便使用者登入成功後能夠回到原本的畫面
		String path = request.getContextPath();
		String uri = request.getRequestURI();
		// 如果session物件不存在
		if (session == null) {
			// 請使用者登入
			response.sendRedirect(response.encodeRedirectURL(path + "/_05_Member/Login.jsp"));
			return;
		}
		MemberVO bean = (MemberVO) session.getAttribute("user");
			if (bean != null) {
				chain.doFilter(request, response);
			} else {
				session.setAttribute("dest", uri);	//儲存目前的路徑
				response.sendRedirect(path + "/_05_Member/Login.jsp");
			}
	}

	private FilterConfig filterConfig;

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		this.filterConfig = filterConfig;
	}

}
