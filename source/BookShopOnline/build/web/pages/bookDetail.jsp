<%-- 
    Document   : bookDetail
    Created on : May 26, 2018, 9:12:21 AM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>

<%
    // Khai báo các biến dùng cho trang này
    String rootPath = request.getContextPath();
%>

<style>
    .thumb {
        max-width: 100%;
        height: auto;
    }

    #productMain {
        padding: 30px;
    }

    .price {
        font-size: 30px;
        font-weight: 300;
        text-align: center;
        margin-top: 40px;
    }

    .required {
        color: red;
    }

    .form-control {
        width: 65%;
    }

    .errorMessage {
        color: red;
    }
</style>

<div class="container">
    <div class="row">
        <div class="col-md-9">
            <div class="row box" id="productMain">
                <form action="addBooksToBasket.action" method="post">
                    <s:hidden name="bookId" value="%{book.bookId}"/>
                    <s:hidden name="image" value="%{book.image}"/>
                    <s:hidden name="bookName" value="%{book.bookName}"/>
                    <s:hidden name="price" value="%{book.price}"/>
                    
                    <div class="col-sm-6">
                        <div id="mainImage">
                            <img src="<%=rootPath%><s:property value="book.image" />" alt="" class="img-responsive">
                        </div>
                    </div>
                    <div class="col-sm-6 text-center">
                        <div class="box">
                            <h1 class="text-center"><s:property value="book.bookName" /></h1>
                            <p class="goToDescription">
                                <a href="#details" class="scroll-to">Mô tả</a>
                            </p>
                            <p class="price"><s:property value="%{getText('{0,number,#,##0}',{book.price})}"/>đ</p>
                            <div class="form-group">
                                <s:label for="quanlity" value="Số lượng" cssClass="col-md-4"/>
                                <s:textfield type="number" name="quanlity" value="%{book.quanlity}" cssClass="form-control"/>
                            </div>

                            <p class="text-center buttons">
                                <button type="submit" class="btn btn-primary"><i class="fa fa-shopping-cart"></i> Thêm vào giỏ</button>
                                <a href="basket.html" class="btn btn-default"><i class="fa fa-heart"></i> Thêm vào wishlist</a>
                            </p>


                        </div>

                        <div class="row">
                            <div class="col-xs-4">
                                <a href="">
                                    <img src="<%=rootPath%><s:property value="book.image" />" alt="" class="img-responsive">
                                </a>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <div class="col-md-3">

        </div>
    </div>

    <div class="box col-xs-12" id="details">
        <h4>Chi tiết sản phẩm</h4>
        <span><s:property value="book.describe"/></span>

        <hr>
        <div class="social">
            <h4>Chia sẻ cho bạn bè</h4>
            <p>
                <a href="#" class="external facebook" data-animate-hover="pulse"><i class="fa fa-facebook"></i></a>
                <a href="#" class="external gplus" data-animate-hover="pulse"><i class="fa fa-google-plus"></i></a>
                <a href="#" class="external twitter" data-animate-hover="pulse"><i class="fa fa-twitter"></i></a>
                <a href="#" class="email" data-animate-hover="pulse"><i class="fa fa-envelope"></i></a>
            </p>
        </div>
    </div> 
</div>

