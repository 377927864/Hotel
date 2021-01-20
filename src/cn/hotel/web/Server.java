package cn.hotel.web;

import cn.hotel.bean.Hotel;
import cn.hotel.bean.ListHotel;
import cn.hotel.bean.Word;
import cn.hotel.dao.HotelDao;
import cn.hotel.dao.impl.HotelDaoImpl;
import cn.hotel.service.HotelService;
import cn.hotel.service.impl.HotelServiceImpl;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import java.io.*;
import java.net.*;
import java.util.*;

public class Server {
    public static final int port = 4701;//监听的端口号
    public static final int port1 = 4701;//监听的端口号
    public static final int port2 = 4702;//监听的端口号

    int count = 0;

    Queue<String> msgQueue = new LinkedList<String>();//queue为消息缓存队列
    int queenLen = 0;
    ArrayList S1 = new ArrayList();
    String[] s11 = new String[3];
    String[] s12 = new String[3];
    String[] s13 = new String[3];
    ArrayList S2 = new ArrayList();
    String[] s21 = new String[3];
    String[] s22 = new String[3];
    String[] s23 = new String[3];
    Double threshold = 1000.0;


    public static void main(String[] args) {
        System.out.println("Server...\n");

        myThread thread1 = new myThread();
        thread1.start();

        Server server = new Server();
        server.init1();
    }

    public void init() {
        try {
            //创建一个ServerSocket，这里可以指定连接请求的队列长度
            //new ServerSocket(port,3);意味着当队列中有3个连接请求时，如果Client再请求连接，就会被Server拒绝
            ServerSocket serverSocket = new ServerSocket(port);
            while (true) {
                //从请求队列中取出一个连接
                Socket client = serverSocket.accept();

                //给连接数计数
                count++;

                // 处理这次连接
                new HandlerThread1(client);
            }
        } catch (Exception e) {
            System.out.println("服务器异常: " + e.getMessage());
        }
    }

    public void init1() {
        try {

            System.out.println("init1监听4701");
            //创建一个ServerSocket，这里可以指定连接请求的队列长度
            //new ServerSocket(port,3);意味着当队列中有3个连接请求时，如果Client再请求连接，就会被Server拒绝
            ServerSocket serverSocket = new ServerSocket(port1);
            while (true) {
                //从请求队列中取出一个连接
                Socket client = serverSocket.accept();

                //给连接数计数
                count++;

                // 处理这次连接
                new HandlerThread1(client);
            }
        } catch (Exception e) {
            System.out.println("服务器异常: " + e.getMessage());
        }
    }

    public void init2() {
        try {
            System.out.println("init1监听4702");
            //创建一个ServerSocket，这里可以指定连接请求的队列长度
            //new ServerSocket(port,3);意味着当队列中有3个连接请求时，如果Client再请求连接，就会被Server拒绝
            ServerSocket serverSocket = new ServerSocket(port2);
            while (true) {
                //从请求队列中取出一个连接
                Socket client = serverSocket.accept();

                //给连接数计数
                count++;

                // 处理这次连接
                new HandlerThread2(client);
            }
        } catch (Exception e) {
            System.out.println("服务器异常: " + e.getMessage());
        }
    }

    private class HandlerThread1 implements Runnable {
        private Socket socket;
        public HandlerThread1(Socket client) {
            socket = client;
            new Thread(this).start();
        }

        public void run() {
            try {
                // 读取客户端数据
                BufferedReader input = new BufferedReader(new InputStreamReader(socket.getInputStream(),"GB2312"));
                String clientInputStr = input.readLine();//这里要注意和客户端输出流的写方法对应,否则会抛 EOFException
                // 处理客户端数据
                System.out.println("客户端发过来的内容:" + clientInputStr);
                int index = clientInputStr.indexOf("&",0);
                int userid = Integer.valueOf(clientInputStr.substring(0,index)).intValue();
                String search_content = clientInputStr.substring(index+1);
                ObjectOutputStream out = new ObjectOutputStream(socket.getOutputStream());

                msgQueue.add(search_content);
                S1.add(s11);
                S1.add(s12);
                S1.add(s13);
                queenLen++;

                for(String q : msgQueue){
                    for (int i = 0; i < S1.size(); i++) {    //遍历 S 中每个分组
                        if(S1.get(i) !=null && !Arrays.asList(((String[])S1.get(i))).contains(search_content)){
                            System.out.println(S1.get(i));
                            if(((String[])S1.get(i))[0] == null){
                                ((String[])S1.get(i))[0] = msgQueue.poll();
                                break;
                            }else if (((String[])S1.get(i))[1] == null){
                                if(getDistance(((String[])S1.get(i))[0],msgQueue.peek()) < threshold){
                                    ((String[])S1.get(i))[1] = msgQueue.poll();
                                    break;
                                }else {
                                    continue;
                                }
                            }else if (((String[])S1.get(i))[2] == null){
                                if(getDistance(((String[])S1.get(i))[0],msgQueue.peek()) < threshold && getDistance(((String[])S1.get(i))[1],msgQueue.peek()) < threshold){
                                    ((String[])S1.get(i))[1] = msgQueue.poll();
                                    break;
                                }else {
                                    continue;
                                }
                            }else {
                                continue;
                            }
                        }
                        else {
                            break;
                        }
                    }

                }

                for(int i = 0; i < S1.size(); i++){
//                    ObjectOutputStream out = new ObjectOutputStream(socket.getOutputStream());
                    //((String[])S1.get(i)).contains(search_content)
                    if(S1.get(i) !=null && Arrays.asList(((String[])S1.get(i))).contains(search_content)){
                        double avgLng = 0;
                        double avgLat = 0;
                        double x = 0.0;
                        for(int j = 0; j < ((String[])S1.get(i)).length; j++){
                            System.out.println("第"+i+"个位置第"+j+"个查询"+((String[])S1.get(i))[j]);
                            double thisLng = 0;
                            double thisLat = 0;
                            if(((String[])S1.get(i))[j] != null){
                                x++;
                                String content = ((String[])S1.get(i))[j];
                                String thisLngLat = getLngLat(content);
                                int commaIndex;
                                if(thisLngLat == null){
                                    commaIndex = 0;
                                }else {
                                    commaIndex = thisLngLat.indexOf(",", 0);
                                }
                                String thislngString = thisLngLat.substring(0, commaIndex);
                                String thislatString = thisLngLat.substring(commaIndex + 1);
                                thisLng = Double.parseDouble(thislngString);
                                thisLat = Double.parseDouble(thislatString);
                            }

                            avgLng = thisLng+avgLng;
                            avgLat = thisLat+avgLat;

                            if(j == ((String[])S1.get(i)).length-1){
                                avgLng = avgLng/x;
                                avgLat = avgLat/x;
                            }
                        }

                        System.out.println("经度为"+avgLng+"纬度为"+avgLat);

                        HotelService service = new HotelServiceImpl();
                        List<Hotel> list = service.SearchAsPlace(avgLng,avgLat);
                        if (list != null) {
                            ListHotel listhotel = new ListHotel();
                            listhotel.setList(list);
                            out.writeObject(listhotel);
                        }
                        else {
                            out.writeObject(null);
                        }
                        out.close();
                        break;
                    }
                    else {
                        String thisLngLat = getLngLat(search_content);
                        int commaIndex;
                        if(thisLngLat == null){
                            commaIndex = 0;
                        }else {
                            commaIndex = thisLngLat.indexOf(",", 0);
                        }
                        String thislngString = thisLngLat.substring(0, commaIndex);
                        String thislatString = thisLngLat.substring(commaIndex + 1);
                        double thisLng = Double.parseDouble(thislngString);
                        double thisLat = Double.parseDouble(thislatString);
                        HotelService service = new HotelServiceImpl();
                        List<Hotel> list = service.SearchAsPlace(thisLng,thisLat);
                        if (list != null) {
                            ListHotel listhotel = new ListHotel();
                            listhotel.setList(list);
                            out.writeObject(listhotel);
                        }
                        else {
                            out.writeObject(null);
                        }
                        out.close();
                        break;
                    }
                }
                input.close();


//                System.out.println(userid+"+"+search_content);

//                String lnglon = getLonLat();
                /*//地点查询
                HotelService service = new HotelServiceImpl();
                List<Hotel> list = service.SearchAsPlace(lng,lon);*/

                //关键字查询
                /*HotelService service = new HotelServiceImpl();
                List<Hotel> list = service.SearchAsKeyword(search_content,userid);
                queenLen--;
                for (Hotel h : list) {
                    System.out.println(h.getHotelname());
                }
//                ObjectOutputStream output = new ObjectOutputStream(socket.getOutputStream());

                ListHotel listhotel = new ListHotel();
                listhotel.setList(list);


                ObjectOutputStream out = new ObjectOutputStream(socket.getOutputStream());
                out.writeObject(listhotel);

                out.close();*/
//                input.close();
//                count--;
//                System.out.println("连接数为:"+count);
            } catch (Exception e) {
                System.out.println("服务器 run 异常: " + e.getMessage());
                e.printStackTrace();
            } finally {
                if (socket != null) {
                    try {
                        socket.close();
                    } catch (Exception e) {
                        socket = null;
                        System.out.println("服务端 finally 异常:" + e.getMessage());
                    }
                }
            }
        }

        public double getDistance(String location1 , String location2){

            String thisLngLat1 = getLngLat(location1);
            int commaIndex1;
            if(thisLngLat1 == null){
                commaIndex1 = 0;
            }else {
                commaIndex1 = thisLngLat1.indexOf(",", 0);
            }
            String thislngString1 = thisLngLat1.substring(0, commaIndex1);
            String thislatString1 = thisLngLat1.substring(commaIndex1 + 1);
            double log1 = Double.parseDouble(thislngString1);
            double lat1 = Double.parseDouble(thislatString1);

            String thisLngLat2 = getLngLat(location2);
            int commaIndex2;
            if(thisLngLat2 == null){
                commaIndex2 = 0;
            }else {
                commaIndex2 = thisLngLat1.indexOf(",", 0);
            }
            String thislngString2 = thisLngLat1.substring(0, commaIndex2);
            String thislatString2 = thisLngLat1.substring(commaIndex2 + 1);
            double lng2 = Double.parseDouble(thislngString2);
            double lat2 = Double.parseDouble(thislatString2);

            double a, b, R;
            R = 6378137; // 地球半径
            lat1 = lat1 * Math.PI / 180.0;
            lat2 = lat2 * Math.PI / 180.0;
            a = lat1 - lat2;
            b = (log1 - lng2) * Math.PI / 180.0;
            double d;
            double sa2, sb2;
            sa2 = Math.sin(a / 2.0);
            sb2 = Math.sin(b / 2.0);
            d = 2 * R * Math.asin(Math.sqrt(sa2 * sa2 + Math.cos(lat1) * Math.cos(lat2) * sb2 * sb2));
            return d;

        }

        public String getLngLat(String address) {
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

    }

    private class HandlerThread2 implements Runnable {
        private Socket socket;
        public HandlerThread2(Socket client) {
            socket = client;
            new Thread(this).start();
        }

        public void run() {
            try {
                // 读取客户端数据
                BufferedReader input = new BufferedReader(new InputStreamReader(socket.getInputStream(),"GB2312"));
//                BufferedReader input = new BufferedReader(new InputStreamReader(socket.getInputStream()));
                String clientInputStr = input.readLine();//这里要注意和客户端输出流的写方法对应,否则会抛 EOFException
                // 处理客户端数据
                System.out.println("客户端发过来的内容:" + clientInputStr);
                int index = clientInputStr.indexOf("&",0);
                int userid = Integer.valueOf(clientInputStr.substring(0,index)).intValue();
                String search_content = clientInputStr.substring(index+1);
                ObjectOutputStream out = new ObjectOutputStream(socket.getOutputStream());

                msgQueue.add(search_content);
                S2.add(s21);
                S2.add(s22);
                S2.add(s23);
                queenLen++;

                    for(String q : msgQueue){
                            for (int i = 0; i < S2.size(); i++) {    //遍历 S 中每个分组
                                if(S2.get(i) !=null && !Arrays.asList(((String[])S2.get(i))).contains(search_content)){
                                    System.out.println((S2.get(i)).toString());
                                    if(((String[])S2.get(i))[0] == null){
                                        ((String[])S2.get(i))[0] = msgQueue.poll();
                                        break;
                                    }else if (((String[])S2.get(i))[1] == null){
                                        if(isSynonym(((String[])S2.get(i))[0],msgQueue.peek())){       //判断是否为近义词，如果是就放在一组
                                            ((String[])S2.get(i))[1] = msgQueue.poll();
                                            break;
                                        }else {
                                            continue;
                                        }
                                    }else if (((String[])S2.get(i))[2] == null){
                                        if(isSynonym(((String[])S2.get(i))[0],msgQueue.peek()) && isSynonym(((String[])S2.get(i))[1],msgQueue.peek())){
                                            ((String[])S2.get(i))[1] = msgQueue.poll();
                                            break;
                                        }else {
                                            continue;
                                        }
                                    }else {
                                        continue;
                                    }
                                }
                                else {
                                    break;
                                }
                            }

                    }

                    for(int i = 0; i < S2.size(); i++){
//                        ObjectOutputStream out = new ObjectOutputStream(socket.getOutputStream());
                        String content;
                        if(S2.get(i) !=null && Arrays.asList(((String[])S2.get(i))).contains(search_content)){
                            content = ((String[])S2.get(i))[0];
                        }
                        else {
                            content = search_content;
                        }
                        System.out.println("419行："+content);
                        /*String content = ((String[])S.get(i))[0];
                        for(int j = 0; j < ((String[])S.get(i)).length; j++){
                            String content = ((String[])S.get(i))[j];
                            System.out.println("第"+i+"个位置第"+j+"个查询"+((String[])S.get(i))[j]);
                            HotelService service = new HotelServiceImpl();
//                            List<Hotel> list = service.SearchAsPlace(,);

                        }*/
                        HotelService service = new HotelServiceImpl();
                        List<Hotel> list = service.SearchAsKeyword(content,userid);
                        if (list != null) {
                            ListHotel listhotel = new ListHotel();
                            listhotel.setList(list);
                            out.writeObject(listhotel);
                        }
                        else {
                            out.writeObject(null);
                        }
                        out.close();
                        break;
                    }
                    input.close();

            } catch (Exception e) {
                System.out.println("服务器 run 异常: " + e.getMessage());
                e.printStackTrace();
            } finally {
                if (socket != null) {
                    try {
                        socket.close();
                    } catch (Exception e) {
                        socket = null;
                        System.out.println("服务端 finally 异常:" + e.getMessage());
                    }
                }
            }
        }

        public boolean isSynonym(String word1,String word2){
            HotelDao hotelDao = new HotelDaoImpl();
            List<Word> words= hotelDao.SearchWords(word1);
            return words.contains(word2);
        }

    }

}
