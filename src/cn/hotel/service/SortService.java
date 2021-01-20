package cn.hotel.service;

import cn.hotel.bean.Hotel;
import cn.hotel.bean.User;

import java.util.List;

public interface SortService {
//    List<Hotel> SortAsPreference(List<Hotel> list, User user);
    List<Hotel> SortAsPreference(List<Hotel> list, int userid);

}
