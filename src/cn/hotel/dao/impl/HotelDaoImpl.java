package cn.hotel.dao.impl;

import cn.hotel.bean.Hotel;
import cn.hotel.bean.Word;
import cn.hotel.dao.HotelDao;
import cn.hotel.utils.JDBCUtils;
import org.junit.Test;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;

import java.util.*;
import java.util.stream.Collectors;

public class HotelDaoImpl implements HotelDao {

    //jdbc模板操作
    JdbcTemplate template = new JdbcTemplate(JDBCUtils.getDataSource());

    //根据关键字查询，先从同义词词典中查询出同义词，然后把同义词分别作为关键字查询酒店，返回查询到的所有酒店
    @Override
    public List<Hotel> SearchAsKeyword(String word) {
        String sql ="select word from word_dic " + "where wordid in (select wordid from word_dic where word=?)";
        String sql2 = "select A.id,A.hotelname,A.price,A.score,A.userNum,A.hotelId,A.keywords from shanghai A where A.keywords like \"%\"?\"%\"";
        List<Word> list = this.template.query(sql,new BeanPropertyRowMapper<Word>(Word.class),word);

        List<Hotel> listAll = new ArrayList<Hotel>();
        List<Hotel> result;
        if(list.size() != 0){
            for (Word w : list) {
                String word1 = w.getWord();
//            List<Hotel> list1 = this.template.query(sql2,new BeanPropertyRowMapper<Hotel>(Hotel.class),word1,word1,word1);
                List<Hotel> list1 = this.template.query(sql2,new BeanPropertyRowMapper<Hotel>(Hotel.class),word1);
                listAll.addAll(list1);
            }
//        listAll = new ArrayList<Hotel>(new LinkedHashSet<>(listAll));
//        Set<Hotel> setdata = new HashSet<Hotel>(listAll);
//        System.out.println(setdata.addAll(listAll));
//            List<Hotel> unique = listAll.stream().collect(
            result = listAll.stream().collect(
                    Collectors.collectingAndThen(
                            Collectors.toCollection(() -> new TreeSet<>(Comparator.comparing(Hotel::getId))), ArrayList::new)
            );
        }
        else {
            result = this.template.query(sql2,new BeanPropertyRowMapper<Hotel>(Hotel.class),word);
        }

        return result;
    }

    //根据地点查询
    @Override
    public List<Hotel> SearchAsPlace(double thisLng, double thisLat) {
        String sql = "SELECT\n" +
                "\t*,\n" +
                "\tROUND(\n" +
                "\t6378.138 * 2 * ASIN(\n" +
                "\tSQRT(\n" +
                "\tPOW( SIN( ( ? * PI( ) / 180 - lat * PI( ) / 180 ) / 2 ), 2 ) + COS( ? * PI( ) / 180 ) * COS( lat * PI( ) / 180 ) * POW( SIN( ( ? * PI( ) / 180 - lng * PI( ) / 180 ) / 2 ), 2 ) \n" +
                "\t) \n" +
                "\t) * 1000 \n" +
                "\t) AS distance \n" +
                "FROM\n" +
                "\tshanghai \n" +
                "ORDER BY\n" +
                "\tdistance ASC limit 20";
        List<Hotel>list = this.template.query(sql,new BeanPropertyRowMapper<Hotel>(Hotel.class),thisLat,thisLat,thisLng);
        return list;
    }

    //以下方法是向数据库中插入酒店的经纬度数据和keywords数据，在实际中不需要用到
    @Override
    public String SearchLocationAsId(int i) {
        String sql ="select location from shanghai"+" where hotelId = ?";
        //return this.template.queryForObject(sql,new BeanPropertyRowMapper<String>(String.class));
        String location = this.template.queryForObject(sql, new Object[] { i }, String.class);
        //Map<String, Object> map = template.queryForMap(sql,_hotel);--这说明你的条件没有传过来
//          return String.valueOf(maps);
//        System.out.println(list);
        return location;
    }

    @Override
    public void AddLngLat(int i, String name, double thisLng, double thisLat) {
        String sql = "update shanghai set lng = ?,lat = ? where hotelId = ?";
        this.template.update(sql,thisLng,thisLat,i);
    }

    @Override
    public Hotel SearchHotelAsId(int i) {
        String sql = "select * from shanghai where hotelId = ?";
        Hotel hotel;
        try {
            hotel = this.template.queryForObject(sql,new BeanPropertyRowMapper<Hotel>(Hotel.class),i);
        } catch (DataAccessException e) {
            hotel=null;
        }
        return hotel;
    }

    @Override
    public void AddKeywords(int hotelId,String keywords) {
        String sql = "update shanghai set keywords=? where hotelId = ?";
        this.template.update(sql,keywords,hotelId);
    }

    @Override
    public List<Word> SearchWords(String word) {
        String sql ="select word from word_dic " + "where wordid in (select wordid from word_dic where word=?)";
        List<Word> list = this.template.query(sql,new BeanPropertyRowMapper<Word>(Word.class),word);
        return list;
    }
}
