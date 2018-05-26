<%-- 
    Document   : home
    Created on : May 9, 2018, 3:56:57 PM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<%
    // Khai báo các biến dùng cho trang này
    String rootPath = request.getContextPath();
%>

<div class="container">
    <div class="col-md-12">
        <div id="main-slider">
            <div class="item">
                <img src="<%=rootPath%>/images/slides/slide-1.jpg" alt="" class="img-responsive">
            </div>
            <div class="item">
                <img class="img-responsive" src="<%=rootPath%>/images/slides/slide-2.jpg" alt="">
            </div>
            <div class="item">
                <img class="img-responsive" src="<%=rootPath%>/images/slides/slide-3.jpg" alt="">
            </div>
        </div>
        <!-- /#main-slider -->
    </div>
</div>

<!-- *** HOT PRODUCT SLIDESHOW ***
_________________________________________________________ -->

<s:action name="getProductsInCategory" executeResult="true" namespace="/"/>
<!-- /#hot -->

<!-- *** HOT END *** -->


