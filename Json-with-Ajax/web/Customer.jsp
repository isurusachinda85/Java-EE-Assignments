<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Customer Form</title>
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
                    <button class="btn btn-outline-success btn-sm col m-2" type="submit">SignUp</button>
                    <button class="btn btn-outline-danger btn-sm col m-2" type="submit">LogOut</button>
                </div>
            </div>
        </div>
    </nav>
</header>
<main class="container">
    <section class="row">
        <div class="position-relative  mt-3 mt-lg-2  ">
            <h1 class="text-center bg-info">Customer Manage</h1>
        </div>
        <form class="p-lg-3" id="customerForm">
            <div class="row ">
                <div class="col-12 col-md-6 mt-4">
                    <input aria-label="Customer ID" id="cusId" name="id" class="form-control" placeholder="Customer ID"
                           type="text">
                </div>
                <div class="mt-4 col-12 col-sm-6 col-md-6">
                    <input aria-label="Customer Name" id="cusName" name="name" class="form-control"
                           placeholder="Customer Name" type="text">
                </div>
                <div class="mt-4 col-12 col-sm-6 col-md-6">
                    <input aria-label="Customer Address" id="cusAddress" name="address" class="form-control"
                           placeholder="Customer Address"
                           type="text">
                </div>
                <div class="mt-4 col-12 col-sm-6 col-md-6">
                    <input aria-label="Customer Mobile" id="cusMobile" name="mobile" class="form-control"
                           placeholder="Customer Mobile" type="tel">
                </div>
                <div class="mt-4 col-12 col-sm-6 col-md-6">
                    <input aria-label="Customer Email" id="cusEmail" name="email" class="form-control"
                           placeholder="Customer Email" type="email">
                </div>
            </div>
        </form>
        <div class="mt-3">
            <button class="col-12 col-sm-4 col-md-2 btn btn-outline-primary" id="saveCustomer" type="button">Save
                Customer
            </button>
            <button class="col-12 col-sm-4 col-md-2 btn btn-outline-success" id="updateCustomer" type="button">Update
                Customer
            </button>
            <button class="col-12 col-sm-4 col-md-2 btn btn-outline-secondary" id="getAllCustomer" type="button">Get All
                Customer
            </button>
            <button class="col-12 col-sm-4 col-md-2 btn btn-outline-warning" type="button">Search Customer</button>

            <button class="col-12 col-sm-4 col-md-2 btn btn-outline-danger" id="deleteCustomer" type="button">Delete
                Customer
            </button>
        </div>

        <section class="col-12">
            <table class="table table-striped mt-4 table table-bordered table-hover text-center">
                <thead class="bg-info text-white">
                <tr>
                    <th scope="col">ID</th>
                    <th scope="col">Name</th>
                    <th scope="col">Address</th>
                    <th scope="col">Mobile</th>
                    <th scope="col">Email</th>
                </tr>
                </thead>
                <tbody id="tblCustomer">

                </tbody>
            </table>

        </section>
    </section>

</main>
<script src="asset/js/jquery-3.7.0.min.js"></script>
<script>

    getAllCustomer();

    $("#saveCustomer").click(function () {
        let formDate = $("#customerForm").serialize();
        $.ajax({
            url: "customer",
            method: "post",
            data: formDate,
            dataType:"json",
            success: function (res) {
                alert(res.message);
                getAllCustomer();
            },
            error:function (error) {
                alert(JSON.parse(error.responseText).message);
            }
        });
    });

    $("#deleteCustomer").click(function () {
        let id = $("#cusId").val();
        $.ajax({
            url: "customer?id=" + id,
            method: "post",
            dataType: "json",
            success: function (res) {
                alert(res.message);
                getAllCustomer();
            },
            error:function (error) {
                alert(JSON.parse(error.responseText).message);
            }
        });
    });

    $("#updateCustomer").click(function () {
        let formData = $("#customerForm").serialize();
        $.ajax({
            url: "customer?option=update",
            method: "post",
            data: formData,
            dataType: "json",
            success: function (res) {
                alert(res.message);
                getAllCustomer();
            },
            error:function (error) {
                alert(JSON.parse(error.responseText).message);
            }
        });
    });

    $("#getAllCustomer").click(function () {
        getAllCustomer();
    });

    function getAllCustomer() {
        $("#tblCustomer").empty();
        $.ajax({
            url: "customer",
            success: function (res) {
                for (let c of res.data) {
                    let row = "<tr><td>" + c.id + "</td><td>" + c.name + "</td><td>" + c.address + "</td><td>" + c.mobile + "</td><td>" + c.email + "</td></tr>";
                    $("#tblCustomer").append(row);
                }
                trTextAddTextCustomer();
                clearText();
            }
        });
    }


    function trTextAddTextCustomer() {
        $("#tblCustomer>tr").click(function () {
            let id = $(this).children().eq(0).text();
            let name = $(this).children().eq(1).text();
            let address = $(this).children().eq(2).text();
            let mobile = $(this).children().eq(3).text();
            let email = $(this).children().eq(4).text();

            $("#cusId").val(id);
            $("#cusName").val(name);
            $("#cusAddress").val(address);
            $("#cusMobile").val(mobile);
            $("#cusEmail").val(email);
        });
    }

    function clearText() {
        $("#cusId,#cusName,#cusAddress,#cusMobile,#cusEmail").val("");
        $("#cusId").val("").focus();
    }

</script>
<script src="asset/js/bootstrap.js"></script>
</body>
</html>
