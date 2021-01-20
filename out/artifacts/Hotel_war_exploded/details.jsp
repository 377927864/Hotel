<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="cn.hotel.dao.impl.DetailsDaoImpl" %>
<%@ page import="cn.hotel.dao.DetailsDao" %>
<%@ page import="cn.hotel.bean.Hotel" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<%@ page isELIgnored="false" %>--%>
<html>
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

    <!-- 1. 导入CSS的全局样式 -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <!-- 2. jQuery导入，建议使用1.9以上的版本 -->
    <script src="js/jquery-2.1.0.min.js"></script>
    <!-- 3. 导入bootstrap的js文件 -->
    <script src="js/bootstrap.min.js"></script>

    <title>Title</title>

    <style type="text/css">
        td, th {
            text-align: center;
        }
        ul li, ol li {
            list-style: none;
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

        .isReserve {
            float: left;
            background-color: orange;
            /*border: none;*/
            color: black;
            padding: 10px 20px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            border-radius:5px
        }
    </style>


    
</head>
<body>

<c:if test="${empty sessionScope.resuser}">
    <span>未登录</span>
    请<a href="${pageContext.request.contextPath}/login.jsp">登录</a>
</c:if>

<c:if test="${not empty sessionScope.resuser}">

    欢迎 &nbsp;<span style="color: orange">${sessionScope.resuser.username}&nbsp;</span>
    <a href="${pageContext.request.contextPath}/UserInformation.jsp">[个人信息]</a>
    <a href="${pageContext.request.contextPath}/LoginOutServlet">[注销]</a>


    <%
        String hotelId = request.getParameter("hotelId");
        String userid = request.getParameter("userid");
        DetailsDao dao = new DetailsDaoImpl();
        System.out.println(hotelId+"+"+userid);
        Hotel this_hotel = dao.hotelDet(hotelId);
        request.setAttribute("hotel", this_hotel);



    %>

    <div align="center">
        <div class="_list">
            <ul class="_searchresult" style="display: inline-block">
                <li class="hotel_pic">
                        <%--酒店图片链接--%>
                    <img src="img/example.jpg" width="130px" height="140px">
                </li>
                <li class="searchresult_info">
                    <div class="searchresult_name">
                        <%--<a href="details.jsp?hotelId=${hotel.hotelId}" title="${hotel.hotelname}">${hotel.hotelname}</a>--%>
                            <a title="${hotel.hotelname}">${hotel.hotelname}</a>
                            <div>品质保障:${hotel.isAssurance}</div>
                    </div>
                    <br>
                    <div>
                        ${hotel.features}
                    </div>
                    <div class="hotel_score">
                        <a href="">
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
                    <br>
                    <br>
                    <br>
                    <button type="button" id="isReserve" class="isReserve" onclick="reserve()">预定</button></br>
                    <span id="reserve_result"></span>
                </li>
            </ul>
            <button type="button" style="float: right;" class="btn btn-default btn-md" onclick="back_to_search()">返回搜索页</button>
        </div>
    </div>
</c:if>
</body>

<script>

    var time = 0;

    window.onload = function () {
        setInterval(function(){
            // var t = new Date();
            time++;
            console.log(time);
        }, 1000);
    };

    function back_to_search() {
        $.ajax({
           type:"POST",
           url:"${pageContext.request.contextPath}/PreferenceServlet?jspNo=3",
           data:{
               userid:${sessionScope.resuser.userid},
               username:"${sessionScope.resuser.username}",
               hotelname:"${hotel.hotelname}",
               browsing_time:time
           },
           success:function () {
               // alert("0611 yes!");
           }
        });
        window.history.back();
    }

    //根据hotelId查询
    function reserve() {
        var userid = ${sessionScope.resuser.userid};
        <%--var hotelid = "";--%>
        <%--hotelid = ${hotel.hotelId};--%>
        var hotelId = ${hotel.hotelId};
        // alert(userid+"++"+hotelid);
        $.ajax({
            type:"POST",
            url:"${pageContext.request.contextPath}/ReserveServlet",
            // data:"userid="+userid+"&"+"hotelId="+hotelId,
            data:{
                userid:${sessionScope.resuser.userid},
                <%--username:${sessionScope.resuser.username},--%>
                hotelId:${hotel.hotelId},
                <%--hotelname:${hotel.hotelname}--%>
            },
            success:function () {
                alert("yes!!!");
                //状态1为已预订，说明预定失败；状态0为未预定，说明预定成功
                document.getElementById("reserve_result").innerHTML = "预定成功";
                $("isReserve").prop("disabled", true);
                document.getElementById("isReserve").innerHTML = "已预订";
            }
        });
    }

</script>

</html>