package com.it.service;

import com.it.domain.Msg;
import com.it.domain.User;

public interface IUserService {
    /**
     * 保存注册信息
     * @return 提示信息
     */
    public void SaveRegistration(User user);
    /**
     * ajax验证用户是否存在
     * @return 提示信息
     */
    public Msg VerifyName(String name);
    /**
     * 验证登陆
     * @return 提示信息
     */
    public Msg VerifyLogin(User user);
}
