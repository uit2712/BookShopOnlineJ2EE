/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package action;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.opensymphony.xwork2.Preparable;
import dao.BookDAO;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.ProductsInCategoryModel;

/**
 *
 * @author Administrator
 * Lấy 1 số sản phẩm trong loại sản phẩm
 */
public class GetBooksInCategory  extends ActionSupport
        implements ModelDriven<ProductsInCategoryModel>, Preparable {
    
    private ProductsInCategoryModel proInCateModel;
    private BookDAO dao;
    private String message;
    private Map<String, List> mapBooks;

    public Map<String, List> getMapBooks() {
        return mapBooks;
    }

    public String getMessage() {
        return message;
    }
    
    @Override
    public ProductsInCategoryModel getModel() {
        return proInCateModel;
    }

    @Override
    public void prepare() {
        proInCateModel = new ProductsInCategoryModel();
        dao = new BookDAO();
        message = "";
        mapBooks = new HashMap<String, List>();
    }
    
    public String getProductsInCategory() {
        mapBooks = dao.getProductsInCategory();
        
        return SUCCESS;
    }
}
