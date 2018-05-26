/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package action;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.opensymphony.xwork2.Preparable;
import dao.CategoryDAO;
import entity.Category;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Administrator
 * Lấy tất cả các loại sách hiện có để hiển thị trên thanh menu
 */
public class GetCategoryAction extends ActionSupport
    implements ModelDriven<Category>, Preparable {
    private Category category;
    private CategoryDAO dao;
    private String message;
    private List<Category> lstCategory;

    public List<Category> getLstCategory() {
        return lstCategory;
    }
    
    public String getMessage() {
        return message;
    }
    
    @Override
    public Category getModel() {
        return category;
    }

    @Override
    public void prepare() {
        category = new Category();
        dao = new CategoryDAO();
        message = "fdsfdsfsd";
        lstCategory = new ArrayList<>();
    }
    
    public String getCategory() {
        lstCategory = dao.getAllCategory();
        message = "hahaha";
        return SUCCESS;
    }
}
