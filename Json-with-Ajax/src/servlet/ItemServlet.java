package servlet;

import db.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet(urlPatterns = "/item")
public class ItemServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

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
