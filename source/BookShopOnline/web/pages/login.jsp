<%-- 
    Document   : login
    Created on : May 8, 2018, 5:37:37 PM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<style>
    .form-control {
        width: 65%;
    }

    .errorMessage {
        color: red;
    }

    button {
        text-align: center;
    }
</style>

<div class="container">
    <div class="col-md-3"></div>
    <div class="box col-md-6">
        <h1>Đăng nhập</h1>
        <label class="errorMessage"><s:property value="message" /></label>
        <form action="login" method="post">
            <div>
                <div class="form-group">
                    <s:label for="username" value="Tên người dùng (*)" cssClass="col-md-4"/>
                    <s:textfield name="username" cssClass="form-control"/>
                </div>

                <div class="form-group">
                    <s:label for="password" value="Mật khẩu (*)" cssClass="col-md-4"/>
                    <s:password name="password" cssClass="form-control"/>
                </div>

                <div class="text-center">
                    <button type="submit" class="btn btn-primary"><i class="fa fa-user-md"></i>Đăng nhập</button>
                    <a href="./register.jsp" class="btn btn-primary"><i class="fa fa-sign-in"></i>Đăng ký</a>
                </div>
            </div>
        </form>
    </div>
    <div class="col-md-3"></div>
</div>

