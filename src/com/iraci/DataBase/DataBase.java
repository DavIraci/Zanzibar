package com.iraci.DataBase;

import com.iraci.model.User;

public class DataBase {
    private String name;
    private String password;
    private String address;


    public static User login(String username, String pass) {
        if(username.equals("davide")){
            return new User(username);
        }else{
            return null;
        }
    }
}
