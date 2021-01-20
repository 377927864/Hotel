package cn.hotel.bean;

public class Word {
    private int id;
    private String wordid;
    private String word;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getWordid() {
        return wordid;
    }

    public void setWordid(String wordid) {
        this.wordid = wordid;
    }

    public String getWord() {
        return word;
    }

    public void setWord(String word) {
        this.word = word;
    }

    @Override
    public String toString() {
        return "Word{" +
                "id=" + id +
                ", wordid='" + wordid + '\'' +
                ", word='" + word + '\'' +
                '}';
    }
}
