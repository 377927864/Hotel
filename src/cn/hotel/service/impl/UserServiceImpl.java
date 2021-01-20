package cn.hotel.service.impl;

import cn.hotel.bean.User;
import cn.hotel.dao.UserDao;
import cn.hotel.dao.impl.UserDaoImpl;
import cn.hotel.service.UserService;

public class UserServiceImpl implements UserService {

    //登陆
    //注入dao层
    UserDao dao = new UserDaoImpl();

    public User loginUser(User user){

        return this.dao.loginUser(user);
    }

    //注册
    @Override
    public boolean userRegist(User user) {

        //user.setPassword(user.getPassword());

        User user1 = dao.checkUsername(user.getUsername());
        //判断用户是否存在
        if(user1==null){
            //直接注册
            dao.userRegist(user);
//            System.out.println(user.getUserid());
            return true;
        }
        return false;
    }
}
