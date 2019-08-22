package com.it.domain;

import java.util.HashMap;
import java.util.Map;

public class Msg {
    private int state;
    private String message;
    private Map<String,Object> stringObjectMap=new HashMap<>();
    public static Msg succeed(){
        Msg msg=new Msg();
        msg.setState(200);
        msg.setMessage("成功");
        return msg;
    }
    public static Msg fail(){
        Msg msg=new Msg();
        msg.setState(100);
        msg.setMessage("失败");
        return msg;
    }
    public Msg add(String key,Object values){
        this.stringObjectMap.put(key,values);
        return this;
    }
    public int getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Map<String, Object> getStringObjectMap() {
        return stringObjectMap;
    }

    public void setStringObjectMap(Map<String, Object> stringObjectMap) {
        this.stringObjectMap = stringObjectMap;
    }
}
