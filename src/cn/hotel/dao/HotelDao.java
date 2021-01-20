package cn.hotel.dao;

import cn.hotel.bean.Hotel;
import cn.hotel.bean.Word;

import java.util.List;

public interface HotelDao {

    List<Hotel> SearchAsKeyword(String hotelname);

    List<Hotel> SearchAsPlace(double thisLng, double thisLat);

    //以下方法是向数据库中插入酒店的经纬度数据和keywords数据，在实际中不需要用到
    String SearchLocationAsId(int i);

    void AddLngLat(int i, String name, double thisLng, double thisLat);

    Hotel SearchHotelAsId(int i);

    void AddKeywords(int hotelId,String keywords);

    List<Word> SearchWords(String word1);
}
