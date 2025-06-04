<%@ page import="java.util.*, com.chilling.restaurant.model.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/includes/check-manager.jsp" %>
<%
    int currentPage = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
    int recordsPerPage = 10;
    
    List<Meal> meals = (List<Meal>) request.getAttribute("meals");
    List<Meal> mealsToDisplay = new ArrayList<>();
    
    if (meals != null && !meals.isEmpty()) {
        int startIndex = (currentPage - 1) * recordsPerPage;
        int endIndex = Math.min(startIndex + recordsPerPage, meals.size());
        mealsToDisplay = meals.subList(startIndex, endIndex);
    }
    
    int totalPages = meals != null ? (int) Math.ceil((double) meals.size() / recordsPerPage) : 0;
%>
<html>
<head>
    <title>Meal Records</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/view-record-style/styles14.css"/>
    <link rel="icon" href="../assets/logo.png"/>
    <script>
        function enterFullScreen() {
            const elem = document.documentElement; 

            if (elem.requestFullscreen) {
              elem.requestFullscreen();
            } else if (elem.webkitRequestFullscreen) { 
              elem.webkitRequestFullscreen();
            } else if (elem.msRequestFullscreen) { 
              elem.msRequestFullscreen();
            }
        }

        function exitFullScreen() {
            if (document.exitFullscreen) {
              document.exitFullscreen();
            } else if (document.webkitExitFullscreen) { 
              document.webkitExitFullscreen();
            } else if (document.msExitFullscreen) { 
              document.msExitFullscreen();
            }
        }
        
        function smoothScrollTo(element, duration) {
            const start = window.pageYOffset;
            const targetPosition = element.getBoundingClientRect().top + window.pageYOffset;
            const startTime = performance.now();

            function scrollAnimation(currentTime) {
                const elapsedTime = currentTime - startTime;
                const progress = Math.min(elapsedTime / duration, 1); 
                const ease = progress * (2 - progress); 
                window.scrollTo(0, start + (targetPosition - start) * ease);

                if (progress < 1) {
                    requestAnimationFrame(scrollAnimation);
                }
            }

            requestAnimationFrame(scrollAnimation);
        }

        window.onload = function () {
            const orderListSection = document.getElementById('order-list');
            if (orderListSection) {
                setTimeout(() => {
                    smoothScrollTo(orderListSection, 200);
                }, 100);
            }
        };
    </script>
</head>

<body>
    <div class="container">
            <%
        String message = request.getParameter("message");
        String error = request.getParameter("error");
    %>
    <aside class="sidebar">
        <a href="<%= request.getContextPath() %>/manager/home.jsp" class="sidebar-link"><svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 -960 960 960" width="24px" fill="#e3e3e3"><path d="m140-220-60-60 300-300 160 160 284-320 56 56-340 384-160-160-240 240Z"/></svg>Home</a>
        <a href="menu-management" class="sidebar-link"><svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 -960 960 960" width="24px" fill="#e3e3e3"><path d="M160-120q-33 0-56.5-23.5T80-200v-120h800v120q0 33-23.5 56.5T800-120H160Zm0-120v40h640v-40H160Zm320-180q-36 0-57 20t-77 20q-56 0-76-20t-56-20q-36 0-57 20t-77 20v-80q36 0 57-20t77-20q56 0 76 20t56 20q36 0 57-20t77-20q56 0 77 20t57 20q36 0 56-20t76-20q56 0 79 20t55 20v80q-56 0-75-20t-55-20q-36 0-58 20t-78 20q-56 0-77-20t-57-20ZM80-560v-40q0-115 108.5-177.5T480-840q183 0 291.5 62.5T880-600v40H80Zm400-200q-124 0-207.5 31T166-640h628q-23-58-106.5-89T480-760Zm0 520Zm0-400Z"/></svg> Menu</a>
        <a href="chef-management" class="sidebar-link"><svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 -960 960 960" width="24px" fill="#e3e3e3"><path d="M360-400h80v-200h-80v200Zm-160-60q-46-23-73-66.5T100-621q0-75 51.5-127T278-800q12 0 24.5 2t24.5 5q25-41 65-64t88-23q48 0 88 23t65 64q12-3 24-5t25-2q75 0 126.5 52T860-621q0 51-27 94.5T760-460v220H200v-220Zm320 60h80v-200h-80v200Zm-240 80h400v-189l44-22q26-13 41-36.5t15-52.5q0-42-28.5-71T682-720q-11 0-20 2t-19 5l-47 13-31-52q-14-23-36.5-35.5T480-800q-26 0-48.5 12.5T395-752l-31 52-48-13q-10-2-19.5-4.5T277-720q-41 0-69 29t-28 71q0 29 15 52.5t41 36.5l44 22v189Zm-80 80h80v80h400v-80h80v160H200v-160Zm280-80Z"/></svg>Chefs</a>        
        <a href="table-management" class="sidebar-link"><svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 -960 960 960" width="24px" fill="#e3e3e3"><path d="M173-600h614l-34-120H208l-35 120Zm307-60Zm192 140H289l-11 80h404l-10-80ZM160-160l49-360h-89q-20 0-31.5-16T82-571l57-200q4-13 14-21t24-8h606q14 0 24 8t14 21l57 200q5 19-6.5 35T840-520h-88l48 360h-80l-27-200H267l-27 200h-80Z"/></svg>Tables</a>                
        <a href="view-record" class="sidebar-link-active"><svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 -960 960 960" width="24px" fill="#e3e3e3"><path d="M612-292 440-464v-216h80v184l148 148-56 56Zm-498-25q-13-29-21-60t-11-63h81q3 21 8.5 42t13.5 41l-71 40ZM82-520q3-32 11-63.5t22-60.5l70 40q-8 20-13.5 41t-8.5 43H82Zm165 366q-27-20-50-43.5T154-248l70-40q14 18 29.5 33.5T287-225l-40 71Zm-22-519-71-40q20-27 43-50t50-43l40 71q-17 14-32.5 29.5T225-673ZM440-82q-32-3-63.5-11T316-115l40-70q20 8 41 13.5t43 8.5v81Zm-84-693-40-70q29-14 60.5-22t63.5-11v81q-22 3-43 8.5T356-775ZM520-82v-81q22-3 43-8.5t41-13.5l40 70q-29 14-60.5 22T520-82Zm84-693q-20-8-41-13.5t-43-8.5v-81q32 3 63.5 11t60.5 22l-40 70Zm109 621-40-71q17-14 32.5-29.5T735-287l71 40q-20 27-43 50.5T713-154Zm22-519q-14-17-29.5-32.5T673-735l40-71q27 19 50 42t42 50l-70 41Zm62 153q-3-22-8.5-43T775-604l70-41q13 30 21.5 61.5T878-520h-81Zm48 204-70-40q8-20 13.5-41t8.5-43h81q-3 32-11 63.5T845-316Z"/></svg> View Records</a>
        <a href="view-profile" class="sidebar-link"><svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 -960 960 960" width="24px" fill="#e3e3e3"><path d="M234-276q51-39 114-61.5T480-360q69 0 132 22.5T726-276q35-41 54.5-93T800-480q0-133-93.5-226.5T480-800q-133 0-226.5 93.5T160-480q0 59 19.5 111t54.5 93Zm246-164q-59 0-99.5-40.5T340-580q0-59 40.5-99.5T480-720q59 0 99.5 40.5T620-580q0 59-40.5 99.5T480-440Zm0 360q-83 0-156-31.5T197-197q-54-54-85.5-127T80-480q0-83 31.5-156T197-763q54-54 127-85.5T480-880q83 0 156 31.5T763-763q54 54 85.5 127T880-480q0 83-31.5 156T763-197q-54 54-127 85.5T480-80Zm0-80q53 0 100-15.5t86-44.5q-39-29-86-44.5T480-280q-53 0-100 15.5T294-220q39 29 86 44.5T480-160Zm0-360q26 0 43-17t17-43q0-26-17-43t-43-17q-26 0-43 17t-17 43q0 26 17 43t43 17Zm0-60Zm0 360Z"/></svg> Your Info</a>
        <a href="<%= request.getContextPath() %>/check-manager" class="sidebar-link"><svg xmlns="http://www.w3.org/2000/svg" height="24px" viewBox="0 -960 960 960" width="24px" fill="#e3e3e3"><path d="M200-120q-33 0-56.5-23.5T120-200v-560q0-33 23.5-56.5T200-840h280v80H200v560h280v80H200Zm440-160-55-58 102-102H360v-80h327L585-622l55-58 200 200-200 200Z"/></svg> Logout</a>
    </aside>
            
    <%
        if (message != null) {
    %>
        <p class="message text-center"><%= message %></p>
    <%
        } else if (error != null) {
    %>
        <p class="error text-center"><%= error %></p>
    <%
        }
    %>
    <main class="main-content">
        <h2 class="form-title">Meal Records</h2>

        <form method="get" action="view-record" class="search-form">
            Search by date: <input type="date" name="searchDate" value="<%= request.getParameter("searchDate") != null ? request.getParameter("searchDate") : "" %>"/>
            <input type="hidden" name="page" value="1"/>
            <input type="submit" value="Search" />
        </form>

        <%
            if (mealsToDisplay != null && !mealsToDisplay.isEmpty()) {
        %>
            <table border="1" cellpadding="8" class="meal-table">
                <tr>
                    <th>Meal ID</th>
                    <th>Start Time</th>
                    <th>End Time</th>
                    <th>Total Amount</th>
                    <th>Rating</th>
                    <th>Comment</th>
                    <th>Order List</th>
                </tr>
                <%
                    for (Meal meal : mealsToDisplay) {
                %>
                    <tr>
                        <td><%= meal.getMealId() %></td>
                        <td><%= meal.getStartTime() %></td>
                        <td><%= meal.getEndTime() %></td>
                        <td><%= meal.getAmount() %></td>
                        <td><%= meal.getRating() %></td>
                        <td><%= meal.getFeedback() %></td>
                        <td>
                            <form method="get" action="view-record#order-list">
                                <input type="hidden" name="viewMealId" value="<%= meal.getMealId() %>" />
                                <input type="hidden" name="searchDate" value="<%= request.getParameter("searchDate") != null ? request.getParameter("searchDate") : "" %>">
                                <input type="hidden" name="page" value="<%= currentPage %>">
                                <input type="submit" value="View" id="view-button" />
                            </form>
                        </td>
                    </tr>
                <%
                    }
                %>
            </table>
            
            <!-- Pagination controls -->
            <div class="pagination">
                <% if (currentPage > 1) { %>
                    <a href="view-record?page=1&searchDate=<%= request.getParameter("searchDate") != null ? request.getParameter("searchDate") : "" %>">&laquo; First</a>
                    <a href="view-record?page=<%= currentPage-1 %>&searchDate=<%= request.getParameter("searchDate") != null ? request.getParameter("searchDate") : "" %>">&lt; Previous</a>
                <% } else { %>
                    <a class="disabled">&laquo; First</a>
                    <a class="disabled">&lt; Previous</a>
                <% } %>
                
                <% 
                    // Show page numbers
                    int startPage = Math.max(1, currentPage - 2);
                    int endPage = Math.min(totalPages, currentPage + 2);
                    
                    if (startPage > 1) { %>
                        <a href="view-record?page=1&searchDate=<%= request.getParameter("searchDate") != null ? request.getParameter("searchDate") : "" %>">1</a>
                        <% if (startPage > 2) { %>...<% } %>
                    <% }
                    
                    for (int i = startPage; i <= endPage; i++) {
                        if (i == currentPage) { %>
                            <a class="active"><%= i %></a>
                        <% } else { %>
                            <a href="view-record?page=<%= i %>&searchDate=<%= request.getParameter("searchDate") != null ? request.getParameter("searchDate") : "" %>"><%= i %></a>
                        <% }
                    }
                    
                    if (endPage < totalPages) { 
                        if (endPage < totalPages - 1) { %>...<% } %>
                        <a href="view-record?page=<%= totalPages %>&searchDate=<%= request.getParameter("searchDate") != null ? request.getParameter("searchDate") : "" %>"><%= totalPages %></a>
                    <% } %>
                
                <% if (currentPage < totalPages) { %>
                    <a href="view-record?page=<%= currentPage+1 %>&searchDate=<%= request.getParameter("searchDate") != null ? request.getParameter("searchDate") : "" %>">Next &gt;</a>
                    <a href="view-record?page=<%= totalPages %>&searchDate=<%= request.getParameter("searchDate") != null ? request.getParameter("searchDate") : "" %>">Last &raquo;</a>
                <% } else { %>
                    <a class="disabled">Next &gt;</a>
                    <a class="disabled">Last &raquo;</a>
                <% } %>
            </div>
        <%
            } else {
        %>
            <p class="empty-message">No meal records found.</p>
        <%
            }
        %>

            <%
                Meal selectedMeal = (Meal) request.getAttribute("selectedMeal");
                if (selectedMeal != null && selectedMeal.getOrderItems() != null && !selectedMeal.getOrderItems().isEmpty()) {
            %>
                <h3 class="section-title" id="order-list">Order Items for Meal ID <%= selectedMeal.getMealId() %></h3>
                <table border="1" cellpadding="6" class="order-table">
                    <tr>
                        <th>Item Name</th>
                        <th>Quantity</th>
                        <th>Price</th>
                        <th>Total</th>
                    </tr>
                    <%
                        for (OrderItem item : selectedMeal.getOrderItems()) {
                            double total = item.getOrderItemQuantity() * item.getItem().getItemPrice();
                    %>
                        <tr>
                            <td><%= item.getItem().getItemName() %></td>
                            <td><%= item.getOrderItemQuantity() %></td>
                            <td><%= item.getItem().getItemPrice() %></td>
                            <td><%= total %></td>
                        </tr>
                    <%
                        }
                    %>
                </table>
            <%
                }
            %>
        </main>
    </div>
</body>
</html>