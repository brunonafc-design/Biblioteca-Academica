SELECT
    l.livro_id,
    l.titulo,
    COUNT(e.exemplar_id) AS exemplares_disponiveis
FROM livro l
LEFT JOIN exemplar e
    ON l.livro_id = e.livro_id
    AND e.situacao = 'DISPONIVEL'
    AND NOT EXISTS (
        SELECT 1
        FROM item_emprestimo ie
        WHERE ie.exemplar_id = e.exemplar_id
        AND ie.data_devolucao IS NULL
    )
GROUP BY l.livro_id, l.titulo;