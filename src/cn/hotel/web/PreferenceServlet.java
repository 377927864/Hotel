package cn.hotel.web;

import cn.hotel.bean.User;
import cn.hotel.service.PreferenceService;
import cn.hotel.service.impl.PreferenceServiceImpl;
import flexjson.JSONSerializer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(urlPatterns = "/PreferenceServlet")
public class PreferenceServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //设置post乱码
        request.setCharacterEncoding("utf-8");

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("resuser");

        //打开用户个人信息时，查询用户的偏好并返回到前端
        if (Integer.valueOf(request.getParameter("jspNo")) == 2){
            int userid = Integer.valueOf(request.getParameter("userid")).intValue();
            PreferenceService service = new PreferenceServiceImpl();
            String pre[] = service.queryPreference(userid);

            //使用json工具把查询到的偏好返回给前端
            JSONSerializer jsonSerializer = new JSONSerializer();
            String json = jsonSerializer.serialize(pre);
            //设置响应
            response.setContentType("application/json;charset=utf-8");
            response.getWriter().print(json);
        }

        //在用户点击保存偏好时，向后台更新该用户的偏好
        if (Integer.valueOf(request.getParameter("jspNo")) == 1){
            String preference[]={String.valueOf(user.getUserid()),user.getUsername(),request.getParameter("Preference_1"),request.getParameter("Preference_2"),request.getParameter("Preference_3"),request.getParameter("Preference_4"),request.getParameter("Preference_5")};
            PreferenceService service = new PreferenceServiceImpl();
            service.savePreference(preference);
        }

        //当用户点击某个酒店的详情页面时，开始计时该用户浏览该酒店的时间(该项数据用于后期动态调整用户偏好)，在用户退出详情时，在此处将该时长存入数据库
        if (Integer.valueOf(request.getParameter("jspNo")) == 3){
            String time[]={request.getParameter("userid"),request.getParameter("username"),request.getParameter("hotelname"),request.getParameter("browsing_time")};
            PreferenceService service = new PreferenceServiceImpl();
            service.saveBrowsingtime(time);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
