<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Alterar Dados do Pet - Lar Doce Lar Animal</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" type="text/css"/>
    <style>
        .image-management-gallery { display: grid; grid-template-columns: repeat(auto-fill, minmax(120px, 1fr)); gap: 15px; margin-top: 15px; padding: 15px; border: 1px solid #eee; border-radius: 8px; }
        .image-container { position: relative; border-radius: 4px; overflow: hidden; }
        .image-container img { width: 100%; height: 120px; object-fit: cover; display: block; }
        .image-container .delete-btn { position: absolute; top: 5px; right: 5px; background-color: rgba(231, 76, 60, 0.8); color: white; border: none; border-radius: 50%; width: 24px; height: 24px; font-size: 14px; font-weight: bold; line-height: 24px; text-align: center; cursor: pointer; text-decoration: none; transition: background-color 0.3s; }
        .image-container .delete-btn:hover { background-color: #c0392b; }
    </style>
</head>
<body>
<div class="wrapper">
    <header>
        <h1>Lar Doce Lar Animal</h1>
        <p class="logo-subtitle">Painel Administrativo - Alterar Dados do Pet</p>
    </header>

    <nav>
        <a href="${pageContext.request.contextPath}/usuario/dashboard_admin">Painel Admin</a>
        <a href="${pageContext.request.contextPath}/usuario/listar">Gerenciar Usuários</a>
        <a href="${pageContext.request.contextPath}/cachorros/gerenciar" class="active">Gerenciar Pets</a>
        <a href="${pageContext.request.contextPath}/logout">Sair</a>
    </nav>

    <div class="container">
        <div class="form-container-wrapper">
            <div class="form-container cadastro">
                <h2 class="page-title" style="font-size: 1.8em; margin-bottom: 20px;">Alterar Pet: <c:out value="${cachorro.nome}"/></h2>

                <c:if test="${not empty msg}">
                    <div class="message-container ${msg.toLowerCase().contains('sucesso') ? 'success' : 'error'}">
                        <p><c:out value="${msg}"/></p>
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/cachorros/editar" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="id" value="${cachorro.id}">

                    <div class="form-group">
                        <label for="nome">Nome:</label>
                        <input type="text" id="nome" name="nome" value="<c:out value="${cachorro.nome}"/>" required>
                    </div>
                    <div class="form-group">
                        <label for="raca">Raça:</label>
                        <input type="text" id="raca" name="raca" value="<c:out value="${cachorro.raca}"/>" required>
                    </div>
                    <div class="form-group">
                        <label for="sexo">Sexo:</label>
                        <select id="sexo" name="sexo" required>
                            <option value="Macho" ${cachorro.sexo == 'Macho' ? 'selected' : ''}>Macho</option>
                            <option value="Fêmea" ${cachorro.sexo == 'Fêmea' ? 'selected' : ''}>Fêmea</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="porte">Porte:</label>
                        <select id="porte" name="porte" required>
                            <option value="Pequeno" ${cachorro.porte == 'Pequeno' ? 'selected' : ''}>Pequeno</option>
                            <option value="Médio" ${cachorro.porte == 'Médio' ? 'selected' : ''}>Médio</option>
                            <option value="Grande" ${cachorro.porte == 'Grande' ? 'selected' : ''}>Grande</option>
                        </select>
                    </div>
                    <div class="form-group form-group-checkbox">
                        <input type="checkbox" id="adotado" name="adotado" value="true" ${cachorro.adotado ? 'checked' : ''}>
                        <label for="adotado" class="checkbox-label">Adotado?</label>
                    </div>

                    <hr class="separator">

                    <div class="form-group">
                        <label>Imagens Atuais:</label>
                        <div class="image-management-gallery">
                            <c:choose>
                                <c:when test="${not empty cachorro.imagens}">
                                    <c:forEach var="imagem" items="${cachorro.imagens}">
                                        <div class="image-container">
                                            <img src="${pageContext.request.contextPath}/imagens/${imagem}" alt="Foto de ${cachorro.nome}">
                                            <a href="${pageContext.request.contextPath}/cachorros/imagem/excluir?idCachorro=${cachorro.id}&nomeImagem=${imagem}"
                                               class="delete-btn" title="Excluir Imagem"
                                               onclick="return confirm('Tem certeza que quer excluir esta imagem?');">&times;</a>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <p>Nenhuma imagem cadastrada.</p>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <div class="form-group" style="margin-top: 20px;">
                        <label for="novasImagens">Adicionar Novas Imagens:</label>
                        <input type="file" id="novasImagens" name="novasImagens" multiple accept="image/*" class="form-control-file">
                        <small class="form-text-muted">Você pode selecionar várias novas imagens para adicionar.</small>
                    </div>


                    <input type="submit" value="Salvar Alterações" style="margin-top: 10px;">
                    <a href="${pageContext.request.contextPath}/cachorros/gerenciar" class="button back-link-button" style="margin-top: 10px;">Cancelar</a>
                </form>
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