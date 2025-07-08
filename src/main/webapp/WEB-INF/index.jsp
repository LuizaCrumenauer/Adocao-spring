<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<html>
<head>
    <title>Lar Doce Lar Animal - Adoção Responsável</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css"/>
</head>
<body>
<div class="wrapper">
    <header>
        <h1>Lar Doce Lar Animal</h1>
        <p class="logo-subtitle">Encontre seu novo melhor amigo!</p>
    </header>

    <nav>
        <a href="${pageContext.request.contextPath}/" class="active">Adote</a>
        <c:choose>
            <c:when test="${empty sessionScope.usuarioLogado}">
                <a href="${pageContext.request.contextPath}/login">Login</a>
                <a href="${pageContext.request.contextPath}/usuario/cadastro">Criar Conta</a>
            </c:when>
            <c:otherwise>
                <c:choose>
                    <c:when test="${sessionScope.usuarioLogado.admin}">
                        <a href="${pageContext.request.contextPath}/usuario/dashboard_admin">Meu Painel</a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/usuario/dashboard_usuario">Meu Painel</a>
                    </c:otherwise>
                </c:choose>
                <a href="${pageContext.request.contextPath}/logout">Sair</a>
            </c:otherwise>
        </c:choose>
    </nav>

    <div class="container">
        <h2 class="page-title">Conheça Nossos Amigos à Espera de um Lar!</h2>

        <c:if test="${not empty mensagemGlobal}">
            <p class="mensagem-global success">${mensagemGlobal}</p>
        </c:if>

        <div class="pet-grid">
            <c:choose>
                <c:when test="${not empty cachorrosDisponiveis && cachorrosDisponiveis.size() > 0}">
                    <c:forEach var="cachorro" items="${cachorrosDisponiveis}">
                        <div class="pet-card">

                                <%--CARROSSEL DE IMAGENS --%>
                            <div class="carousel-container">
                                <c:choose>
                                    <c:when test="${not empty cachorro.imagens}">
                                        <c:forEach var="imagem" items="${cachorro.imagens}" varStatus="loop">
                                            <div class="carousel-slide ${loop.first ? 'active' : ''}">
                                                <img src="${pageContext.request.contextPath}/imagens/${imagem}" alt="Foto de ${cachorro.nome}">
                                            </div>
                                        </c:forEach>
                                        <c:if test="${cachorro.imagens.size() > 1}">
                                            <a class="prev" onclick="plusSlides(this, -1)">&#10094;</a>
                                            <a class="next" onclick="plusSlides(this, 1)">&#10095;</a>
                                        </c:if>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="carousel-slide active">
                                            <img src="${pageContext.request.contextPath}/imagens/semimagem.jpg" alt="Sem foto">
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <h3>${cachorro.nome}</h3>
                            <p>
                                <strong>Raça:</strong> ${cachorro.raca}<br>
                                <strong>Sexo:</strong> ${cachorro.sexo}<br>
                                <strong>Porte:</strong> ${cachorro.porte}
                            </p>

                            <c:choose>
                                <c:when test="${empty sessionScope.usuarioLogado}">
                                    <a href="${pageContext.request.contextPath}/login?redirectTo=adocao&cachorroId=${cachorro.id}" class="adocao-button">Quero Adotar!</a>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/adocao?id_cachorro=${cachorro.id}" class="adocao-button">Quero Adotar!</a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <p style="text-align:center; grid-column: 1 / -1;">Nenhum cachorrinho disponível para adoção no momento. Volte em breve!</p>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<footer>
    <p>&copy; <fmt:formatDate value="<%=new java.util.Date()%>" pattern="yyyy" /> Lar Doce Lar Animal. Todos os direitos reservados.</p>
    <p>Trabalho de Aula - POOW1</p>
</footer>

<script src="${pageContext.request.contextPath}/js/script.js"></script>

</body>
</html>