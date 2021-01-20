package cn.hotel.dao.impl;

import cn.hotel.bean.User;
import cn.hotel.dao.UserDao;
import cn.hotel.utils.JDBCUtils;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;

import java.sql.*;
import java.util.List;
import java.util.Map;

public class UserDaoImpl implements UserDao {

    //jdbc模板操作
    private JdbcTemplate template = new JdbcTemplate(JDBCUtils.getDataSource());



    //连接数据库
    public User loginUser(User user){

        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        PreparedStatement pstmt = null;
        try {
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hotel","root","root");

            pstmt = conn.prepareStatement("select * from tb_user where username = ? and password = ?");

            pstmt.setString(1,user.getUsername());
            pstmt.setString(2,user.getPassword());

            rs = pstmt.executeQuery();

            //stmt = conn.createStatement();
            //rs = stmt.executeQuery("select * from t_user where username = '"+user.getUsername()+"'and password = '"+user.getPassword()+"'");
            //要么查到，要么查不到
            if(rs.next()){
                User u = new User();

                u.setUserid(rs.getInt("userid"));
                u.setUsername(rs.getString("username"));
                u.setPassword(rs.getString("password"));
                u.setNickname(rs.getString("nickname"));
                u.setSex(rs.getString("sex"));
                u.setEmail(rs.getString("email"));
                u.setOccupation(rs.getString("occupation"));
                u.setBirthday(rs.getString("birthday"));
                u.setAddress(rs.getString("address"));
                u.setTel(rs.getInt("tel"));

                return u;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }finally{
            try {
                if(rs!=null){
                    rs.close();
                    rs=null;
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                if(stmt!=null){
                    stmt.close();
                    stmt=null;
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                if(conn!=null){
                    conn.close();
                    conn=null;
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return null;
    }

    @Override
    public int getTotalCounts(Map<String, String[]> map) {
        return 0;
    }

    @Override
    public List<User> getListCustomers(int startIndex, int pageSize, Map<String, String[]> map) {
        return null;
    }

    //注册时核验用户名是否已存在
    @Override
    public User checkUsername(String username) {

        String sql = "select username from tb_user where username = ?";
        //如果BeanPropertyRowMapper类返回的是0 或者是 大于1 会报错，我们的需求是查不到返回null
        try {
            return this.template.queryForObject(sql, new BeanPropertyRowMapper<User>(User.class), username);
        } catch (DataAccessException e) {
//            e.printStackTrace();
        }
        return null;
    }

    //用户注册
    @Override
    public void userRegist(User user) {
        String sql = "insert into tb_user values(?,?,?,?,?,?,?,?,?,?)";
        this.template.update(sql,user.getUserid(),user.getUsername(),user.getPassword(),user.getNickname(),user.getSex(),user.getEmail(),user.getOccupation(),user.getBirthday(),user.getAddress(),user.getTel());
//        System.out.println(this.template.queryForObject("select userid from tb_user where username = "+user.getUsername()",user.getClass()));
        /*user.setUserid(user.getUserid());
        System.out.println(user.getUserid());*/
    }

    //修改用户个人信息
    @Override
    public User savaInformation(User user) {
        String sql = "update tb_user set nickname=?,sex=?,email=?,occupation=?,birthday=?,address=?,tel=? where tb_user.userid=?";
        this.template.update(sql,user.getNickname(),user.getSex(),user.getEmail(),user.getOccupation(),user.getBirthday(),user.getAddress(),user.getTel(),user.getUserid());
        return user;
    }

}