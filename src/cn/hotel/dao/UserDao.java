package cn.hotel.dao;

import cn.hotel.bean.Hotel;
import cn.hotel.bean.User;

import java.util.List;
import java.util.Map;

public interface UserDao {
    //List<User> selectAllUser();

    User loginUser(User user);

    int getTotalCounts(Map<String, String[]> map);

    List<User> getListCustomers(int startIndex, int pageSize, Map<String, String[]> map);

    User checkUsername(String username);

    void userRegist(User user);

    User savaInformation(User user);
}
