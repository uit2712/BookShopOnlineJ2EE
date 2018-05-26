<%-- 
    Document   : Register
    Created on : May 8, 2018, 5:36:30 PM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>

<style>
    .form-control {
        width: 65%;
    }

    .errorMessage {
        color: red;
    }

    #register-msg {
        color: green;
    }
</style>

<div class="container">
    <div class="col-md-3"></div>
    <div class="box col-md-6">
        <h1>Đăng ký</h1>
        <label id="register-msg"><s:property value="message" /></label>
        <form action="register" method="post">
            <div>
                <div class="form-group">
                    <s:label for="name" value="Họ tên (*)" cssClass="col-md-4"/>
                    <s:textfield name="name" cssClass="form-control"/>
                </div>

                <div class="form-group">
                    <s:label for="email" value="Email" cssClass="col-md-4"/>
                    <s:textfield name="email" cssClass="form-control"/>
                </div>

                <div class="form-group">
                    <s:label for="address" value="Địa chỉ (*)" cssClass="col-md-4"/>
                    <s:textfield name="address" cssClass="form-control"/>
                </div>

                <div class="form-group">
                    <s:label for="phone" value="Số điện thoại (*)" cssClass="col-md-4"/>
                    <s:textfield name="phone" cssClass="form-control"/>
                </div>

                <div class="form-group">
                    <s:label for="username" value="Tên người dùng (*)" cssClass="col-md-4"/>
                    <s:textfield name="username" cssClass="form-control"/>
                </div>

                <div class="form-group">
                    <s:label for="password" value="Mật khẩu (*)" cssClass="col-md-4"/>
                    <s:password name="password" cssClass="form-control"/>
                </div>

                <div class="form-group">
                    <s:label for="confirmPassword" value="Nhập lại mật khẩu (*)" cssClass="col-md-4"/>
                    <s:password name="confirmPassword" cssClass="form-control"/>
                </div>

                <div class="text-center">
                    <button type="submit" class="btn btn-primary"><i class="fa fa-sign-in"></i>Đăng ký</button>
                </div>
            </div>
        </form>
    </div>
    <div class="col-md-3"></div>
</div>

