package cn.hotel.dao;

public interface PreferenceDao {
    void savePreference(String[] preference);

//    String[] queryPreference(String username);
    String[] queryPreference(int userid);

    void saveBrowsingtime(String[] time);

    Double[] queryWeight(int userid);
}
