package com.chilling.restaurant.servlet;

import com.chilling.restaurant.dao.CookScheduleItemDAO;
import com.chilling.restaurant.dao.CookScheduleListDAO;
import com.chilling.restaurant.dao.OrderItemDAO;
import com.chilling.restaurant.dao.OrderListDAO;
import com.chilling.restaurant.model.OrderItem;
import com.chilling.restaurant.model.OrderList;
import java.io.IOException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.HashSet;
import java.util.Set;

@WebServlet("/update-quantity")
public class UpdateQuantityServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int oitem_id = Integer.parseInt(request.getParameter("id"));
        String action = request.getParameter("action");

        HttpSession session = request.getSession();
        OrderList orderList = (OrderList) session.getAttribute("orderList");
        CookScheduleItemDAO cookScheduleItemDAO = new CookScheduleItemDAO();
        CookScheduleListDAO cookScheduleListDAO = new CookScheduleListDAO();
        OrderItemDAO orderItemDAO = new OrderItemDAO();

        if (orderList != null) {
            int olist_id = orderList.getOrderList_id();
            boolean isPending = !cookScheduleItemDAO.hasCookingStatus(olist_id);

            OrderItemDAO dao = new OrderItemDAO();
            OrderItem item = dao.getOrderItemById(oitem_id);

            if (item != null) {
                int quantity = item.getOrderItemQuantity();

                if ("increase".equals(action)) {
                    quantity++;
                } else if ("decrease".equals(action)) {
                    if (quantity > 1) {
                        quantity--;
                    } else {
                        if(cookScheduleListDAO.getScheduleByOlistId(olist_id) != null) {
                            cookScheduleItemDAO.deleteCookScheduleItem(cookScheduleListDAO.getScheduleListIdByOlistId(olist_id), oitem_id);
                        }
                        orderItemDAO.deleteOrderItem(olist_id, oitem_id);
                    }
                }

                dao.updateOrderItemQuantity(olist_id, oitem_id, quantity);
            }
        }

        response.sendRedirect("table-menu");
    }
}
