package cn.hotel.dao.impl;

import cn.hotel.bean.Hotel;
import cn.hotel.dao.ReserveDao;
import cn.hotel.utils.JDBCUtils;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;

import java.util.List;

public class ReserveDaoImpl implements ReserveDao {

    JdbcTemplate template = new JdbcTemplate(JDBCUtils.getDataSource());

    @Override
    public void reserve(int userid, int hotelId) {
//        System.out.println(userid+"and"+hotelId);
        String sql1 = "select userid from reserve "+"where userid =? and hotelId =?";

//        String sql2 = "select username from tb_user "+"where userid =?";
//        String sql3 = "select hotelname from hotel_test "+"where hotelId =?";
//        System.out.println("111");
        try {
            int exitId = template.queryForObject(sql1,Integer.class,new Object[]{userid,hotelId});
            reserveAdd(exitId);
            System.out.println("id为"+exitId+"的用户预定次数+1");
        } catch (DataAccessException e) {
            System.out.println("异常了,说明这条预定记录还不存在，所以插入一条记录");
//            String username = template.queryForObject(sql2,String.class,new Object[]{userid});
//            String hotelname = template.queryForObject(sql3,String.class,new Object[]{hotelId});

            reserveNew(userid,hotelId);
//            e.printStackTrace();
        }

        String sql2 = "select price,breakfast,freewifi,shuttle,deposit,morningcall from shanghai_new where hotelId =?";
        String sql3 = "update score set score1 = score1+?,score2 = score2+?,score3 = score3+?,score4 = score4+?,score5 = score5+?,price1 = price1+?,price2 = price2+?,price3 = price3+?,price4 = price4+?,price5 = price5+? where userid = ?";

        List<Hotel> hotel = this.template.query(sql2,new BeanPropertyRowMapper<>(Hotel.class),hotelId);
        int score1 = hotel.get(0).getBreakfast();
        int score2 = hotel.get(0).getFreewifi();
        int score3 = hotel.get(0).getShuttle();
        int score4 = hotel.get(0).getDeposit();
        int score5 = hotel.get(0).getMorningcall();
        int price = hotel.get(0).getPrice();
        int price1 = 0;
        int price2 = 0;
        int price3 = 0;
        int price4 = 0;
        int price5 = 0;

        switch (price>150?(price>300?(price>450?(price>600?5:4):3):2):1){
            case 1:++price1;break;
            case 2:++price2;break;
            case 3:++price3;break;
            case 4:++price4;break;
            case 5:++price5;break;
        }
        this.template.update(sql3,score1*5,score2*5,score3*5,score4*5,score5*5,price1,price2,price3,price4,price5,userid);
    }

    private void reserveNew(int a, int b) {
        String c = this_username(a);
        String d = this_hotelname(b);
        reserveInsert(a,c,b,d);
    }

    private void reserveInsert(int a, String c, int b, String d) {
        String sql = "insert into reserve values(null,?,?,?,?,1)";
        this.template.update(sql,a,c,b,d);
    }

    private String this_username(int a) {
        String sql = "select username from tb_user "+"where userid =?";
        return template.queryForObject(sql,String.class,new Object[]{a});
    }

    private String this_hotelname(int b) {
        String sql = "select hotelname from shanghai "+"where hotelId =?";
        return template.queryForObject(sql,String.class,new Object[]{b});
    }

    private void reserveAdd(int a) {
        String sql = "update reserve set reserve_times = reserve_times+1 where userid = ?";
        template.update(sql,a);
    }
}
