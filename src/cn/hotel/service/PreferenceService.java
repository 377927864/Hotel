package cn.hotel.service;

public interface PreferenceService {
    //保存用户偏好
    void savePreference(String[] preference);

    //查询用户偏好
//    String[] queryPreference(String username);
    String[] queryPreference(int userid);

    //保存用户对某个酒店的浏览时间
    void saveBrowsingtime(String[] time);

    Double[] queryWeight(int userid);
}
