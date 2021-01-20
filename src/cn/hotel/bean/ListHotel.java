package cn.hotel.bean;

import java.io.Serializable;
import java.util.List;

public class ListHotel implements Serializable {//实现序列化接口...必须

    private List<Hotel> list;

    public List<Hotel> getList() {
        return list;
    }

    public void setList(List<Hotel> list) {
        this.list = list;
    }

    public int size(){
        return list.size();
    }

}