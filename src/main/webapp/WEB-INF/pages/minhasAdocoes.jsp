<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page isELIgnored="false" %>

<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Minhas Adoções - Lar Doce Lar Animal</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css"/>
</head>
<body>
<div class="wrapper">
    <header>
        <h1>Lar Doce Lar Animal</h1>
        <p class="logo-subtitle">Acompanhe suas adoções.</p>
    </header>

    <nav>
        <a href="${pageContext.request.contextPath}/">Adote</a>
        <c:choose>
            <c:when test="${sessionScope.usuarioLogado.admin}">
                <a href="${pageContext.request.contextPath}/usuario/dashboard_admin">Meu Painel</a>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/usuario/dashboard_usuario">Meu Painel</a>
            </c:otherwise>
        </c:choose>
        <a href="${pageContext.request.contextPath}/adocao/minhas" class="active">Minhas Adoções</a>
        <a href="${pageContext.request.contextPath}/logout">Sair</a>
    </nav>

    <div class="container">
        <h2 class="page-title">Minhas Adoções</h2>

        <c:if test="${not empty msg_adocao_status}">
            <div class="message-container ${msg_adocao_status.toLowerCase().contains('sucesso') || msg_adocao_status.toLowerCase().contains('atualizadas') ? 'success' : 'error'}">
                <p><c:out value="${msg_adocao_status}"/></p>
            </div>
        </c:if>

        <c:choose>
            <c:when test="${not empty minhasAdocoes}">
                <div class="table-responsive-wrapper">
                    <table class="data-table">
                        <thead>
                        <tr>
                            <th>Nome do Pet</th>
                            <th>Raça</th>
                            <th>Porte</th>
                            <th>Informações Fornecidas</th>
                            <th>Ações</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="adocao" items="${minhasAdocoes}">
                            <tr>
                                <td data-label="Nome do Pet">${adocao.cachorro.nome}</td>
                                <td data-label="Raça">${adocao.cachorro.raca}</td>
                                <td data-label="Porte">${adocao.cachorro.porte}</td>
                                <td data-label="Informações"><c:out value="${adocao.informacoes}"/></td>
                                <td data-label="Ações" class="table-actions">
                                    <a href="${pageContext.request.contextPath}/adocao/editar/${adocao.id}" class="table-action-button edit">Editar</a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:when>
            <c:otherwise>
                <p class="empty-data-message">Você ainda não realizou nenhuma adoção.</p>
            </c:otherwise>
        </c:choose>

        <div class="page-navigation-links">
            <a href="${pageContext.request.contextPath}/cachorros" class="action-button secondary">Ver Pets Disponíveis</a>
            <c:choose>
                <c:when test="${sessionScope.usuarioLogado.admin}">
                    <a href="${pageContext.request.contextPath}/usuario/dashboard_admin" class="action-button primary">Meu Painel</a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/usuario/dashboard_usuario" class="action-button primary">Meu Painel</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>
<footer>
    <p>&copy; <fmt:formatDate value="<%=new java.util.Date()%>" pattern="yyyy" /> Lar Doce Lar Animal. Todos os direitos reservados.</p>
    <p>Trabalho de Aula - POOW1</p>
</footer>
</body>
</html>