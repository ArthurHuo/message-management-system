package org.mm.servlet;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class BaseServlet extends HttpServlet {

	@Override
	protected void service(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		String m=request.getParameter("m");
//		if("reg".equals(m)){ // 如果操作是注册
//			reg(request, response);
//		}else if("regInput".equals(m)){ //如果操作是注册前的输入
//			regInput(request,response);
//		}else if("check".equals(m)){
//			check(request,response);
//		}
		
		//由方法名称字符串如何推导出方法对象 ->反射机制
		
		try {
			Method method=this.getClass().getDeclaredMethod(m, HttpServletRequest.class,HttpServletResponse.class);
			//运行期动态调用
			method.invoke(this, request,response);
			
		} catch (SecurityException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (NoSuchMethodException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalArgumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		

	}
}
