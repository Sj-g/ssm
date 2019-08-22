package com.it.service;

import com.it.dao.UserMapper;
import com.it.domain.Msg;
import com.it.domain.User;
import com.it.domain.UserExample;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service
public class UserService implements IUserService {
    @Autowired
    private UserMapper userMapper;
    @Override
    public void SaveRegistration(User user) {
        user.setDate(new Date());
        user.setIsdel(1);
        userMapper.insertSelective(user);
    }

    @Override
    public Msg VerifyName(String name) {
        UserExample example=new UserExample();;
        UserExample.Criteria criteria=example.createCriteria();
        criteria.andUsernameEqualTo(name);
        List<User> list=userMapper.selectByExample(example);
        if (list.size()==0){
            return Msg.succeed();
        }
        return Msg.fail().add("message","用户已存在");
    }

    @Override
    public Msg VerifyLogin(User user) {
        UserExample example=new UserExample();;
        UserExample.Criteria criteria=example.createCriteria();
        criteria.andUsernameEqualTo(user.getUsername());
        List<User> list=userMapper.selectByExample(example);
        if(list.size()==0){
            return Msg.fail().add("mes","用户不存在");
        }
        if(list.get(0).getUsername().equals(user.getUsername())){
            boolean flag=list.get(0).getPassword().equals(user.getPassword());
            if(flag==true){
                return Msg.succeed();
            }else{
                return Msg.fail().add("mes","密码错误");
            }
        }
        return Msg.fail().add("mes","密码错误");
    }
}
