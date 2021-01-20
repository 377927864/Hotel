package cn.hotel.web;

import cn.hotel.bean.Hotel;
import cn.hotel.service.HotelService;
import cn.hotel.service.impl.HotelServiceImpl;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.util.List;

@WebServlet(urlPatterns = "/RecServlet")
public class RecServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");

        //TODO 在这里根据用户职业推荐部分酒店，响应到前端页面

        System.out.println(request.getParameter("lng")+"   ......");

        Double thisLng = Double.parseDouble(request.getParameter("lng"));
        Double thisLat = Double.parseDouble(request.getParameter("lat"));

        HotelService service = new HotelServiceImpl();
        List<Hotel> list = service.SearchAsPlace(thisLng, thisLat);
        if (list != null) {

            for(int i=0;i<list.size();i++){
                System.out.println(list.get(i).getHotelname()+"/*/");
            }

            PrintWriter printWriter = response.getWriter();
            JSONArray jsonArray2 = JSONArray.fromObject(list);
            printWriter.print(jsonArray2);
            printWriter.flush();
            printWriter.close();
            System.out.println("finish");
            request.setAttribute("msg2", "为你推荐");
            System.out.println("嗯哼++");
            request.setAttribute("_hotel", list);
            request.getRequestDispatcher("/search.jsp").forward(request, response);
        }
        else {
            request.getRequestDispatcher("/search.jsp").forward(request, response);
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
        JSONObject jo = new JSONObject().fromObject(queryResult);
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
        doPost(request,response);
    }
}
