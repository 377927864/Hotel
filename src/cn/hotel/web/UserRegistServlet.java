package cn.hotel.web;

import cn.hotel.bean.User;
import cn.hotel.service.UserService;
import cn.hotel.service.impl.UserServiceImpl;
import org.apache.commons.beanutils.BeanUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.Iterator;
import java.util.Map;

@WebServlet(urlPatterns = "/UserRegistServlet")
public class UserRegistServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //用户注册

        //设置post乱码
        request.setCharacterEncoding("utf-8");

        /*//获取用户获取的验证码
        String img = request.getParameter("_img");
        //获取服务器验证码
        String server_code =(String)request.getSession().getAttribute("code");
        //判断验证码
        if(!img.equalsIgnoreCase(server_code)){
            request.setAttribute("msg","验证码不正确！");
            request.getRequestDispatcher("/login.jsp").forward(request,response);
            return;
        }*/

        //获取页面上所有提交过来的数据
        Map<String, String[]> map = request.getParameterMap();

        User user  = new User();
        //封装beanUtils
        try {
            BeanUtils.populate(user,map);
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InvocationTargetException e) {
            e.printStackTrace();
        }
        //调用业务层
        UserService service = new UserServiceImpl();
        boolean flag = service.userRegist(user);
        //根据username查询用户名是否重复
        if(flag){
            //直接注册
            request.getRequestDispatcher("/login.jsp").forward(request,response);
        }
        else {
            //用户名已存在
            request.setAttribute("msg","用户名已存在");
            request.getRequestDispatcher("/login.jsp").forward(request,response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
