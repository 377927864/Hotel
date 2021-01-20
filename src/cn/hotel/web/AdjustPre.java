package cn.hotel.web;

import cn.hotel.dao.impl.PreferenceDaoImpl;
import cn.hotel.utils.JDBCUtils;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;

import java.util.Map;
import java.util.Timer;
import java.util.TimerTask;

public class AdjustPre {

//    static int count = 1;
    static int threshold = 150; //阈值

    public static void main(String[] args) {
        Timer time = new Timer();
//        time.schedule(new updateWeight(),1000,3600000*24*7);   //1s之后开始执行，每周执行一次，参数单位（毫秒）
        time.schedule(new updateWeight(),10000,20000);   //10s之后开始执行，每20s执行一次，参数单位（毫秒）

        while(true){
            try {
                int in = System.in.read();   //控制台输入t时停止定时器，具体定时器开关可根据实际业务需要自己设计
                if (in == 't') {
                    time.cancel();  //关闭定时器操作
                    break;
                }
            } catch (Exception e) {
            }
        }

    }

    private static double Sigmoid(int x){
        return 1 / (1 + Math.pow(Math.E, -x));
    }

    private static class Preference {
        boolean selected = false;   //用户是否选择此偏好
        boolean class_01 = true;   //是否是01型偏好
        int flag = 0;           //该偏好的状态，分为-1:建议去除或修改；0:无变化；1:推荐添加该偏好
        Double weight;             //权值
        int base;               //基数
        int change;             //连续大于70%的次数
    }

    private static class updateWeight extends TimerTask {

        @Override
        public void run() {

            JdbcTemplate template = new JdbcTemplate(JDBCUtils.getDataSource());
            String sql1 = "select max(userid) from tb_user;";
//            String sql2 = "select userid from tb_user where userid = ?";
            String sql3 = "INSERT INTO score(userid,score1,score2,score3,score4,score5,price1,price2,price3,price4,price5)values(?,?,?,?,?,?,?,?,?,?,?) ON DUPLICATE KEY UPDATE userid = values(userid), score1 = values(score1), score2 = values(score2), score3 = values(score3), score4 = values(score4), score5 = values(score5), price1 = values(price1), price2 = values(price2), price3 = values(price3), price4 = values(price4), price5 = values(price5)";
//            String sql3 = "insert into score(userid,score1,score2,score3,score4,score5,price1,price2,price3,price4,price5) values (?,?,?,?,?,?,?,?,?,?,?)";
//            String sql4 = "update weight set userid = ?,weight1 = ?,base1 = ?,change1 = ?,weight2 = ?,base2 = ?,change2 = ?,weight3 = ?,base3 = ?,change3 = ?,weight4 = ?,base4 = ?,change4 = ?,weight5 = ?,base5 = ?,change5 = ?,weight6 = ?,base6 = ?,change6 = ?";
            String sql4 = "INSERT INTO weight(userid,weight1,base1,change1,weight2,base2,change2,weight3,base3,change3,weight4,base4,change4,weight5,base5,change5,weight6,base6,change6)values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)ON DUPLICATE KEY UPDATE userid = values(userid),weight1 = values(weight1),base1 = values(base1),change1 = values(change1),weight2 = values(weight2),base2 = values(base2),change2 = values(change2),weight3 = values(weight3),base3 = values(base3),change3 = values(change3),weight4 = values(weight4),base4 = values(base4),change4 = values(change4),weight5 = values(weight5),base5 = values(base5),change5 = values(change5),weight6 = values(weight6),base6 = values(base6),change6 = values(change6);";
            String sql5 = "select * from score where userid = ?";
            String sql6 = "select * from weight where userid = ?";
//            String sql7 = "insert into message(userid, message) select ?, ? from DUAL where not exists(select userid from message where userid = ?)";
            String sql7 = "insert into message(userid, message)values(?,?)ON DUPLICATE KEY UPDATE userid = values(userid),message = values(message)";
            int x = template.queryForObject(sql1,new Object[]{}, Integer.class);   //用户数量

            System.out.println("x="+x);

            for(int i = 1; i <= x; i++){

                String pre[] = new PreferenceDaoImpl().queryPreference(i);

                Preference breakfast = new Preference();
                Preference freewifi = new Preference();
                Preference shuttle = new Preference();
                Preference deposit = new Preference();
                Preference morningcall = new Preference();
                Preference price = new Preference();

                for(int j = 0; j < pre.length; j++){
                    if(pre[j].equals("有早餐")){
                        breakfast.selected = true;
                    }else if(pre[j].equals("免费WiFi")){
                        freewifi.selected = true;
                    }else if(pre[j].equals("接送服务")){
                        shuttle.selected = true;
                    }else if(pre[j].equals("行李寄存")){
                        deposit.selected = true;
                    }else if(pre[j].equals("叫醒服务")){
                        morningcall.selected = true;
                    }else {
                        price.selected = true;
                        price.class_01 = false;
                    }
                }

                Map<String,Object> score;
                Map<String,Object> weight;
                try {
                    score = template.queryForMap(sql5,i);
                } catch (DataAccessException e) {
                    template.update(sql3, i,0,0,0,0,0,0,0,0,0,0);
                    score = template.queryForMap(sql5,i);
                }
                try {
                    weight = template.queryForMap(sql6,i);
                } catch (DataAccessException e) {
                    template.update(sql4, i,0.5,0,0,0.5,0,0,0.5,0,0,0.5,0,0,0.5,0,0,0.5,0,0);
                    weight = template.queryForMap(sql6,i);
                }
                breakfast.weight = Double.parseDouble(weight.get("weight1").toString());
                freewifi.weight = Double.parseDouble(weight.get("weight2").toString());
                shuttle.weight = Double.parseDouble(weight.get("weight3").toString());
                deposit.weight = Double.parseDouble(weight.get("weight4").toString());
                morningcall.weight = Double.parseDouble(weight.get("weight5").toString());
                price.weight = Double.parseDouble(weight.get("weight6").toString());
                breakfast.base =  (Integer) weight.get("base1");
                freewifi.base =  (Integer) weight.get("base2");
                shuttle.base =  (Integer) weight.get("base3");
                deposit.base =  (Integer) weight.get("base4");
                morningcall.base =  (Integer) weight.get("base5");
                price.base =  (Integer) weight.get("base6");
                breakfast.change =  (Integer) weight.get("change1");
                freewifi.change =  (Integer) weight.get("change2");
                shuttle.change =  (Integer) weight.get("change3");
                deposit.change =  (Integer) weight.get("change4");
                morningcall.change =  (Integer) weight.get("change5");
                price.change =  (Integer) weight.get("change6");

                for(int j = 1; j < 6; j++){     //循环5个0-1型偏好
                    int this_score =  (Integer) score.get("score"+j);
                    if(this_score > threshold * 0.8){       //上调权重
                        if(j == 1){
                            breakfast.base = breakfast.base + 2;
                            breakfast.weight = Sigmoid(breakfast.base);
                            if(this_score > threshold * 0.7){
                                breakfast.change ++;
                                if(breakfast.change == 3){
                                    breakfast.flag = 1;
                                }
                            }else {
                                breakfast.change = 0;
                            }
                        }if(j == 2){
                            freewifi.base = freewifi.base + 2;
                            freewifi.weight = Sigmoid(freewifi.base);
                            if(this_score > threshold * 0.7){
                                freewifi.change ++;
                                if(freewifi.change == 3){
                                    freewifi.flag = 1;
                                }
                            }else {
                                freewifi.change = 0;
                            }
                        }if(j == 3){
                            shuttle.base = shuttle.base + 2;
                            shuttle.weight = Sigmoid(shuttle.base);
                            if(this_score > threshold * 0.7){
                                shuttle.change ++;
                                if(shuttle.change == 3){
                                    shuttle.flag = 1;
                                }
                            }else {
                                shuttle.change = 0;
                            }
                        }if(j == 4){
                            deposit.base = deposit.base + 2;
                            deposit.weight = Sigmoid(deposit.base);
                            if(this_score > threshold * 0.7){
                                deposit.change ++;
                                if(deposit.change == 3){
                                    deposit.flag = 1;
                                }
                            }else {
                                deposit.change = 0;
                            }
                        }if(j == 5){
                            morningcall.base = morningcall.base + 2;
                            morningcall.weight = Sigmoid(morningcall.base);
                            if(this_score > threshold * 0.7){
                                morningcall.change ++;
                                if(morningcall.change == 3){
                                    morningcall.flag = 1;
                                }
                            }else {
                                morningcall.change = 0;
                            }
                        }
                    }
                    if(this_score > 0 && this_score < threshold * 0.4){       //下调权重
                        if(j == 1){
                            breakfast.base = breakfast.base - 2;
                            breakfast.weight = Sigmoid(breakfast.base);
                            breakfast.change = 0;
                            if(breakfast.weight < 0.1){
                                breakfast.flag = -1;
                            }
                        }if(j == 2){
                            freewifi.base = freewifi.base - 2;
                            freewifi.weight = Sigmoid(freewifi.base);
                            freewifi.change = 0;
                            if(freewifi.weight < 0.1){
                                freewifi.flag = -1;
                            }
                        }if(j == 3){
                            shuttle.base = shuttle.base - 2;
                            shuttle.weight = Sigmoid(shuttle.base);
                            shuttle.change = 0;
                            if(shuttle.weight < 0.1){
                                shuttle.flag = -1;
                            }
                        }if(j == 4){
                            deposit.base = deposit.base - 2;
                            deposit.weight = Sigmoid(deposit.base);
                            deposit.change = 0;
                            if(deposit.weight < 0.1){
                                deposit.flag = -1;
                            }
                        }if(j == 5){
                            morningcall.base = morningcall.base - 2;
                            morningcall.weight = Sigmoid(morningcall.base);
                            morningcall.change = 0;
                            if(morningcall.weight < 0.1){
                                morningcall.flag = -1;
                            }
                        }
                    }
                }

                //判断价格偏好是否需要调整权值
                int selected_times = 0;
                int total_times = 0;
                for(int j = 1; j < 6; j++){
                    if(pre[j-1].equals("150以下")){
                        selected_times += (Integer) score.get("price"+j);
                    }
                    if(pre[j-1].equals("150--300")){
                        selected_times += (Integer) score.get("price"+j);
                    }
                    if(pre[j-1].equals("300--450")){
                        selected_times += (Integer) score.get("price"+j);
                    }
                    if(pre[j-1].equals("450--600")){
                        selected_times += (Integer) score.get("price"+j);
                    }
                    if(pre[j-1].equals("600以上")){
                        selected_times += (Integer) score.get("price"+j);
                    }
                    total_times += (Integer) score.get("price"+j);
                }
                if(selected_times != 0){
                    if(selected_times * 1.0/ total_times > 0.6){    //上调权重
                        price.weight = Sigmoid(price.base + 2);
                        price.change ++;
                    }
                    if(selected_times * 1.0/ total_times < 0.25){   //下调权重
                        price.weight = Sigmoid(price.base - 2);
                        price.change  = 0;
                        if(price.weight < 0.1){
                            price.flag = -1;
                        }
                    }
                }

                String msg = "根据您的消费习惯,建议您";
                String msgSelect = "添加偏好:";
                String msgDelect = "去掉偏好:";
                String msgChange = "";
                if(!breakfast.selected){
                    if(breakfast.flag == 1){
                        //推荐
                        msgSelect += "\"有早餐\" ";
                    }
                }else {
                    if(breakfast.flag == -1){
                        //建议去除
                        msgDelect += "\"有早餐\" ";
                    }
                }
                if(!freewifi.selected){
                    if(freewifi.flag == 1){
                        //推荐
                        msgSelect += "\"免费WiFi\" ";
                    }
                }else {
                    if(freewifi.flag == -1){
                        //建议去除
                        msgDelect += "\"免费WiFi\" ";
                    }
                }if(!shuttle.selected){
                    if(shuttle.flag == 1){
                        //推荐
                        msgSelect += "\"接送服务\" ";
                    }
                }else {
                    if(shuttle.flag == -1){
                        //建议去除
                        msgDelect += "\"接送服务\" ";
                    }
                }if(!deposit.selected){
                    if(deposit.flag == 1){
                        //推荐
                        msgSelect += "\"行李寄存\" ";
                    }
                }else {
                    if(deposit.flag == -1){
                        //建议去除
                        msgDelect += "\"行李寄存\" ";
                    }
                }if(!morningcall.selected){
                    if(morningcall.flag == 1){
                        //推荐
                        msgSelect += "\"叫醒服务\" ";
                    }
                }else {
                    if(morningcall.flag == -1){
                        //建议去除
                        msgDelect += "\"叫醒服务\" ";
                    }
                }if(price.selected && price.flag == -1){
                    msgChange += "修改价格偏好";
                }

                if(msgSelect.length() > 5){
                    msg += msgSelect;
                }
                if(msgDelect.length() >5){
                    msg += msgDelect;
                }
                if(msgChange.length() > 0){
                    msg += msgChange;
                }
                if(msg.length() > 12){
                    template.update(sql7,i,msg);
                }

                //更新完权重、基数、占比连续大于0.7的次数，更新该用户对应的权重表，并将该用户的得分表置零
                template.update(sql3, i,0,0,0,0,0,0,0,0,0,0);
                template.update(sql4, i,breakfast.weight,breakfast.base,breakfast.change,freewifi.weight,freewifi.base,freewifi.change,shuttle.weight,shuttle.base,shuttle.change,deposit.weight,deposit.base,deposit.change,morningcall.weight,morningcall.base,morningcall.change,price.weight,price.base,price.change);

            }
                    //在上调权重的同时，记录连续大于70%的次数，下调则清零；数据库里还需要存储sigmoid函数的自变量，每次的权重值weight（0~1）都由自变量计算得到
//                    System.out.println(map.get("score"+(i+1))+"//"+map.get("price3"));
                    /*for (Map.Entry<String, Object> entry : entrySet) {
                        System.out.println("key is " + entry.getKey());
                        System.out.println("value is " + entry.getValue());
                    }*/

            /*String sql = "select message from message where userid = ?";
            String result;
            try {
                result = template.queryForObject(sql,String.class,1);
            } catch (DataAccessException e) {
                result = null;
            }
            System.out.println(result+"hehe");*/
        }

    }


}

