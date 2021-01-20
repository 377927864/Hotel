package cn.hotel.service;

import cn.hotel.bean.User;

public interface UserService {

    User loginUser(User user);//登陆

    boolean userRegist(User user);//注册
}
