package com.alan.service.impl;

import com.alan.dao.IUserDao;
import com.alan.model.User;
import com.alan.service.IUserService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * Created by alan_007@foxmail.com on 2017-07-13.
 */
@Service
public class UserServiceImpl implements IUserService {

    @Resource
    private IUserDao userDao;
    public User selectUser(long userId) {
        return this.userDao.selectUser(userId);
    }
}
