package cn.hotel.dao.impl;

import cn.hotel.bean.Hotel;
import cn.hotel.dao.DetailsDao;
import cn.hotel.utils.JDBCUtils;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;

import java.util.List;

public class DetailsDaoImpl implements DetailsDao {

    //jdbc操作模板
    JdbcTemplate template = new JdbcTemplate(JDBCUtils.getDataSource());

    //
    public Hotel hotelDet(String hotelId) {

        String sql = "select * from shanghai"+" where hotelId = ?";
        Hotel hotel = this.template.queryForObject(sql,new BeanPropertyRowMapper<Hotel>(Hotel.class),hotelId);
        return hotel;
    }
}
