package cn.hotel.service.impl;

public class Point {

    int ID;
    public double[] content;
    boolean isSky=false;
    int DuiYingHotelId;

    public Point(String str, int _ID, int HotelId){
        String[] strs=str.split(" ");
        content=new double[strs.length];
        for (int i = 0; i < strs.length; i++) {
            content[i]=Double.valueOf(strs[i]);
        }
        ID=_ID;
        DuiYingHotelId = HotelId;
    }

    public  boolean dominance(Point p) {//判断this是否支配p，同一维度小值为优
        int counter=0;
        int equalcount=0;
        int lengh=p.content.length;
        for (int i = 0; i <lengh; i++) {
            if(this.content[i]<p.content[i]){
                counter++;
            }
            else if(this.content[i]==p.content[i]) {
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
        // TODO Auto-generated method stub
        StringBuffer sb=new StringBuffer();
        sb.append("[ "+ID);
        for (int i = 0; i < content.length; i++) {
            sb.append(" "+content[i]);
        }
        return sb.append("]").toString();
    }

}
