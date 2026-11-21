use biblioteca_academica;

SELECT
    le.leitor_id,
    le.nome

FROM leitor le

WHERE NOT EXISTS (
    SELECT 1

    FROM emprestimo em

    INNER JOIN item_emprestimo it
        ON it.emprestimo_id = em.emprestimo_id

    WHERE em.leitor_id = le.leitor_id
      AND it.data_devolucao IS NULL
)

ORDER BY le.nome;