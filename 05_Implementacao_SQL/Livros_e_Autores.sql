USE biblioteca_academica;


SELECT
    li.titulo,
    GROUP_CONCAT(
        au.nome
        ORDER BY au.nome
        SEPARATOR ', '
    ) AS autores

FROM livro li

LEFT JOIN livro_autor la
    ON la.livro_id = li.livro_id

LEFT JOIN autor au
    ON au.autor_id = la.autor_id

GROUP BY
    li.livro_id,
    li.titulo

ORDER BY
    li.titulo;