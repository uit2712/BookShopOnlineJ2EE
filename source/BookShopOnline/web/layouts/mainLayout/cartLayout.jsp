<%-- 
    Document   : cartLayout
    Created on : May 9, 2018, 3:22:00 PM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>

<div class="navbar-collapse collapse right" id="basket-overview">
    <s:a action="basketView.action" cssClass="btn btn-primary navbar-btn">
        <i class="fa fa-shopping-cart"></i>
        <s:if test="%{#session.totalBook == null}">
            <span class="hidden-xs">0 sản phẩm</span>
        </s:if> 
        <s:else>
            <span class="hidden-xs"><s:property value='#session.totalBook'/> sản phẩm</span>
        </s:else>
    </s:a>
</div>
