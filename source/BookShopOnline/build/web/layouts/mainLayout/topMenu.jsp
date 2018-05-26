<%-- 
    Document   : topMenu
    Created on : May 24, 2018, 10:04:20 AM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>

<div class="navbar-collapse collapse" id="navigation">
    <ul class="nav navbar-nav navbar-left">
        <li class="active">
            <a href="index.html">Trang chủ</a>
        </li>
        <s:iterator value="lstCategory">
            <li>
                <a href="index.html"><s:property value="categoryName"/></a>
            </li>
        </s:iterator>
    </ul>
</div>
