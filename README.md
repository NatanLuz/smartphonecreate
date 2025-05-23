# 📱 SmartphoneCreate

> Projeto SQL para criação e gerenciamento de um banco de dados de smartphones. Desenvolvido com foco em estruturação profissional de dados.

---

## 💡 Objetivo

Este projeto foi criado para demonstrar habilidades práticas em **modelagem de banco de dados relacional**, utilizando comandos **DDL** e **DML** no SQL.  
É ideal para cenários como:

- Cadastro e consulta de smartphones
- Armazenamento estruturado de especificações técnicas
- Gerenciamento de fornecedores, estoques e modelos

---

## 🛠️ Tecnologias e Conceitos Utilizados

- SQL (Structured Query Language)
- Comandos DDL (CREATE, ALTER, DROP)
- Comandos DML (INSERT, SELECT, UPDATE, DELETE)
- Criação de Procedures e uso de Constraints
- Normalização básica
- Modelagem lógica e física

---

## 🧾 Conteúdo do Script `smartphonecreate.sql`

O script realiza:

- Criação de tabelas como `Fabricante`, `Modelo`, `Smartphone`, `Estoque`
- Definição de chaves primárias e estrangeiras
- Inserção de dados simulados
- Criação de stored procedures
- Relacionamentos entre tabelas
- Exemplos de queries

---

## 🚀 Como Executar

1. Clone o repositório ou baixe o arquivo `.sql`
2. Abra em um SGBD de sua preferência (MySQL Workbench, DBeaver, etc)
3. Execute o script em um banco de dados novo

---

## 📌 Exemplos de Uso

```sql
-- Consultar todos os smartphones com fabricante
SELECT s.nome_modelo, f.nome_fabricante
FROM Smartphone s
JOIN Fabricante f ON s.id_fabricante = f.id_fabricante;

-- Executar procedure para exibir estoque por modelo
CALL MostrarEstoquePorModelo();
