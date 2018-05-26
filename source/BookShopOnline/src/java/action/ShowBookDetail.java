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
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import model.BookDetailModel;
import org.apache.struts2.ServletActionContext;

/**
 *
 * @author Administrator
 */
public class ShowBookDetail extends ActionSupport
        implements ModelDriven<BookDetailModel>, Preparable {

    private BookDetailModel book;
    private BookDAO dao;
    private String message;

    public BookDetailModel getBook() {
        return book;
    }

    public String getMessage() {
        return message;
    }
    
    @Override
    public BookDetailModel getModel() {
        return book;
    }

    @Override
    public void prepare() throws Exception {
        dao = new BookDAO();
        book = new BookDetailModel();
        message = "";
    }
    
    public String getBookDetail() { 
        if(!dao.IsBookExists(book.getBookId()))
            return ERROR;
        
        book = dao.getBookDetail(book.getBookId());
        return SUCCESS;
    }
}
