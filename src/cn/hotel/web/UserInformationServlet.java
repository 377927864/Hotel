package cn.hotel.web;

import cn.hotel.bean.User;
import cn.hotel.service.UserInformationService;
import cn.hotel.service.impl.UserInformationServiceImpl;
import org.apache.commons.beanutils.BeanUtils;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.Map;

@WebServlet(urlPatterns = "/UserInformationServlet")
public class UserInformationServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //当用户更改个人信息时，向后台更新信息，并将新的user返回到前台
        request.setCharacterEncoding("utf-8");

        User this_user = (User) request.getSession().getAttribute("resuser");
        User user = new User();
        Map<String, String[]> map = request.getParameterMap();
        user.setUserid(this_user.getUserid());
        user.setUsername(this_user.getUsername());

        try {
            BeanUtils.populate(user,map);
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InvocationTargetException e) {
            e.printStackTrace();
        }

        UserInformationService service = new UserInformationServiceImpl();
        User u = service.saveInformation(user);
        request.getSession().setAttribute("resuser",u);
        request.getRequestDispatcher("/UserInformation.jsp").forward(request,response);


    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
