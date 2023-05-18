<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <tiles:insertAttribute name="include"/>
    <title>Octopus</title>
</head>
<body>
    <div id="container" class="admin">
        <div class="head-area">
            <tiles:insertAttribute name="header"/>
        </div>
        <main id="main">
            <section class="section main-sec 해당영역을 나타내는 클래스-sec">
                <tiles:insertAttribute name="body"/>
                <div class="blank" style="height: 150vh;"></div>
            </section>
        </main>
        <tiles:insertAttribute name="footer"/>
    </div>
</body>
</html>