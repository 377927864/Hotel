<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link href="https://cdn.bootcss.com/font-awesome/5.11.2/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/font-awesome.min.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="./css/login.css">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <!-- 2. jQuery导入，建议使用1.9以上的版本 -->
    <script src="js/jquery-2.1.0.min.js"></script>
    <!-- 3. 导入bootstrap的js文件 -->
    <script src="js/bootstrap.min.js"></script>
    <script type="text/javascript">
        //用户登录
        window.onload =function () {
            var tagName = document.getElementsByTagName("input");
            for(var i =0; i<tagName.length; i++){
                tagName[i].setAttribute("autocomplete","off");
            }
        };
        //切换验证码
        function refreshCode(){
            //1.获取验证码图片对象
            var vcode = document.getElementById("vcode");

            //2.设置其src属性，加时间戳
            vcode.src = "${pageContext.request.contextPath}/Checkcode?time="+new Date().getTime();
        }

        //用户注册
        //确定两次密码
        function ckpwd(){
            var password = document.getElementById("password").value;
            var repassword = document.getElementById("repassword").value;
            if(password != repassword){
                document.getElementById("strongid").innerHTML="两次密码不一致！";
                $("input[name='password']").val("");
                $("input[name='repassword']").val("");
                return false;
            }
        }
        function ck_notnull() {
            var _username = document.getElementById("username").value;
            var _password = document.getElementById("password").value;
            if (_username == ""){
                document.getElementById("username_notnull").innerHTML="用户名不能为空！";
            }
            if (_password == ""){
                document.getElementById("password_notnull").innerHTML="密码不能为空！";
            }
        }
        function check(){
            $.ajax({
                type:"POST",
                url:"${pageContext.request.contextPath}/PreferenceServlet?jspNo=1",
                data:{
                    username:document.getElementById("username").value,
                    Preference_1:document.getElementById("selection_box_1").innerHTML,
                    Preference_2:document.getElementById("selection_box_2").innerHTML,
                    Preference_3:document.getElementById("selection_box_3").innerHTML,
                    Preference_4:document.getElementById("selection_box_4").innerHTML,
                    Preference_5:document.getElementById("selection_box_5").innerHTML
                },
                success:function () {
                    // alert("存储成功!!!");
                }
            });

            // alert(3);
            return true;
        }

        //清除所有input中记录
        window.onload = function () {
            var form_check=0;
            var tagName = document.getElementsByTagName("input");
            for(var i =0; i<tagName.length; i++){
                tagName[i].setAttribute("autocomplete","off");
            }
        };


        //切换验证码
        function refreshCode(){
            //1.获取验证码图片对象
            var vcode = document.getElementById("vcode");

            //2.设置其src属性，加时间戳
            vcode.src = "${pageContext.request.contextPath}/Checkcode?time="+new Date().getTime();
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
    </script>
    <style type="text/css">

        label,select{ vertical-align:middle;}

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
    <title>酒店推荐系统 | 登录</title>
</head>

<body>
<div class="container" id="container">
    <div class="form-container sign-up-container">
        <form action="${pageContext.request.contextPath}/UserRegistServlet" method="post" onsubmit="return check()">
            <h1>注 册</h1>

            <input type="text" name="username" class="form-control notnull" id="username" placeholder="姓名" />
            <span id="username_notnull">${username_notnull}</span>

            <input type="password" name="password" onblur="ck_notnull()" class="form-control notnull" id="password" placeholder="密码" />
            <span id="password_notnull">${password_notnull}</span>
            <div class="form-group" style="height: 250px">
                <%--<label>偏好选择：</label>--%>

                <div id="sortFactors" style="float:left">
                    <div style="margin-bottom:60px">
                        <div style="width: 180px">偏好选择--价格因素:</div>
                        <div class="sort_box" id="price_sort_1" onclick="a(this.id)">150以下</div>
                        <div class="sort_box" id="price_sort_2" onclick="a(this.id)">150--300</div>
                        <div class="sort_box" id="price_sort_3" onclick="a(this.id)">300--450</div>
                        <div class="sort_box" id="price_sort_4" onclick="a(this.id)">450--600</div>
                        <div class="sort_box" id="price_sort_5" onclick="a(this.id)">600以上</div>
                    </div>
                    <div style="margin-bottom:60px">
                        <div style="width: 180px">偏好选择--位置因素:</div>
                        <div class="sort_box" id="location_sort_1" onclick="a(this.id)">商业区</div>
                        <div class="sort_box" id="location_sort_2" onclick="a(this.id)">机场附近</div>
                        <div class="sort_box" id="location_sort_3" onclick="a(this.id)">火车站附近</div>
                        <div class="sort_box" id="location_sort_4" onclick="a(this.id)">地铁附近</div>
                        <div class="sort_box" id="location_sort_5" onclick="a(this.id)">近景区</div>
                    </div>
                    <div style="margin-bottom:60px">
                        <div style="width: 180px">偏好选择--酒店特色:</div>
                        <div class="sort_box" id="service_sort_1" onclick="a(this.id)">有早餐</div>
                        <div class="sort_box" id="service_sort_2" onclick="a(this.id)">免费WiFi</div>
                        <div class="sort_box" id="service_sort_3" onclick="a(this.id)">接送服务</div>
                        <div class="sort_box" id="service_sort_4" onclick="a(this.id)">行李寄存</div>
                        <div class="sort_box" id="service_sort_5" onclick="a(this.id)">叫醒服务</div>
                    </div>
                </div>
                <div style="margin-bottom:60px">
                    <div style="width: 150px">已选择的偏好:</div>
                    <div>
                        <div class="sort_box" id="selection_box_1" onclick="b(this.id)" ondrop="drop(event,this)" ondragover="allowDrop(event)" draggable="true" ondragstart="drag(event, this)"></div>
                        <div class="sort_box" id="selection_box_2" onclick="b(this.id)" ondrop="drop(event,this)" ondragover="allowDrop(event)" draggable="true" ondragstart="drag(event, this)"></div>
                        <div class="sort_box" id="selection_box_3" onclick="b(this.id)" ondrop="drop(event,this)" ondragover="allowDrop(event)" draggable="true" ondragstart="drag(event, this)"></div>
                        <div class="sort_box" id="selection_box_4" onclick="b(this.id)" ondrop="drop(event,this)" ondragover="allowDrop(event)" draggable="true" ondragstart="drag(event, this)"></div>
                        <div class="sort_box" id="selection_box_5" onclick="b(this.id)" ondrop="drop(event,this)" ondragover="allowDrop(event)" draggable="true" ondragstart="drag(event, this)"></div>
                    </div>
                </div>
            </div>
            <br><br><br>
            <%--<div class="form-inline">
                <label for="vcode" style="float:left">验证码：</label>
                <input type="text" name="_img" class="form-control" id="verifycode" placeholder="请输入验证码" style="width: 120px;"/>
                <a href="javascript:refreshCode();">
                    <img src="${pageContext.request.contextPath}/Checkcode" title="看不清点击刷新" id="vcode"/>
                </a>
            </div>--%>

            <button type="submit">注册</button>
        </form>
    </div>
    <div class="form-container sign-in-container">
        <form action="${pageContext.request.contextPath}/UserLoginServlet" method="post">
            <h1>登 录</h1>
            <div class="social-container">
                <a href="#" class="social"><i class="fab fa-qq"></i></a>
                <a href="#" class="social"><i class="fab fa-weixin"></i></a>
                <a href="#" class="social"><i class="fab fa-weibo"></i></a>
            </div>
            <span>选择以上方式登录或使用您的账号</span>
            <input type="text"  name="username" value="${sessionScope.resuser.username}" class="form-control" id="user" placeholder="用户名" />
            <input type="password" name="password" class="form-control" id="password" placeholder="密码" />

            <div class="form-inline">
                <label for="vcode">验证码：</label>
                <input type="text" name="_img" class="form-control" id="verifycode" placeholder="请输入验证码" style="width: 120px;"/>
                <a href="javascript:refreshCode();">
                    <img src="${pageContext.request.contextPath}/Checkcode" title="看不清点击刷新" id="vcode"/>
                </a>
            </div>
            <button type="submit">登录</button>
            <a href="#">忘记密码？</a>
        </form>
    </div>
    <div class="overlay-container">
        <div class="overlay">
            <div class="overlay-panel overlay-left">
                <h1>已有账号？</h1>
                <p>请使用您的账号进行登录</p>
                <button class="ghost" id="signIn">登录</button>
            </div>
            <div class="overlay-panel overlay-right">
                <h1>没有账号？</h1>
                <p>立即注册加入我们，和我们一起开始旅程吧。</p>
                <button class="ghost" id="signUp">注册</button>
            </div>
        </div>
    </div>
</div>
<script src="js/main.js"></script>
</body>

</html>
