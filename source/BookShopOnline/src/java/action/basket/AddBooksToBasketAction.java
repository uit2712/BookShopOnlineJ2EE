/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package action.basket;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.opensymphony.xwork2.Preparable;
import dao.BasketDAO;
import java.util.HashMap;
import java.util.Map;
import model.BookInBasketModel;

/**
 *
 * @author Administrator
 */
public class AddBooksToBasketAction extends ActionSupport 
implements ModelDriven<BookInBasketModel>, Preparable {

    /**
    * Giỏ hàng chứa danh sách các cuốn sách được thêm vào:
    * - String: mã sách
    * - BookInBasketModel: thông tin sách trong giỏ
    */
    private BookInBasketModel book;
    private String message;
    private BasketDAO dao;
    private Integer totalBook;

    public Integer getTotalBook() {
        return totalBook;
    }

    public void setTotalBook(Integer totalBook) {
        this.totalBook = totalBook;
    }

    public BookInBasketModel getBook() {
        return book;
    }

    public String getMessage() {
        return message;
    }
    
    @Override
    public BookInBasketModel getModel() {
        return book;
    }
    
    @Override
    public void prepare() throws Exception {
        book = new BookInBasketModel();
        dao = new BasketDAO();
        totalBook = 0;
        message = "";
    }
    
    public String addBooksToBasket() {
        Object currentBasket = ActionContext.getContext().getSession().get("basket");
        Map<Integer, BookInBasketModel> basket = (Map<Integer, BookInBasketModel>) currentBasket;
        if(basket == null) {
            basket = new HashMap<>();
        }
        
        dao.addBooksToBasket(book, basket);
        totalBook = dao.getTotalBook(basket);
        ActionContext.getContext().getSession().put("basket", basket);
        ActionContext.getContext().getSession().put("totalBook", totalBook);
                
        return SUCCESS;
    }
}
