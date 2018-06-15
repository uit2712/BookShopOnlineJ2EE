/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import com.googlecode.s2hibernate.struts2.plugin.annotations.SessionTarget;
import entity.Book;
import entity.Category;
import entity.OrderDetail;
import entity.OrderDetailId;
import entity.OrderHistory;
import entity.User;
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
    
    public List<BookInBasketModel> getListBooksInOrderDetail(String username) {
        List<BookInBasketModel> lstProducts = new ArrayList<>();
        session = sessionFactory.openSession();
        
        User user = (User) session.get(User.class, username);
        if(user == null) // không tồn tại người dùng
            return lstProducts;
        
        // tồn tại người dùng
        try { 
            String query = "FROM OrderHistory WHERE username='" + username + "' AND isCart=true";
            Query qr = session.createQuery(query);
            List<OrderHistory> lstOrder = qr.list();
            for(OrderHistory order: lstOrder) {
                int orderID = order.getOrderId();
                // tìm các cuốn sách được đặt
                query = "FROM OrderDetail WHERE orderID=" + orderID;
                qr = session.createQuery(query);
                List<OrderDetail> lstOrderDetail = qr.list();
                
                // thêm các cuốn sách được đặt vào giỏ
                for(OrderDetail orderDetail: lstOrderDetail) {
                    Book book = (Book) session.get(Book.class, orderDetail.getBook().getBookId());
                    if(book != null) { // thêm sách vào giỏ hàng nếu nó tồn tại
                        BookInBasketModel bookInBasket = new BookInBasketModel();
                        bookInBasket.setBookId(book.getBookId());
                        bookInBasket.setBookName(book.getBookName());
                        bookInBasket.setImage(book.getImage());
                        bookInBasket.setPrice(book.getPrice());
                        bookInBasket.setQuanlity(orderDetail.getQuanlity());
                        
                        lstProducts.add(bookInBasket);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            session.close();
        }
        
        return lstProducts;
    }
    
    public void combineBasket(Map<Integer, BookInBasketModel> basket, String username) {
        // thêm các sản phẩm đã có trong csdl nếu người dùng đã đăng nhập
        List<BookInBasketModel> lstProductsInDB = getListBooksInOrderDetail(username);
        for (BookInBasketModel book : lstProductsInDB) {
            if (basket.containsKey(book.getBookId())) {
                // sách đã tồn tại thì cộng dồn số lượng
                BookInBasketModel newBook = basket.get(book.getBookId());
                newBook.setQuanlity(newBook.getQuanlity() + book.getQuanlity());
                basket.put(newBook.getBookId(), newBook); // chỉnh sửa xong số lượng
            } else {
                basket.put(book.getBookId(), book);
            }
        }
    }
    
    public void updateBasket(List<BookInBasketModel> lstProduct) {
        int size = lstProduct.size();
        for(int i = 0; i < size;){
            BookInBasketModel book = lstProduct.get(i);
            if(book.getQuanlity() == 0) {
                lstProduct.remove(i);
                size--;
            }
            else i++;
        }  
    }
    
    public boolean setListBookToBasket(List<BookInBasketModel> lstProduct, Map<Integer, BookInBasketModel> basket) {
        for(BookInBasketModel book: lstProduct) {
            basket.put(book.getBookId(), book);
        }
        
        return true;
    }
    
    public boolean setListBooksInOrderDetail(List<BookInBasketModel> lstProduct, String username) {
        session = sessionFactory.openSession();
        
        User user = (User) session.get(User.class, username);
        if(user == null) // không tồn tại người dùng
            return false;
        
        // tồn tại người dùng
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            
            String query = "FROM OrderHistory WHERE username='" + username + "' AND isCart=true";
            Query qr = session.createQuery(query);
            List<OrderHistory> lstOrder = qr.list();
            for(OrderHistory order: lstOrder) {
                int orderID = order.getOrderId();
                
                // xóa các sản phẩm trong giỏ trong CSDL
                for(Object orderDetail: order.getOrderDetails()) {
                    session.delete(orderDetail);
                }
                
                for(BookInBasketModel bookInBasket: lstProduct) {
                    Book book = (Book) session.get(Book.class, bookInBasket.getBookId());
                    if(book != null) {
                        // thêm sách vào trong giỏ hàng của người dùng hiện tại
                        OrderDetail orderDetail = new OrderDetail();
                        orderDetail.setQuanlity(bookInBasket.getQuanlity());
                        orderDetail.setId(new OrderDetailId(orderID, book.getBookId()));
                        
                        session.save(orderDetail);
                    }
                }
            }
            
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            session.close();
        }
        
        return true;
    }
    
    public boolean setListBooksInOrderDetail(Map<Integer, BookInBasketModel> basket, String username) {
        session = sessionFactory.openSession();
        
        User user = (User) session.get(User.class, username);
        if(user == null) // không tồn tại người dùng
            return false;
        
        // tồn tại người dùng
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            
            String query = "FROM OrderHistory WHERE username='" + username + "' AND isCart=true";
            Query qr = session.createQuery(query);
            List<OrderHistory> lstOrder = qr.list();
            for(OrderHistory order: lstOrder) {
                int orderID = order.getOrderId();
                
                // xóa các sản phẩm trong giỏ trong CSDL
                for(Object orderDetail: order.getOrderDetails()) {
                    session.delete(orderDetail);
                }
                
                for(Integer bookID: basket.keySet()) {
                    BookInBasketModel bookInBasket = basket.get(bookID);
                    Book book = (Book) session.get(Book.class, bookInBasket.getBookId());
                    if(book != null) {
                        // thêm sách vào trong giỏ hàng của người dùng hiện tại
                        OrderDetail orderDetail = new OrderDetail();
                        orderDetail.setQuanlity(bookInBasket.getQuanlity());
                        orderDetail.setId(new OrderDetailId(orderID, book.getBookId()));
                        
                        session.save(orderDetail);
                    }
                }
            }
            
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            session.close();
        }
        
        return true;
    }
    
    public boolean deleteBooksInBasket(List<BookInBasketModel> lstProduct, String username) {
        if(lstProduct == null)
            return false;
        
        session = sessionFactory.openSession();
        
        User user = (User) session.get(User.class, username);
        if(user == null) // không tồn tại người dùng
            return false;
        
        // tồn tại người dùng
        Transaction tx = null;
        try {
            tx = session.beginTransaction();
            
            String query = "FROM OrderHistory WHERE username='" + username + "' AND isCart=true";
            Query qr = session.createQuery(query);
            List<OrderHistory> lstOrder = qr.list();
            for(OrderHistory order: lstOrder) {
                int orderID = order.getOrderId();
                Map<OrderDetailId, OrderDetail> mapOrderDetail = new HashMap<>();
                for(Object item: order.getOrderDetails()) {
                    OrderDetail od = (OrderDetail) item;
                    mapOrderDetail.put(od.getId(), od);
                }
                
                // xóa các sản phẩm trong giỏ trong CSDL
                for(BookInBasketModel book: lstProduct) {
                    OrderDetailId id = new OrderDetailId(orderID, book.getBookId());
                    OrderDetail od = mapOrderDetail.get(id);
                    
                    // xóa sách được đặt trong giỏ hàng nếu có
                    if(od != null)
                        session.delete(od);
                }
            }
            
            tx.commit();
        } catch (Exception e) {
            e.printStackTrace(System.out);
        } finally {
            session.close();
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
