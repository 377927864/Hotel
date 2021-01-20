<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="css/style.css">
    <title>酒店推荐系统｜关于我们</title>
</head>
<body>
<header>
    <nav id="navbar">
        <div class="container">
            <h1><a href="login.jsp">酒店推荐系统</a></h1>
            <ul>
                <li><a href="login.jsp">首页</a></li>
                <li><a class=" current" href="about.jsp">关于我们</a></li>
                <li><a href="contact.jsp">联系我们</a></li>
            </ul>
        </div>
    </nav>
</header>
<section id="about-info" class="py bg-light">
    <div class="container">
        <div class="info-left">
            <h1 class="l-heading">关于<span class="text-primary">酒店推荐系统</span></h1>
            <p>目前，以IPV6为核心的下一代互联网已经得到了广泛的部署和应用，用户可以利用网络方便地进行电子购物、资料检索等。但是，另一方面，网络上的资源繁多，而每个用户的偏好各不相同，使得用户难以准确的查找到感兴趣的信息；另一方面，网络上潜伏着大量的攻击者，意图窃取用户泄露的隐私信息。</p>
            <p>该系统实现了面向IPV6网络的用户偏好信息获取，用户偏好结果推荐和用户隐私保护。</p>
        </div>
        <div class="info-right">
            <img src="./img/03about-aboutinfo-img.jpg" alt="米修在线">
        </div>
    </div>
</section>
<section id="testimonials">
    <div class="container">
        <h2 class="l-heading">系统功能</h2>
        <div class="testimonial bg-primary">
            <img src="./img/05about-testimonal-guest1.jpg" alt="Jan">
            <p>在用户首次使用系统时，偏好信息为空，拟采用“解析-补充”的二步走方式对偏好信息表进行初始化。所谓的“解析”方式，指的是用户发起查询时明确给出的信息。另外，随着时间的推移，人们的偏好条件会改变，这就需要对偏好信息进行更新。针对这类需求，拟采用“隐藏区+匿名”的方式来满足用户要求。</p>
        </div>
        <div class="testimonial bg-primary">
            <img src="./img/06about-testimonal-guest2.jpg" alt="Lucy">
            <p>本项目充分借鉴了skyline和top-k查询的优势，拟采用优选skyline元组作为最终偏好查询的结果返回给用户，既可以删除大量不满足用户偏好的冗余数据，也可以有效的控制最终结果的数目，得到高度精炼的查询结果。在IPv6网络中，用户通常会提出一些隐私性需求，要求对自己的查询地点和某些维度的偏好信息进行保护。针对这类需求，拟采用“隐藏区+匿名”的方式来满足用户要求。</p>
        </div>
    </div>
</section>
<footer id="main-footer">
    <p>酒店推荐系统 &copy; 2021, All Rights Reserved</p>
</footer>
</body>
</html>
