package servlet;

import db.DBConnection;

import javax.json.Json;
import javax.json.JsonArrayBuilder;
import javax.json.JsonObjectBuilder;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet(urlPatterns = "/customer")
public class CustomerServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        try {
            PreparedStatement st = DBConnection.getInstance().getConnection().prepareStatement("select * from customer");
            ResultSet rst = st.executeQuery();

            JsonArrayBuilder allCustomer = Json.createArrayBuilder();

            while (rst.next()) {
                JsonObjectBuilder customer = Json.createObjectBuilder();
                customer.add("id",rst.getString(1));
                customer.add("name",rst.getString(2));
                customer.add("address",rst.getString(3));
                customer.add("mobile",rst.getString(4));
                customer.add("email",rst.getString(5));

                allCustomer.add(customer.build());
            }

            resp.addHeader("Content-Type","application/json");
            resp.getWriter().print(allCustomer.build());
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        String name = req.getParameter("name");
        String address = req.getParameter("address");
        String mobile = req.getParameter("mobile");
        String email = req.getParameter("email");

        String option = req.getParameter("option");

        PreparedStatement st;

        try {

            switch (option) {
                case "save":
                    st = DBConnection.getInstance().getConnection().prepareStatement("INSERT INTO Customer VALUES (?, ?, ?, ?, ?)");

                    st.setString(1, id);
                    st.setString(2, name);
                    st.setString(3, address);
                    st.setString(4, mobile);
                    st.setString(5, email);
                    if (st.executeUpdate() > 0) {

                    }
                    break;

                case "delete":
                    st = DBConnection.getInstance().getConnection().prepareStatement("delete from Customer where id=?");
                    st.setString(1, id);
                    if (st.executeUpdate() > 0) {

                    }
                    break;

                case "update":
                    st = DBConnection.getInstance().getConnection().prepareStatement("update Customer set name=?,address=?,mobile=?,email=? where id=?");
                    st.setString(5, id);
                    st.setString(1, name);
                    st.setString(2, address);
                    st.setString(3, mobile);
                    st.setString(4, email);
                    if (st.executeUpdate() > 0) {

                    }
                    break;
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

    }
}
