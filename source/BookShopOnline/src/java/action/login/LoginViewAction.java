/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package action.login;

import com.opensymphony.xwork2.ActionSupport;

/**
 *
 * @author Administrator
 * Hiển thị giao diện Đăng nhập lúc đầu, tránh trường hợp validation lúc vừa tải trang
 */
public class LoginViewAction extends ActionSupport {
    
    @Override
    public String execute() {
        return SUCCESS;
    }
}
