/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import com.googlecode.s2hibernate.struts2.plugin.annotations.SessionTarget;
import entity.Category;
import java.util.ArrayList;
import java.util.List;
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
public class CategoryDAO {
    private SessionFactory sessionFactory = null;

    @SessionTarget
    private Session session;

    public CategoryDAO() {
        sessionFactory = HibernateUtil.getSessionFactory();
    }

    public List<Category> getAllCategory() {
        session = sessionFactory.openSession();
        Transaction tx = null;
        List<Category> categories = new ArrayList<>();

        try {
            tx = session.beginTransaction();
            Query qr = session.createQuery("FROM Category");
            categories = qr.list();
            tx.commit();
        } catch (HibernateException e) {
            if (tx != null) {
                tx.rollback();
            }
        } finally {
            session.close();
        }
        return categories;
    }
}
