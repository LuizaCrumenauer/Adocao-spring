# 🐾 Sistema de Adoção de Animais - Spring MVC

Este é um projeto acadêmico desenvolvido como parte da disciplina de **Programação Orientada a Objetos Web 1**. O sistema consiste em uma plataforma para adoção de animais, permitindo que usuários visualizem pets disponíveis e que administradores gerenciem o conteúdo do site.

> 🔄 O projeto foi originalmente desenvolvido com Servlets e JSP em um servidor WildFly e foi completamente migrado para uma arquitetura moderna utilizando **Spring Boot** com o framework **Spring MVC**.

---

## ✨ Funcionalidades Principais

- **Visão Pública:** Visualização de pets disponíveis para adoção.
- **Cadastro e Login:** Autenticação com perfis distintos (usuário comum e administrador).
- **Painel do Usuário:** Visualização das adoções realizadas e início de novos processos.
- **Painel Administrativo:**
  - CRUD completo de usuários e pets
  - Upload de múltiplas imagens por pet
- **Segurança:** Controle de acesso com Interceptors do Spring, protegendo áreas restritas.

---

## ⚙️ Como Executar o Projeto

### ✅ Pré-requisitos

- Java 17 ou superior
- Maven instalado e configurado
- PostgreSQL instalado e em execução

### 🔧 1. Configuração do Banco de Dados

#### a) Criar Banco de Dados
Primeiro, crie um banco de dados vazio no PostgreSQL com o nome sistema-adocao-simples. Você pode fazer isso através de um cliente SQL (como DBeaver ou pgAdmin) ou pela linha de comando:

```sql
CREATE DATABASE "sistema-adocao-simples";
```

#### b)  Restaurar o Backup
O repositório inclui um arquivo de backup chamado backup_adocao.sql. Você precisará restaurá-lo no banco de dados que acabou de criar.
Abra um terminal ou prompt de comando na pasta raiz do projeto (onde o arquivo backup_adocao.sql está localizado) e execute o seguinte comando:

```
psql -U postgres -h localhost -d sistema-adocao-simples -f backup_adocao.sql
```
Você será solicitado a digitar a senha do seu usuário postgres

---
## 🛠️ 2. Configuração da Aplicação

Abra o arquivo ConectarBancoDados.java e certifique-se de que a senha do banco de dados corresponde à sua senha local do PostgreSQL.

![image](https://github.com/user-attachments/assets/ef06b930-f8c7-42eb-8018-8b63cc46b071)

---
## ▶️ 3. Executando a Aplicação

#### a) Pela IDE (IntelliJ, Eclipse, VSCode)
Localize a classe SistemaAdocaoSpringApplication.java

Clique com o botão direito e selecione Run ou Debug

#### b) Pela Linha de Comando

```
mvn spring-boot:run
```
#### A aplicação estará disponível em:
🔗 http://localhost:8080

---
### 🔐 Acesso ao Sistema

#### Para acessar as funcionalidades administrativas, utilize:

E-mail: admin@admin.com

Senha: admin


