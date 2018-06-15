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
                <s:if test="%{#session.totalBook > 0}">
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
                                <s:iterator value="model" var="book" status="b">
                                    <!--Thiết lập các thuộc tính cho sách-->
                                    <s:hidden name="model[%{#b.index}].bookId" value="%{#book.bookId}"/>
                                    <s:hidden name="model[%{#b.index}].bookName" value="%{#book.bookName}"/>
                                    <s:hidden name="model[%{#b.index}].image" value="%{#book.image}"/>
                                    <s:hidden name="model[%{#b.index}].price" value="%{#book.price}"/>
                                    <tr class="row<s:property value="%{#b.index}"/>">
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
                                                name="model[%{#b.index}].quanlity"
                                                id="quanlity%{#b.index}"
                                                type="number"
                                                value="%{#book.quanlity}"
                                                min="0"
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
                                        <td>
                                            <s:a onclick="removeProduct(%{#b.index})"><i class="fa fa-trash-o"></i></s:a>
                                            <script>
                                                function removeProduct(index) {
                                                    event.preventDefault();
                                                    $(".row" + index).hide(); // ẩn đi sản phẩm được chọn
                                                    $("#quanlity" + index).val(0); // thiết lập số lượng là 0
                                                    $("#quanlity" + index).trigger("change");
                                                    
                                                    var totalBill = 0;
                                                    $(".total-price").each(function () {
                                                        totalBill += parseInt($(this).text().replace(/\./g, '').replace(/\đ/g, '').replace(/\ /g, ''));
                                                    });
                                                    $("#total-bill").text(totalBill.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".") + " đ");
                                                }
                                            </script>
                                        </td>
                                    </tr>
                                </s:iterator>
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
                                <button type="submit" class="btn btn-default"><i class="fa fa-refresh"></i> Cập nhật giỏ hàng</button>
                                <button class="btn btn-primary">Tiến hành đặt hàng <i class="fa fa-chevron-right"></i>
                                </button>
                            </div>
                        </div>
                </s:if>
                <s:else>
                    <div class="text-center">
                        <label>Bạn không có sản phẩm nào trong giỏ.</label>
                        <s:a action="home.action" cssClass="btn btn-default"><i class="fa fa-chevron-right"></i> Tiếp tục mua</s:a>
                    </div>
                </s:else>
            </form>

        </div>
        <!-- /.box -->


    </div>
    <!-- /.col-md-9 -->

    <div class="col-md-3">
        <div class="box" id="order-summary">
            <div class="box-header">
                <h3>Đơn hàng</h3>
            </div>
            <p class="text-muted">Chi phí giao hàng và chi phí bổ sung được tính dựa trên các giá trị bạn đã nhập.</p>

            <div class="table-responsive">
                <table class="table">
                    <tbody>
                        <tr>
                            <td>Tổng tiền các sản phẩm</td>
                            <th><s:label id="total-books-price" value="99.000 đ" theme="simple"/></th>
                        </tr>
                        <tr>
                            <td>Tiền vận chuyển</td>
                            <th>0 đ</th>
                        </tr>
                        <tr class="total">
                            <td>Tổng</td>
                            <th><s:label id="total-order" value="99.000 đ" theme="simple"/></th>
                        </tr>
                    </tbody>
                </table>
            </div>

        </div>
    </div>
    <!-- /.col-md-3 -->

</div>
