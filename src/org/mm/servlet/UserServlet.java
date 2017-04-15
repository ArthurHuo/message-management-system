package org.mm.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.mm.dao.QuestionDao;
import org.mm.dao.UserDao;
import org.mm.model.Question;
import org.mm.model.User;

public class UserServlet extends BaseServlet {

	protected void check(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		UserDao userDao = new UserDao();
		String id = request.getParameter("id");
		User user = userDao.get(id);
		String info = null;
		String isOk = null;
		if (user == null) {
			info = "用户名可用！";
			isOk = "true";
		} else {
			info = "用户名不可用！";
			isOk = "false";
		}
		request.setAttribute("info", info);
		request.setAttribute("isOk", isOk);

		request.getRequestDispatcher("/user/check.jsp").forward(request,
				response);

	}
	
	protected void list(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		UserDao userDao = new UserDao();
		String keyStr = request.getParameter("keyStr");
		if(keyStr == null){
			keyStr = "";
		}
		
		request.setAttribute("users", userDao.quary(keyStr));
		
		request.getRequestDispatcher("/message/user_list.jsp").forward(request,
				response);

	}
	
	protected void loginOut(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		request.getSession().invalidate();
		response.sendRedirect(request.getContextPath()+"/login.jsp");

	}
	
	

	protected void login(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		UserDao userDao = new UserDao();
		String id = request.getParameter("id");
		String password = request.getParameter("password");

		User user = userDao.get(id);

		String info = null;
		if (user == null) {
			info = "用户不存在";

		} else {
			if (!user.getPassword().equals(password)) {
				info = "密码不正确";
			}
		}

		if (info != null) {
			request.setAttribute("info", info);

				request.getRequestDispatcher("/login.jsp").forward(request,
						response);

		}else{
			request.getSession().setAttribute("LOGIN_USER", user);
			response.sendRedirect(request.getContextPath()+"/main.html");
		}
	
	}
	
	protected void resetPassword(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		UserDao userDao = new UserDao();
		User user = (User)request.getSession().getAttribute("USER_LOST");
		String resetPassword = request.getParameter("resetPassword");
		userDao.resetPassword(resetPassword,user.getId());
		
		request.getRequestDispatcher("/login.jsp").forward(request,
				response);
	}
	
	protected void changePassword(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		UserDao userDao = new UserDao();
		User user = (User)request.getSession().getAttribute("LOGIN_USER");
		String resetPassword = request.getParameter("resetPassword");
		userDao.resetPassword(resetPassword,user.getId());
		
		request.getRequestDispatcher("/login.jsp").forward(request,
				response);
	}
	
	
	protected void lostPassword(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		UserDao userDao = new UserDao();
		String id = request.getParameter("id");
		String password = request.getParameter("password");

		User user = userDao.get(id);
		String info = null;
		if (user == null) {
			request.setAttribute("info", info);

			request.getRequestDispatcher("/user/lostpassword.jsp").forward(request,
					response);
	

		}else{
			info = "true";
			request.getSession().setAttribute("USER_LOST", user);
			request.setAttribute("info", info);
			request.setAttribute("userlost", user);
			request.getRequestDispatcher("/user/lostpassword.jsp").forward(request,
					response);
		}
	
	}

	protected void checkCode(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String code = request.getParameter("checkCode");
		String isOk = null;
		String info = null;
		String getcode = (String) request.getSession().getAttribute(
				"CHECK_CODE");
		if (request.getSession().getAttribute("CHECK_CODE") != "") {
			if (!code.equals(getcode)) {
				info = "验证码不正确";
				isOk = "false";
			} else {
				info = "验证码正确";
				isOk = "true";
			}
		}
		request.setAttribute("isOk", isOk);
		request.setAttribute("info", info);

		request.getRequestDispatcher("/user/check.jsp").forward(request,
				response);

	}
	
	protected void checkAnswer(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String answer = (String)request.getParameter("answer");
		User user = (User)request.getSession().getAttribute("USER_LOST");
		
		String checkAnswer = (user.getQuestion().getAnswer());
		
		String isOk = null;
		String info = null;
		if(answer.equals(checkAnswer)){
			request.getSession().setAttribute("LOGIN_USER", user);
			request.getRequestDispatcher("/user/resetpassword.jsp").forward(request,
					response);
		}else{
			request.getRequestDispatcher("/user/lostpassword.jsp").forward(request,
					response);
		}
		
	}
	
	

	public void reg(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String info = null;
		String id = request.getParameter("id");
		User u = new UserDao().get(id);
		if (u != null) {
			info = "用户名不可用";
			request.setAttribute("info", info);
			request.getRequestDispatcher("/user/check.jsp").forward(request,
					response);
			return;
		}

		String checkCode = request.getParameter("checkCode");
		String getcode = (String) request.getSession().getAttribute(
				"CHECK_CODE");

		if (request.getSession().getAttribute("CHECK_CODE") != null) {
			if (!checkCode.equals(getcode)) {
				info = "验证码不正确";
				request.setAttribute("info", info);
				request.getRequestDispatcher("/user/check.jsp").forward(
						request, response);
				return;
			}
		}

		User user = new User();
		user.setId(request.getParameter("id"));
		user.setMobile(request.getParameter("mobile"));
		user.setName(request.getParameter("name"));
		user.setNick(request.getParameter("nick"));
		user.setPassword(request.getParameter("password"));
		Question q = new Question();
		String questionId = request.getParameter("question");
		String answer = request.getParameter("answer");
		q.setId(questionId);
		q.setAnswer(answer);
		user.setQuestion(q);

		UserDao userDao = new UserDao();
		userDao.save(user);

		request.getRequestDispatcher("/user/reg_success.jsp?success=true")
				.forward(request, response);
	}

	public void regInput(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		List<Question> qs = new ArrayList();
		QuestionDao qd = new QuestionDao();
		qs = qd.query();
		request.setAttribute("questions", qs);

		request.getRequestDispatcher("/user/reg_input.jsp").forward(request,
				response);
	}

}
