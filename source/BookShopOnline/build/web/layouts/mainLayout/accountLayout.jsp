<%-- 
    Document   : loginLayout
    Created on : May 8, 2018, 8:04:14 PM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<ul class="menu">
    <s:if test="%{#session.username == false}">
        <li>hahaha</li>
    </s:if>
    <s:if test="%{#session.username == null}">
        <li>
            <s:a action="login-view.action">Đăng nhập</s:a>
        </li>
        <li>
            <s:a action="register-view.action">Đăng ký</s:a>
        </li>
    </s:if>
    <s:else>
        <li>
            <a href="">Xin chào, <s:property value='#session.username'/></a>
        </li>
        <li>
            <s:a action="logOff">Đăng xuất</s:a>
        </li>
    </s:else>
    <li><a href="contact.html">Contact</a>
    </li>
    <li><a href="#">Recently viewed</a>
    </li>
</ul>
