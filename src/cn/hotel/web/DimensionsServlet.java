package cn.hotel.web;
import cn.hotel.bean.Hotel;
import cn.hotel.bean.User;
import cn.hotel.service.DimensionsService;
import cn.hotel.service.HotelService;
import cn.hotel.service.impl.HotelServiceImpl;
import cn.hotel.service.impl.DimensionsServiceImpl;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;

import java.util.List;
@WebServlet(urlPatterns = "/DimensionsServlet")
public class DimensionsServlet extends HttpServlet{
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");

        //获取用户输入的内容
        String search_content = request.getParameter("search_content");
        //System.out.println(search_content+"3333");
        //根据a的值来区分关键字搜索和地点搜索
        String a = request.getParameter("a");
        //按关键字查找
        if (Integer.valueOf(a) == 1) {
            //request.setAttribute("msg1", "以下是关于\"" + search_content + "\"的搜索结果:");
//            String []preference = {request.getParameter("Selected_Preference_1"),request.getParameter("Selected_Preference_2"),request.getParameter("Selected_Preference_3"),request.getParameter("Selected_Preference_4"),request.getParameter("Selected_Preference_5")};
            String []preference = {request.getParameter("s1"),request.getParameter("s2"),request.getParameter("s3"),request.getParameter("s4"),request.getParameter("s5")};
            System.out.println("这里测试能不能取到偏好"+request.getParameter("s3"));
            HotelService service = new HotelServiceImpl();
            DimensionsService dimensionsService = new DimensionsServiceImpl();
            List<Hotel> list = service.SearchAsDimension(search_content,preference);
            if (list != null) {
//                request.setAttribute("_dim_hotel", list);
                request.setAttribute("_hotel", list);
//                request.getRequestDispatcher("/dimensions.jsp").forward(request, response);
                request.getRequestDispatcher("/searchHotelPage.jsp").forward(request, response);
            }
            else {
                //request.setAttribute("msg2", "无搜索结果");
                request.getRequestDispatcher("/searchHotelPage.jsp").forward(request, response);
            }
        }
        //按地点查找
        else if (Integer.valueOf(a) == 2) {
            //request.setAttribute("msg2", "以下是关于\"" + search_content + "\"的搜索结果:");
            User user = (User)request.getSession().getAttribute("resuser");
            String thisLonLat = getLonLat(search_content);

            int commaIndex = thisLonLat.indexOf(",", 0);
            String thislngString = thisLonLat.substring(0, commaIndex);
            String thislatString = thisLonLat.substring(commaIndex + 1);
            double thisLng = Double.parseDouble(thislngString);
            double thisLat = Double.parseDouble(thislatString);

            //注入业务层
            HotelService service = new HotelServiceImpl();
            DimensionsService dimensionsService = new DimensionsServiceImpl();
            List<Hotel> list = service.SearchAsPlace(thisLng, thisLat);
            if (list != null) {
//                request.setAttribute("_dim_hotel", list);
                request.setAttribute("_hotel", list);
//                request.getRequestDispatcher("/dimensions.jsp").forward(request, response);
                request.getRequestDispatcher("/searchHotelPage.jsp").forward(request, response);
            } else {
                //request.setAttribute("msg", "无搜索结果");
                request.getRequestDispatcher("/searchHotelPage.jsp").forward(request, response);
            }

        }
        //搜索内容为空时
        else {
            if (search_content == "") {
                request.setAttribute("msg1", "搜索信息不能为空！");
                request.getRequestDispatcher("/searchHotelPage.jsp").forward(request, response);
            }
        }
    }

    private String getResponse(String serverUrl) {
        //用JAVA发起http请求，并返回json格式的结果
        StringBuffer result = new StringBuffer();
        try {
            URL url = new URL(serverUrl);
            URLConnection conn = url.openConnection();
            BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));

            String line;
            while((line = in.readLine()) != null){
                result.append(line);
            }
            in.close();

        } catch (MalformedURLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return result.toString();
    }

    //获取经纬度
    public String getLonLat(String address) {
        try {
            address = URLEncoder.encode(address, "UTF-8");
        } catch (UnsupportedEncodingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        String url = "http://restapi.amap.com/v3/geocode/geo?address=" + address + "&output=json&key=9a0ac37df43a4d72e9c6d9336a375169";

        String queryResult = getResponse(url);
        JSONObject jo= new JSONObject().fromObject(queryResult);
//        System.out.println(jo);
        JSONArray ja = jo.getJSONArray("geocodes");
        String resultString = null;
        int a = 0;
        try {
            resultString = ja.getJSONObject(0).getString("location");
        } catch (Exception e) {
            System.out.println("第"+(++a)+"次异常");
        }

        return resultString;
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    }
}

