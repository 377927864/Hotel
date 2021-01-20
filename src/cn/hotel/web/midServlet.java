package cn.hotel.web;

import cn.hotel.bean.Hotel;
import cn.hotel.bean.ListHotel;
import cn.hotel.bean.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.PrintStream;
import java.net.Socket;
import java.util.List;

@WebServlet(urlPatterns = "/midServlet")
public class midServlet extends HttpServlet {

    public static boolean on_off = false;       //多查询拼接开关，默认关闭

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("utf-8");
        String a = request.getParameter("a");

        final int port;//监听的端口号
        if(on_off){                             //多查询拼接开启时
            if(a.equals("1")){
                System.out.println("关键字查询");
                port = 4702;                    //关键字查询
            }
            else {
                System.out.println("地点查询");
                port = 4701;                    //地点查询
            }
            String search_content = request.getParameter("search_content");
            User user = (User)request.getSession().getAttribute("resuser");

//            final int port = 4701;//监听的端口号
            final String host = "localhost";
            System.out.println("Client Start...");
//        while (true) {
            Socket socket = null;
            try {
                //创建一个流套接字并将其连接到指定主机上的指定端口号
                socket = new Socket(host,port);

                //向监听器发送请求
                PrintStream out = new PrintStream(socket.getOutputStream());
                out.println(user.getUserid()+"&"+search_content);

                //读取监听器传回的数据
                ObjectInputStream in = new ObjectInputStream(socket.getInputStream());
                //进行Object传输可以使用ObjectInputStream
                ListHotel test = (ListHotel) in.readObject();
                List<Hotel> list;

                //判空
                if(test == null || test.size() == 0){
                    list = null;
                }
                else {
                    list = test.getList();
                    for (Hotel hotel : list) {
                        System.out.println(hotel.getHotelname()+"/");
                    }
                }

                out.close();
                in.close();

                if (list == null || list.size() == 0) {
                    request.setAttribute("msg2", "以下是关于\"" + search_content + "\"的搜索结果:");
                    request.setAttribute("msg", "暂无搜索结果");
                    request.getRequestDispatcher("/searchHotelPage.jsp").forward(request, response);
                }
                else {
                    request.setAttribute("msg2", "以下是关于\"" + search_content + "\"的搜索结果:");
                    request.setAttribute("_hotel", list);
                    request.getRequestDispatcher("/searchHotelPage.jsp").forward(request, response);
                }
            } catch (Exception e) {
                System.out.println("客户端异常:" + e.getMessage());
                e.printStackTrace();
            } finally {
                if (socket != null) {
                    try {
                        socket.close();
                    } catch (IOException e) {
                        socket = null;
                        System.out.println("客户端 finally 异常:" + e.getMessage());
                    }
                }
            }
        }
        else {
            request.getRequestDispatcher("/SearchServlet?a="+Integer.valueOf(a)).forward(request, response);
        }






    }


    /*@WebListener   //在此注明以下类是监听器
    public class onLineCount implements HttpSessionListener {

        public int count=0;
        public void sessionCreated(HttpSessionEvent arg0) {
            count++;
            arg0.getSession().getServletContext().setAttribute("Count", count);

        }
        @Override
        public void sessionDestroyed(HttpSessionEvent arg0) {
            count--;
            arg0.getSession().getServletContext().setAttribute("Count", count);
        }

    }*/


    public double getDistance(String a , String b){
        return 0;
    }

    /*public static final int port = 8080;//监听的端口号
    public static final String host = "localhost";*/
    public static void main(String[] args) {
        /*System.out.println("Client Start...");
        while (true) {
            Socket socket = null;
            try {
                //创建一个流套接字并将其连接到指定主机上的指定端口号
                socket = new Socket(host,port);

                //读取服务器端数据
                BufferedReader input = new BufferedReader(new InputStreamReader(socket.getInputStream()));
                //向服务器端发送数据
                PrintStream out = new PrintStream(socket.getOutputStream());
                System.out.print("请输入: \t");
//                String str = new BufferedReader(new InputStreamReader(System.in)).readLine();
                String str = "";
                out.println(str);

                String ret = input.readLine();
                System.out.println("服务器端返回过来的是: " + ret);
                // 如接收到 "OK" 则断开连接
                if ("OK".equals(ret)) {
                    System.out.println("客户端将关闭连接");
                    Thread.sleep(500);
                    break;
                }

                out.close();
                input.close();
            } catch (Exception e) {
                System.out.println("客户端异常:" + e.getMessage());
            } finally {
                if (socket != null) {
                    try {
                        socket.close();
                    } catch (IOException e) {
                        socket = null;
                        System.out.println("客户端 finally 异常:" + e.getMessage());
                    }
                }
            }
        }*/
    }





    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
