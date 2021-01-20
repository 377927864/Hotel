package cn.hotel.service.impl;

import cn.hotel.bean.User;
import cn.hotel.dao.UserDao;
import cn.hotel.dao.impl.UserDaoImpl;
import cn.hotel.service.UserInformationService;

public class UserInformationServiceImpl implements UserInformationService {

    UserDao dao = new UserDaoImpl();

    @Override
    public User saveInformation(User user) {
        return this.dao.savaInformation(user);
    }
}
