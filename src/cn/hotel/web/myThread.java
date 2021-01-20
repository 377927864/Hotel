package cn.hotel.web;

public class myThread extends Thread{

    public void run(){
        Server server = new Server();
        server.init2();
    }
}
