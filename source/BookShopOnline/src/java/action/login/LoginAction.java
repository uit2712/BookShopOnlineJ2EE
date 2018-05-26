/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package action.login;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.opensymphony.xwork2.Preparable;
import dao.UserDAO;
import java.security.NoSuchAlgorithmException;
import model.LoginModel;
import org.apache.struts2.interceptor.validation.SkipValidation;

/**
 *
 * @author Administrator Dùng để kiểm chứng tài khoản khi đăng nhập
 */
public class LoginAction extends ActionSupport
        implements ModelDriven<LoginModel>, Preparable {

    private LoginModel loginModel;
    private UserDAO dao;
    private String message;

    public String getMessage() {
        return message;
    }

    @Override
    public LoginModel getModel() {
        return loginModel;
    }

    @Override
    public void prepare() {
        loginModel = new LoginModel();
        dao = new UserDAO();
        message = "";
    }

    public String login() throws NoSuchAlgorithmException {
        boolean success = dao.login(loginModel);
        if (success) {
            message = "Đăng nhập thành công";
            ActionContext.getContext().getSession().put("username", loginModel.getUsername());
        } else {
            message = "Sai tên người dùng hoặc mật khẩu";
        }
        
        return SUCCESS;
    }

    public String logOff() {
        ActionContext.getContext().getSession().remove("username");
        return SUCCESS;
    }
}
