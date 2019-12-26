package com.zr.ems.web;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import com.zr.ems.pojo.Emp;
import com.zr.ems.service.IEmpService;
import com.zr.ems.service.impl.EmpService;

@SuppressWarnings("serial")
@WebServlet("/EmpServlet")
public class EmpServlet extends HttpServlet{
	

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//设置请求的编码
		req.setCharacterEncoding("utf-8");
		//告诉客户端如何解析服务器发送的反馈
		resp.setContentType("text/html;charset=utf-8");
		//接受请求参数
		String cmd =req.getParameter("cmd");
		
		if("login".equals(cmd)) {
			login(req,resp);
		}
		else if("register".equals(cmd)) {
			
			register(req,resp);
		}
		else if("findAll".equals(cmd)) {
			
			findAll(req,resp);
			
		}
		else if("delete".equals(cmd)) {
			delete(req,resp);
			
		}
		else if("update".equals(cmd)) {
			update(req,resp);
		}
		else if("FindByid".equals(cmd)) {
			FindByid(req,resp);
		}
	
	}

	

	/**
	 * 用于处理注册功能的方法
	 * @param req
	 * @param resp
	 * @throws IOException 
	 * @throws ServletException 
	 */
	private void register(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 首先获取到前台页面传递的数据
				String nickname = req.getParameter("nickname");
				String password = req.getParameter("password");
				String gender = req.getParameter("gender");
				double salary = Double.parseDouble(req.getParameter("salary"));
				
				/**
				 * 可以首先判断昵称是否已经被使用, 如果被使用, 则不允许注册.
				 */
				// 获取到服务对象
				IEmpService service = new EmpService();

				// 调用判断用户名是否存在的方法.
				// 1表示存在, 非1表示不存在
				int flag = service.findEmpByNickname(nickname);

				if (flag == 1) {

					resp.getWriter().write("<script>alert('账号已经存在！'); window.location='register.jsp'; window.close();</script>");
					resp.getWriter().flush();
					return;
				} else {
					
					// 把所有的数据封装到实体对象中
					Emp emp = new Emp(1, nickname, password, gender, salary);

					// 调用注册的方法
					service.registerEmp(emp);
					//提示注册成功后，返回登录页面
					resp.getWriter().write("<script>alert('注册成功！'); window.location='login.jsp'; window.close();</script>");
					resp.getWriter().flush();
				}

		
	}
	/**
	 * 专门用于处理登录功能的方法
	 * @param req
	 * @param resp
	 * @throws IOException 
	 */
	private void login (HttpServletRequest req, HttpServletResponse resp) throws IOException {
		
		/**
		 * 1.获取用户名和密码
		 * 2.去数据库比对 
		 * 3.如果存在则允许跳转
		 * 4.如果不存在，则告诉用户账号或密码有误
		 */
		
		//1.获取用户名和密码
		String nickname=req.getParameter("nickname");
		String password=req.getParameter("password");
		
		//2.去数据库比对 
		IEmpService service = new EmpService();

		Emp emp = service.findEmpByNicknameAndPassword(nickname, password);

		if (emp != null) {
			resp.getWriter().write("<script>alert('恭喜你，登录成功！'); window.location='EmpServlet?cmd=findAll'; window.close();</script>");
			resp.getWriter().flush();

			return;
		} else {
			//resp.getWriter().write("账号或密码有误, 请检查后登录");

			resp.getWriter().write("<script>alert('账号或密码有误, 请检查后登录'); window.location='login.jsp'; window.close();</script>");
			resp.getWriter().flush();
		}
		
	}
	/**
	 * 
	 * 通过接收主界面id查找到员工信息
	 * 将员工信息发送到修改页面
	 * 将用户更改后的信息接收进去
	 * 进入数据库完成修改
	 * 返回主页面
	 * @throws IOException 
	 * @throws ServletException 
	 * 
	 */
	private void FindByid(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		IEmpService service = new EmpService();
		int id = Integer.parseInt(req.getParameter("id"));
		Emp emp=service.FindByid(id);
		req.setAttribute("emp", emp);
		req.getRequestDispatcher("update.jsp").forward(req, resp);
		
	}
	private void update(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		/*
		 * 1.接收页面的修改信息
		 * 2.进行更改
		 * 3.更改完成后返回主页面
		 */
		IEmpService service = new EmpService();
		int id = Integer.parseInt(req.getParameter("id"));
		String nickname = req.getParameter("nickname");
		String gender = req.getParameter("gender");
		double salary = Double.parseDouble(req.getParameter("salary"));
		Emp emp = new Emp(id, nickname, gender, salary);
		service.UpdateByid(emp);
		resp.getWriter().write("<script>alert('修改成功！'); window.location='EmpServlet?cmd=findAll'; window.close();</script>");
		resp.getWriter().flush();
		
		
		}
	/**
	 * 
	 * 通过id删除员工信息
	 * @throws ServletException
	 * @throws IOException
	 */
	private void delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			IEmpService service = new EmpService();
			int id = Integer.parseInt(req.getParameter("id"));
			System.out.println(id);
			service.DelByid(id);
			resp.getWriter().write("<script>alert('删除成功！'); window.location='EmpServlet?cmd=findAll'; window.close();</script>");
			resp.getWriter().flush();
			
		}
	private void findAll (HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
			
			/**
			 * 1.遍历数据库中员工信息
			 * 2.将所有信息发送到前端展示
			 * 3.
			 */
					IEmpService service = new EmpService();
					List<Emp> list=service.findEmp();
					req.setAttribute("list", list);
					req.getRequestDispatcher("main.jsp").forward(req, resp);

			
		}
}
