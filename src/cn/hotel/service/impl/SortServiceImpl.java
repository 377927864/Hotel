package cn.hotel.service.impl;

import cn.hotel.bean.Hotel;
import cn.hotel.bean.User;
import cn.hotel.service.PreferenceService;
import cn.hotel.service.SortService;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;

public class SortServiceImpl implements SortService {

    //按用户偏好对每个酒店进行打分，然后按分数由高到低排序后输出
    @Override
    public List<Hotel> SortAsPreference(List<Hotel> list, int userid) {

        if(list.size() == 0){
            return null;
        }

        //查询该用户的偏好
        PreferenceService service = new PreferenceServiceImpl();
        String userPre[] = service.queryPreference(userid);

        //查询该用户各项的权重系数
        PreferenceService weight = new PreferenceServiceImpl();
        Double weights[] = weight.queryWeight(userid);
        /*for(int i =0;i<weights.length;i++){
            System.out.println(weights[i]);
        }*/

        double median;//所有酒店价格的中位数
        //得到最高价格和最低价格
        int min_price = 10000;
        int max_price = 0;
        for(Hotel hotel : list){
            if(hotel.getPrice() < min_price){
                min_price = hotel.getPrice();
            }
            if(hotel.getPrice() > max_price){
                max_price = hotel.getPrice();
            }
        }

        System.out.println("最低价格:"+min_price+";"+"最高价格:"+max_price);

        Collections.sort(list, (o1, o2) -> {
            int price1 = o1.getPrice();
            double price2 = o2.getPrice();
            if (price1 == price2) {
                return 0;
            }else {
                // 从小到大
                return price1 < price2 ? 1 : -1 ;
                // 如果需要从小到大，可以将return的值反过来即可
            }
        });
        if(list.size()%2 == 0 && list.size() > 0){
            median = (list.get(list.size()/2-1).getPrice()+list.get(list.size()/2).getPrice())/2.0;
        } else {
            median = list.get(list.size()/2).getPrice();
        }

        //外层循环用户的五个偏好，内层循环list里的酒店
        for(int i=0;i<5;i++){
            for(int j=0;j<list.size();j++){
                double point = list.get(j).getPoint();
                int price = list.get(j).getPrice();
                String keywords = list.get(j).getKeywords();
                switch (userPre[i]){
                    case ("150以下"):
                        if(price<150){
                            list.get(j).setPoint(point + (1 + 1-0.2*i) * weights[5]);
                        }else {
                            list.get(j).setPoint(point + (1-absValue(price-median)/(max_price-median)) + (1 + 1-0.2*i) * weights[5]);
                        }
                        break;
                    case ("150--300"):
                        if(price>150&&price<300){
                            list.get(j).setPoint(point + (1 +1-0.2*i) * weights[5]);
                        }else {
                            list.get(j).setPoint(point + (1-absValue(price-median)/(max_price-median)) + (1 + 1-0.2*i) * weights[5]);
                        }
                        break;
                    case ("300--450"):
                        if(price>300&&price<450){
                            list.get(j).setPoint(point+ (1 + 1-0.2*i) * weights[5]);
                        }else {
                            list.get(j).setPoint(point + (1-absValue(price-median)/(max_price-median)) + (1 + 1-0.2*i) * weights[5]);
                        }
                        break;
                    case ("450--600"):
                        if(price>450&&price<600){
                            list.get(j).setPoint(point+ (1 + 1-0.2*i) * weights[5]);
                        }else {
                            list.get(j).setPoint(point + (1-absValue(price-median)/(max_price-median)) + (1 + 1-0.2*i) * weights[5]);
                        }
                        break;
                    case ("600以上"):
                        if(price>600){
                            list.get(j).setPoint(point+ (1 + 1-0.2*i) * weights[5]);
                        }else {
                            list.get(j).setPoint(point + (1-absValue(price-median)/(max_price-median)) + (1 + 1-0.2*i) * weights[5]);
                        }
                        break;
                    case ("商业区"):
                        if(isContain("商业区",keywords)){
                            list.get(j).setPoint(point+1-0.2*i);
                        }
                        break;
                    case ("机场附近"):
                        if(isContain("机场附近",keywords)){
                            list.get(j).setPoint(point+1-0.2*i);
                        }
                        break;
                    case ("火车站附近"):
                        if(isContain("火车站附近",keywords)){
                            list.get(j).setPoint(point+1-0.2*i);
                        }
                        break;
                    case ("地铁附近"):
                        if(isContain("地铁附近",keywords)){
                            list.get(j).setPoint(point+1-0.2*i);
                        }
                        break;
                    case ("近景区"):
                        if(isContain("近景区",keywords)){
                            list.get(j).setPoint(point+1-0.2*i);
                        }
                        break;
                    case ("有早餐"):
                        if(isContain("有早餐",keywords)){
                            list.get(j).setPoint(point+(1-0.2*i)*weights[0]);
                        }
                        break;
                    case ("免费WiFi"):
                        if(isContain("WiFi",keywords)){
                            list.get(j).setPoint(point+(1-0.2*i)*weights[1]);
                        }
                        break;
                    case ("接送服务"):
                        if(isContain("接送服务",keywords)){
                            list.get(j).setPoint(point+(1-0.2*i)*weights[2]);
                        }
                        break;
                    case ("行李寄存"):
                        if(isContain("行李寄存",keywords)){
                            list.get(j).setPoint(point+(1-0.2*i)*weights[3]);
                        }
                        break;
                    case ("叫醒服务"):
                        if(isContain("叫醒服务",keywords)){
                            list.get(j).setPoint(point+(1-0.2*i)*weights[4]);
                        }
                        break;
                    default:
                }
            }

        }



        Collections.sort(list, (o1, o2) -> {
            double point1 = o1.getPoint();
            double point2 = o2.getPoint();
            if (point1 == point2) {
                return 0;
            }else {
                // 从小到大
                return point1 < point2 ? 1 : -1 ;
                // 如果需要从小到大，可以将return的值反过来即可
            }
        });
        /*for(int j=0;j<list.size();j++){
            System.out.println(list.get(j).getHotelname()+"  得分："+list.get(j).getPoint());
        }*/
        return list;
    }

    //判断该酒店的关键字内是否包含该用户偏好
    private boolean isContain(String subKeyword,String totalKeyword) {
        return totalKeyword.contains(subKeyword);
    }

    //取绝对值
    public static double absValue(double a) {
        return (a < 0) ? -a : a;
    }


}
