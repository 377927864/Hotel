<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020-03-18
  Time: 16:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <title>用户注册</title>

    <!-- 1. 导入CSS的全局样式 -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <!-- 2. jQuery导入，建议使用1.9以上的版本 -->
    <script src="js/jquery-2.1.0.min.js"></script>
    <!-- 3. 导入bootstrap的js文件 -->
    <script src="js/bootstrap.min.js"></script>
    <script type="text/javascript">


    //TODO 用户名校验

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
        /*var name = document.getElementById("name").value;
        if(name ==  null || name == ''){
            alert("用户名不能为空");
            return false;
        }*/

        // alert(1);
        //在这里用ajax往后台存入用户偏好
        // alert(document.getElementById("selection_box_1").innerHTML+"+"+document.getElementById("selection_box_2").innerHTML+"+"+document.getElementById("selection_box_3").innerHTML+"+"+document.getElementById("selection_box_4").innerHTML+"+"+document.getElementById("selection_box_5").innerHTML);
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
        /*$(function(){

            $("#sub").click(function(){

                var pwd = $("input[name='password']").val();

                var rpwd = $("input[name='repassword']").val();
                if(pwd != rpwd){
                    alert("两次密码不一致!");
                    $("input[name='uPwd']").val("");
                    $("input[name='uPwd2']").val("");
                    return false;
                }
            });
        });*/

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
        /*form fieldset{
            border: 0 #d3d3d3;
            text-align: center;
            margin-bottom:15px;
        }
        label{
            display: inline-block;
            width: 350px;
            text-align: right;
        }
        input{
            width: 350px;
        }
        !*#button input{
            width: 60px;
            position: relative;
            left: 30%;
        }*!
        select{
            width: 350px;
        }*/
        /*dl{
            display: block;
            padding:10px 0;
            clear: both;
        }
        dt{
            float:left;
            margin-right: 10px;
            width: 130px;
            line-height: 36px;
            font-size: 14px;
            text-align: right;
        }
        dd{
            float:left;
        }
        .r_input{
            position: relative;
            height: 28px;
            line-height: 28px;
            padding-left: 10px;
            font-size: 14px;
            color: #333;
            border-color: #ccc;
        }

        .div{
            background-color:#F00;
            overflow:auto;

        }

        .div>.div1{

            width:50%;
            height:100px;
            line-height:100px;
            display:inline-block;
        }
        .div>.div2{

            width:50%;
            height:100px;
            line-height:100px;
            background-color:#aaa;
            display:inline-block;
        }*/

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

        /*.abc{
            width:900px;
            height:700px;
            border:1px solid #F00;
            overflow: hidden;
            position:relative;!**绝对定位**!
            left:50%;!**左边50%**!
            top:20%;!**顶部50%**!
            !*margin-top:-50px;!**上移-50%**!*!
            margin-left:-100px;!**左移-50%**!
        }*/

        .notclick{
            pointer-events: none;
            background-color: gray;
        }

    </style>

</head>
<body>
<div class="container" style="width: 600px;">
    <h3 style="text-align: center;">新用户注册</h3>
    <div>
        <span>提示:带有<span style="color: red; ">*</span>的内容为必填项</span><br>
        <form action="${pageContext.request.contextPath}/UserRegistServlet" method="post" onsubmit="return check()">
            <%--<dl>
                <dt class="label">用户名：</dt>
                <dd>
                    <div class="r_input">
                        <input type="text" name="username" id="user" placeholder="请输入用户名">
                    </div>
                    <font color="red">*</font>
                </dd>
            </dl>--%>

            <div class="form-group">
                <label for="username" style="float:left">用户名<span style="color: red; ">*</span>：</label>
                <input type="text" name="username" class="form-control notnull" id="username" placeholder="请输入用户名"/>
            </div>
                <span id="username_notnull">${username_notnull}</span>

            <div class="form-group">
                <label for="password" style="float:left">密码<span style="color: red; ">*</span>：</label>
                <input type="password" name="password" onblur="ck_notnull()" class="form-control notnull" id="password" placeholder="请输入密码"/>
            </div>
                <span id="password_notnull">${password_notnull}</span>

            <div class="form-group">
                <label for="repassword" style="float:left">确认密码<span style="color: red; ">*</span>：</label>
                <input type="password" name="repassword" class="form-control notnull" onblur="ckpwd()" id="repassword" placeholder="确认密码"/>
            </div>
                <span id="username_notnull">${username_notnull}</span>

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

            <div class="form-group">
                <label for="nickname">昵称</label>
                <input type="text" name="nickname" class="form-control" id="nickname" placeholder="请输入昵称">
            </div>

            <div class="form-group">
                <label for="sex" style="float:left">性别</label>
                <select class="form-control" id="sex" name="sex">
                    <option value="">请选择性别</option>
                    <option value="男">男</option>
                    <option value="女">女</option>
                </select>
            </div>
            <div class="form-group">
                <label for="email" style="float:left">邮箱</label>
                <input type="text" name="email" class="form-control" id="email" placeholder="请输入邮箱">
            </div>
            <%--<div class="text" style="margin-bottom: 20px;">--%>
            <div class="form-group" style="margin-bottom: 20px;">
            <label for="occupation" style="float:left">职业</label>
                <select class="form-control" id="occupation" name="occupation">
                    <option value="">请选择职业</option>
                    <option value="计算机/互联网/通信">计算机/互联网/通信</option>
                    <option value="生产/工艺/制作">生产/工艺/制作</option>
                    <option value="医疗/护理/制药">医疗/护理/制药</option>
                    <option value="金融/银行/投资/保险">金融/银行/投资/保险</option>
                    <option value="商业/服务业/个体经营">商业/服务业/个体经营</option>
                    <option value="文化/广告/传媒">文化/广告/传媒</option>
                    <option value="娱乐/艺术/表演">娱乐/艺术/表演</option>
                    <option value="律师/法务">律师/法务</option>
                    <option value="教育/培训">教育/培训</option>
                    <option value="公务员/行政/事业单位">公务员/行政/事业单位</option>
                    <option value="模特">模特</option>
                    <option value="空姐">空姐</option>
                    <option value="学生">学生</option>
                    <option value="其他职业">其他职业</option>
                </select>
            </div>
            <div class="text" style="margin-bottom: 20px;">
                <label for="birthday" style="float:left">出生日期</label>
                <input type="text" name="birthday" class="form-control" id="birthday" placeholder="请输入出生日期，例如:2020/01/01">
            </div>
            <div class="text" style="margin-bottom: 20px;">
                <label for="address" style="float:left">住址</label>
                <input type="text" name="address" class="form-control" id="address" placeholder="请输入住址，例如:北京">
            </div>
            <div class="text" style="margin-bottom: 20px;">
                <label for="tel" style="float:left">电话</label>
                <input type="text" name="tel" class="form-control" id="tel" placeholder="请输入电话">
            </div>

            <div class="form-inline">
                <label for="vcode" style="float:left">验证码：</label>
                <input type="text" name="_img" class="form-control" id="verifycode" placeholder="请输入验证码" style="width: 120px;"/>
                <a href="javascript:refreshCode();">
                    <img src="${pageContext.request.contextPath}/Checkcode" title="看不清点击刷新" id="vcode"/>
                </a>
            </div>
            <hr/>
            <div>
                <span id="isnull">${isnull}</span>
            </div>
            <div class="form-group" style="text-align: center;">
                <input class="btn btn btn-primary" type="submit" value="注册" onclick="cknull()">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                已有帐号,<a href="${pageContext.request.contextPath}/login.jsp">点击登录</a>
            </div>
        </form>
    </div>
    <!-- 出错显示的信息框 -->
    <div class="alert alert-warning alert-dismissible" role="alert">
        <button type="button" class="close" data-dismiss="alert" >
            <span class="glyphicon glyphicon-remove"></span>
        </button>
        <strong id="strongid">${msg}</strong>
    </div>
</div>

<%--<form action="${pageContext.request.contextPath}/UserRegistServlet" method="post">
    <fieldset>
        <p>
            <label for="user">用户名：</label>
            <input type="text"  name="username" id="user" placeholder="请输入用户名"/>
            <font color="red">*</font>
        </p>
        <p>
            <label for="password">密码：</label>
            <input type="password" name="password" id="password" placeholder="请输入密码"/>
            <font color="red">*</font>
        </p>
        <p>
            <label for="repassword">确认密码：</label>
            <input type="password" name="repassword" onblur="ckpwd()" id="repassword" placeholder="确认密码"/>
            <font color="red">*</font>
        </p>
        <p>
            <label for="nickname">昵称</label>
            <input type="text" name="nickname" id="nickname" placeholder="请输入昵称">
        </p>
        <p>
            <label for="sex">性别</label>
            <select id="sex" name="_sex">
                <option value="">请选择性别</option>
                <option value="男">男</option>
                <option value="女">女</option>
            </select>
        </p>
        <p>
            <label for="email">邮箱</label>
            <input type="text" name="email" id="email" placeholder="请输入邮箱">
        </p>
        <p>
            <label for="occupation">职业</label>
            <select id="occupation" name="occupation">
                <option value="">请选择职业</option>
                <option value="计算机/互联网/通信">计算机/互联网/通信</option>
                <option value="生产/工艺/制作">生产/工艺/制作</option>
                <option value="医疗/护理/制药">医疗/护理/制药</option>
                <option value="金融/银行/投资/保险">金融/银行/投资/保险</option>
                <option value="商业/服务业/个体经营">商业/服务业/个体经营</option>
                <option value="文化/广告/传媒">文化/广告/传媒</option>
                <option value="娱乐/艺术/表演">娱乐/艺术/表演</option>
                <option value="律师/法务">律师/法务</option>
                <option value="教育/培训">教育/培训</option>
                <option value="公务员/行政/事业单位">公务员/行政/事业单位</option>
                <option value="模特">模特</option>
                <option value="空姐">空姐</option>
                <option value="学生">学生</option>
                <option value="其他职业">其他职业</option>
            </select>
        </p>
        <p>
            <label for="birthday">出生日期</label>
            <input type="text" name="birthday" id="birthday" placeholder="请输入出生日期，例如:2020/01/01">
        </p>
        <p>
            <label for="address">住址</label>
            <input type="text" name="address" id="address" placeholder="请输入住址，例如:北京">
        </p>
        <p>
            <label for="tel">电话</label>
            <input type="text" name="tel" id="tel" placeholder="请输入电话">
        </p>
        &lt;%&ndash;<p id="button">
            <input type="submit" name="submit" value="登录">
            <input type="reset" name="reset" value="重置">
        </p>&ndash;%&gt;
        <div class="form-inline">
            <label for="vcode" style="float:left">验证码：</label>
            <input type="text" name="_img" class="form-control" id="verifycode" placeholder="请输入验证码" style="width: 120px;"/>
            <a href="javascript:refreshCode();">
                <img src="${pageContext.request.contextPath}/Checkcode" title="看不清点击刷新" id="vcode"/>
            </a>
        </div>
        <div>
            <span id="isnull">${isnull}</span>
            </br>
        </div>
        <div class="form-group" style="text-align: center;">
            <input class="btn btn btn-primary" type="submit" value="注册">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            已有帐号,点击<a href="${pageContext.request.contextPath}/login.jsp">登录</a>
        </div>
    </fieldset>
</form>--%>

</body>
</html>