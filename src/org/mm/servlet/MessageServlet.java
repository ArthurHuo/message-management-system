package org.mm.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.mm.dao.MessageDao;
import org.mm.dao.MessageLogDao;
import org.mm.model.Message;
import org.mm.model.MessageLog;
import org.mm.model.Page;
import org.mm.model.User;
import org.mm.utils.MessageListMode;

public class MessageServlet extends BaseServlet {

	public void add(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String receiver = request.getParameter("receiver");
		receiver = receiver.replaceAll("；", ";");

		Message m = new Message();
		m.setTitle(title);
		m.setContent(content);
		m.setReceiver(receiver);
		m.setSender((User) request.getSession().getAttribute("LOGIN_USER"));
		synchronized (this) {
			MessageDao messageDao = new MessageDao();
			messageDao.save(m);
			m.setId(messageDao.getMaxId());
		}

		MessageLogDao messageLogDao = new MessageLogDao();
		String[] tos = m.getReceiver().split(";");
		for (String to : tos) {
			MessageLog log = new MessageLog();
			log.setMessage(m);
			User user = new User();
			user.setId(to);
			log.setReceiver(user);

			messageLogDao.save(log);
		}

		request.getRequestDispatcher("/message/send_input.jsp").forward(
				request, response);
	}

	public void receive(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Page page = new Page();
		MessageLogDao messageLogDao = new MessageLogDao();
		User user = (User) request.getSession().getAttribute("LOGIN_USER");

		if (request.getParameter("pageNo") != null) {
			page.setPageNo(Integer.parseInt(request.getParameter("pageNo")));
		}
		request.setAttribute("logs", messageLogDao.query(user, page, ""));
		request.setAttribute("page", page);

		request.getRequestDispatcher("/message/message_list.jsp").forward(
				request, response);

	}

	public void list(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		MessageLogDao messageLogDao = new MessageLogDao();
		User user = (User) request.getSession().getAttribute("LOGIN_USER");
		Page page = new Page();
		page.setMode(MessageListMode.LIST);
		if (request.getParameter("pageNo") != null) {
			page.setPageNo(Integer.parseInt(request.getParameter("pageNo")));
		}
		String title = request.getParameter("title");
		request.setAttribute("logs", messageLogDao.query(user, page, title));


		request.setAttribute("page", page);

		request.getRequestDispatcher("/message/message_list.jsp").forward(
				request, response);

	}

	public void inbox(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		MessageLogDao messageLogDao = new MessageLogDao();
		User user = (User) request.getSession().getAttribute("LOGIN_USER");
		Page pageModel = new Page();
		pageModel.setMode(MessageListMode.INBOX);
		if (request.getParameter("pageNo") != null) {
			pageModel.setPageNo(Integer.parseInt(request.getParameter("pageNo")));
		}

		request.setAttribute("logs", messageLogDao.query(user, pageModel, ""));

		request.setAttribute("page", pageModel);

		request.getRequestDispatcher("/message/message_list.jsp").forward(
				request, response);

	}

	public void outbox(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		MessageLogDao messageLogDao = new MessageLogDao();
		User user = (User) request.getSession().getAttribute("LOGIN_USER");
		Page pageModel = new Page();
		pageModel.setMode(MessageListMode.OUTBOX);
		if (request.getParameter("pageNo") != null) {
			pageModel
					.setPageNo(Integer.parseInt(request.getParameter("pageNo")));
		}

		request.setAttribute("logs", messageLogDao.query(user, pageModel, ""));

		request.setAttribute("page", pageModel);

		request.getRequestDispatcher("/message/message_list.jsp").forward(
				request, response);

	}
	
	public void sendbox(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		MessageDao messageDao = new MessageDao();
		
		User user = (User) request.getSession().getAttribute("LOGIN_USER");
		Page pageModel = new Page();
		
		if (request.getParameter("pageNo") != null) {
			pageModel
					.setPageNo(Integer.parseInt(request.getParameter("pageNo")));
		}

		request.setAttribute("logs", messageDao.query(user,pageModel));

		request.setAttribute("page", pageModel);

		request.getRequestDispatcher("/message/message_outbox.jsp").forward(
				request, response);

	}
	
	public void outboxDel(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		MessageDao messageDao = new MessageDao();
		String[] ids = request.getParameterValues("c");

		messageDao.updateDelFlag(convert(ids), "1");
		request.getRequestDispatcher("/MessageServlet?m=sendbox").forward(
				request, response);

	}
	

	public void delBatch(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		MessageLogDao messageLogDao = new MessageLogDao();
		String[] ids = request.getParameterValues("c");
		String mode = request.getParameter("mode");
		messageLogDao.updateDelFlag(convert(ids), "1");
		request.getRequestDispatcher("/MessageServlet?m=" + mode).forward(
				request, response);

	}
	
	public void truncate(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		MessageLogDao messageLogDao = new MessageLogDao();
		String[] ids=request.getParameterValues("c");
		String mode=request.getParameter("mode");
		messageLogDao.delete(convert(ids));
		request.getRequestDispatcher("/MessageServlet?m="+mode).forward(
				request, response);

	}
	
	public void restore(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		MessageLogDao messageLogDao = new MessageLogDao();
		String[] ids=request.getParameterValues("c");
		String mode=request.getParameter("mode");
		messageLogDao.updateDelFlag(convert(ids), "0");
		request.getRequestDispatcher("/MessageServlet?m="+mode).forward(
				request, response);

	}
	
	public void read(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		MessageLogDao messageLogDao = new MessageLogDao();
		int logId=Integer.parseInt(request.getParameter("logId"));
		

		messageLogDao.updateReadFlag(logId,"1");
		
		
		//String mode=request.getParameter("mode");
		
		MessageLog log=messageLogDao.get(logId);
		
		request.setAttribute("message", log.getMessage());

		request.getRequestDispatcher("/message/detail.jsp").forward(
				request, response);

	}
	
	public void reply(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		MessageDao messageDao = new MessageDao();
		int msgId=Integer.parseInt(request.getParameter("msgId"));
		
		request.setAttribute("message", messageDao.get(msgId));
		request.getRequestDispatcher("/message/message_reply.jsp").forward(
				request, response);

	}
	public void forward(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		MessageDao messageDao = new MessageDao();
		int msgId=Integer.parseInt(request.getParameter("msgId"));
		
		request.setAttribute("message", messageDao.get(msgId));
		
		
		
		request.getRequestDispatcher("/message/message_forward.jsp").forward(
				request, response);

	}
	

	private int[] convert(String[] idStr) {
		int[] ids = new int[idStr.length];
		int index = 0;
		for (String id : idStr) {
			ids[index++] = Integer.parseInt(id);
		}

		return ids;
	}

}
