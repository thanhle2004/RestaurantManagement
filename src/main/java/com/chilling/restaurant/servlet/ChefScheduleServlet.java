package com.chilling.restaurant.servlet;

import com.chilling.restaurant.dao.CookScheduleItemDAO;
import com.chilling.restaurant.dao.CookScheduleListDAO;
import com.chilling.restaurant.dao.OrderItemDAO;
import com.chilling.restaurant.dao.OrderListDAO;
import com.chilling.restaurant.dao.TableDAO;
import com.chilling.restaurant.model.CookScheduleItem;
import com.chilling.restaurant.model.CookScheduleList;
import com.chilling.restaurant.model.OrderItem;
import com.chilling.restaurant.model.OrderList;
import com.chilling.restaurant.model.Table;
import com.chilling.restaurant.model.User;
import com.chilling.restaurant.utils.AuthUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/chef/schedule")
public class ChefScheduleServlet extends HttpServlet {
    private CookScheduleListDAO scheduleListDAO = new CookScheduleListDAO();
    private CookScheduleItemDAO scheduleItemDAO = new CookScheduleItemDAO();
    private OrderItemDAO orderItemDAO = new OrderItemDAO();
    private OrderListDAO orderListDAO = new OrderListDAO();
    private TableDAO tableDAO = new TableDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("ChefScheduleServlet: doGet called for /chef/schedule");

        if (!AuthUtil.checkRole(request, response, "chef")) {
            System.out.println("ChefScheduleServlet: Role check failed");
            return;
        }

        HttpSession session = request.getSession();
        try {
            User chef = (User) session.getAttribute("user");
            System.out.println("ChefScheduleServlet: User from session - " + chef);
            int userId = chef.getUserId();
            System.out.println("ChefScheduleServlet: User ID - " + userId);

            // Lấy tất cả OrderList có status 'pending'
            List<OrderList> orderLists = orderListDAO.getPendingOrderLists();
            System.out.println("ChefScheduleServlet: OrderLists retrieved - " + (orderLists != null ? orderLists.size() : "null"));
            for (OrderList orderList : orderLists) {
                Table table = tableDAO.getTableByOlistId(orderList.getOrderList_id());
                orderList.setTable(table);
                System.out.println("ChefScheduleServlet: Table for OrderList " + orderList.getOrderList_id() + " - " + table);
            }
            request.setAttribute("orderLists", orderLists);

            String olistIdStr = request.getParameter("olistId");
            if (olistIdStr != null) {
                int olistId = Integer.parseInt(olistIdStr);
                System.out.println("ChefScheduleServlet: olistId parameter - " + olistId);
                List<OrderItem> orderItems = orderItemDAO.getItemsByOrderListId(olistId);
                System.out.println("ChefScheduleServlet: OrderItems retrieved - " + (orderItems != null ? orderItems.size() : "null"));
                request.setAttribute("orderItems", orderItems);
                request.setAttribute("selectedOlistId", olistId);

                CookScheduleList schedule = scheduleListDAO.getScheduleByOlistIdAndUserId(olistId, userId);
                System.out.println("ChefScheduleServlet: CookScheduleList retrieved - " + schedule);
                if (schedule == null) {
                    schedule = new CookScheduleList();
                    schedule.setOlistId(olistId);
                    schedule.setUserId(userId);
                    schedule.setStatus("pending");
                    schedule = scheduleListDAO.createSchedule(schedule);
                    System.out.println("ChefScheduleServlet: Created new CookScheduleList - " + schedule);
                }
                request.setAttribute("schedule", schedule);
            }
            session.setAttribute("user", chef);

            System.out.println("ChefScheduleServlet: Forwarding to /chef/schedule.jsp");
            request.getRequestDispatcher("/chef/schedule.jsp").forward(request, response);

        } catch (Exception e) {
            System.err.println("ChefScheduleServlet: Error - " + e.getMessage());
            e.printStackTrace();
            throw new ServletException("Error loading chef schedule: " + e.getMessage(), e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("ChefScheduleServlet: doPost called");

        if (!AuthUtil.checkRole(request, response, "chef")) {
            System.out.println("ChefScheduleServlet: Role check failed in doPost");
            return;
        }

        try {
            String[] scheduleIds = request.getParameterValues("scheduleId[]");
            String[] schlistIds = request.getParameterValues("schlistId[]");
            String[] oitemIds = request.getParameterValues("oitemId[]");
            String[] completionTimes = request.getParameterValues("completionTime[]");
            String[] statuses = request.getParameterValues("status[]");
            int olistId = -1;

            for (int i = 0; i < oitemIds.length; i++) {
                int scheduleId = Integer.parseInt(scheduleIds[i]);
                int schlistId = Integer.parseInt(schlistIds[i]);
                int oitemId = Integer.parseInt(oitemIds[i]);
                int completionTime = 0;
                if (completionTimes[i] != null && !completionTimes[i].isEmpty()) {
                    completionTime = Integer.parseInt(completionTimes[i]);
                }
                String status = statuses[i];

                CookScheduleItem item = new CookScheduleItem();
                item.setScheduleId(scheduleId);
                item.setOitemId(oitemId);
                item.setOitemTimeCook(completionTime);
                item.setStatus(status);

                scheduleItemDAO.updateItem(item);

                if ("completed".equals(status)) {
                    OrderItem orderItem = orderItemDAO.getOrderItemById(oitemId);
                    scheduleItemDAO.updateCompletedQuantity(orderItem.getBaseQuantity(), oitemId);
                }

                CookScheduleList schedule = scheduleListDAO.getScheduleById(schlistId);
                if (schedule == null) {
                    throw new ServletException("Schedule with schlistId " + schlistId + " not found");
                }
                
                olistId = schedule.getOlistId();

                // Cập nhật trạng thái của schedule và orderList nếu cần
                if (scheduleItemDAO.hasCookingStatus(schlistId) || "cooking".equals(status)) {
                    scheduleListDAO.updateStatus(schlistId, "cooking");
                    orderListDAO.updateOrderStatus(olistId, "preparing");
                }

                if (scheduleItemDAO.areAllItemsCompleted(schlistId)) {
                    scheduleListDAO.updateStatus(schlistId, "completed");
                    orderListDAO.updateOrderStatus(olistId, "served");
                }
            }

            System.out.println("ChefScheduleServlet: Redirecting after successful update");
            response.sendRedirect("schedule?success=true&olistId=" + olistId);

        } catch (Exception e) {
            System.err.println("ChefScheduleServlet: Error in doPost - " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Update failed: " + e.getMessage());
            doGet(request, response);
        }
    }
}