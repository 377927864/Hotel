<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <!-- 指定字符集 -->
    <meta charset="utf-8">
    <!-- 使用Edge最新的浏览器的渲染方式 -->
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- viewport视口：网页可以根据设置的宽度自动进行适配，在浏览器的内部虚拟一个容器，容器的宽度与设备的宽度相同。
    width: 默认宽度与设备的宽度相同
    initial-scale: 初始的缩放比，为1:1 -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>酒店推荐系统 | skyline查询结果</title>

    <!-- 1. 导入CSS的全局样式 -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <!-- link + Tab键生成样式表引用 -->
    <link rel="stylesheet" href="./css/common.css">
    <link rel="stylesheet" href="./css/index.css">

    <!-- 2. jQuery导入，建议使用1.9以上的版本 -->
    <script src="js/jquery-2.1.0.min.js"></script>
    <script src="js/layer.js"></script>
    <!-- 3. 导入bootstrap的js文件 -->
    <script src="js/bootstrap.min.js"></script>
    <style type="text/css">
        td, th {
            text-align: center;
        }
        ul li, ol li {
            list-style: none;
        }
        ._left{
            position: relative;
            margin-top: 10px;
            margin-left: 1%;
            font-size: 20px;
            color: #3298FF;
        }
        ._list{
            width: 780px;
            position: relative;
            margin-bottom: 12px;
        }
        ._searchresult{
            width: 780px;
            padding-bottom: 10px;
            border-bottom: 1px dotted #DDD;
        }
        .hotel_pic{
            float: left;
            position: relative;
            width:130px;
            margin-right: 10px;
        }
        .searchresult_info{
            float: left;
            width: 446px;
            margin-top: 25px;
            margin-right: 10px;
        }
        .hotel_score{
            margin-top: 15px;
        }
        .hotel_price_ico{
            display: block;
            height: 135px;
            text-align: right;
            margin-top: 25px;
        }
        .hotel_price{
            float: left;
            margin-top: 5px;
            font-size: 24px;
            color: #F60;
        }
        .searchresult_name{
            margin-right: 5px;
            vertical-align: middle;
            color: #06C;
            font: bold 14px Simsun;
            text-shadow: 0 0 black;
        }

        .part{
            display:none;
            background-color: #e6fdff;
            height:100px;
            width:400px;
            position:relative;
            margin:2%;
        }


        .black_overlay{
            display: none;
            position: absolute;
            top: 0%;
            left: 0%;
            width: 100%;
            height: 100%;
            background-color: rgba(30, 30, 30, 0.88);
            z-index:1001;
            -moz-opacity: 0.8;
            opacity:.80;
            filter: alpha(opacity=88);
        }
        .white_content {
            display: none;
            position: absolute;
            top: 25%;
            left: 35%;
            width: 28%;
            height: 45%;
            padding: 20px;
            border:1px solid rgba(71, 113, 113, 0.39);
            background-color: #ffffff;
            z-index:1002;
            overflow: auto;
            font-size:larger;

            border-radius:30px;
            text-align: center;
        }
        .skyline_search{

            height: 50px;
            border:1px solid rgba(71, 113, 113, 0.39);
            border-radius:30px;
            text-align: center;
            font-size: x-large
        }
        .white_content_dimensions {
            display: none;
            position: absolute;
            top: 15%;
            left: 27%;
            width: 45%;
            height: 70%;
            padding: 20px;
            border: 1px solid rgba(71, 113, 113, 0.39);
            background-color: #ffffff;
            z-index: 1002;
            overflow: auto;
            font-size: larger;
            border-radius:30px;
        }
        .dimensions_search{

            height: 55px;
            border:1px solid rgba(71, 113, 113, 0.39);
            border-radius:30px;
            text-align: center;
            font-size: x-large
        }




        input,label,select{ vertical-align:middle;}

        .sort_box{
            width: 80px;
            height: 30px;
            background-color: cornflowerblue;
            color: #FFFFFF;
            font-size: 16px;
            text-align: center;
            line-height: 30px;
            float: left;
            margin-left: 5px;
            margin-top: 5px;
            cursor:default
        }

        .notclick{
            pointer-events: none;
            background-color: gray;
        }
    </style>

    <script>

        function dochange() {
            var selectedvalue = $(":selected","#searchtype").attr("value");
            if (selectedvalue=="地点"){
                $('#search_content').attr('placeholder',"请输入具体地点名");
            }
            else if (selectedvalue=="关键字"){
                $('#search_content').attr('placeholder',"请输入酒店名/酒店特色等");
            }
            else{
                $('#search_content').attr('placeholder',"请输入酒店名");
            }
        }

        function check() {
            var _hotelname = document.getElementById("hotelname");
            var _keyword = document.getElementById("keyword");
            if(_hotelname.value == "" && _keyword.value == ""){
                document.getElementById("msg1").innerText="搜索信息不能为空";
            }
        }

        function typecase() {
            var selectedvalue = $(":selected","#searchtype").attr("value");
            var search_content = $('#search_content').val();
            if(search_content == null || search_content.length == 0){
                alert("搜索内容不能为空！")
            }else {
                // alert(selectedvalue);
                if (selectedvalue=="关键字"){
                    <%--document.form1.action="${pageContext.request.contextPath}/SearchServlet?a=1";--%>
                    document.form1.action="${pageContext.request.contextPath}/midServlet?a=1";
                    document.form1.submit();

                }
                else{
                    <%--document.form1.action="${pageContext.request.contextPath}/SearchServlet?a=2";--%>
                    document.form1.action="${pageContext.request.contextPath}/midServlet?a=2";
                    document.form1.submit();
                }
            }
        }
        function skyline() {
            var selectedvalue = $(":selected","#searchtype").attr("value");
            // alert(selectedvalue);
            var search_content = $('#search_content').val();
            if(search_content == null || search_content.length == 0){
                alert("搜索内容不能为空！")
            }else{
                if (selectedvalue=="关键字"){
                    document.form1.action="${pageContext.request.contextPath}/SkylineServlet?a=1";
                    document.form1.submit();
                    <%--document.getElementById("form1").action="${pageContext.request.contextPath}/SearchServlet?a=1"--%>
                }
                else{
                    document.form1.action="${pageContext.request.contextPath}/SkylineServlet?a=2";
                    document.form1.submit();
                    <%--document.getElementById("form1").action="${pageContext.request.contextPath}/SearchServlet?a=3"--%>
                }
            }
        }
        function show(){
            var show_part = document.querySelector('.part');
            show_part.style.display = 'block';
        }
        /*function dimensions() {
            var selectedvalue = $(":selected","#searchtype").attr("value");
            // alert(selectedvalue);
            if (selectedvalue=="关键字"){
                document.form1.action="${pageContext.request.contextPath}/DimensionsServlet?a=1";
                document.form1.submit();

            }
            else{
                document.form1.action="${pageContext.request.contextPath}/DimensionsServlet?a=2";
                document.form1.submit();

            }
        }*/

        function dimensions() {
            var selectedvalue = $(":selected","#searchtype").attr("value");
            var search_content = $('#search_content').val();
            if(search_content == null || search_content.length == 0){
                alert("搜索内容不能为空！")
            }else{
                if (selectedvalue === "关键字"){
                    var p1 = document.getElementById("selection_box_1").innerText;
                    var p2 = document.getElementById("selection_box_2").innerText;
                    var p3 = document.getElementById("selection_box_3").innerText;
                    var p4 = document.getElementById("selection_box_4").innerText;
                    var p5 = document.getElementById("selection_box_5").innerText;

                    document.form1.action="${pageContext.request.contextPath}/DimensionsServlet?a=1&s1="+p1+"&s2="+p2+"&s3="+p3+"&s4="+p4+"&s5="+p5;

                    document.form1.submit();
                    <%--document.getElementById("form1").action="${pageContext.request.contextPath}/SearchServlet?a=1"--%>
                }
                else{
                    document.form1.action="${pageContext.request.contextPath}/DimensionsServlet?a=2";
                    document.form1.submit();
                    <%--document.getElementById("form1").action="${pageContext.request.contextPath}/SearchServlet?a=3"--%>
                }
            }
        };

        $(function(){
            var tips;
            $('h3.tooltip-icon01').on({
                mouseenter:function(){
                    var that = this;
                    tips =layer.tips(
                        "<span style='color: #000;'>skyline查询帮助用户动态调整需求变化，筛选出更为满意的结果。例如，选择“价格”和“评分”两个筛选条件，则按“价格”、“评分”两个维度进行skyline查询，优先显示出价格低，评分高的酒店。</span>",that,{tips:[1,'#fffcd7'],time:0,area:'auto',maxWidth:500}
                    );
                },
                mouseleave:function(){
                    layer.close(tips);
                }
            });
            $('u.tooltip-icon01').on({
                mouseenter:function(){
                    var that = this;
                    tips =layer.tips(
                        "<span style='color: #000;'>①选择1~4个条件(单选、多选都可)②点击“确定”按钮③显示skyline查询结果</span>",that,{tips:[2,'#fffcd7'],time:0,area:'auto',maxWidth:500}
                    );
                },
                mouseleave:function(){
                    layer.close(tips);
                }
            });
            $('h3.tooltip-icon02').on({
                mouseenter:function(){
                    var that = this;
                    tips =layer.tips(
                        "<span style='color: #000;'>多维度联合查询帮助用户重新选择酒店查询条件，实现用户从“价格”“位置”“酒店特色”等多个维度的重新查询。例如，选择“150以下”“商业区”和“有早餐”三个查询条件，则按这三个维度重新进行酒店查询，显示出满足这三个条件的酒店。</span>",that,{tips:[1,'#fffcd7'],time:0,area:'auto',maxWidth:650}
                    );
                },
                mouseleave:function(){
                    layer.close(tips);
                }
            });
            $('h4.tooltip-icon02').on({
                mouseenter:function(){
                    var that = this;
                    tips =layer.tips(
                        "<span style='color: #000;'>①选择查询条件，最多选择五个，相同维度或不同维度都可②点击“确定”按钮③显示多维度联合查询结果</span>",that,{tips:[1,'#fffcd7'],time:0,area:'auto',maxWidth:650}
                    );
                },
                mouseleave:function(){
                    layer.close(tips);
                }
            });

        })

        //在元素正在拖动到放置目标时触发
        function allowDrop(ev)
        {
            ev.preventDefault();
        }

        var srcdiv = null;
        //在用户 开始拖动 元素时执行 JS
        function drag(ev,divdom)
        {
            srcdiv=divdom;
            ev.dataTransfer.setData("text/html",divdom.innerHTML);//把divdom的内容存储到ev里
        }

        //在可拖动元素 放置在 元素中时执行JS
        function drop(ev,divdom)
        {
            ev.preventDefault();
            if(srcdiv != divdom && divdom.innerHTML.replace(/\s+|[\r\n]/g,"").length !=0){
                srcdiv.innerHTML = divdom.innerHTML;
                divdom.innerHTML=ev.dataTransfer.getData("text/html");
            }
            ev.stopPropagation();
        }

        var selectArr = new Array("selection_box_1","selection_box_2","selection_box_3","selection_box_4","selection_box_5");

        function a(thisId) {
            for (var i=0;i<selectArr.length;i++){
                var selectId = selectArr[i];
                if (document.getElementById(selectId).innerText == ""){
                    document.getElementById(selectId).innerHTML = document.getElementById(thisId).innerHTML;
                    $("#"+thisId).addClass("notclick");
                    break;
                }
                if (i == 4){
                    alert("您已经选择了五项！");
                }
            }
        };

        function b(bId) {
            // var innerDiv = document.getElementById(bId).getElementsByTagName("div");
            var srcId = "";
            var text = document.getElementById(bId).innerHTML;
            var innerDivIndex = selectArr.indexOf(bId);
            switch (text) {
                case ("150以下"):srcId = "price_sort_1";break;
                case ("150--300"):srcId = "price_sort_2";break;
                case ("300--450"):srcId = "price_sort_3";break;
                case ("450--600"):srcId = "price_sort_4";break;
                case ("600以上"):srcId = "price_sort_5";break;
                case ("商业区"):srcId = "location_sort_1";break;
                case ("机场附近"):srcId = "location_sort_2";break;
                case ("火车站附近"):srcId = "location_sort_3";break;
                case ("地铁附近"):srcId = "location_sort_4";break;
                case ("近景区"):srcId = "location_sort_5";break;
                case ("有早餐"):srcId = "service_sort_1";break;
                case ("免费WiFi"):srcId = "service_sort_2";break;
                case ("接送服务"):srcId = "service_sort_3";break;
                case ("行李寄存"):srcId = "service_sort_4";break;
                case ("叫醒服务"):srcId = "service_sort_5";break;
            }
            $("#"+srcId).removeClass("notclick");
            document.getElementById(bId).innerHTML = "";
            for (;innerDivIndex<4;innerDivIndex++){
                document.getElementById(selectArr[innerDivIndex]).innerHTML = document.getElementById(selectArr[innerDivIndex+1]).innerHTML;
                document.getElementById(selectArr[innerDivIndex+1]).innerHTML = "";
            }
        }

    </script>


</head>
<body>

<div class="topBox">
    <div class="topCenterBox">
        <!-- 左边盒子 -->
        <div class="topLeftBox">
            <!-- 左侧文字 -->
            <div class="topLeftInfoBox">
                让旅行更幸福
            </div>
            <!-- 语言盒子 -->
            <div class="languageBox">
                <img src="./images/index/icon/earth.png" class="earth" alt="地球仪">
                Language
            </div>
        </div>
        <!-- 右边盒子 -->
        <div class="topRightBox">
            <ul>
                <c:if test="${empty sessionScope.resuser}">
                    <li><a href="${pageContext.request.contextPath}/login.jsp" class="loginInfoLink">您好,请登录</a></li>
                </c:if>
                <c:if test="${not empty sessionScope.resuser}">
                    <li>欢迎您, &nbsp;<a href="${pageContext.request.contextPath}/UserInformation.jsp" class="loginInfoLink"><span style="color: orange">${sessionScope.resuser.username}&nbsp;</span></a></li>
                </c:if>
                <%--<li><a href="UserInformation.jsp" target="_blank" class="loginInfoLink">我的信息</a></li>--%>
                <li><a href="search.jsp">返回首页</a></li>
                <c:if test="${not empty sessionScope.resuser}">
                    <li><a href="${pageContext.request.contextPath}/LoginOutServlet">退出登录</a></li>
                </c:if>
                <li><a href="#" target="_blank">浏览历史</a></li>
                <li><a href="#" target="_blank">我的订单</a></li>
                <li><a href="#" target="_blank">客服中心</a></li>
                <li><a href="#" target="_blank">
                    <img src="./images/index/icon/phone.png" class="phone" alt="手机">
                </a></li>
                <li><a href="#" target="_blank">
                    <img src="./images/index/icon/wechat.png" class="wechat" alt="微信">
                </a></li>
            </ul>
        </div>
    </div>
</div>

<!-- 导航条的编写 -->
<div class="navBox">
    <!-- 中心框 -->
    <div class="navCenterBox">
        <ul>
            <li><a class=" current" href="index.jsp">首页</a></li>
            <li><a href="about.jsp">关于我们</a></li>
            <li><a href="contact.jsp">联系我们</a></li>
        </ul>
    </div>
</div>

<!-- 导航条的子导航编写 -->
<div class="menusBox">
    <!-- 中心框 -->
    <div class="menusCenterBox">
        <!-- 文本 -->
        <span class="menusInfo">境外直通车</span>
        <ul>
            <li><a href="#" target="_blank">
                <img src="./images/index/menus/hotel.png" class="menusIcon" alt="hotel">
                海外酒店
            </a></li>
            <li><a href="#" target="_blank">
                <img src="./images/index/menus/airplane.png" class="menusIcon" alt="hotel">
                国际•港澳台机票
            </a></li>
            <li><a href="#" target="_blank">
                <img src="./images/index/menus/airplane.png" class="menusIcon" alt="airplane">
                国际•港澳台机票
            </a></li>
            <li><a href="#" target="_blank">
                <img src="./images/index/menus/hotel.png" class="menusIcon" alt="hotel">
                海外酒店
            </a></li>
            <li><a href="#" target="_blank">
                <img src="./images/index/menus/airplane.png" class="menusIcon" alt="hotel">
                国际•港澳台机票
            </a></li>
            <li><a href="#" target="_blank">
                <img src="./images/index/menus/hotel.png" class="menusIcon" alt="hotel">
                海外酒店
            </a></li>
            <li><a href="#" target="_blank">
                <img src="./images/index/menus/airplane.png" class="menusIcon" alt="hotel">
                国际•港澳台机票
            </a></li>
        </ul>
    </div>
</div>

<!-- banner位的大盒子 -->
<div class="bannerBox">
    <!-- 中间盒子 -->
    <div class="bannerMiddleBox">
        <!-- 左边盒子 -->
        <div class="bannerLeftBox">
            <!-- 左边盒子里面的导航列 -->
            <div class="bannerList">
                <ul>
                    <li id=" "><a href="#"><div>酒店</div></a></li>
                    <li><a href="#"><div>机票</div></a></li>
                    <li><a href="#"><div>旅游</div></a></li>
                    <li><a href="#"><div>跟团游</div></a></li>
                    <li><a href="#"><div>自由行</div></a></li>
                    <li><a href="#"><div>酒店</div></a></li>
                </ul>
            </div>
            <!-- 右侧的搜索区 -->
            <div class="rightSearchBox">
                <!-- 搜索区域的顶部导航条 -->
                <div class="searchNavBox">
                    <ul>
                        <li id="active"><a href="#">国内酒店</a></li>
                        <li><a href="#">海外酒店</a></li>
                        <li><a href="#">民宿</a></li>
                        <li><a href="#">酒店团购</a></li>
                        <li><a href="#">国内+酒店</a></li>
                        <li><a href="#">国内+酒店</a></li>
                    </ul>
                </div>
                <!-- 搜索区域的搜索框 -->
                <form name="form1" action="" method="post" class="form-inline">
                    <div class="searchContentBox">
                        <table>
                            <tr>
                                <select id="searchtype" onchange="dochange()" class="form-control">
                                    <option value="关键字">关键字</option>
                                    <option value="地点">地点</option>
                                </select>&nbsp;&nbsp;
                                <input type="text" class="form-control" name="search_content" id="search_content" placeholder="请输入酒店名/酒店特色等">
                                <div>
                                    <span id="msg1">${msg1}</span>
                                    </br>
                                </div>
                            </tr>
                            <tr>
                                <td align="right">入住时间</td>
                                <td>
                                    <input type="date" name="checkIn" id="" class="dateBox">
                                </td>
                                <td align="right">退房日期</td>
                                <td>
                                    <input type="date" name="checkIn" id="" class="dateBox">
                                </td>
                            </tr>
                            <tr>
                                <td align="right">房间数</td>
                                <td>
                                    <select name="" id="" class="roomBox">
                                        <option value="1">1间</option>
                                        <option value="2">2间</option>
                                    </select>
                                </td>
                                <td align="right">住客数</td>
                                <td>
                                    <select name="" id="" class="roomBox">
                                        <option value="1">1人</option>
                                        <option value="2">2人</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td align="right">酒店级别</td>
                                <td>
                                    <select name="" id="" class="roomBox">
                                        <option value="1">不限</option>
                                        <option value="1">1间</option>
                                        <option value="2">2间</option>
                                    </select>
                                </td>

                            </tr>
                        </table>
                        <br>
                        <tr>
                            <td>
                                <button type="button" class="btn btn-default btn-md" onclick="typecase();">
                                    <span class="glyphicon glyphicon-search"></span> 搜索
                                </button>
                            </td>
                            &nbsp;&nbsp;&nbsp;&nbsp;
                            <td>
                                <button type="button" class="btn btn-default btn-md">
                                    <span class="glyphicon glyphicon-search"></span>
                                    <a href = "javascript:void(0)" onclick = "document.getElementById('light').style.display='block';document.getElementById('fade').style.display='block'">
                                        skyline查询
                                    </a>
                                </button>
                                <div id="light" class="white_content">
                                    <div class="skyline_search">

                                        <h3 class="iconfont icon-combined-shape-copy tooltip-icon01">skyline查询</h3>
                                    </div>
                                    <br>
                                    <h4 align="center " class="iconfont icon-combined-shape-copy tooltip-icon01">请选择筛选条件：</h4><br>
                                    <form action="" method="post" >
                                        <input type="checkbox" name="price" id="price">价格
                                        &nbsp;&nbsp;&nbsp;
                                        <input type="checkbox" name="score">评分
                                        &nbsp;&nbsp;&nbsp;
                                        <input type="checkbox" name="rate">好评率
                                        &nbsp;&nbsp;&nbsp;
                                        <input type="checkbox" name="userNum">评价人数<br><br><br>
                                        <div style="float: right">
                                            <u style="color: #D18F00;font-size: large" class="iconfont icon-combined-shape-copy tooltip-icon01">帮助</u>

                                        </div>
                                        <div style="float: contour">
                                            <button style="width: 100px;height: 50px;background-color: #46b8da;" onclick="skyline()">
                                                <a href = "javascript:void(0)" onclick = "document.getElementById('light').style.display='none';document.getElementById('fade').style.display='none'">
                                                    确定
                                                </a>
                                            </button>

                                        </div>
                                    </form>
                                </div>
                                <div id="fade" class="black_overlay">
                                </div>
                            </td>
                            &nbsp;&nbsp;&nbsp;&nbsp;
                            <td>
                                <button type="button" class="btn btn-default btn-md">
                                    <span class="glyphicon glyphicon-search"></span>
                                    <a href = "javascript:void(0)" onclick = "document.getElementById('light02').style.display='block';document.getElementById('fade02').style.display='block'">
                                        多维度联合查询
                                    </a>
                                </button>
                                <div id="light02" class="white_content_dimensions">
                                    <div class="dimensions_search">

                                        <h3 class="iconfont icon-combined-shape-copy tooltip-icon02">多维度联合查询</h3>
                                    </div>
                                    <br>
                                    <h4 align="center " class="iconfont icon-combined-shape-copy tooltip-icon02">请选择查询条件：</h4><br>

                                    <%--<form action="" method="post" >--%>
                                    <div class="form-group" style="height: 250px">
                                        <div id="sortFactors" style="float:left">
                                            <div style="margin-bottom:60px">
                                                <div>价格因素:</div>
                                                <div class="sort_box" id="price_sort_1" onclick="a(this.id)">150以下</div>
                                                <div class="sort_box" id="price_sort_2" onclick="a(this.id)">150--300</div>
                                                <div class="sort_box" id="price_sort_3" onclick="a(this.id)">300--450</div>
                                                <div class="sort_box" id="price_sort_4" onclick="a(this.id)">450--600</div>
                                                <div class="sort_box" id="price_sort_5" onclick="a(this.id)">600以上</div>
                                            </div>
                                            <div style="margin-bottom:60px">
                                                <div>位置因素:</div>
                                                <div class="sort_box" id="location_sort_1" onclick="a(this.id)">商业区</div>
                                                <div class="sort_box" id="location_sort_2" onclick="a(this.id)">机场附近</div>
                                                <div class="sort_box" id="location_sort_3" onclick="a(this.id)">火车站附近</div>
                                                <div class="sort_box" id="location_sort_4" onclick="a(this.id)">地铁附近</div>
                                                <div class="sort_box" id="location_sort_5" onclick="a(this.id)">近景区</div>
                                            </div>
                                            <div style="margin-bottom:60px">
                                                <div>酒店特色:</div>
                                                <div class="sort_box" id="service_sort_1" onclick="a(this.id)">有早餐</div>
                                                <div class="sort_box" id="service_sort_2" onclick="a(this.id)">免费WiFi</div>
                                                <div class="sort_box" id="service_sort_3" onclick="a(this.id)">接送服务</div>
                                                <div class="sort_box" id="service_sort_4" onclick="a(this.id)">行李寄存</div>
                                                <div class="sort_box" id="service_sort_5" onclick="a(this.id)">叫醒服务</div>
                                            </div>
                                        </div>
                                        <div style="float: left;margin-left: 30px;margin-right:20px">
                                            <div>已选择的:</div>
                                            <div style="border:1px solid #F00;">
                                                <div class="sort_box" style="margin-bottom: 12px;margin-right: 5px;float: none" id="selection_box_1" onclick="b(this.id)" ondrop="drop(event,this)" ondragover="allowDrop(event)" draggable="true" ondragstart="drag(event, this)"></div>
                                                <div class="sort_box" style="margin-bottom: 12px;margin-right: 5px;float: none" id="selection_box_2" onclick="b(this.id)" ondrop="drop(event,this)" ondragover="allowDrop(event)" draggable="true" ondragstart="drag(event, this)"></div>
                                                <div class="sort_box" style="margin-bottom: 12px;margin-right: 5px;float: none" id="selection_box_3" onclick="b(this.id)" ondrop="drop(event,this)" ondragover="allowDrop(event)" draggable="true" ondragstart="drag(event, this)"></div>
                                                <div class="sort_box" style="margin-bottom: 12px;margin-right: 5px;float: none" id="selection_box_4" onclick="b(this.id)" ondrop="drop(event,this)" ondragover="allowDrop(event)" draggable="true" ondragstart="drag(event, this)"></div>
                                                <div class="sort_box" style="margin-bottom: 5px;margin-right: 5px;float: none" id="selection_box_5" onclick="b(this.id)" ondrop="drop(event,this)" ondragover="allowDrop(event)" draggable="true" ondragstart="drag(event, this)"></div>
                                            </div>
                                        </div>
                                        <%--<div style="float: right">--%>
                                        <%--<u style="color: #D18F00;font-size: large" class="iconfont icon-combined-shape-copy tooltip-icon02">帮助</u>--%>

                                        <%--</div>--%>

                                        <div style="float: left">
                                            <button style="width: 100px;height: 50px;background-color: #46b8da;" onclick="dimensions()">
                                                <a href = "javascript:void(0)" onclick = "document.getElementById('light02').style.display='none';document.getElementById('fade02').style.display='none'">
                                                    确定
                                                </a>
                                            </button>

                                        </div>
                                        <%--</form>--%>
                                    </div>
                                </div>
                                <div id="fade02" class="black_overlay">
                                </div>
                            </td>


                        </tr>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>


<c:if test="${not empty sessionScope.resuser}">
    <!-- 下面的内容区 -->
    <div class="contentBox">
        <!-- 居中盒 -->
        <div class="container">
            <!-- 第一个热门区域 -->
            <div class="hotBox">

                    <%--<!-- 热门的内容区 -->--%>
                <div class="hotContentBox">

                        <%--<!-- 内容区 -->--%>
                    <div class="picContentBox">
                        <!-- 左侧图片盒子 -->
                        <div class="picSearch  width910">
                            <c:forEach items="${requestScope._sky_hotel}" var="hotel">
                                <div class="_list">
                                    <ul class="_searchresult" style="display: inline-block">
                                        <li class="hotel_pic">
                                                <%--酒店图片链接--%>
                                            <img src="img/example.jpg" width="130px" height="140px">
                                        </li>
                                        <li class="searchresult_info">
                                            <div class="searchresult_name">
                                                <a href="details.jsp?hotelId=${hotel.hotelId}&userid=${sessionScope.resuser.userid}" title="${hotel.hotelname}}">${hotel.hotelname}</a>
                                            </div>
                                            <div class="hotel_score">
                                                <a >
                                                        ${hotel.score}分
                                                    <b style="color:#CCC;">|</b>
                                                    来自${hotel.userNum}人点评
                                                </a>
                                            </div>
                                        </li>
                                        <li class="hotel_price_ico">
                                            <div class="hotel_price" style="text-align: right;">
                                                <font size="-10px" color="black"><dfn>¥</dfn></font>
                                                <b>${hotel.price}</b>
                                                <font size="-10">起</font>
                                            </div>
                                        </li>
                                    </ul>
                                </div>
                            </c:forEach>
                        </div>
                    </div>

                </div>
            </div>



        </div>
    </div>
</c:if>
<!-- footer页面版权底部 -->
<div class="footerBox">
    <!-- 中间盒子 -->
    <div class="container">
        <!-- 上面区域 -->
        <div class="footerTopBox">
            <!-- 左侧位置 -->
            <div class="footerOneBox">
                <p class="title">为什么选择我们</p>
                <div class="footerIntroBox">
                    <div class="commonBox leftImgBox1"></div>
                    <p class="pTitle blueColor">放心的服务</p>
                    <p class="pIntro">领先的独创服务 独创的保障体系</p>
                </div>
                <div class="footerIntroBox top10">
                    <div class="commonBox leftImgBox2"></div>
                    <p class="pTitle orangeColor">放心的价格</p>
                    <p class="pIntro">领先的独创服务 独创的保障体系</p>
                </div>
            </div>
            <!-- 旅游资讯 -->
            <div class="footerTwoBox">
                <p class="title">酒店资讯</p>
                <ul>
                    <li><a href="#">宾馆索引</a></li>
                    <li><a href="#">宾馆索引</a></li>
                    <li><a href="#">宾馆索引</a></li>
                    <li><a href="#">宾馆索引</a></li>
                    <li><a href="#">宾馆索引</a></li>
                    <li><a href="#">宾馆索引</a></li>
                    <li><a href="#">宾馆索引</a></li>
                    <li><a href="#">宾馆索引</a></li>
                </ul>
            </div>
            <!-- 加盟合作 -->
            <div class="footerTwoBox">
                <p class="title">加盟合作</p>
                <ul>
                    <li><a href="#">宾馆索引</a></li>
                    <li><a href="#">宾馆索引</a></li>
                    <li><a href="#">宾馆索引</a></li>
                    <li><a href="#">宾馆索引</a></li>
                    <li><a href="#">宾馆索引</a></li>
                    <li><a href="#">宾馆索引</a></li>
                    <li><a href="#">宾馆索引</a></li>
                    <li><a href="#">宾馆索引</a></li>
                </ul>
            </div>
            <!-- 关于携程 -->
            <div class="footerTwoBox">
                <p class="title">关于酒店</p>
                <ul>
                    <li><a href="#">宾馆索引</a></li>
                    <li><a href="#">宾馆索引</a></li>
                    <li><a href="#">宾馆索引</a></li>
                    <li><a href="#">宾馆索引</a></li>
                    <li><a href="#">宾馆索引</a></li>
                    <li><a href="#">宾馆索引</a></li>
                    <li><a href="#">宾馆索引</a></li>
                    <li><a href="#">宾馆索引</a></li>
                </ul>
            </div>
            <!-- 最右边的二维码 -->
            <div class="footerTwoBox" id="brNone">
                <p class="codeTitle">微信公众号</p>
                <div class="codeBox">
                    <img src="./images/index/code.jpg" alt="">
                    <p class="font12">扫一扫，领旅游福利</p>
                </div>
            </div>
        </div>

        <!-- 中间版权位置 -->
        <div class="copyRightBox">
            <p>
                <a href="#">Copyright</a>
                ©1111-2222,
                <a href="#">ctrip.com</a>
                . All rights reserved. |
                <a href="">ICP证：111-2000000</a>
            </p>
            <p>
                <span class="copyRightIcon"></span>
                <a href="#">网备11111111111号</a>
            </p>
            <p>
                违法和不良信息举报电话011-22222222丨 <a href="#">大连市旅游网站落实诚信建设主体责任承诺书</a>
            </p>
        </div>


    </div>
</div>

<!-- 左侧的一个固定图片 -->
<div class="phoneBox">
    <img src="./images/index/redpacket.png" alt="">
</div>
</body>
</html>





