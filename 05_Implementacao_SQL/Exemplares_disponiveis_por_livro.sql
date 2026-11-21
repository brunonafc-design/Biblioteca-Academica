use biblioteca_academica;

SELECT
    l.livro_id,
    l.titulo,
    COUNT(
        CASE
            WHEN e.situacao = 'DISPONIVEL'
            THEN e.exemplar_id
        END
    ) AS exemplares_disponiveis

FROM livro l

LEFT JOIN exemplar e
    ON e.livro_id = l.livro_id

GROUP BY
    l.livro_id,
    l.titulo

ORDER BY
    l.titulo;