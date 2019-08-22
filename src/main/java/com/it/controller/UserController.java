package com.it.controller;

import com.it.domain.Msg;
import com.it.domain.User;
import com.it.service.IUserService;
import com.sun.org.apache.xpath.internal.objects.XString;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/login")
public class UserController {
    @Autowired
    private IUserService userService;
    /**
     * 登陆验证密码
     */
    @RequestMapping("/verify")
    @ResponseBody
    public Msg verifyUsername(@RequestBody User user,HttpServletRequest request){
        HttpSession session=request.getSession();
        session.setAttribute("user",user);
        System.out.println(user.getUsername());
        Msg msg=userService.VerifyLogin(user);
        return msg;
    }
    /**
     * 注册验证用户名
     */
    @RequestMapping("/checkuser")
    @ResponseBody
    public Msg VerifyName(String empName){
//        System.out.println(empName);
        Msg msg=userService.VerifyName(empName);
        return msg;
    }
    /**
     * 保存注册信息
     */
    @RequestMapping("/save")
    @ResponseBody
    public Msg  SaveRegistration(@RequestBody @Valid User user, BindingResult bindingResult){
        System.out.println(user.getUsername());
        System.out.println(user.getPassword());
        Map<String,String> map=new HashMap<>();
        if(bindingResult.hasErrors()){
            FieldError fieldError=bindingResult.getFieldError();
            System.out.println("错误字段:"+fieldError.getField());
            System.out.println("错误信息:"+fieldError.getDefaultMessage());
            map.put(fieldError.getField(),fieldError.getDefaultMessage());
            return Msg.fail().add("errormessage",map);
        }
            userService.SaveRegistration(user);
            return Msg.succeed();
    }
    /**
     * 转发到注册页面
     */
    @RequestMapping("/registration")
    public String registration(){
        return "registration_login/Registration";
    }

    /**
     * 登陆页面
     * @return
     */
    @RequestMapping("/loginpages")
    public String loginpages(){
//        int s=1/0;
        return "registration_login/Login";
    }
    /**
     * 退出
     * @return
     */
    @RequestMapping("/exit")
    public String exit(HttpServletRequest httpServletRequest){
        httpServletRequest.getSession().invalidate();
        return "registration_login/Login";
    }
    @RequestMapping("/emp")
    public String em(){
        return "index";
    }
}
