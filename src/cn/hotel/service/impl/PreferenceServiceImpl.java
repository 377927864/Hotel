package cn.hotel.service.impl;

import cn.hotel.dao.PreferenceDao;
import cn.hotel.dao.impl.PreferenceDaoImpl;
import cn.hotel.service.PreferenceService;

public class PreferenceServiceImpl implements PreferenceService {

    PreferenceDao dao = new PreferenceDaoImpl();

    @Override
    public void savePreference(String[] preference) {
        this.dao.savePreference(preference);
    }

    /*@Override
    public String[] queryPreference(String username) {
        return this.dao.queryPreference(username);
    }*/
    public String[] queryPreference(int userid) {
        return this.dao.queryPreference(userid);
    }

    @Override
    public void saveBrowsingtime(String[] time) {
        this.dao.saveBrowsingtime(time);
    }

    @Override
    public Double[] queryWeight(int userid) {
        return this.dao.queryWeight(userid);
    }
}
