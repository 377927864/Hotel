<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="stylesheet" href="css/font-awesome.min.css">
    <link rel="stylesheet" href="css/style.css">
    <title>酒店推荐系统｜联系我们</title>
</head>

<body>
<header>
    <nav id="navbar">
        <div class="container">
            <h1><a href="login.jsp">酒店推荐系统</a></h1>
            <ul>
                <li><a href="login.jsp">首页</a></li>
                <li><a href="about.jsp">关于我们</a></li>
                <li><a class=" current" href="contact.jsp">联系我们</a></li>
            </ul>
        </div>
    </nav>
</header>
<section id="contact-form" class="py">
    <div class="container">
        <h1 class="l-heading"><span class="text-primary">联系</span>我们</h1>
        <p>如有疑问请填写以下信息联系我们！</p>
        <form action="process.php">
            <div class="form-group">
                <label for="name">姓名</label>
                <input type="text" name="name" id="name">
            </div>
            <div class="form-group">
                <label for="email">邮箱</label>
                <input type="text" name="email" id="email">
            </div>
            <div class="form-group">
                <label for="message">反馈内容</label>
                <textarea type="text" name="message" id="message"></textarea>
            </div>
            <button type="submit" class="btn">提交</button>
        </form>
    </div>
</section>
<section id="contact-info" class="bg-dark">
    <div class="container">
        <div class="box">
            <i class="fa fa-home fa-3x"></i>
            <h3>联系地址</h3>
            <p>大连海事大学</p>
        </div>
        <div class="box">
            <i class="fa fa-phone fa-3x"></i>
            <h3>联系电话</h3>
            <p>011-12345678</p>
        </div>
        <div class="box">
            <i class="fa fa-envelope fa-3x"></i>
            <h3>邮箱地址</h3>
            <p>酒店推荐系统@163.com</p>
        </div>
    </div>

</section>
<footer id="main-footer">
    <p>酒店推荐系统 &copy; 2021, All Rights Reserved</p>
</footer>
</body>

</html>
