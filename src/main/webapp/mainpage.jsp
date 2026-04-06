<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Estately | Your Dream Home Awaits</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/modern.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        .hero-immersive {
            height: 100vh;
            background: linear-gradient(rgba(0,0,0,0.3), rgba(0,0,0,0.6)), url('<%= request.getContextPath() %>/images/hero-bg.png') center/cover;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            padding: 0 10%;
        }

        .hero-content {
            max-width: 900px;
            color: white;
        }

        .hero-content h1 {
            font-size: 5rem;
            font-weight: 800;
            margin-bottom: 2rem;
            text-shadow: 0 4px 20px rgba(0,0,0,0.3);
            line-height: 1.1;
        }

        .hero-content p {
            font-size: 1.25rem;
            font-weight: 500;
            opacity: 0.9;
            max-width: 700px;
            margin: 0 auto;
            line-height: 1.6;
        }

        .about-section {
            padding: 10rem 10%;
            background: white;
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 6rem;
            align-items: center;
        }

        .about-img-stack {
            position: relative;
            height: 600px;
        }

        .about-img-main {
            width: 85%;
            height: 85%;
            object-fit: cover;
            border-radius: 40px;
            box-shadow: 0 30px 60px -12px rgba(50,50,93,0.25);
        }

        .about-img-sub {
            position: absolute;
            bottom: 0;
            right: 0;
            width: 60%;
            height: 60%;
            object-fit: cover;
            border-radius: 40px;
            border: 15px solid white;
            box-shadow: 0 30px 60px -12px rgba(50,50,93,0.25);
        }

        .about-text h2 {
            font-size: 3rem;
            font-weight: 800;
            color: #1e293b;
            margin-bottom: 2rem;
            line-height: 1.2;
        }

        .about-text p {
            color: #64748b;
            font-size: 1.1rem;
            line-height: 1.8;
            margin-bottom: 2.5rem;
        }

        .stat-bar-modern {
            display: flex;
            gap: 4rem;
            margin-top: 4rem;
        }

        .stat-item-modern h3 {
            font-size: 2rem;
            font-weight: 800;
            color: var(--primary);
            margin-bottom: 0.25rem;
        }

        .stat-item-modern span {
            font-size: 0.85rem;
            font-weight: 700;
            color: #94a3b8;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
    </style>
</head>
<body>

<nav class="navbar" id="navbar" style="background: transparent; border-bottom: none; transition: all 0.4s ease;">
    <a href="#" class="logo" style="color: white;">
        <i class="fas fa-home"></i>
        <span>Estately</span>
    </a>
    <ul class="nav-links">
        <li><a href="#" class="active" style="color: white; opacity: 0.9;">Home</a></li>
        <li><a href="<%= request.getContextPath() %>/user-dashboard" style="color: white; opacity: 0.7;">Properties</a></li>
        <li><a href="#about" style="color: white; opacity: 0.7;">About</a></li>
        <li><a href="#" style="color: white; opacity: 0.7;">Contact</a></li>
    </ul>
    <div class="nav-btns">
        <a href="<%= request.getContextPath() %>/pages/common/login.jsp" class="btn btn-primary" style="background: #3b82f6; border: none; border-radius: 12px; font-weight: 700; padding: 0.8rem 2rem;">Login</a>
        <a href="<%= request.getContextPath() %>/pages/common/register.jsp" class="btn btn-primary" style="background: #3b82f6; border: none; border-radius: 12px; font-weight: 700; padding: 0.8rem 2rem; margin-left: 0.5rem;">Join Now</a>
    </div>
</nav>

<section class="hero-immersive">
    <div class="hero-content">
        <h1>Your Dream Home Awaits</h1>
        <p>Discover the finest luxury real estate. From elegant city apartments to sprawling country estates, find your perfect match with Estately.</p>
    </div>
</section>

<section class="about-section" id="about">
    <div class="about-img-stack">
        <img src="<%= request.getContextPath() %>/images/modern_living_room.png" alt="Luxury Living" class="about-img-main">
        <img src="<%= request.getContextPath() %>/images/hero-bg.png" alt="Luxury Estate" class="about-img-sub">
    </div>
    <div class="about-text">
        <span style="color: var(--primary); font-weight: 800; text-transform: uppercase; letter-spacing: 3px; font-size: 0.8rem;">Our Legacy</span>
        <h2>Redefining the Higher Standard of Living</h2>
        <p>At Estately, we don't just list properties; we curate lifestyle benchmarks. Our portfolio represents the pinnacle of architectural excellence and community integration, ensuring that every asset we manage becomes a legacy for its owner.</p>
        
        <div class="stat-bar-modern">
            <div class="stat-item-modern">
                <h3>12k+</h3>
                <span>Premium Assets</span>
            </div>
            <div class="stat-item-modern">
                <h3>98%</h3>
                <span>Success Rate</span>
            </div>
            <div class="stat-item-modern">
                <h3>25y</h3>
                <span>Real Estate Glory</span>
            </div>
        </div>

        <a href="<%= request.getContextPath() %>/pages/common/register.jsp" class="btn btn-primary" style="margin-top: 4rem; border-radius: 14px; padding: 1.25rem 3rem;">Begin Your Journey</a>
    </div>
</section>

<footer style="background: #0f172a; padding: 6rem 10% 3rem; color: white;">
    <div class="footer-grid">
        <div>
            <a href="#" class="logo" style="color: white;">
                <i class="fas fa-home"></i>
                <span>Estately</span>
            </a>
            <p style="color: #94a3b8; margin-top: 1.5rem; line-height: 1.7;">The global benchmark for luxury real estate discovery and asset management.</p>
        </div>
        <div>
            <h4 style="color: white; margin-bottom: 2rem;">Ecosystem</h4>
            <ul class="footer-links-list">
                <li><a href="#" style="color: #94a3b8;">Marketplace</a></li>
                <li><a href="#" style="color: #94a3b8;">Investment Hub</a></li>
                <li><a href="#" style="color: #94a3b8;">Seller Node</a></li>
            </ul>
        </div>
        <div>
            <h4 style="color: white; margin-bottom: 2rem;">Company</h4>
            <ul class="footer-links-list">
                <li><a href="#" style="color: #94a3b8;">Our Vision</a></li>
                <li><a href="#" style="color: #94a3b8;">Leadership</a></li>
                <li><a href="#" style="color: #94a3b8;">Advisory</a></li>
            </ul>
        </div>
        <div>
            <h4 style="color: white; margin-bottom: 2rem;">Connectivity</h4>
            <div style="display: flex; gap: 1.5rem; font-size: 1.5rem;">
                <a href="#" style="color: #94a3b8;"><i class="fab fa-instagram"></i></a>
                <a href="#" style="color: #94a3b8;"><i class="fab fa-linkedin"></i></a>
                <a href="#" style="color: #94a3b8;"><i class="fab fa-twitter"></i></a>
            </div>
        </div>
    </div>
    <div style="text-align: center; color: #475569; font-size: 0.85rem; margin-top: 6rem; padding-top: 3rem; border-top: 1px solid rgba(255,255,255,0.05);">
        &copy; 2024 Estately Global Portfolio. Engineered for Excellence.
    </div>
</footer>

<script>
    window.addEventListener('scroll', function() {
        const navbar = document.getElementById('navbar');
        const links = navbar.querySelectorAll('.nav-links a');
        const logo = navbar.querySelector('.logo');
        const btnOutline = navbar.querySelector('.btn-outline');

        if (window.scrollY > 100) {
            navbar.style.background = 'rgba(255,255,255,0.95)';
            navbar.style.backdropFilter = 'blur(10px)';
            navbar.style.boxShadow = '0 10px 30px rgba(0,0,0,0.05)';
            logo.style.color = '#1e293b';
            links.forEach(link => { link.style.color = '#64748b'; link.style.opacity = '1'; });
            btnOutline.style.color = '#1e293b';
            btnOutline.style.borderColor = '#e2e8f0';
        } else {
            navbar.style.background = 'transparent';
            navbar.style.backdropFilter = 'none';
            navbar.style.boxShadow = 'none';
            logo.style.color = 'white';
            links.forEach(link => { link.style.color = 'white'; link.style.opacity = '0.7'; });
            btnOutline.style.color = 'white';
            btnOutline.style.borderColor = 'rgba(255,255,255,0.3)';
        }
    });
</script>

</body>
</html>
