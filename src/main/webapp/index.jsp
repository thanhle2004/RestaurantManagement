<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Chilling Restaurant</title>
    <link rel="stylesheet" href="assets/index-style/styles.css"/>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@400..700&display=swap" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Atkinson+Hyperlegible+Mono:ital,wght@0,200..800;1,200..800&display=swap" rel="stylesheet">
    <link rel="icon" href="assets/index-style/chilling_burger.png"/>
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
<body class="head">
    <header class="header-container">
        <div class="nav-left">
            <img src="assets/index-style/chilling_burger.png" alt="alt"/>
        </div>
        <ul class="nav-center-content">
          <li><a href="#home">HOME</a></li>
          <li><a href="#menu">MENU</a></li>
          <li><a href="#about_us">ABOUT US</a></li>
          <li><a href="#gallery">GALLERY</a></li>
        </ul>

        <div class="nav-right">
          <a href="javascript:void(0)" class="login-link" onclick="showLoginPopup()">LOGIN</a>
        </div>
    </header>

    <section id ="home">
        <p class="dancing-script-content">welcome to Chilling Burger — where every bite is a burst of flavor!</p>
        <h1>BEHIND THE DISHES</h1>
        <p class="normal_content">We serve handcrafted burgers made with 100% fresh beef, soft toasted buns, and secret sauces you’ll crave. Whether you're into classic cheeseburgers or adventurous spicy stacks, we've got something sizzling for every taste bud. Come hungry, leave happy!</p>
    </section>

    <section id="about_us">
        <p class="dancing-script-content">Special moments</p>
        <h1 class="atkinson-hyperlegible-mono-content">ABOUT US</h1>           
        <div class='flexbox'>
            <div class='box1'><img src="https://www.niesslbeck.de/wp-content/uploads/2021/08/Hamburger-scaled.jpeg" alt="box1"/></a></div>
            <div class='box2'>
                <p class='dancing-script-content'>Taste perception</p>
                <h1 class="atkinson-hyperlegible-mono-content">JUICY & SMOKY</h1>
                <p class="normal_content">Every bite offers perfect harmony of smoky beef, melted cheese, crisp veggies, tangy secret sauce.</p>
            </div>
            <div class="box3"><img src="https://transform-cf1.nws.ai/https%3A//cdn.thenewsroom.io/platform/story_media/1288820281/618188362.jpg/w_1200,c_limit/" alt="box3"/></div>
        </div>
    </section>

    <section id="menu">
        <p class="subtitle">our best menu</p>
        <h1 class="menu-title">SPECIAL BURGER MENU</h1>
        <div class='flexbox-menu'>
            <div class="menu-list">
                <ul class="burger-menu-list">
                    <li>
                        <span class="dish-name">CLASSIC CHEESEBURGER</span>
                        <span class="dots"></span>
                        <span class="price">$80</span>
                        <p class="description">Served with fresh lettuce, tomato, and cheese</p>
                    </li>
                    <li>
                        <span class="dish-name">SPICY BBQ BURGER</span>
                        <span class="dots"></span>
                        <span class="price">$95</span>
                        <p class="description">Smoky BBQ sauce, jalapeños, and crispy onions</p>
                    </li>
                    <li>
                        <span class="dish-name">BACON MUSHROOM BURGER</span>
                        <span class="dots"></span>
                        <span class="price">$100</span>
                        <p class="description">Grilled mushrooms, crispy bacon, and cheddar</p>
                    </li>
                    <li>
                        <span class="dish-name">VEGGIE DELIGHT BURGER</span>
                        <span class="dots"></span>
                        <span class="price">$70</span>
                        <p class="description">A vegetarian patty with fresh greens and avocado</p>
                    </li>
                    <li>
                        <span class="dish-name">DOUBLE BEEF BURGER</span>
                        <span class="dots"></span>
                        <span class="price">$120</span>
                        <p class="description">Two juicy beef patties, cheddar, and special sauce</p>
                    </li>
                </ul>
            </div>
            <div class="menu-img">
                <img src="assets/index-style/hamburger-1.jpg" alt="hamburger-1"/>
            </div>
        </div>           
    </section>

    <section id="gallery">
        <p class="dancing-script-content">Bite into happiness. One layer at a time.</p>
        <h1 class="atkinson-hyperlegible-mono-content" style="margin-bottom: 30px;">GALLERY</h1>
        <div class="gallery_1to4">
            <img src="assets/index-style/gallery-1.jpg" alt="alt-1"/>
            <img src="assets/index-style/gallery-2.jpg" alt="alt-2"/>
            <img src="assets/index-style/gallery-3.jpg" alt="alt-3"/>
        </div>
        <div class="gallery_5to8">
           <img src="assets/index-style/gallery-5.jpg" alt="alt-5"/>
           <img src="assets/index-style/gallery-6.jpg" alt="alt-6"/>
           <img src="assets/index-style/gallery-7.jpg" alt="alt-7"/>

        </div>
    </section>

    <div id="loginPopup" class="login-popup-overlay">
        <div class="login-popup-content">
            <h2 class="dancing-script-content">Choose Login Type</h2>
            <div class="login-options">
                <a href="${pageContext.request.contextPath}/check-manager?error=false" class="login-box">Restaurant</a>
                <a href="table-login" class="login-box">Tables</a>
            </div>
            <button class="close-btn" onclick="closeLoginPopup()">✖</button>
        </div>
    </div>

    <script>
        function showLoginPopup() {
            document.getElementById("loginPopup").style.display = "flex";
        }

        function closeLoginPopup() {
            document.getElementById("loginPopup").style.display = "none";
        }

        window.addEventListener("click", function(e) {
            const popup = document.getElementById("loginPopup");
            if (e.target === popup) {
                popup.style.display = "none";
            }
        });
    </script>
</body>
</html>
