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

@WebServlet(urlPatterns = "/item")
public class ItemServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        try {
            PreparedStatement st = DBConnection.getInstance().getConnection().prepareStatement("select * from item");
            ResultSet rst = st.executeQuery();

            JsonArrayBuilder allItem = Json.createArrayBuilder();

            while (rst.next()) {
                JsonObjectBuilder item = Json.createObjectBuilder();
                item.add("code",rst.getString(1));
                item.add("itemName",rst.getString(2));
                item.add("unitPrice",rst.getDouble(3));
                item.add("qty",rst.getInt(4));

                allItem.add(item.build());
            }

            resp.addHeader("Content-Type","application/json");

            JsonObjectBuilder obj = Json.createObjectBuilder();
            obj.add("state","OK");
            obj.add("message","Successfully loaded......!");
            obj.add("data",allItem.build());

            resp.getWriter().print(obj.build());

        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }


    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String itemCode = req.getParameter("code");
        String itemName = req.getParameter("itemName");


        String option = req.getParameter("option");

        PreparedStatement st;

        try {
            switch (option) {
                case "save":
                    double unitPrice = Double.parseDouble(req.getParameter("unitPrice"));
                    int qty = Integer.parseInt(req.getParameter("qty"));

                    st = DBConnection.getInstance().getConnection().prepareStatement("INSERT INTO item VALUES (?, ?, ?, ?)");
                    st.setString(1, itemCode);
                    st.setString(2, itemName);
                    st.setDouble(3, unitPrice);
                    st.setInt(4, qty);

                    if (st.executeUpdate() > 0) {

                    }
                    break;

                case "update":

                    unitPrice = Double.parseDouble(req.getParameter("unitPrice"));
                    qty = Integer.parseInt(req.getParameter("qty"));

                    st = DBConnection.getInstance().getConnection().prepareStatement("update item set itemName=?,unitPrice=?,qty=? where itemCode=?");
                    st.setString(4, itemCode);
                    st.setString(1, itemName);
                    st.setDouble(2, unitPrice);
                    st.setInt(3, qty);
                    if (st.executeUpdate() > 0) {

                    }
                    break;

                case "delete":
                    st = DBConnection.getInstance().getConnection().prepareStatement("delete from item where itemCode=?");
                    st.setString(1, itemCode);
                    if (st.executeUpdate() > 0) {

                    }
                    break;
            }

        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }
}
