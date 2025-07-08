<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gerenciar Pets - Lar Doce Lar Animal</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css"/>
    <style>
        .image-preview-cell { display: flex; flex-wrap: wrap; gap: 5px; justify-content: center; align-items: center; padding: 5px; }
        .table-image-preview { width: 50px; height: 50px; object-fit: cover; border-radius: 4px; border: 1px solid #ddd; }
    </style>
</head>
<body>
<div class="wrapper">
    <header>
        <h1>Lar Doce Lar Animal</h1>
        <p class="logo-subtitle">Painel Administrativo - Gerenciar Pets</p>
    </header>

    <nav>
        <a href="${pageContext.request.contextPath}/usuario/dashboard_admin">Painel Admin</a>
        <a href="${pageContext.request.contextPath}/">Ver Site</a>
        <a href="${pageContext.request.contextPath}/usuario/listar">Gerenciar Usuários</a>
            <a href="${pageContext.request.contextPath}/usuario/admin/cadastro" >Cadastrar Admin</a>
            <a href="${pageContext.request.contextPath}/cachorros/gerenciar" class="active">Gerenciar Pets</a>
        <a href="${pageContext.request.contextPath}/logout">Sair</a>
    </nav>

    <div class="container">
        <h2 class="page-title">Gerenciamento de Pets</h2>

        <c:if test="${not empty msg}">
            <div class="message-container ${msg.toLowerCase().contains('sucesso') ? 'success' : 'error'}">
                <p><c:out value="${msg}"/></p>
            </div>
        </c:if>

        <div class="form-container cadastro" style="margin-bottom: 40px;">
            <h3 class="form-section-title">Cadastrar Novo Pet</h3>
            <form action="${pageContext.request.contextPath}/cachorros/cadastrar" method="post" enctype="multipart/form-data">

                <div class="form-grid-columns">
                    <div class="form-group">
                        <label for="nome">Nome:</label>
                        <input type="text" id="nome" name="nome" required>
                    </div>
                    <div class="form-group">
                        <label for="raca">Raça:</label>
                        <input type="text" id="raca" name="raca" required>
                    </div>
                    <div class="form-group">
                        <label for="sexo">Sexo:</label>
                        <select id="sexo" name="sexo" required>
                            <option value="">Selecione...</option>
                            <option value="Macho">Macho</option>
                            <option value="Fêmea">Fêmea</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="porte">Porte:</label>
                        <select id="porte" name="porte" required>
                            <option value="">Selecione...</option>
                            <option value="Pequeno">Pequeno</option>
                            <option value="Médio">Médio</option>
                            <option value="Grande">Grande</option>
                        </select>
                    </div>
                </div>

                <div class="form-group" style="margin-top: 20px;">
                    <label for="imagens">Fotos do Pet:</label>
                    <input type="file" id="imagens" name="novasImagens" multiple accept="image/*" class="form-control-file">
                    <small class="form-text-muted">Você pode selecionar várias imagens de uma vez.</small>
                </div>

                <input type="submit" value="Cadastrar Pet" style="margin-top: 20px;">
            </form>
        </div>

        <hr class="separator">

        <h3 class="page-title" style="font-size: 1.8em; margin-top: 30px;">Pets Cadastrados</h3>
        <div class="table-responsive-wrapper">
            <table class="data-table">
                <thead>
                <tr>
                    <th>ID</th><th>Imagens</th><th>Nome</th><th>Raça</th><th>Sexo</th><th>Porte</th><th>Adotado?</th><th>Ações</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="dog" items="${cachorros}">
                    <tr>
                        <td data-label="ID">${dog.id}</td>
                        <td data-label="Imagens">
                            <div class="image-preview-cell">
                                <c:choose>
                                    <c:when test="${not empty dog.imagens}">
                                        <c:forEach var="imagem" items="${dog.imagens}" begin="0" end="2">
                                            <img src="${pageContext.request.contextPath}/imagens/${imagem}" alt="Foto de ${dog.nome}" class="table-image-preview">
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise><small>Nenhuma</small></c:otherwise>
                                </c:choose>
                            </div>
                        </td>
                        <td data-label="Nome"><c:out value="${dog.nome}"/></td>
                        <td data-label="Raça"><c:out value="${dog.raca}"/></td>
                        <td data-label="Sexo"><c:out value="${dog.sexo}"/></td>
                        <td data-label="Porte"><c:out value="${dog.porte}"/></td>
                        <td data-label="Adotado?">${dog.adotado ? 'Sim' : 'Não'}</td>
                        <td data-label="Ações" class="table-actions">
                            <a href="${pageContext.request.contextPath}/cachorros/editar/${dog.id}" class="table-action-button edit">Alterar</a>
                            <a href="${pageContext.request.contextPath}/cachorros/excluir/${dog.id}" class="table-action-button delete"
                               onclick="return confirm('Tem certeza que deseja excluir o pet ${dog.nome}? Esta ação não pode ser desfeita.');">Excluir</a>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty cachorros}">
                    <tr>
                        <td colspan="8" class="empty-data-message" style="padding: 20px;">Nenhum pet cadastrado.</td>
                    </tr>
                </c:if>
                </tbody>
            </table>
        </div>

        <div class="page-navigation-links" style="margin-bottom: 30px;">
            <a href="${pageContext.request.contextPath}/usuario/dashboard_admin" class="action-button secondary">Voltar ao Dashboard</a>
        </div>
    </div>
</div>
<footer>
    <p>&copy; <fmt:formatDate value="<%=new java.util.Date()%>" pattern="yyyy" /> Lar Doce Lar Animal. Todos os direitos reservados.</p>
    <p>Trabalho de Aula - POOW1</p>
</footer>
</body>
</html>