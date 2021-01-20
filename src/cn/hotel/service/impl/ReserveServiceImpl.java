package cn.hotel.service.impl;

import cn.hotel.dao.ReserveDao;
import cn.hotel.dao.impl.ReserveDaoImpl;
import cn.hotel.service.ReserveService;

public class ReserveServiceImpl implements ReserveService {

    ReserveDao dao = new ReserveDaoImpl();

    @Override
    public void reserve(int userid, int hotelId) {
        this.dao.reserve(userid,hotelId);
    }
}
