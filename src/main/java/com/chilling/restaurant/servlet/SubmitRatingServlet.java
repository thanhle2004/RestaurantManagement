package com.chilling.restaurant.servlet;

import com.chilling.restaurant.dao.MealDAO;
import com.chilling.restaurant.dao.RateDAO;
import com.chilling.restaurant.model.Meal;
import com.chilling.restaurant.model.Rate;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/submit-rating")
public class SubmitRatingServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Meal meal = (Meal) session.getAttribute("meal");
        LocalDateTime now = LocalDateTime.now();
        int rate_value = Integer.parseInt(request.getParameter("rate_value"));
        String comment = request.getParameter("comment");

        RateDAO rateDAO = new RateDAO();
        MealDAO mealDAO = new MealDAO();
        try {
            meal.setRateId(rateDAO.createRate(rate_value, comment));
            meal.setEndTime(now);
            mealDAO.updateMeal(meal);
        } catch (SQLException ex) {
            Logger.getLogger(SubmitRatingServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        response.sendRedirect("/restaurant/table/thank-you.jsp");
        
    }
}
