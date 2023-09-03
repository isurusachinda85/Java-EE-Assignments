<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Item Form</title>
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
        <div class="position-relative  mt-3 mt-lg-2  ">
            <h1 class="text-center bg-danger">Item Manage</h1>
        </div>
        <form class="p-lg-3" id="itemForm">
            <div class="row ">
                <div class="col-12 col-md-6 mt-4">
                    <input aria-label="Item Code" class="form-control" id="txtCode" name="code" placeholder="Item Code"
                           type="text">
                </div>
                <div class="mt-4 col-12 col-md-6">
                    <input aria-label="Item Name" class="form-control" id="txtItemName" name="itemName"
                           placeholder="Item Name" type="text">
                </div>
                <div class="mt-4 col-12 col-md-6">
                    <input aria-label="Unit Price" class="form-control" id="txtPrice" name="unitPrice"
                           placeholder="Unit Price"
                           type="text">
                </div>
                <div class="mt-4 col-12 col-md-6">
                    <input aria-label="Item Quantity" class="form-control" id="txtQty" name="qty"
                           placeholder="Item Quantity" type="number">
                </div>
            </div>
        </form>
        <div class="mt-3">
            <button class="col-12 col-sm-4 col-md-2 btn btn-outline-primary" id="saveItem" type="button">Save Item
            </button>
            <button class="col-12 col-sm-4 col-md-2 btn btn-outline-success" id="updateItem" type="button">Update Item
            </button>
            <button class="col-12 col-sm-4 col-md-2 btn btn-outline-secondary" id="getAllItem" type="button">Get
                AllItem
            </button>
            <button class="col-12 col-sm-4 col-md-2 btn btn-outline-warning" type="button">Search Item</button>
            <button class="col-12 col-sm-4 col-md-2 btn btn-outline-danger" id="deleteItem" type="button">Delete Item
            </button>
        </div>
        <section>
            <table class="table table-striped mt-5 table table-bordered table-hover text-center">
                <thead class="bg-danger text-white">
                <tr>
                    <th scope="col">Item Code</th>
                    <th scope="col">Item Name</th>
                    <th scope="col">Unit Price</th>
                    <th scope="col">Item Quantity</th>
                </tr>
                </thead>
                <tbody id="tblItem">

                </tbody>
            </table>

        </section>
    </section>

</main>
<script src="asset/js/jquery-3.7.0.min.js"></script>

<script>

    getAllItem();

    $("#saveItem").click(function () {
        let formData = $("#itemForm").serialize();

        $.ajax({
            url: "item?option=save",
            method: "post",
            data: formData,
            dataType:"json",
            success: function (res) {
                alert(res.message);
                getAllItem();
            },
            error:function (error) {
                alert(JSON.parse(error.responseText).message);
            }
        });
    });

    $("#updateItem").click(function () {
        let formData = $("#itemForm").serialize();
        $.ajax({
            url: "item?option=update",
            method: "post",
            data: formData,
            dataType:"json",
            success: function (res) {
                alert(res.message);
                getAllItem();
            },
            error:function (error) {
                alert(JSON.parse(error.responseText).message);
            }
        });
    });

    $("#deleteItem").click(function () {
        let code = $("#txtCode").val();
        $.ajax({
            url: "item?code=" + code + "&option=delete",
            method: "post",
            dataType:"json",
            success: function (res) {
                alert(res.message);
                getAllItem();
            },
            error:function (error) {
                alert(JSON.parse(error.responseText).message);
            }
        });
    });

    $("#getAllItem").click(function () {
        getAllItem();
    });

    function getAllItem() {
        $("#tblItem").empty();
        $.ajax({
            url: "item",
            success: function (res) {
                for (let i of res.data) {
                    let row = "<tr><td>" + i.code + "</td><td>" + i.itemName + "</td><td>" + i.unitPrice + "</td><td>" + i.qty + "</td><tr>";
                    $("#tblItem").append(row);
                }
                trTextAddTextItem();
                clearText();
            }
        });
    }

    function trTextAddTextItem() {
        $("#tblItem>tr").click(function () {
            let code = $(this).children().eq(0).text();
            let itemName = $(this).children().eq(1).text();
            let unitPrice = $(this).children().eq(2).text();
            let qty = $(this).children().eq(3).text();

            $("#txtCode").val(code);
            $("#txtItemName").val(itemName);
            $("#txtPrice").val(unitPrice);
            $("#txtQty").val(qty);
        });
    }

    function clearText() {
        $("#txtCode,#txtItemName,#txtPrice,#txtQty").val("");
        $("#txtCode").focus();
    }

</script>
<script src="asset/js/bootstrap.js"></script>
</body>
</html>
