<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  request.setAttribute("title", "Login");
%>

<!DOCTYPE html>
<html>
<head>
  <jsp:include page="/_layouts/head.jsp" />
</head>
<body class="bg-gradient-primary">
  <div class="container">
    <div class="row justify-content-center align-items-center" style="height: 100vh;">
      <div class="col-xl-10 col-lg-12 col-md-9">
        <div class="card o-hidden border-0 shadow-lg my-5">
          <div class="card-body p-0">
            <div class="row">
              <div class="col-12">
                <div class="p-5">
                  <div class="text-center">
                    <h1 class="h4 text-gray-900 mb-4">Login</h1>
                  </div>

                  <form class="user" action="login" method="post">
                    <div class="form-group">
                      <input type="email" class="form-control form-control-user"
                        id="exampleInputEmail" aria-describedby="emailHelp"
                        name="email" placeholder="Enter Email Address...">
                    </div>

                    <div class="form-group">
                      <input type="password" class="form-control form-control-user"
                        id="exampleInputPassword" name="password" placeholder="Password">
                    </div>

                    <% if (request.getAttribute("error") != null) { %>
                      <div class="alert alert-danger" role="alert">
                        <%= request.getAttribute("error") %>
                      </div>
                    <% } %>
                    
                    <button type="submit" class="btn btn-primary btn-user btn-block">
                      Login
                    </button>
                  </form>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <jsp:include page="/_layouts/script.jsp" />
</body>
</html>