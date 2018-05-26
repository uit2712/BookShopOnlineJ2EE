/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import assets.MD5Assets;
import com.googlecode.s2hibernate.struts2.plugin.annotations.SessionTarget;
import entity.User;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.List;
import model.LoginModel;
import model.RegisterModel;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

/**
 *
 * @author Administrator
 */
public class UserDAO {

    private SessionFactory sessionFactory = null;
    private MD5Assets md5 = null;

    @SessionTarget
    private Session session;

    public UserDAO() {
        if (sessionFactory == null) {
            sessionFactory = new Configuration().configure("hibernate.cfg.xml").buildSessionFactory();
        }
        
        md5 = new MD5Assets();
    }

    public boolean register(RegisterModel model) throws NoSuchAlgorithmException {
        session = sessionFactory.openSession();
        Transaction tx = null;

        try {
            tx = session.beginTransaction();

            User user1 = (User) session.get(User.class, model.getUsername());
            if (user1 != null) {
                return false;
            } else {
                User user = new User();
                user.setAddress(model.getAddress());
                user.setEmail(model.getEmail());
                user.setName(model.getName());
                user.setPassword(md5.getMD5(model.getPassword()));
                user.setPhone(model.getPhone());
                user.setUsername(model.getUsername());

                session.save(user);
                tx.commit();
            }
        } catch (HibernateException e) {
            if (tx != null) {
                tx.rollback();
            }
            
            e.printStackTrace(System.out);
            return false;
        } finally {
            session.close();
        }
        
        return true;
    }
    
    public boolean login(LoginModel model) throws NoSuchAlgorithmException {
        if(model.getUsername() == null || model.getPassword() == null)
            return false;
        
        session = sessionFactory.openSession();

        try {

            User user = (User) session.get(User.class, model.getUsername());
            if (user == null) {
                return false;
            } else {
                if(!user.getPassword().equals(md5.getMD5(model.getPassword())))
                    return false;
            }
        } catch (HibernateException e) {
            e.printStackTrace(System.out);
            return false;
        } finally {
            session.close();
        }
        
        return true;
    }

    public boolean IsExistsUser(String username) {
        session = sessionFactory.openSession();
        
        try {
            User user = (User) session.get(User.class, username);
            if (user != null)
                return true;
        } catch (HibernateException e) {
            return false;
        } finally {
            session.close();
        }

        return false;
    }

    public String updateUser(User user) {
        String status = "Not updated";
        session = sessionFactory.openSession();
        Transaction tx = null;

        try {
            tx = session.beginTransaction();
            User user1 = (User) session.get(User.class, user.getUsername());
            if (user1 != null) {
                user1.setName(user.getName());
                user1.setPassword(user.getPassword());
                session.update(user1);
                status = "User updated";
            }
            tx.commit();
        } catch (HibernateException e) {
            if (tx != null) {
                tx.rollback();
            }
        } finally {
            session.close();
        }

        return status;
    }

    public String deleteUser(User user) {
        String status = "Not deleted";
        session = sessionFactory.openSession();
        Transaction tx = null;

        try {
            tx = session.beginTransaction();
            User user1 = (User) session.get(User.class, user.getUsername());
            if (user1 != null) {
                session.delete(user1);
                status = "Employe Deleted";
            }
            tx.commit();
        } catch (HibernateException e) {
            if (tx != null) {
                tx.rollback();
            }
        } finally {
            session.close();
        }

        return status;
    }

    public User queryUser(User user) {
        User user1 = (User) session.get(User.class, user.getUsername());
        return user1;
    }

    public List<User> showallUser() {
        session = sessionFactory.openSession();
        Transaction tx = null;
        List<User> users = new ArrayList<>();

        try {
            tx = session.beginTransaction();
            Query qr = session.createQuery("FROM entity.User");
            users = qr.list();
            tx.commit();
        } catch (HibernateException e) {
            if (tx != null) {
                tx.rollback();
            }
        } finally {
            session.close();
        }
        return users;
    }
}
