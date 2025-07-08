<%@page contentType="text/html; charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page isELIgnored="false" %>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cadastrar Novo Administrador - Lar Doce Lar Animal</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css"/>
</head>
<body>
<div class="wrapper">
    <header>
        <h1>Lar Doce Lar Animal</h1>
        <p class="logo-subtitle">Painel Administrativo - Novo Administrador</p>
    </header>

    <nav>

        <a href="${pageContext.request.contextPath}/usuario/dashboard_admin">Painel Admin</a><a href="${pageContext.request.contextPath}/">Ver Site</a>
        <a href="${pageContext.request.contextPath}/usuario/listar">Gerenciar Usuários</a>
        <a href="${pageContext.request.contextPath}/usuario/admin/cadastro" class="active">Cadastrar Admin</a>
        <a href="${pageContext.request.contextPath}/cachorros/gerenciar">Gerenciar Pets</a>
        <a href="${pageContext.request.contextPath}/logout">Sair</a>
    </nav>

    <div class="container">
        <div class="form-container-wrapper">
            <div class="form-container cadastro">
                <h2 class="page-title" style="font-size: 1.8em; margin-bottom: 20px;">Cadastrar Novo Administrador</h2>

                <c:if test="${not empty msg_erro_cadastro_admin}">
                    <div class="message-container error">
                        <p><c:out value="${msg_erro_cadastro_admin}"/></p>
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/usuario/admin/cadastrar" method="post">

                    <div class="form-group">
                        <label for="nome">Nome Completo:</label>
                        <input type="text" id="nome" name="nome" value="<c:out value='${usuario.nome}'/>" required>
                    </div>
                    <div class="form-group">
                        <label for="endereco">Endereço:</label>
                        <input type="text" id="endereco" name="endereco" value="<c:out value='${usuario.endereco}'/>">
                    </div>
                    <div class="form-group">
                        <label for="cpf">CPF:</label>
                        <input type="text" id="cpf" name="cpf" value="<c:out value='${usuario.cpf}'/>" placeholder="000.000.000-00">
                    </div>
                    <div class="form-group">
                        <label for="celular">Celular:</label>
                        <input type="tel" id="celular" name="celular" value="<c:out value='${usuario.celular}'/>" placeholder="(00) 90000-0000">
                    </div>
                    <div class="form-group">
                        <label for="email">E-mail:</label>
                        <input type="email" id="email" name="email" value="<c:out value='${usuario.email}'/>" placeholder="admin@email.com" required>
                    </div>
                    <div class="form-group">
                        <label for="senha">Senha:</label>
                        <input type="password" id="senha" name="senha" required>
                    </div>

                    <input type="submit" value="Cadastrar Administrador">
                </form>

                <a href="${pageContext.request.contextPath}/usuario/dashboard_admin" class="button back-link-button" style="margin-top: 20px;">Voltar ao Dashboard</a>
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