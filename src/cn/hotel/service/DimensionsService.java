package cn.hotel.service;
import cn.hotel.bean.Hotel;

import java.util.List;
public interface DimensionsService {
    List<Hotel> Dimensions(List<Hotel> list, String userPre[]);
}
