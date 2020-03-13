<%@page import="java.io.BufferedReader"%>  
<%@page import="java.io.FileReader"%>  
<%@page import="java.io.File"%> 
<%@page import="java.io.FileInputStream" %>
<%@page import="java.io.InputStream" %>
<%@page import="java.io.InputStreamReader" %> 
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="UTF-8">
    <title>新冠肺炎疫情地图</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <script src="echarts.min.js"></script>
    <script src="china.js"></script>
    <script src="http://upcdn.b0.upaiyun.com/libs/jquery/jquery-2.0.2.min.js"></script>
<link rel="stylesheet" type="text/css" href="semantic/dist/semantic.min.css">
<script src="semantic/dist/semantic.min.js"></script>
    <script type="text/javascript">
function altRows(id){
    if(document.getElementsByTagName){ 
         
        var table = document.getElementById(id); 
        var rows = table.getElementsByTagName("tr");
          
        for(i = 0; i < rows.length; i++){         
            if(i % 2 == 0){
                rows[i].className = "evenrowcolor";
            }else{
                rows[i].className = "oddrowcolor";
            }     
        }
    }
}
function jump(page){
    window.location.href=page+".html";
} 
window.onload=function(){
    altRows('alternatecolor');
}
</script>
    <style>
        *{margin:0;padding:0}
        html,body{
            width:100%;
            height:100%;
        }
        #main{
              width:600px;
              height:450px;
              margin: 1px auto;
              border:1px;
          }
        /*默认长宽比0.75*/
 table.altrowstable {
    font-family: verdana,arial,sans-serif;
    font-size:22px;
    color:#333333;
    border-width: 1px;
    border-color: #a9c6c9;
    border-collapse: collapse;
}
table.altrowstable th {
    border-width: 1px;
    padding: 8px;
    border-style: solid;
    border-color: #a9c6c9;
}
table.altrowstable td {
    border-width: 1px;
    padding: 8px;
    border-style: solid;
    border-color: #a9c6c9;
}
.oddrowcolor{
    background-color:#d4e3e5;
}
.evenrowcolor{
    background-color:#c3dde0;
}
    </style>
</head>
<body>
    <div style="float: left;width:460px;height:1500px;"></div>
    <div style="height:60px;background-color: #AFEEEE">
        <p style="font-size:35px">新冠肺炎疫情地图</p>
    </div>
    <%
        String basePath="D:/log/";
        String[] list=new File(basePath).list();
        String name = request.getParameter("name");
        int num = list.length;        
        int i = 0;        
        int[] confirm = new int[15];
        int[] cure = new int[15];
        int[] dead = new int[15];
        for (int j=0;j<num;j++) {
        String path = "D:/log/"+list[j];
        FileInputStream f = new FileInputStream(path);
        InputStreamReader reader = new InputStreamReader(f, "UTF-8");
        BufferedReader bf = new BufferedReader(reader);
        String str = null;
        while ((str = bf.readLine())!= null){
            String[] line = str.split(" ");  ///以空格间隔提取内容
            if(name.equals(line[0])){
                confirm[i] = Integer.parseInt(line[1]);
                cure[i] = Integer.parseInt(line[3]);
                dead[i] = Integer.parseInt(line[4]);
                i++;
            }

        }
        bf.close();
        f.close();
        }
    %>
    <div style="width:;height: 200px">
         <p style="color:#708090">数据更新至2月02日</p>
           <table class="altrowstable" id="alternatecolor" style="width:600px;text-align: center;">
            <tr>
                <td>现存确诊<br/><p style="color:#F08080"><%=confirm[14]%></p></td>
                <td>累计确诊<br><p style="color:#A52A2A"><%=(confirm[14]+cure[14])%></p></td>
                <td>累计治愈<br><p style="color:#32CD32"><%=cure[14]%></p></td>
                <td>累计死亡<br><p style="color:#696969"><%=dead[14]%></p></td>
            </tr>

</table>
    </div>
    
     <div style="text-align:;"> 
        <p style="color:#2F4F4F;font-size:25px;"><%=name %>&nbsp;&nbsp;&nbsp;新增确诊趋势</p>   
        <form action="test2.jsp" method="post">
        <button class="ui button">选择日期</button> 
        <select name="date">
            <option value="2020-01-19">2020-01-19</option>
            <option value="2020-01-20">2020-01-20</option>
            <option value="2020-01-21">2020-01-21</option>
            <option value="2020-01-22">2020-01-22</option>
            <option value="2020-01-23">2020-01-23</option>
            <option value="2020-01-24">2020-01-24</option>
            <option value="2020-01-25">2020-01-25</option>
            <option value="2020-01-26">2020-01-26</option>
            <option value="2020-01-27">2020-01-27</option>
            <option value="2020-01-28">2020-01-28</option>
            <option value="2020-01-29">2020-01-29</option>
            <option value ="2020-01-30">2020-01-30</option>
            <option value ="2020-01-31">2020-01-31</option>
            <option value="2020-02-01">2020-02-01</option>
            <option value="2020-02-02">2020-02-02</option>
        </select>
        <input type="submit" class="ui button" value="确定" />
        </form>  
          
    </div>
 
    <div id="main" style="background-color:#F5F5F5">
        
    </div>
    <script type="text/javascript">
        
        var myChart = echarts.init(document.getElementById('main'));
        function randomValue() {
            return Math.round(Math.random()*1000);
        }
        option = {
    xAxis: {
        type: 'category',
        data: ['1.19', '1.20','1.21','1.22','1.23','1.24','1.25','1.26','1.27','1.28','1.29','1.30','1.31','2.1','2.2']
    },
    yAxis: {
        type: 'value'
    },
    series: [{
        data: ["<%=confirm[0]%>", "<%=confirm[1]%>", "<%=confirm[2]%>", "<%=confirm[3]%>", "<%=confirm[4]%>", "<%=confirm[5]%>", "<%=confirm[6]%>","<%=confirm[7]%>","<%=confirm[8]%>","<%=confirm[9]%>","<%=confirm[10]%>","<%=confirm[11]%>","<%=confirm[12]%>","<%=confirm[13]%>","<%=confirm[14]%>"],
        type: 'line'
    }]
};
        myChart.setOption(option);
    </script>
    <div style="width:1077px;height: 200px;text-align: center;">
         <button class="ui teal button">新增<br>确诊趋势</button>
         <button onclick="jump('infected')" class="ui grey basic button">新增<br>疑似趋势</button>
         <button onclick="jump('cure')" class="ui grey basic button">累计<br>治愈趋势</button>
         <button onclick="jump('dead')" class="ui grey basic button">累计<br>死亡趋势</button>
    </div>
</body>
</html>