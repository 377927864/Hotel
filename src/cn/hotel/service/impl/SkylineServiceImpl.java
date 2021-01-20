package cn.hotel.service.impl;

import cn.hotel.bean.Hotel;
import cn.hotel.service.SkylineService;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

public class SkylineServiceImpl implements SkylineService {

    @Override
    public List<Hotel> Skyline(List<Hotel> list){
        //对价格,评分等数据进行skyline查询
        ArrayList<Point> arrayList=new ArrayList<>();
        List<Hotel> result = new ArrayList<>();



///////////////////到这里都是正确的，能获取到传过来的list，
///////////////////但是Skyline()方法并没有起到过滤作用，why？？？？？？
        System.out.println(list.size()+"list长度");
        System.out.println(list.toString());

        for(int i = 0; i < list.size(); i++){
            int price = list.get(i).getPrice();
            StringBuilder sb = new StringBuilder();
            sb.append(String.valueOf(price));
            sb.append(" ");
            double score = 1 / list.get(i).getScore();
            sb.append(String.valueOf(score));
            String str = sb.toString();
            int hotelId = list.get(i).getHotelId();
            arrayList.add(new Point(str,i, hotelId));
        }
        //到这里都是正确的，arrayList中能获取到list传进去的数据
        System.out.println(arrayList.size()+"arrayList长度");
        System.out.println("初始arrayList\n"+arrayList.toString());


        Collections.sort(arrayList, new Comparator<Point>() {
            //数据点按照第0维排序，小值在前。如果第0维值相等，则比较第1维，以此类推
            //排序之后，只可能排序在前的点支配后面的点，反过来一定不会支配
            @Override
            public int compare(Point o1, Point o2) {

                for (int j = 0; j < o1.content.length; j++) {
                    if (o1.content[j] > o2.content[j]) {
                        return 1;
                    } else if (o1.content[j] < o2.content[j]) {
                        return -1;
                    }
                }
                return 0;
            }

        });

        System.out.println("排序后arrayList\n"+arrayList.toString());

        for (int i = 0; i < list.size(); i++) {
            if (list.get(i).getId() == arrayList.get(0).DuiYingHotelId) {
                result.add(list.get(i));
            }
        }
        //result.add(arrayList.get(0));
        boolean isResult;
        for (int i = 1; i < arrayList.size(); i++) {
            isResult=true;
            for (int j =0; j < result.size(); j++) {

                if (result.get(j).dominance(arrayList.get(i))) {
                    isResult=false;
                    break;
                }
            }
            if (isResult) {
                for(int j = 0;j < list.size(); j++){
                    Hotel hotel = list.get(j);
                    if(hotel.getHotelId() == arrayList.get(i).DuiYingHotelId){
                        result.add(hotel);
                    }
                }
//                result.add(arrayList.get(i));
            }
        }
        System.out.println(result.size()+"result长度");
        System.out.println(result.toString());
        return result;
    }
}

