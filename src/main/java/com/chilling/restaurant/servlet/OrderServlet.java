package com.chilling.restaurant.servlet;

import com.chilling.restaurant.dao.OrderItemDAO;
import com.chilling.restaurant.dao.OrderListDAO;
import com.chilling.restaurant.model.Meal;
import com.chilling.restaurant.model.MenuItem;
import com.chilling.restaurant.model.OrderItem;
import com.chilling.restaurant.model.OrderList;
import com.chilling.restaurant.model.Table;

import java.io.IOException;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/add-to-order")
public class OrderServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        Table table = (Table) session.getAttribute("table");
        Meal meal = (Meal) session.getAttribute("meal");

        if (table == null) {
            response.sendRedirect("table-login");
            return;
        }

        OrderListDAO orderListDAO = new OrderListDAO();
        OrderItemDAO orderItemDAO = new OrderItemDAO();

        OrderList orderList = orderListDAO.getOrderListById(meal.getOlistId());

        if (orderList == null) {
            try {
                OrderList orderListId = orderListDAO.createOrderList();
            } catch (SQLException ex) {
                Logger.getLogger(OrderServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            
        }

        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        double price = Double.parseDouble(request.getParameter("price"));
        String img = request.getParameter("img");
        int timeCook = Integer.parseInt(request.getParameter("time"));

        MenuItem item = new MenuItem();
        item.setItemId(id);
        item.setItemName(name);
        item.setItemPrice(price);
        item.setItemImgPath(img);
        item.setItemTimeCook(timeCook);

        OrderItem existingItem = orderItemDAO.getOrderItemByListIdAndItemId(orderList.getOrderList_id(), id);

        boolean isPending = "pending".equalsIgnoreCase(orderList.getOrderStatus());

        if (existingItem != null) {
            int previousQuantity = existingItem.getOrderItemQuantity();
            int newQuantity = previousQuantity + 1;

            if (isPending || newQuantity >= previousQuantity) {
                // cho phép cập nhật nếu đơn còn pending hoặc đang tăng số lượng
                existingItem.setOrderItemQuantity(newQuantity);
                orderItemDAO.updateOrderItemQuantity(
                    existingItem.getOrderList_id(),
                    existingItem.getOrderItem_id(),
                    newQuantity
                );
            } else {
                session.setAttribute("error", "Không thể giảm số lượng món đã gọi!");
            }
        } else {
            // Món chưa từng gọi → thêm mới
            OrderItem newItem = new OrderItem(0, orderList.getOrderList_id(), item, 1);
            orderItemDAO.insertOrderItem(newItem);
        }

        List<OrderItem> items = orderItemDAO.getItemsByOrderListId(orderList.getOrderList_id());
        orderList.setItems(items);

        try {
            double totalAmount = orderItemDAO.getTotalAmountByOrderListId(orderList.getOrderList_id());
            session.setAttribute("totalAmount", String.format("%.2f", totalAmount));
        } catch (SQLException ex) {
            Logger.getLogger(OrderServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        session.setAttribute("meal", meal);
        session.setAttribute("orderList", orderList);
        session.setAttribute("orderItems", items);

        response.sendRedirect("table-menu");
    }
}
