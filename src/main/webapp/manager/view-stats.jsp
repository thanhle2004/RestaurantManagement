<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Chilling Restaurant</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body {
            font-family: Arial;
            background: #f9f9f9;
            margin: 0;
            padding: 2rem;
        }
        .dashboard {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 1rem;
            max-width: 1200px;
            margin: auto;
        }
        .card {
            background: #fff;
            padding: 1.5rem;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            border-radius: 16px;
            text-align: center;
        }
        canvas {
            max-width: 100%;
        }
        .chart-controls {
            text-align: center;
            margin-top: 1rem;
        }
        .ratings {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 0.5rem;
        }
    </style>
    <style>
    html, body {
      height: 100%;
      overflow: auto;
      scrollbar-width: none; /* Firefox */
    }

    html::-webkit-scrollbar,
    body::-webkit-scrollbar {
      display: none; /* Chrome, Safari, Edge */
    }
    </style>
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
    </script>
</head>
<body>

<div class="dashboard">
    <div class="card">
        <h3>Total Meal</h3>
        <p id="totalMeals">Loading...</p>
    </div>
    <div class="card">
        <h3>Total Dishes</h3>
        <p id="totalDishes">Loading...</p>
    </div>
    <div class="card">
        <h3>Total Revenue</h3>
        <p id="totalRevenue">Loading...</p>
    </div>
    <div class="card" style="grid-column: span 2;">
        <h3>Revenue Chart</h3>
        <div class="chart-controls">
            <label>Group by:</label>
            <select id="groupBy">
                <option value="day">Day</option>
                <option value="week">Week</option>
                <option value="month" selected>Month</option>
                <option value="year">Year</option>
            </select>
        </div>
        <canvas id="revenueChart" height="100"></canvas>
    </div>
    <div class="card">
        <h3>Ratings</h3>
        <div class="ratings">
            <div id="totalVotes">0 votes</div>
            <div><strong>Average Rating:</strong> <span id="averageRating">0.0</span> ★</div>
            <div>★★★★★ <span id="percent-5">0%</span></div>
            <div>★★★★☆ <span id="percent-4">0%</span></div>
            <div>★★★☆☆ <span id="percent-3">0%</span></div>
            <div>★★☆☆☆ <span id="percent-2">0%</span></div>
            <div>★☆☆☆☆ <span id="percent-1">0%</span></div>
        </div>
    </div>
</div>

<script>
    function fetchRevenueData(groupBy) {
        fetch(`ViewStatsServlet?groupBy=${groupBy}`)
            .then(response => response.json())
            .then(data => {
                document.getElementById("totalMeals").textContent = data.totalMeals;
                document.getElementById("totalDishes").textContent = data.totalDishes;
                document.getElementById("totalRevenue").textContent = new Intl.NumberFormat('vi-VN').format(data.totalRevenue) + " USD";

                const ctx = document.getElementById('revenueChart').getContext('2d');
                if (window.revenueChart && typeof window.revenueChart.destroy === 'function') {
                    window.revenueChart.destroy();
                }

                window.revenueChart = new Chart(ctx, {
                    type: 'line',
                    data: {
                        labels: data.chartLabels,
                        datasets: [{
                            label: 'Revenue (USD)',
                            data: data.chartData,
                            backgroundColor: 'rgba(54, 162, 235, 0.6)',
                            borderColor: 'rgba(54, 162, 235, 1)',
                            borderWidth: 1
                        }]
                    },
                    options: {
                        scales: {
                            y: {
                                beginAtZero: true,
                                ticks: {
                                    callback: value => new Intl.NumberFormat('vi-VN').format(value)
                                }
                            }
                        }
                    }
                });

                const ratings = data.ratingPercents || [];
                const totalVotes = data.ratingTotalVotes || 0;
                document.getElementById("totalVotes").textContent = totalVotes + " votes";

                let averageRating = 0;
                if (ratings.length === 5) {
                    averageRating = (
                        5 * (ratings[0] || 0) +
                        4 * (ratings[1] || 0) +
                        3 * (ratings[2] || 0) +
                        2 * (ratings[3] || 0) +
                        1 * (ratings[4] || 0)
                    ) / 100;
                    averageRating = averageRating.toFixed(1);
                }
                document.getElementById("averageRating").textContent = averageRating;

                for (let i = 0; i < 5; i++) {
                    const star = 5 - i; 
                    const percent = ratings[i];
                    const elem = document.getElementById("percent-" + star);
                    if (elem && typeof percent === 'number') {
                        elem.textContent = percent + "%";
                    } else {
                        console.warn("Error: percent-" + star, percent);
                    }
                }
            })
            .catch(err => {
                console.error("Error fetching data:", err);
            });
    }

    document.getElementById("groupBy").addEventListener("change", function () {
        fetchRevenueData(this.value);
    });

    fetchRevenueData("day");
</script>

</body>
</html>
