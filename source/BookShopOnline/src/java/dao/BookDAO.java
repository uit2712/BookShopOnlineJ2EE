/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import com.googlecode.s2hibernate.struts2.plugin.annotations.SessionTarget;
import entity.Book;
import entity.Category;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.BookDetailModel;
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
public class BookDAO {
    private SessionFactory sessionFactory = null;

    @SessionTarget
    private Session session;

    public BookDAO() {
        sessionFactory = HibernateUtil.getSessionFactory();
    }

    public Map<String, List> getProductsInCategory() {
        session = sessionFactory.openSession();
        Transaction tx = null;
        Map<String, List> mapBooks = new HashMap<>();
        List<Category> categories = new ArrayList<>();
        String query = "";

        try {
            tx = session.beginTransaction();
            query = "FROM Category";
            Query qr = session.createQuery(query);
            categories = qr.list();
            
            for (int i = 0; i < categories.size(); i++) {
                Category category = categories.get(i);
                query = "FROM Book WHERE categoryID = '" + category.getCategoryID() + "'";
                qr = session.createQuery(query);
                List<Book> books = qr.list();
                if(books.size() > 0)
                    mapBooks.put(category.getCategoryName(), books);   
            }
            
            tx.commit();
        } catch (HibernateException e) {
            e.printStackTrace();
            if (tx != null) {
                tx.rollback();
            }
        } finally {
            session.close();
        }
        return mapBooks;
    }
    
    public BookDetailModel getBookDetail(int bookID) {
        session = sessionFactory.openSession();
        BookDetailModel model = new BookDetailModel();

        try {

            Book book = (Book) session.get(Book.class, bookID);
            if(book != null) {
                model.setBookId(book.getBookId());
                model.setBookName(book.getBookName());
                model.setCategoryId(book.getCategoryId());
                model.setDescribe(book.getDescribe());
                model.setImage(book.getImage());
                model.setPrice(book.getPrice());
            }
            
        } catch (HibernateException e) {
            e.printStackTrace(System.out);
        } finally {
            session.close();
        }

        return model;
    }
    
    public boolean IsBookExists(int bookID) {
        session = sessionFactory.openSession();

        try {

            Book book = (Book) session.get(Book.class, bookID);
            if(book == null)
                return false;     
            
        } catch (HibernateException e) {
            e.printStackTrace(System.out);
            return false;
        } finally {
            session.close();
        }

        return true;
    }
}
