package cn.hotel.web;

import cn.hotel.service.ReserveService;
import cn.hotel.service.impl.ReserveServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(urlPatterns = "/ReserveServlet")
public class ReserveServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //预定酒店时向后台存入预定信息
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");

        Integer a = Integer.parseInt(request.getParameter("userid"));
        Integer b = Integer.parseInt(request.getParameter("hotelId"));
        System.out.println(a+"+"+b);

        ReserveService service = new ReserveServiceImpl();
        service.reserve(a,b);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
