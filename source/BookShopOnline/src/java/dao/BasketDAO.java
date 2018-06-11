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
import model.BookInBasketModel;
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
public class BasketDAO {
    private SessionFactory sessionFactory = null;

    @SessionTarget
    private Session session;

    public BasketDAO() {
        if (sessionFactory == null) {
            sessionFactory = new Configuration().configure("hibernate.cfg.xml").buildSessionFactory();
        }
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
    
    public boolean addBooksToBasket(BookInBasketModel bookInBasket, Map<Integer, BookInBasketModel> basket) {
        if(!IsBookExists(bookInBasket.getBookId())) // không tồn tại sách
            return false;

        session = sessionFactory.openSession();
        
        try {
            // thiết lập thông tin sách
            Book book = (Book) session.get(Book.class, bookInBasket.getBookId());
            bookInBasket.setBookName(book.getBookName());
            bookInBasket.setImage(book.getImage());
            bookInBasket.setPrice(book.getPrice());
            
            // đã tồn tại sách hiện tại
            if(basket.containsKey(bookInBasket.getBookId())) {
               BookInBasketModel currentBook = basket.get(bookInBasket.getBookId());
               
               // thiết lập lại số lượng trong giỏ
               currentBook.setQuanlity(currentBook.getQuanlity() + bookInBasket.getQuanlity());
               basket.put(bookInBasket.getBookId(), currentBook);
            }
            else {
                basket.put(bookInBasket.getBookId(), bookInBasket);
            }

        } catch (Exception e) {
            e.printStackTrace(System.out);
            return false;
        } finally {
            session.close();
        }
        
        return true;
    }
    
    public boolean setListBookToBasket(List<BookInBasketModel> lstProduct, Map<Integer, BookInBasketModel> basket) {
        for(BookInBasketModel book: lstProduct) {
            basket.put(book.getBookId(), book);
        }
        
        return true;
    }
    
    public Integer getTotalBook(Map<Integer, BookInBasketModel> basket) {
        Integer sum = 0;
        for(Integer bookID: basket.keySet())
            sum += ((BookInBasketModel)basket.get(bookID)).getQuanlity();

        return sum;
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
