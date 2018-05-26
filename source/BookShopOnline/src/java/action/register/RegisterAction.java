/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package action.register;

import static com.opensymphony.xwork2.Action.SUCCESS;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.opensymphony.xwork2.Preparable;
import dao.UserDAO;
import java.security.NoSuchAlgorithmException;
import model.RegisterModel;

/**
 *
 * @author Administrator
 * Dùng để thực hiện hành động đăng ký tài khoản
 */
public class RegisterAction extends ActionSupport
        implements ModelDriven<RegisterModel>, Preparable {

    private RegisterModel registerModel;
    private UserDAO dao;
    private String message;

    public String getMessage() {
        return message;
    }

    @Override
    public void prepare() {
        registerModel = new RegisterModel();
        dao = new UserDAO();
        message = "";
    }

    @Override
    public RegisterModel getModel() {
        return registerModel;
    }

    public RegisterModel getRegisterModel() {
        return registerModel;
    }

    public void setRegisterModel(RegisterModel registerModel) {
        this.registerModel = registerModel;
    }
    
    @Override
    public String execute() {
        return SUCCESS;
    }

    // add method
    public String register() throws NoSuchAlgorithmException {
        // message = "Add method executed";
        boolean addUser = dao.register(registerModel);
        if (addUser) {
            message = "Thêm người dùng " + registerModel.getUsername() + " thành công";
        } else {
            message = "Thêm người dùng thất bại";
        }
        return SUCCESS;
    }

    @Override
    public void validate() {
        //<editor-fold defaultstate="collapsed" desc=" Kiểm tra đầu vào tên người dùng ">
        //</editor-fold>
        if (this.dao.IsExistsUser(registerModel.getUsername()))
            addFieldError("username", getText("username.exists"));
        
        if(!registerModel.getConfirmPassword().equals(registerModel.getPassword()))
            addFieldError("confirmPassword", getText("password.notmatch"));
        
    }
}
