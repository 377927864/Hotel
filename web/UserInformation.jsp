<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">

    <!-- 使用Edge最新的浏览器的渲染方式 -->
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- viewport视口：网页可以根据设置的宽度自动进行适配，在浏览器的内部虚拟一个容器，容器的宽度与设备的宽度相同。
    width: 默认宽度与设备的宽度相同
    initial-scale: 初始的缩放比，为1:1 -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>酒店推荐系统 | 个人信息</title>

    <!-- 1. 导入CSS的全局样式 -->
    <link href="css/bootstrap.min.css" rel="stylesheet">


    <!-- link + Tab键生成样式表引用 -->
    <link rel="stylesheet" href="./css/common.css">
    <link rel="stylesheet" href="./css/index.css">


    <!-- 2. jQuery导入，建议使用1.9以上的版本 -->
    <script src="js/jquery-2.1.0.min.js"></script>
    <!-- 3. 导入bootstrap的js文件 -->
    <script src="js/bootstrap.min.js"></script>
    <script src="js/layer.js"></script>
    <style type="text/css">
        td, th {
            text-align: center;
        }
        ul li, ol li {
            list-style: none;
        }
        .part{
            display:none;
            background-color: #e6fdff;
            height:100px;
            width:400px;
            position:relative;
            margin:2%;
        }




        /* CSS Document */
        *{
            margin:0px;
            padding:0px;
            /*font:"微软雅黑";*/
            font-size:16px;
        }
        #header{
            width:100%;
            height:40px;
            background-color:#000;
        }
        #header-con{
            width:900px;
            height:40px;
            margin:0 auto;
            line-height:40px;
        }
        #header-con div{
            float:right;
            margin-left:10px;
            line-height:40px;
        }
        #header-con div a{
            text-decoration:none;
            margin-top:0 auto;
            color:#fff;
            display:block;
        }
        .login-item input{
            width:350px;
            height:40px;
        }
        .login-item a{
            width:354px;
            height:50px;
            background:#00897B;
            display:block;
            font-size:16px;
            color:#fff;
            line-height:50px;
            text-align:center;

            text-decoration:none;
        }
        .login-item{
            margin-top:15px;
            margin-left:20px;
        }
        #loginBox{
            display:none;
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

            height: 55px;
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
        function check() {
            var _hotelname = document.getElementById("hotelname");
            var _keyword = document.getElementById("keyword");
            if(_hotelname.value == "" && _keyword.value == ""){
                document.getElementById("msg1").innerText="搜索信息不能为空";
            }
        }

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







        function back() {
            window.location.href="searchHotelPage.jsp";
        }

        window.onload = function () {
            // alert("加载了");
            $.ajax({
                type:"POST",
                url:"${pageContext.request.contextPath}/PreferenceServlet?jspNo=2",
                data:{
                    userid:"${sessionScope.resuser.userid}"
                },
                success:function (data) {
                    var srcId = "";
                    for(var i=0;i<data.length;i++){
                        document.getElementById(selectArr[i]).innerHTML = data[i];
                        switch (data[i]) {
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
                        $("#"+srcId).addClass("notclick");
                    }

                }
            });
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



<!-- 下面的内容区 -->
<div class="contentBox">
    <!-- 居中盒 -->
    <div class="container">
        <!-- 第一个热门区域 -->
        <div class="hotBox">
            <!-- 热门的内容区 -->
            <div class="hotContentBox">

                <div class="container" style="width: 600px;">
                    <form action="${pageContext.request.contextPath}/UserInformationServlet" method="post" class="form-inline" onsubmit="return check()">
                        <%--<div class="text" style="margin-bottom: 20px;">
                            <label for="nickname">id</label>
                            <input type="text" readonly="readonly" value="${sessionScope.resuser.userid}" name="userid" class="form-control" id="userid" placeholder="请输入昵称">
                        </div>--%>
                        <div class="text" style="margin-top: 50px;margin-bottom: 20px;">
                            <label for="nickname">昵称</label>
                            <input type="text" value="${sessionScope.resuser.nickname}" name="nickname" class="form-control" id="nickname" placeholder="请输入昵称">
                        </div>
                        <div class="text" style="margin-bottom: 20px;">
                            <label for="sex">性别</label>
                            <select id="sex" name="sex" class="form-control">
                                <option value="">&nbsp;&nbsp;----请选择性别----&nbsp;&nbsp;</option>
                                <option value="男" <c:if test="${sessionScope.resuser.sex=='男'}">selected</c:if>>男</option>
                                <option value="女" <c:if test="${sessionScope.resuser.sex=='女'}">selected</c:if>>女</option>
                            </select>
                        </div>

                        <div class="form-group" style="height: 250px">
                            <label>偏好选择：</label>
                            <br>
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
                        </div>

                        <div class="text" style="margin-bottom: 20px;">
                            <label for="email">邮箱</label>
                            <input type="text" value="${sessionScope.resuser.email}" name="email" class="form-control" id="email" placeholder="请输入邮箱">
                        </div>
                        <div class="text" style="margin-bottom: 20px;">
                            <label for="occupation">职业</label>
                            <select id="occupation" name="occupation" class="form-control">
                                <option value="">请选择职业</option>
                                <option value="计算机/互联网/通信"<c:if test="${sessionScope.resuser.occupation=='计算机/互联网/通信'}">selected</c:if>>计算机/互联网/通信</option>
                                <option value="生产/工艺/制作"<c:if test="${sessionScope.resuser.occupation=='生产/工艺/制作'}">selected</c:if>>生产/工艺/制作</option>
                                <option value="医疗/护理/制药"<c:if test="${sessionScope.resuser.occupation=='医疗/护理/制药'}">selected</c:if>>医疗/护理/制药</option>
                                <option value="金融/银行/投资/保险"<c:if test="${sessionScope.resuser.occupation=='金融/银行/投资/保险'}">selected</c:if>>金融/银行/投资/保险</option>
                                <option value="商业/服务业/个体经营"<c:if test="${sessionScope.resuser.occupation=='商业/服务业/个体经营'}">selected</c:if>>商业/服务业/个体经营</option>
                                <option value="文化/广告/传媒"<c:if test="${sessionScope.resuser.occupation=='文化/广告/传媒'}">selected</c:if>>文化/广告/传媒</option>
                                <option value="娱乐/艺术/表演"<c:if test="${sessionScope.resuser.occupation=='娱乐/艺术/表演'}">selected</c:if>>娱乐/艺术/表演</option>
                                <option value="律师/法务"<c:if test="${sessionScope.resuser.occupation=='律师/法务'}">selected</c:if>>律师/法务</option>
                                <option value="教育/培训"<c:if test="${sessionScope.resuser.occupation=='教育/培训'}">selected</c:if>>教育/培训</option>
                                <option value="公务员/行政/事业单位"<c:if test="${sessionScope.resuser.occupation=='公务员/行政/事业单位'}">selected</c:if>>公务员/行政/事业单位</option>
                                <option value="模特"<c:if test="${sessionScope.resuser.occupation=='模特'}">selected</c:if>>模特</option>
                                <option value="空姐"<c:if test="${sessionScope.resuser.occupation=='空姐'}">selected</c:if>>空姐</option>
                                <option value="学生"<c:if test="${sessionScope.resuser.occupation=='学生'}">selected</c:if>>学生</option>
                                <option value="其他职业"<c:if test="${sessionScope.resuser.occupation=='其他职业'}">selected</c:if>>其他职业</option>
                            </select>
                        </div>
                        <div class="text" style="margin-bottom: 20px;">
                            <label for="birthday">生日</label>
                            <input type="text" value="${sessionScope.resuser.birthday}" name="birthday" class="form-control" id="birthday" placeholder="请输入出生日期，例如:2020/01/01">
                        </div>
                        <div class="text" style="margin-bottom: 20px;">
                            <label for="address">住址</label>
                            <input type="text" value="${sessionScope.resuser.address}" name="address" class="form-control" id="address" placeholder="请输入住址，例如:北京">
                        </div>
                        <div class="text" style="margin-bottom: 20px;">
                            <label for="tel">电话</label>
                            <input type="text" value="${sessionScope.resuser.tel}" name="tel" class="form-control" id="tel" placeholder="请输入电话">
                        </div>
                        <button type="submit" class="btn btn-default btn-md" >
                            <span class="glyphicon glyphicon-floppy-disk" aria-hidden="true"></span> 保存
                        </button>
                        <button type="button" class="btn btn-default btn-md" onclick="back()">
                            <span  aria-hidden="true"></span> 返回
                        </button>
                    </form>
                </div>


            </div>
        </div>
    </div>
</div>

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