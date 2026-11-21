USE biblioteca_academica;



SELECT
    le.nome,
    em.emprestimo_id,
    em.data_emprestimo,
    em.data_prevista_devolucao,
    li.titulo,
    ex.codigo_tombo,
    it.data_devolucao

FROM leitor le

INNER JOIN emprestimo em
    ON em.leitor_id = le.leitor_id

INNER JOIN item_emprestimo it
    ON it.emprestimo_id = em.emprestimo_id

INNER JOIN exemplar ex
    ON ex.exemplar_id = it.exemplar_id

INNER JOIN livro li
    ON li.livro_id = ex.livro_id

WHERE le.leitor_id = 1

ORDER BY
    em.data_emprestimo DESC,
    em.emprestimo_id DESC;