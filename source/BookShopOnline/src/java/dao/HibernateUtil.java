/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

/**
 *
 * @author Administrator
 */
public class HibernateUtil {
    private static SessionFactory sessionFactory = null;
    
    public static SessionFactory getSessionFactory() {
        if(sessionFactory == null)
            sessionFactory = new Configuration().configure("hibernate.cfg.xml").buildSessionFactory();
        
        return sessionFactory;
    }
}
