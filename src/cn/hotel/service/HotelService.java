package cn.hotel.service;

import cn.hotel.bean.Hotel;
import cn.hotel.bean.User;

import java.util.List;

public interface HotelService {

    //按关键字查询
    List<Hotel> SearchAsKeyword(String search_content, int userid);

    List<Hotel> SearchAsDimension(String search_content, String userPre[]);

    //按地点查询
    List<Hotel> SearchAsPlace(double thisLng, double thisLat);

    //以下方法是向数据库中插入酒店的经纬度数据和keywords数据，在实际中不需要用到
    String SearchLocationAsId(int i);

    void AddLngLat(int i, String name, double thisLng, double thisLat);

    Hotel SearchHotelAsId(int i);

    void AddKeywords(int hotelId,String keywords);
}
