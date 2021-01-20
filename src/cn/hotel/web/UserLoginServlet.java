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
import java.util.Map;

@WebServlet(urlPatterns = "/UserLoginServlet")
public class UserLoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //获取用户获取的验证码
        String img = request.getParameter("_img");
        //获取服务器验证码
        String server_code =(String)request.getSession().getAttribute("code");
        //判断验证码
        if(!img.equalsIgnoreCase(server_code)){
            request.setAttribute("msg","验证码不正确！");
            request.getRequestDispatcher("/login.jsp").forward(request,response);
            return;
        }

        //获取用户输入的信息
        Map<String, String[]> map = request.getParameterMap();
        User user = new User();

        try {

            //通过beanUtils工具封装
            BeanUtils.populate(user,map);

        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InvocationTargetException e) {
            e.printStackTrace();
        }

        //注入业务层
        UserService service = new UserServiceImpl();
        //从后台查询出来的用户
        User u = service.loginUser(user);
        if(u != null){
            //表示登录成功，跳到查询页面
            //把登录成功的用户名存到session
            request.getSession().setAttribute("resuser",u);

            // response.sendRedirect(request.getContextPath()+"/SelvetAllServlet");
            response.sendRedirect(request.getContextPath()+"/searchHotel");
        }else{
            request.setAttribute("msg","用户名或密码错误！");
            request.getRequestDispatcher("/login.jsp").forward(request,response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
