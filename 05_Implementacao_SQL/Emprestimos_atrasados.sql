USE biblioteca_academica;



SELECT
    em.emprestimo_id,
    le.nome,
    li.titulo,
    ex.codigo_tombo,
    em.data_prevista_devolucao

FROM emprestimo em

INNER JOIN leitor le
    ON le.leitor_id = em.leitor_id

INNER JOIN item_emprestimo it
    ON it.emprestimo_id = em.emprestimo_id

INNER JOIN exemplar ex
    ON ex.exemplar_id = it.exemplar_id

INNER JOIN livro li
    ON li.livro_id = ex.livro_id

WHERE it.data_devolucao IS NULL
  AND em.data_prevista_devolucao < CURRENT_DATE

ORDER BY em.data_prevista_devolucao;