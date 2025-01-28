-- Eventos com maior número de responsáveis
CREATE VIEW eventos_populares AS
SELECT 
    e.id_evento, 
    e.nome_evento, 
    COUNT(ep.id_evento) AS num_participantes
FROM TAB_EVENTO e
JOIN TAB_EVENTO_RESPONSAVEL ep ON e.id_evento = ep.id_evento
GROUP BY e.id_evento, e.nome_evento
ORDER BY num_participantes DESC;

-- Atividades mais populares por tipo
CREATE VIEW atividades_populares AS
SELECT 
    a.tipo, 
    COUNT(ac.id_atividade) AS num_atividades
FROM TAB_ATIVIDADE a
JOIN TAB_ATIVIDADE_CONTRATADO_FUNCAO ac ON a.id_atividade = ac.id_atividade
GROUP BY a.tipo
ORDER BY num_atividades DESC;

-- ganhos totais por evento
CREATE VIEW ganhos_por_evento AS
SELECT 
    e.id_evento, 
    e.nome_evento, 
    SUM(p.valor) AS total_ganho
FROM TAB_EVENTO e
JOIN TAB_ATIVIDADE a ON e.id_evento = a.id_evento
JOIN TAB_PAGAMENTO p ON a.id_atividade = p.id_atividade
GROUP BY e.id_evento, e.nome_evento;

SELECT * FROM atividades_populares;
SELECT * FROM eventos_populares;
SELECT * FROM ganhos_por_evento;

