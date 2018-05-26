<%-- 
    Document   : prodsInCate
    Created on : May 25, 2018, 11:20:17 AM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>
<%
    // Khai báo các biến dùng cho trang này
    String rootPath = request.getContextPath();
%>

<style>
    .product {
        min-height: 300px;
    }

    .front, .back, .product-image {
        min-height: 200px;
        max-height: 200px;
    }
</style>

<div id="hot">
    <s:iterator value="mapBooks">
        <div id="hot">
            <div class="box">
                <div class="container">
                    <div class="col-md-12">
                        <h2><s:property value="key"/></h2>
                    </div>
                </div>
            </div>

            <div class="container">
                <div class="container">
                    <div class="product-slider">
                        <s:iterator value="value" var="book">

                            <div class="item">
                                <div class="product">
                                    <div class="flip-container">
                                        <div class="flipper">
                                            <div class="front">
                                                <s:url action="getBookDetail.action" var="bookDetailUrl">
                                                    <s:param name="bookId" value="%{#book.bookId}"/>
                                                </s:url>
                                                <a href="<s:property value="#bookDetailUrl" />">
                                                    <img src="<%=rootPath%><s:property value="%{#book.image}"/>" alt="" class="img-responsive product-image">
                                                </a>
                                                
                                            </div>

                                            <div class="back">
                                                <a href="<s:property value="#bookDetailUrl" />">
                                                    <img src="<%=rootPath%><s:property value="%{#book.image}"/>" alt="" class="img-responsive product-image">
                                                </a>
                                            </div>

                                        </div>
                                    </div>
                                    <a href="" class="invisible">
                                        <img src="<%=rootPath%><s:property value="%{#book.image}"/>" alt="" class="img-responsive product-image">
                                    </a>

                                    <div class="text">
                                        <h3><a href="<s:property value="#bookDetailUrl" />"><s:property value="%{#book.bookName}"/></a></h3>
                                        <p class="price"><s:property value="%{getText('{0,number,#,##0}',{#book.price})}"/><u>đ</u></p>
                                    </div>
                                    <!-- /.text -->
                                </div>
                                <!-- /.product -->
                            </div>
                        </s:iterator>
                    </div>
                    <!-- /.product-slider -->

                </div>
            </div>
        </div>
    </s:iterator>
    <!-- /.container -->

</div>
