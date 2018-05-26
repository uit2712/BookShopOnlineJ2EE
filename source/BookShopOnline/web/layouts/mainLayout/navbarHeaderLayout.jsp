<%-- 
    Document   : navbarHeaderLayout
    Created on : May 8, 2018, 8:04:22 PM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Khai báo các biến dùng cho trang này
    String rootPath = request.getContextPath();
%>

<div class="navbar-header">

    <a class="navbar-brand home" href="index.jsp" data-animate-hover="bounce">
        <img src="<%=rootPath%>/images/logo.png" alt="Obaju logo" class="hidden-xs">
        <img src="<%=rootPath%>/images/logo-small.png" alt="Obaju logo" class="visible-xs"><span class="sr-only">Obaju - go to homepage</span>
    </a>
    <div class="navbar-buttons">
        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navigation">
            <span class="sr-only">Toggle navigation</span>
            <i class="fa fa-align-justify"></i>
        </button>
        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#search">
            <span class="sr-only">Toggle search</span>
            <i class="fa fa-search"></i>
        </button>
        <a class="btn btn-default navbar-toggle" href="basket.html">
            <i class="fa fa-shopping-cart"></i>  <span class="hidden-xs">3 items in cart</span>
        </a>
    </div>
</div>
