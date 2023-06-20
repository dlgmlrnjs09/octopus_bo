<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <div>
      <div>
        <form method="post" action="/authenticate">
          <div>
            <label>ID</label>
            <input type="text" name="userId">
          </div>
          <div>
            <label>암호</label>
            <input type="password" name="password">
          </div>
          <div>
            <label></label>
            <input type="submit" value="로그인">
          </div>
        </form>
      </div>
    </div>
  </body>
</html>
