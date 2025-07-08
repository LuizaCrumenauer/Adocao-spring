<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page isELIgnored="false" %>

<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Meu Painel - Lar Doce Lar Animal</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css"/>
</head>
<body>
<div class="wrapper">
    <header>
        <h1>Lar Doce Lar Animal</h1>
        <p class="logo-subtitle">Seu espaço pessoal em nossa comunidade.</p>
    </header>

    <nav>
        <a href="${pageContext.request.contextPath}/">Adote</a>
        <c:choose>
            <c:when test="${sessionScope.usuarioLogado.admin}">
                <a href="${pageContext.request.contextPath}/usuario/dashboard_admin">Meu Painel</a>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/usuario/dashboard_usuario" class="active">Meu Painel</a>
            </c:otherwise>
        </c:choose>

        <a href="${pageContext.request.contextPath}/adocao/minhas">Minhas Adoções</a>
        <a href="${pageContext.request.contextPath}/logout">Sair</a>
    </nav>

    <div class="container">
        <h2 class="page-title">Painel do Usuário</h2>

        <div class="dashboard-content">
            <p class="dashboard-welcome-text">
                Olá, <strong><c:out value="${sessionScope.usuarioLogado.nome}"/></strong>! Seja bem-vindo(a) de volta.
            </p>

            <c:if test="${not empty msg_adocao_status}">
                <div class="message-container ${msg_adocao_status.toLowerCase().contains('sucesso') ? 'success' : 'error'}">
                    <p><c:out value="${msg_adocao_status}"/></p>
                </div>
            </c:if>

            <div class="dashboard-actions">
                <a href="${pageContext.request.contextPath}/adocao/minhas" class="action-button primary">
                    Minhas Adoções
                </a>
                <a href="${pageContext.request.contextPath}/cachorros" class="action-button secondary">
                    Ver Pets para Adoção
                </a>
            </div>
        </div>
    </div>
</div>

<footer>
    <p>&copy; <fmt:formatDate value="<%=new java.util.Date()%>" pattern="yyyy" /> Lar Doce Lar Animal. Todos os direitos reservados.</p>
    <p>Trabalho de Aula - POOW1</p>
</footer>
</body>
</html>