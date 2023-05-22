<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <tiles:insertAttribute name="include"/>
    <title>Octopus</title>
</head>
<body>
    <div id="container">
        <div class="head-area">
            <tiles:insertAttribute name="header"/>
        </div>
        <main id="main">
            <div id="container" class="admin">
                <tiles:insertAttribute name="body"/>
                <div class="blank" style="height: 10vh;"></div>
            </div>
        </main>
        <tiles:insertAttribute name="footer"/>
    </div>
</body>
</html>