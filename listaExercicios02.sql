CREATE PROCEDURE sp_ListarAutores
AS
BEGIN
    SELECT * FROM Autores;
END
EXEC sp_ListarAutores;

CREATE PROCEDURE sp_LivrosPorCategoria
@Categoria VARCHAR(255)
AS
BEGIN
    SELECT * FROM Livros WHERE Categoria = @Categoria;
END
EXEC sp_LivrosPorCategoria 'Aventura';

CREATE PROCEDURE sp_ContarLivrosPorCategoria
@Categoria VARCHAR(255)
AS
BEGIN
    SELECT COUNT(*) AS 'Total' FROM Livros WHERE Categoria = @Categoria;
END
EXEC sp_ContarLivrosPorCategoria 'Romance';

CREATE PROCEDURE sp_VerificarLivrosCategoria
@Categoria VARCHAR(255)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Livros WHERE Categoria = @Categoria)
        PRINT 'Categoria possui livros.';
    ELSE
        PRINT 'Categoria não possui livros.';
END
EXEC sp_VerificarLivrosCategoria 'Ficção Científica';

CREATE PROCEDURE sp_LivrosAteAno
@AnoPublicacao INT
AS
BEGIN
    SELECT * FROM Livros WHERE AnoPublicacao <= @AnoPublicacao;
END
EXEC sp_LivrosAteAno 2000;

CREATE PROCEDURE sp_TitulosPorCategoria
@Categoria VARCHAR(255)
AS
BEGIN
    DECLARE @Titulo VARCHAR(255);
    DECLARE cur CURSOR FOR
        SELECT Titulo FROM Livros WHERE Categoria = @Categoria;
    OPEN cur;
    FETCH NEXT FROM cur INTO @Titulo;
    WHILE @@FETCH_STATUS = 0
    BEGIN
        PRINT @Titulo;
        FETCH NEXT FROM cur INTO @Titulo;
    END
    CLOSE cur;
    DEALLOCATE cur;
END
EXEC sp_TitulosPorCategoria 'Suspense';

CREATE PROCEDURE sp_AdicionarLivro
@Titulo VARCHAR(255),
@AutorID INT,
@AnoPublicacao INT
AS
BEGIN
    BEGIN TRY
        INSERT INTO Livros (Titulo, AutorID, AnoPublicacao)
        VALUES (@Titulo, @AutorID, @AnoPublicacao);
        PRINT 'Livro adicionado com sucesso.';
    END TRY
    BEGIN CATCH
        PRINT 'Erro ao adicionar o livro. Verifique se o título já existe.';
    END CATCH
END
EXEC sp_AdicionarLivro 'Novo Livro', 3, 2022;

CREATE PROCEDURE sp_AutorMaisAntigo
AS
BEGIN
    SELECT TOP 1 Nome, Sobrenome
    FROM Autores
    ORDER BY DataNascimento;
END
EXEC sp_AutorMaisAntigo;

/*
Nome da Stored Procedure: sp_LivrosPorCategoria

Esta stored procedure aceita o nome de uma categoria como parâmetro e retorna todos os livros que pertencem a categoria.

Parâmetros:
- @Categoria (VARCHAR): O nome da categoria pela qual os livros devem ser filtrados.

Exemplo de Uso:
EXEC sp_LivrosPorCategoria 'Ficção Científica';

Retorno:
A procedure retorna um conjunto de resultados com os livros que pertencem à categoria especificada.
*/
CREATE PROCEDURE sp_LivrosPorCategoria
@Categoria VARCHAR(255)
AS
BEGIN
    SELECT * FROM Livros WHERE Categoria = @Categoria;
END

CREATE PROCEDURE sp_LivrosESeusAutores
AS
BEGIN
    SELECT Livros.Titulo, Autores.Nome, Autores.Sobrenome
    FROM Livros
    INNER JOIN Autores ON Livros.AutorID = Autores.ID;
END
EXEC sp_LivrosESeusAutores;




