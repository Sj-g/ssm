package com.it.domain;

import javax.validation.constraints.Pattern;
import java.util.Date;

public class User {
    private Integer id;
    @Pattern(regexp = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})",message = "用户名不正确")
    private String username;

    private String password;

    private Date date;

    private Integer isdel;

    public User(Integer id, String username, String password, Date date, Integer isdel) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.date = date;
        this.isdel = isdel;
    }

    public User() {
        super();
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username == null ? null : username.trim();
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password == null ? null : password.trim();
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public Integer getIsdel() {
        return isdel;
    }

    public void setIsdel(Integer isdel) {
        this.isdel = isdel;
    }
}