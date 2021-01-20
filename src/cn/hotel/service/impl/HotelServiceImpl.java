package cn.hotel.service.impl;

import cn.hotel.bean.Hotel;
import cn.hotel.bean.User;
import cn.hotel.dao.HotelDao;
import cn.hotel.dao.impl.HotelDaoImpl;
import cn.hotel.service.DimensionsService;
import cn.hotel.service.HotelService;
import cn.hotel.service.SortService;

import java.util.List;

public class HotelServiceImpl implements HotelService {

    //注入dao层
    HotelDao dao = new HotelDaoImpl();

    @Override
    public List<Hotel> SearchAsKeyword(String search_content, int userid) {
        SortService service = new SortServiceImpl();
        return service.SortAsPreference(this.dao.SearchAsKeyword(search_content),userid);
    }

    @Override
    public List<Hotel> SearchAsDimension(String search_content, String userPre[]) {
        DimensionsService service = new DimensionsServiceImpl();
        return service.Dimensions(this.dao.SearchAsKeyword(search_content),userPre);
    }

    @Override
    public List<Hotel> SearchAsPlace(double thisLng, double thisLat) {
        return this.dao.SearchAsPlace(thisLng,thisLat);
    }

    //以下方法是向数据库中插入酒店的经纬度数据和keywords数据，在实际中不需要用到
    @Override
    public String SearchLocationAsId(int i) {
        return this.dao.SearchLocationAsId(i);
    }

    @Override
    public void AddLngLat(int i, String name, double thisLng, double thisLat) {
        this.dao.AddLngLat(i,name,thisLng,thisLat);
    }

    @Override
    public Hotel SearchHotelAsId(int i) {
        return this.dao.SearchHotelAsId(i);
    }

    @Override
    public void AddKeywords(int hotelId,String keywords) {
        this.dao.AddKeywords(hotelId,keywords);
    }
}
