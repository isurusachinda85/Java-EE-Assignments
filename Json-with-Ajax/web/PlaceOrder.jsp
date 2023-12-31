<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Place Order Form</title>
    <meta content="width=device-width initial-scale=1 user-scalable=no" name="viewport">
    <link href="asset/css/bootstrap.css" rel="stylesheet">
</head>
<body>
<header>
    <nav class="navbar navbar-expand-lg bg-body-tertiary" data-bs-theme="dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">Pos System</a>
            <button aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation"
                    class="navbar-toggler"
                    data-bs-target="#navbarNav" data-bs-toggle="collapse" type="button">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a aria-current="page" class="nav-link active" href="index.html">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="Customer.jsp">Customer</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="Item.jsp">Item</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="PlaceOrder.jsp">Place Order</a>
                    </li>
                </ul>
                <div class="gap-5 col-2" role="search">
                    <button class="btn btn-outline-success btn-sm col m-2 " type="submit">SignUp</button>
                    <button class="btn btn-outline-danger btn-sm col m-2" type="submit">LogOut</button>
                </div>
            </div>
        </div>
    </nav>
</header>

<main class="container">

    <section class="row">

        <div class="mt-4">
            <h1 class="text-center bg-success text-white">Place Order Form</h1>
        </div>

        <form class="row">
            <div class="mb-3 col-12 col-md-3">
                <label class="form-label" for="orderId">Order ID</label>
                <input class="form-control" id="orderId" type="text">
            </div>
            <div class="mb-3 col-12 col-md-3">
                <label class="form-label" for="orderDate">Order Date</label>
                <input class="form-control" id="orderDate" type="date">
            </div>
            <div class="mb-3 col-12 col-md-3">
                <label class="form-label" for="orderTime">Order Time</label>
                <input class="form-control" id="orderTime" type="time">
            </div>
        </form>


        <form class="row">
            <div class="mb-3 col-6 col-md-3">
                <label class="form-label" for="cusID">Customer ID</label>
                <select class="form-control" id="cusID"></select>
            </div>
            <div class="mb-3 col-6 col-md-3">
                <label class="form-label" for="cusName">Customer Name</label>
                <input class="form-control" id="cusName" type="text">
            </div>
            <div class="mb-3 col-6 col-md-3">
                <label class="form-label" for="cusAddress">Customer Address</label>
                <input class="form-control" id="cusAddress" type="text">
            </div>
            <div class="mb-3 col-6 col-md-3">
                <label class="form-label" for="cusEmail">Customer Mobile</label>
                <input class="form-control" id="cusEmail" type="tel">
            </div>
        </form>

        <form class="row">
            <div class="mb-3 col-6 col-md-3 col-lg-2">
                <label class="form-label" for="itemCode">Item Code</label>
                <select class="form-control" id="itemCode"></select>
            </div>
            <div class="mb-3 col-6 col-md-3 col-lg-2">
                <label class="form-label" for="itemName">Item Name</label>
                <input class="form-control" id="itemName" type="text">
            </div>
            <div class="mb-3 col-6 col-md-3 col-lg-2">
                <label class="form-label" for="unitPrice">Unit Price</label>
                <input class="form-control" id="unitPrice" type="text">
            </div>
            <div class="mb-3 col-6 col-md-3 col-lg-1">
                <label class="form-label" for="category">Category</label>
                <input class="form-control" id="category" type="text">
            </div>
            <div class="mb-3 col-3 col-md-4 col-lg-1">
                <label class="form-label" for="qtyOnHand">QtyOnH</label>
                <input class="form-control" id="qtyOnHand" type="number">
            </div>
            <div class="mb-3 col-3 col-md-4 col-lg-1">
                <label class="form-label" for="orderQty">QTY </label>
                <input class="form-control" id="orderQty" type="number">
            </div>
            <div class=" col-6 col-md-4 col-lg-3">
                <div class="offset-3 m-4 p-2">
                    <button class="btn btn-outline-primary" type="button">Add To Cart</button>
                </div>
            </div>
        </form>

        <section class="col-12 col-md-7 col-lg-8">
            <table class="table table-striped mt-5 table table-bordered table-hover text-center">
                <thead class="bg-success text-white">
                <tr>
                    <th>Item Code</th>
                    <th>Item Name</th>
                    <th>Unit Price</th>
                    <th>Category</th>
                    <th scope="col">Qty</th>
                </tr>
                </thead>
                <tbody>

                </tbody>
            </table>

        </section>

        <section class="col-12 col-md-5 col-lg-4">
            <form class="row">
                <div class="mb-3 col-12 col-lg-8">
                    <label class="form-label" for="total">Sub Total</label>
                    <input class="form-control" id="total" type="text">
                </div>
                <div class="mb-3 col-6 ">
                    <label class="form-label" for="orderDate">Discount</label>
                    <input class="form-control" id="discount" type="text">
                </div>
                <div class="mb-3 col-6 ">
                    <label class="form-label" for="cash">Cash</label>
                    <input class="form-control" id="cash" type="text">
                </div>
                <div class="mb-3 col-5 col-lg-6">
                    <label class="form-label" for="balance">Balance</label>
                    <input class="form-control" id="balance" type="text">
                </div>
                <div class="col-7 mt-2 col-lg-6">
                    <div class="offset-3 mt-4 ">
                        <button class="btn btn-outline-success" type="button">Place Order</button>
                    </div>
                </div>
            </form>
        </section>

    </section>

</main>
<script src="asset/js/bootstrap.js"></script>
</body>
</html>