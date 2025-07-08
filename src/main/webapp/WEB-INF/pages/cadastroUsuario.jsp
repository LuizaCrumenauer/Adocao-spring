<%@page contentType="text/html; charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cadastro de Usuário - Lar Doce Lar Animal</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css"/>
</head>
<body>
<div class="wrapper">
    <header>
        <h1>Lar Doce Lar Animal</h1>
        <p class="logo-subtitle">Crie sua conta para encontrar seu novo amigo!</p>
    </header>

    <nav>
        <a href="${pageContext.request.contextPath}/">Adote</a>
        <a href="${pageContext.request.contextPath}/login">Login</a>
        <a href="${pageContext.request.contextPath}/usuario/cadastro" class="active">Criar Conta</a>
    </nav>

    <div class="form-container-wrapper">
        <div class="form-container">
            <h2>CADASTRE-SE</h2>

            <c:if test="${not empty msg_erro_cadastro}">
                <div class="message-container error">
                    <p>${msg_erro_cadastro}</p>
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/usuario/cadastrar" method="post">
                <div class="form-group">
                    <label for="nome">Nome Completo:</label>
                    <input type="text" id="nome" name="nome" value="${usuario.nome}" required>
                </div>
                <div class="form-group">
                    <label for="endereco">Endereço:</label>
                    <input type="text" id="endereco" name="endereco" value="${usuario.endereco}">
                </div>
                <div class="form-group">
                    <label for="cpf">CPF:</label>
                    <input type="text" id="cpf" name="cpf" value="${usuario.cpf}" placeholder="000.000.000-00">
                </div>
                <div class="form-group">
                    <label for="celular">Celular:</label>
                    <input type="tel" id="celular" name="celular" value="${usuario.celular}" placeholder="(00) 90000-0000">
                </div>
                <div class="form-group">
                    <label for="email">E-mail:</label>
                    <input type="email" id="email" name="email" value="${usuario.email}" placeholder="seu@email.com" required>
                </div>
                <div class="form-group">
                    <label for="senha">Senha:</label>
                    <input type="password" id="senha" name="senha" required>
                </div>

                <input type="submit" value="Cadastrar">
            </form>

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