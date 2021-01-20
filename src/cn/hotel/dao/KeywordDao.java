package cn.hotel.dao;

import cn.hotel.bean.Hotel;

import java.util.List;

public interface KeywordDao {
    List<Hotel> SearchAsKeyword(String keyword);
}
