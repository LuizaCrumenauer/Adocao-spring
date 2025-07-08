<%@page contentType="text/html; charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Login - Lar Doce Lar Animal</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css"/>
</head>
<body>
<div class="wrapper">
  <header>
    <h1>Lar Doce Lar Animal</h1>
    <p class="logo-subtitle">Acesse sua conta ou cadastre-se!</p>
  </header>

  <nav>
    <a href="${pageContext.request.contextPath}/">Adote</a>
    <a href="${pageContext.request.contextPath}/login" class="active">Login</a>
    <a href="${pageContext.request.contextPath}/usuario/cadastro">Criar Conta</a>
  </nav>

  <div class="form-container-wrapper">
    <div class="form-container">
      <h2>LOGIN NO SISTEMA</h2>

      <c:if test="${not empty redirectTo and redirectTo == 'adocao'}">
        <div class="message-container info">
          <p>Você precisa fazer login para continuar o processo de adoção.</p>
        </div>
      </c:if>

      <c:if test="${not empty msg}">
        <div class="message-container error">
          <p>${msg}</p>
        </div>
      </c:if>

      <c:if test="${not empty msg_cadastro_sucesso}">
        <div class="message-container success">
          <p>${msg_cadastro_sucesso}</p>
        </div>
      </c:if>


      <form action="${pageContext.request.contextPath}/login" method="post">
        <c:if test="${not empty redirectTo}">
          <input type="hidden" name="redirectTo" value="${redirectTo}">
        </c:if>
        <c:if test="${not empty cachorroId}">
          <input type="hidden" name="cachorroId" value="${cachorroId}">
        </c:if>

        <div class="form-group">
          <label for="email">E-mail:</label>
          <input type="email" id="email" placeholder="seu@email.com" name="email" value="${not empty email ? email : ''}" required>
        </div>
        <div class="form-group">
          <label for="senha">Senha:</label>
          <input type="password" id="senha" placeholder="Sua Senha" name="senha" required>
        </div>
        <input type="submit" value="LOGAR">
      </form>

      <div class="form-link">
        Não tem uma conta? <a href="${pageContext.request.contextPath}/usuario/cadastro">Cadastre-se</a>
      </div>

      <a href="${pageContext.request.contextPath}/" class="button back-link-button">Voltar à Página Inicial</a>
    </div>
  </div>
</div>

<footer>
  <p>&copy; <fmt:formatDate value="<%=new java.util.Date()%>" pattern="yyyy" /> Lar Doce Lar Animal. Todos os direitos reservados.</p>
  <p>Trabalho de Aula - POOW1</p>
</footer>

</body>
</html>