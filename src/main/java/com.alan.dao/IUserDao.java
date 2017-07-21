package com.alan.dao;

import com.alan.model.User;
import org.springframework.stereotype.Repository;

/**
 * Created by alan_007@foxmail.com on 2017-07-13.
 */
@Repository
public interface IUserDao {
    User selectUser(long id);
}
