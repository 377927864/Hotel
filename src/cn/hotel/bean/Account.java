package cn.hotel.bean;

public class Account {
    private int userid;
    private String nickname;
    private String sex;
    private String email;
    private String occupation;
    private String birthday;
    private String address;
    private int tel;

    public int getUserid() {
        return userid;
    }

    public void setUserid(int userid) {
        this.userid = userid;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getOccupation() {
        return occupation;
    }

    public void setOccupation(String occupation) {
        this.occupation = occupation;
    }

    public String getBirthday() {
        return birthday;
    }

    public void setBirthday(String birthday) {
        this.birthday = birthday;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public int getTel() {
        return tel;
    }

    public void setTel(int tel) {
        this.tel = tel;
    }

    @Override
    public String toString() {
        return "Account{" +
                "userid=" + userid +
                ", nickname='" + nickname + '\'' +
                ", sex='" + sex + '\'' +
                ", email='" + email + '\'' +
                ", occupation='" + occupation + '\'' +
                ", birthday='" + birthday + '\'' +
                ", address='" + address + '\'' +
                ", tel=" + tel +
                '}';
    }
}
