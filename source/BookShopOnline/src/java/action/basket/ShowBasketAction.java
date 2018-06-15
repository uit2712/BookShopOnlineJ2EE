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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import model.BookInBasketModel;
import org.apache.struts2.interceptor.ServletRequestAware;

/**
 *
 * @author Administrator
 */
public class ShowBasketAction extends ActionSupport 
implements ModelDriven<List<BookInBasketModel>>, Preparable, ServletRequestAware {

    /**
    * Giỏ hàng chứa danh sách các cuốn sách được thêm vào:
    * - String: mã sách
    * - BookInBasketModel: thông tin sách trong giỏ
    */
    private Map<Integer, BookInBasketModel> basket;
    private List<BookInBasketModel> model;
    private Integer totalBook;
    private BasketDAO dao;
    private HttpServletRequest httpRequest;

    public void setServletRequest(HttpServletRequest request) {    
      this.httpRequest = request;
     }

    public Map<Integer, BookInBasketModel> getBasket() {
        return basket;
    }

    public void setBasket(Map<Integer, BookInBasketModel> basket) {
        this.basket = basket;
    }

    public Integer getTotalBook() {
        return totalBook;
    }

    public void setTotalBook(Integer totalBook) {
        this.totalBook = totalBook;
    }
    
    @Override
    public List<BookInBasketModel> getModel() {
        return model;
    }
    
    public void setModel(List<BookInBasketModel> model) {
        this.model = model;
    }
    
    @Override
    public void prepare() throws Exception {
        basket = new HashMap<>();
        totalBook = 0;
        dao = new BasketDAO();
        model = new ArrayList<>();
    }
    
    public String showBasket() {
        String method = httpRequest.getMethod();
        if(method.equals("GET"))
            g_showBasket();
        else p_showBasket();
        
        totalBook = dao.getTotalBook(basket);
        ActionContext.getContext().getSession().put("totalBook", totalBook);
        
        return SUCCESS;
    }
    
    // GET: showBasket
    public void g_showBasket() {
        Object currentBasket = ActionContext.getContext().getSession().get("basket");
        if(currentBasket == null)
            ActionContext.getContext().getSession().put("basket", new HashMap<>());
        else basket = (Map<Integer, BookInBasketModel>) currentBasket;
        
        // thiết lập danh sách sản phẩm có trong session
        model.clear();
        for(Integer bookID: basket.keySet())
            model.add((BookInBasketModel)basket.get(bookID));
    } 
    
    // POST: showBasket
    public void p_showBasket() {
        // thiết lập lại giỏ hàng mới cho session
        basket.clear();
        dao.updateBasket(model);
        dao.setListBookToBasket(model, basket);
        
        // chỉnh sửa giỏ hàng trong CSDL
        boolean isLoggin = ActionContext.getContext().getSession().containsKey("username");
        if(isLoggin) {
            String username = String.valueOf(ActionContext.getContext().getSession().get("username"));
            dao.setListBooksInOrderDetail(model, username);
        }
        
        // thêm giỏ hàng vào session
        ActionContext.getContext().getSession().put("basket", basket);
    }
}
