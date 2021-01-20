package cn.hotel.dao.impl;

import cn.hotel.dao.PreferenceDao;
import cn.hotel.utils.JDBCUtils;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;

import java.util.Map;

public class PreferenceDaoImpl implements PreferenceDao {

    //jdbc操作模板
    JdbcTemplate template = new JdbcTemplate(JDBCUtils.getDataSource());

    @Override
    public void savePreference(String[] preference) {
//        String sql1 = "select 1 from preference where username = ? limit 1";
        String sql1 = "insert into preference values(?,?,?,?,?,?,?)";
        String sql2 = "update preference set pa = ?, pb = ?, pc = ?, pd = ?, pe = ? where userid = ?";
        if(existPre(preference[0]) == 0){
            this.template.update(sql1,preference[0],preference[1],preference[2],preference[3],preference[4],preference[5],preference[6]);
        }
        else {
            this.template.update(sql2,preference[2],preference[3],preference[4],preference[5],preference[6],preference[0]);
        }
        /*try {
            System.out.println(this.template.queryForObject(sql1,String.class,preference[0]));
        } catch (DataAccessException e) {
            System.out.println("0");
        }*/
    }

    private int existPre(String username) {
        String sql1 = "select 1 from preference where username = ? limit 1";
        try {
            return this.template.queryForObject(sql1,int.class,username);
        } catch (DataAccessException e) {
            return 0;
        }
    }

    /*@Override
    public String[] queryPreference(String username) {
        String sql1 = "select pa from preference where username = ?";
        String sql2 = "select pb from preference where username = ?";
        String sql3 = "select pc from preference where username = ?";
        String sql4 = "select pd from preference where username = ?";
        String sql5 = "select pe from preference where username = ?";

        //将查询出的一行多列数据装进数组再返回到前台ajax
        String a , b ,c ,d ,e;
        try {
            a = this.template.queryForObject(sql1, new Object[] { username }, String.class);
        } catch (DataAccessException ex) {
            a = "";
        }
        try {
            b = this.template.queryForObject(sql2, new Object[] { username }, String.class);
        } catch (DataAccessException ex) {
            b = "";
        }
        try {
            c = this.template.queryForObject(sql3, new Object[] { username }, String.class);
        } catch (DataAccessException ex) {
            c = "";
        }
        try {
            d = this.template.queryForObject(sql4, new Object[] { username }, String.class);
        } catch (DataAccessException ex) {
            d = "";
        }
        try {
            e = this.template.queryForObject(sql5, new Object[] { username }, String.class);
        } catch (DataAccessException ex) {
            e = "";
        }

        String pre[] = {a,b,c,d,e};
       *//* for (int i = 0;i<pre.length;i++){
            System.out.println(pre[i]);
        }*//*
        return pre;
//        this.template.queryForObject(sql,new BeanPropertyRowMapper<Hotel>(Hotel.class),username);
        *//*SqlRowSet rs = this.template.queryForRowSet(sql);
        System.out.println(rs);*//*
    }*/

    @Override
    public String[] queryPreference(int userid) {
        String sql1 = "select pa from preference where userid = ?";
        String sql2 = "select pb from preference where userid = ?";
        String sql3 = "select pc from preference where userid = ?";
        String sql4 = "select pd from preference where userid = ?";
        String sql5 = "select pe from preference where userid = ?";

        //将查询出的一行多列数据装进数组再返回到前台ajax
        String a ,b ,c ,d ,e;
        try {
            a = this.template.queryForObject(sql1, new Object[] { userid }, String.class);
        } catch (DataAccessException ex) {
            a = "";
        }
        try {
            b = this.template.queryForObject(sql2, new Object[] { userid }, String.class);
        } catch (DataAccessException ex) {
            b = "";
        }
        try {
            c = this.template.queryForObject(sql3, new Object[] { userid }, String.class);
        } catch (DataAccessException ex) {
            c = "";
        }
        try {
            d = this.template.queryForObject(sql4, new Object[] { userid }, String.class);
        } catch (DataAccessException ex) {
            d = "";
        }
        try {
            e = this.template.queryForObject(sql5, new Object[] { userid }, String.class);
        } catch (DataAccessException ex) {
            e = "";
        }

        String pre[] = {a,b,c,d,e};
       /* for (int i = 0;i<pre.length;i++){
            System.out.println(pre[i]);
        }*/
        return pre;
//        this.template.queryForObject(sql,new BeanPropertyRowMapper<Hotel>(Hotel.class),username);
        /*SqlRowSet rs = this.template.queryForRowSet(sql);
        System.out.println(rs);*/
    }

    @Override
    public void saveBrowsingtime(String[] time) {
        String sql1 = "insert into browse values(?,?,?,?)";
        String sql2 = "update browse set browsing_time = browsing_time+? where username = ? and hotelname = ?";
        if(existBrowse(time[1],time[2]) == 0){
            this.template.update(sql1,time[0],time[1],time[2],time[3]);
        }
        else {
            this.template.update(sql2,time[3],time[1],time[2]);
        }
    }

    @Override
    public Double[] queryWeight(int userid) {

//        String sql = "select weight1, weight2, weight3, weight4, weight5, weight6 from weight where userid = ?";
        String sql1 = "select weight1 from weight where userid =?";
        String sql2 = "select weight2 from weight where userid =?";
        String sql3 = "select weight3 from weight where userid =?";
        String sql4 = "select weight4 from weight where userid =?";
        String sql5 = "select weight5 from weight where userid =?";
        String sql6 = "select weight6 from weight where userid =?";

//        weight = this.template.queryForMap(sql2,userid);
        Double weight1 = this.template.queryForObject(sql1,new Object[] { userid }, Double.class);
        Double weight2 = this.template.queryForObject(sql2,new Object[] { userid }, Double.class);
        Double weight3 = this.template.queryForObject(sql3,new Object[] { userid }, Double.class);
        Double weight4 = this.template.queryForObject(sql4,new Object[] { userid }, Double.class);
        Double weight5 = this.template.queryForObject(sql5,new Object[] { userid }, Double.class);
        Double weight6 = this.template.queryForObject(sql6,new Object[] { userid }, Double.class);
        Double weights[] = {weight1,weight2,weight3,weight4,weight5,weight6};
        /*Double weight1 = Double.parseDouble(weight.get("weight1").toString());
        Double weight2 = Double.parseDouble(weight.get("weight2").toString());
        Double weight3 = Double.parseDouble(weight.get("weight3").toString());
        Double weight4 = Double.parseDouble(weight.get("weight4").toString());
        Double weight5 = Double.parseDouble(weight.get("weight5").toString());
        Double []weights = {weight1,weight2,weight3,weight4,weight5,};*/

        return weights;
    }

    private int existBrowse(String username,String hotelname) {
        String sql1 = "select 1 from browse where username = ? and hotelname = ? limit 1";
        try {
            return this.template.queryForObject(sql1,int.class,username,hotelname);
        } catch (DataAccessException e) {
            return 0;
        }
    }
}
