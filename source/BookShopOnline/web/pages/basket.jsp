<%-- 
    Document   : basket
    Created on : May 27, 2018, 12:48:50 AM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags" %>

<%
    // Khai báo các biến dùng cho trang này
    String rootPath = request.getContextPath();
%>

<style>
    #quanlity {
        width: 75px;
    }
</style>

<div class="container">

    <div class="col-md-12">
        <ul class="breadcrumb">
            <li><a href="#">Trang chủ</a>
            </li>
            <li>Giỏ hàng</li>
        </ul>
    </div>

    <div class="col-md-9" id="basket">

        <div class="box">

            <form method="post" action="basketView.action" onkeydown="return event.keyCode != 13">

                <h1>Giỏ hàng</h1>
                <p class="text-muted">Bạn hiện có <b><u><s:property value="totalBook"/></u></b> cuốn sách trong giỏ.</p>
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Ảnh bìa</th>
                                <th>Tên sách</th>
                                <th>Số lượng</th>
                                <th>Giá</th>
                                <th>Tổng tiền</th>
                                <th>Xóa</th>
                            </tr>
                        </thead>
                        <tbody>
                            <s:if test="%{#session.basket != null}">
                                <s:iterator value="lstProducts" var="book" status="b">
                                    <!--Thiết lập các thuộc tính cho sách-->
                                    <s:hidden name="lstProducts[%{#b.index}].bookId" value="%{#book.bookId}"/>
                                    <s:hidden name="lstProducts[%{#b.index}].bookName" value="%{#book.bookName}"/>
                                    <s:hidden name="lstProducts[%{#b.index}].image" value="%{#book.image}"/>
                                    <s:hidden name="lstProducts[%{#b.index}].price" value="%{#book.price}"/>
                                    <tr>
                                        <td>
                                            <a href="#">
                                                <img src="<%=rootPath%><s:property value="%{#book.image}"/>" alt="<s:property value="%{#book.bookName}"/>">
                                            </a>
                                        </td>
                                        <td>
                                            <s:url action="getBookDetail.action" var="bookDetailUrl">
                                                <s:param name="bookId" value="%{#book.bookId}"/>
                                            </s:url>
                                            <a href="<s:property value="#bookDetailUrl" />"><s:property value="%{#book.bookName}"/></a>
                                        </td>
                                        <td>
                                            <s:textfield
                                                cssStyle="width: 70px;"
                                                theme="simple"
                                                name="lstProducts[%{#b.index}].quanlity"
                                                type="number"
                                                value="%{#book.quanlity}"
                                                cssClass="form-control"
                                                onchange="onchangeQuanlity($(this).val(), %{#book.price}, %{#book.bookId})"
                                                oninput="onchangeQuanlity($(this).val(), %{#book.price}, %{#book.bookId})"/>
                                        </td>
                                        <td><s:property value="%{getText('{0,number,#,##0}',{#book.price})}"/> đ</td>
                                        <td>
                                            <s:label id="%{'total-price' + #book.bookId}" cssClass="total-price" value="%{getText('{0,number,#,##0}',{#book.price * #book.quanlity})} đ" theme="simple"/>
                                            <script>
                                                function onchangeQuanlity(quanlity, price, bookID) {
                                                    var totalPrice = price * quanlity;
                                                    $("#total-price" + bookID).text(totalPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".") + " đ");

                                                    var totalBill = 0;
                                                    $(".total-price").each(function () {
                                                        totalBill += parseInt($(this).text().replace(/\./g, '').replace(/\đ/g, '').replace(/\ /g, ''));
                                                    });
                                                    $("#total-bill").text(totalBill.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".") + " đ");
                                                }
                                            </script>
                                        </td>
                                        <td><a href="#"><i class="fa fa-trash-o"></i></a>
                                        </td>
                                    </tr>

                                </s:iterator>
                            </s:if>
                            <s:else>
                            <label>Bạn không có sản phẩm nào trong giỏ. Tiếp tục đặt hàng</label>
                        </s:else>
                        </tbody>
                        <tfoot>
                            <tr>
                                <th colspan="4">Tổng</th>
                                <th colspan="2">
                                    <s:label id="total-bill" value="99.000 đ" theme="simple"/>
                                </th>
                            </tr>
                        </tfoot>
                    </table>

                </div>
                <!-- /.table-responsive -->

                <div class="box-footer">
                    <div class="pull-left">
                        <s:a action="home.action" cssClass="btn btn-default"><i class="fa fa-chevron-left"></i> Tiếp tục mua</s:a>
                    </div>
                    <div class="pull-right">
                        <button class="btn btn-default"><i class="fa fa-refresh"></i> Update basket</button>
                        <button type="submit" class="btn btn-primary">Proceed to checkout <i class="fa fa-chevron-right"></i>
                        </button>
                    </div>
                </div>

            </form>

        </div>
        <!-- /.box -->


    </div>
    <!-- /.col-md-9 -->

    <div class="col-md-3">
        <div class="box" id="order-summary">
            <div class="box-header">
                <h3>Order summary</h3>
            </div>
            <p class="text-muted">Shipping and additional costs are calculated based on the values you have entered.</p>

            <div class="table-responsive">
                <table class="table">
                    <tbody>
                        <tr>
                            <td>Order subtotal</td>
                            <th>$446.00</th>
                        </tr>
                        <tr>
                            <td>Shipping and handling</td>
                            <th>$10.00</th>
                        </tr>
                        <tr>
                            <td>Tax</td>
                            <th>$0.00</th>
                        </tr>
                        <tr class="total">
                            <td>Total</td>
                            <th>$456.00</th>
                        </tr>
                    </tbody>
                </table>
            </div>

        </div>


        <div class="box">
            <div class="box-header">
                <h4>Coupon code</h4>
            </div>
            <p class="text-muted">If you have a coupon code, please enter it in the box below.</p>
            <form>
                <div class="input-group">

                    <input type="text" class="form-control">

                    <span class="input-group-btn">

                        <button class="btn btn-primary" type="button"><i class="fa fa-gift"></i></button>

                    </span>
                </div>
                <!-- /input-group -->
            </form>
        </div>

    </div>
    <!-- /.col-md-3 -->

</div>
