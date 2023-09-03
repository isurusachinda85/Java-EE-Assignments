package servlet;

import db.DBConnection;

import javax.json.*;
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
            JsonObjectBuilder error = Json.createObjectBuilder();
            error.add("state", "Error");
            error.add("message", e.getMessage());
            error.add("data", "");
            resp.setStatus(400);
            resp.getWriter().print(error.build());
        } catch (ClassNotFoundException e) {
            JsonObjectBuilder error = Json.createObjectBuilder();
            error.add("state", "Error");
            error.add("message", e.getMessage());
            error.add("data", "");
            resp.setStatus(400);
            resp.getWriter().print(error.build());
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        try {
            PreparedStatement st = DBConnection.getInstance().getConnection().prepareStatement("INSERT INTO item VALUES (?, ?, ?, ?)");
            st.setString(1, req.getParameter("code"));
            st.setString(2, req.getParameter("itemName"));
            st.setDouble(3, Double.parseDouble(req.getParameter("unitPrice")));
            st.setInt(4, Integer.parseInt(req.getParameter("qty")));

            if (st.executeUpdate() > 0) {
                JsonObjectBuilder responseObject = Json.createObjectBuilder();
                responseObject.add("state", "OK");
                responseObject.add("message", "Item Save Successfully.... ");
                responseObject.add("data", "");
                resp.getWriter().print(responseObject.build());
            }
        } catch (SQLException | ClassNotFoundException e) {
            JsonObjectBuilder error = Json.createObjectBuilder();
            error.add("state", "Error");
            error.add("message", e.getMessage());
            error.add("data", "");
            resp.setStatus(400);
            resp.getWriter().print(error.build());
        }

        /*String option = req.getParameter("option");



                case "update":

                    unitPrice = Double.parseDouble(req.getParameter("unitPrice"));
                    qty = Integer.parseInt(req.getParameter("qty"));

                    st = DBConnection.getInstance().getConnection().prepareStatement("update item set itemName=?,unitPrice=?,qty=? where itemCode=?");
                    st.setString(4, itemCode);
                    st.setString(1, itemName);
                    st.setDouble(2, unitPrice);
                    st.setInt(3, qty);
                    if (st.executeUpdate() > 0) {
                        JsonObjectBuilder responseObject = Json.createObjectBuilder();
                        responseObject.add("state", "OK");
                        responseObject.add("message", "Item Update Successfully.... ");
                        responseObject.add("data", "");
                        resp.getWriter().print(responseObject.build());
                    }else {
                        throw new RuntimeException("Wrong ID,Please Check The ID.....!");
                    }
                    break;

                case "delete":
                    st = DBConnection.getInstance().getConnection().prepareStatement("delete from item where itemCode=?");
                    st.setString(1, itemCode);
                    if (st.executeUpdate() > 0) {
                        JsonObjectBuilder responseObject = Json.createObjectBuilder();
                        responseObject.add("state", "OK");
                        responseObject.add("message", "Item Delete Successfully.... ");
                        responseObject.add("data", "");
                        resp.getWriter().print(responseObject.build());
                    }else {
                        throw new RuntimeException("There is no such customer for that ID...!");
                    }
                    break;
            }

        } catch (SQLException | ClassNotFoundException e) {
            JsonObjectBuilder error = Json.createObjectBuilder();
            error.add("state", "Error");
            error.add("message", e.getMessage());
            error.add("data", "");
            resp.setStatus(400);
            resp.getWriter().print(error.build());
        }catch (RuntimeException e) {
            JsonObjectBuilder error = Json.createObjectBuilder();
            error.add("state", "Error");
            error.add("message", e.getMessage());
            error.add("data", "");
            resp.setStatus(400);
            resp.getWriter().print(error.build());
        }*/
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        try {
            PreparedStatement st = DBConnection.getInstance().getConnection().prepareStatement("delete from item where itemCode=?");
            st.setString(1, req.getParameter("code"));
            if (st.executeUpdate() > 0) {
                JsonObjectBuilder responseObject = Json.createObjectBuilder();
                responseObject.add("state", "OK");
                responseObject.add("message", "Item Delete Successfully.... ");
                responseObject.add("data", "");
                resp.getWriter().print(responseObject.build());
            }else {
                throw new RuntimeException("There is no such customer for that ID...!");
            }
        } catch (SQLException | ClassNotFoundException e) {
            JsonObjectBuilder error = Json.createObjectBuilder();
            error.add("state", "Error");
            error.add("message", e.getMessage());
            error.add("data", "");
            resp.setStatus(400);
            resp.getWriter().print(error.build());
        }catch (RuntimeException e) {
            JsonObjectBuilder error = Json.createObjectBuilder();
            error.add("state", "Error");
            error.add("message", e.getMessage());
            error.add("data", "");
            resp.setStatus(400);
            resp.getWriter().print(error.build());
        }
    }

    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        JsonReader reader = Json.createReader(req.getReader());
        JsonObject item = reader.readObject();

        try {
            PreparedStatement st = DBConnection.getInstance().getConnection().prepareStatement("update item set itemName=?,unitPrice=?,qty=? where itemCode=?");
            st.setString(4, item.getString("code"));
            st.setString(1, item.getString("itemName"));
            st.setDouble(2, Double.parseDouble(item.getString("unitPrice")));
            st.setInt(3, Integer.parseInt(item.getString("qty")));

            if (st.executeUpdate() > 0) {
                JsonObjectBuilder responseObject = Json.createObjectBuilder();
                responseObject.add("state", "OK");
                responseObject.add("message", "Item Update Successfully.... ");
                responseObject.add("data", "");
                resp.getWriter().print(responseObject.build());
            }else {
                throw new RuntimeException("Wrong ID,Please Check The ID.....!");
            }
        } catch (SQLException | ClassNotFoundException e) {
            JsonObjectBuilder error = Json.createObjectBuilder();
            error.add("state", "Error");
            error.add("message", e.getMessage());
            error.add("data", "");
            resp.setStatus(400);
            resp.getWriter().print(error.build());
        }catch (RuntimeException e) {
            JsonObjectBuilder error = Json.createObjectBuilder();
            error.add("state", "Error");
            error.add("message", e.getMessage());
            error.add("data", "");
            resp.setStatus(400);
            resp.getWriter().print(error.build());
        }
    }
}
