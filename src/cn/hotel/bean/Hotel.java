package cn.hotel.bean;

import cn.hotel.service.impl.Point;

import java.io.Serializable;
import java.util.List;

public class Hotel  implements Serializable {
    private int id;             //id
    private int hotelId;        //酒店名id
    private String hotelname;   //酒店名
    private String isAssurance; //品质保障
//    private int star;           //星级
    private String location;    //地址
    private String nearby;      //临近景点
    private int price;          //价格
    private String evaluation;  //综合评价
    private float score;        //用户评分
    private double rate;        //用户推荐率
    private int userNum;        //评价用户数
    private String features;    //酒店特色
    private String keywords;      //关键字
    private double point;       //排序时的得分
    private int breakfast;
    private int freewifi;
    private int shuttle;
    private int deposit;
    private int morningcall;
    private double[] dimArr;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getHotelId() {
        return hotelId;
    }

    public void setHotelId(int hotelId) {
        this.hotelId = hotelId;
    }

    public String getHotelname() {
        return hotelname;
    }

    public void setHotelname(String hotelname) {
        this.hotelname = hotelname;
    }

    public String getIsAssurance() {
        return isAssurance;
    }

    public void setIsAssurance(String isAssurance) {
        this.isAssurance = isAssurance;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getNearby() {
        return nearby;
    }

    public void setNearby(String nearby) {
        this.nearby = nearby;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public String getEvaluation() {
        return evaluation;
    }

    public void setEvaluation(String evaluation) {
        this.evaluation = evaluation;
    }

    public float getScore() {
        return score;
    }

    public void setScore(float score) {
        this.score = score;
    }

    public double getRate() {
        return rate;
    }

    public void setRate(double rate) {
        this.rate = rate;
    }

    public int getUserNum() {
        return userNum;
    }

    public void setUserNum(int userNum) {
        this.userNum = userNum;
    }

    public String getFeatures() {
        return features;
    }

    public void setFeatures(String features) {
        this.features = features;
    }

    public String getKeywords() {
        return keywords;
    }

    public void setKeywords(String keyword) {
        this.keywords = keyword;
    }

    public double getPoint() {
        return point;
    }

    public void setPoint(double point) {
        this.point = point;
    }

    public int getBreakfast() {
        return breakfast;
    }

    public void setBreakfast(int breakfast) {
        this.breakfast = breakfast;
    }

    public int getFreewifi() {
        return freewifi;
    }

    public void setFreewifi(int freewifi) {
        this.freewifi = freewifi;
    }

    public int getShuttle() {
        return shuttle;
    }

    public void setShuttle(int shuttle) {
        this.shuttle = shuttle;
    }

    public int getDeposit() {
        return deposit;
    }

    public void setDeposit(int deposit) {
        this.deposit = deposit;
    }

    public int getMorningcall() {
        return morningcall;
    }

    public void setMorningcall(int morningcall) {
        this.morningcall = morningcall;
    }

    public void getDimArr() {
        dimArr = new double[2];
        dimArr[0] = this.getPrice();
        dimArr[1] = 1 / this.getScore();
    }

    public  boolean dominance(Point p) {//判断this是否支配p，同一维度小值为优
        getDimArr();
        int counter=0;
        int equalcount=0;
        int lengh=p.content.length;
        for (int i = 0; i <lengh; i++) {
            if(this.dimArr[i]<p.content[i]){
                counter++;
            }
            else if(this.dimArr[i]==p.content[i]) {
                equalcount++;
            }
        }
        if((counter+equalcount)==lengh&&counter>0){
            return true;
        }
        else {
            return false;
        }
    }

    @Override
    public String toString() {
        return "Hotel{" +
                "id=" + id +
                ", hotelId=" + hotelId +
                ", hotelname='" + hotelname + '\'' +
                ", isAssurance='" + isAssurance + '\'' +
                ", location='" + location + '\'' +
                ", nearby='" + nearby + '\'' +
                ", price=" + price +
                ", evaluation='" + evaluation + '\'' +
                ", score=" + score +
                ", rate=" + rate +
                ", userNum=" + userNum +
                ", features='" + features + '\'' +
                ", keyword='" + keywords + '\'' +
                ", point='" + point + '\'' +
                '}';
    }

    /* public boolean equals(Object arg0){
        Hotel h = (Hotel) arg0;
        return hotelname.equals(h.hotelname);
    }

    public int hashCode(){
        return  hotelname.hashCode();
    }*/
}
