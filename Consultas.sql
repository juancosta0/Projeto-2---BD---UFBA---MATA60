
--(AVANÇADA)Consulta de Eventos com Informações dos Responsáveis e Locais
--Esta consulta retorna uma lista de eventos, incluindo o nome do evento,
--os responsáveis associados (com nome completo), e os locais onde o evento ocorre.
SELECT 
    e.nome_evento AS evento,
    STRING_AGG(DISTINCT r.nome_completo, ', ') AS responsaveis,
    STRING_AGG(DISTINCT l.endereco, ', ') AS locais
FROM 
    TAB_EVENTO e
JOIN TAB_EVENTO_RESPONSAVEL er ON e.id_evento = er.id_evento
JOIN TAB_RESPONSAVEL r ON er.id_responsavel = r.id_responsavel
JOIN TAB_EVENTO_LOCAL el ON e.id_evento = el.id_evento
JOIN TAB_LOCAL l ON el.id_local = l.id_local
GROUP BY e.id_evento, e.nome_evento
ORDER BY e.nome_evento;


--(INTERMEDIARIA)Participantes que Pagaram por Atividades e Detalhes do Pagamento
--Esta consulta retorna uma lista de usuários que realizaram pagamentos, 
--incluindo o nome do usuário, a atividade pela qual pagaram, o valor do pagamento e a forma de pagamento.
SELECT 
    u.nome_sobrenome AS participante,
    a.nome_atividade AS atividade,
    p.valor AS valor_pago,
    p.forma_pagamento AS forma_pagamento
FROM 
    TAB_PAGAMENTO p
JOIN TAB_USUARIO u ON p.id_usuario = u.id_usuario
JOIN TAB_ATIVIDADE a ON p.id_atividade = a.id_atividade
ORDER BY u.nome_sobrenome, a.nome_atividade;

--(INTERMEDIARIA)Número de Contratados por Função em Atividades
--ta consulta retorna a contagem de contratados por função, agrupados por nome da função e tipo de atividade.
SELECT 
    f.nome_funcao AS funcao,
    a.tipo AS tipo_atividade,
    COUNT(DISTINCT cf.id_contratado) AS total_contratados
FROM 
    TAB_ATIVIDADE_CONTRATADO_FUNCAO cf
JOIN TAB_FUNCAO f ON cf.id_funcao = f.id_funcao
JOIN TAB_ATIVIDADE a ON cf.id_atividade = a.id_atividade
GROUP BY f.nome_funcao, a.tipo
ORDER BY f.nome_funcao, a.tipo;

--(AVANÇADA)Detalhes de Atividades, Contratados e suas Funções no Evento
--Esta consulta lista as atividades realizadas em eventos, os contratados responsáveis, 
--suas funções e o local onde o evento ocorre.
SELECT 
    e.nome_evento AS evento,
    a.nome_atividade AS atividade,
    c.nome_completo AS contratado,
    f.nome_funcao AS funcao,
    l.endereco AS local
FROM 
    TAB_ATIVIDADE a
JOIN TAB_EVENTO e ON a.id_evento = e.id_evento
JOIN TAB_ATIVIDADE_CONTRATADO_FUNCAO acf ON a.id_atividade = acf.id_atividade
JOIN TAB_CONTRATADO c ON acf.id_contratado = c.id_contratado
JOIN TAB_FUNCAO f ON acf.id_funcao = f.id_funcao
JOIN TAB_EVENTO_LOCAL el ON e.id_evento = el.id_evento
JOIN TAB_LOCAL l ON el.id_local = l.id_local
ORDER BY e.nome_evento, a.nome_atividade, c.nome_completo;

-- (AVANÇADA) Participantes Pagantes e Detalhes de Eventos e Locais
--Esta consulta retorna uma lista de participantes que realizaram pagamentos, 
--os eventos correspondentes, os locais onde os eventos ocorrem e o valor pago.

SELECT 
    u.nome_sobrenome AS participante,
    e.nome_evento AS evento,
    l.endereco AS local,
    p.valor AS valor_pago
FROM 
    TAB_PAGAMENTO p
JOIN TAB_USUARIO u ON p.id_usuario = u.id_usuario
JOIN TAB_ATIVIDADE a ON p.id_atividade = a.id_atividade
JOIN TAB_EVENTO e ON a.id_evento = e.id_evento
JOIN TAB_EVENTO_LOCAL el ON e.id_evento = el.id_evento
JOIN TAB_LOCAL l ON el.id_local = l.id_local
ORDER BY u.nome_sobrenome, e.nome_evento, l.endereco;

--(INTERMEDIARIA)Locais com Capacidade Média para Eventos
--Esta consulta calcula a capacidade média dos locais utilizados para eventos, agrupando por tipo de evento.
SELECT 
    e.tipo AS tipo_evento,
    AVG(l.capacidade) AS capacidade_media
FROM 
    TAB_EVENTO e
JOIN TAB_EVENTO_LOCAL el ON e.id_evento = el.id_evento
JOIN TAB_LOCAL l ON el.id_local = l.id_local
GROUP BY e.tipo
ORDER BY e.tipo;

--(SIMPLES)Visualiza todo os usuarios
SELECT * FROM TAB_USUARIO;

--(SIMPLES)VISUALIZA todos os eventos
SELECT * FROM TAB_EVENTO

--(SIMPLES)Visualiza todo os pagamentos
SELECT * FROM TAB_PAGAMENTO;

--(SIMPLES)VISUALIZA todos as atividades
SELECT * FROM TAB_ATIVIDADE;


SELECT 
    E.id_evento,
    E.nome_evento,
    SUM(P.valor) AS total_arrecadado
FROM 
    TAB_EVENTO E
INNER JOIN 
    TAB_ATIVIDADE A ON E.id_evento = A.id_evento
INNER JOIN 
    TAB_PAGAMENTO P ON A.id_atividade = P.id_atividade
GROUP BY 
    E.id_evento, E.nome_evento;

SELECT 
    e.nome_evento AS evento,
    STRING_AGG(DISTINCT r.nome_completo, ', ') AS responsaveis,
    STRING_AGG(DISTINCT l.endereco, ', ') AS locais
FROM 
    TAB_EVENTO e
JOIN TAB_EVENTO_RESPONSAVEL er ON e.id_evento = er.id_evento
JOIN TAB_RESPONSAVEL r ON er.id_responsavel = r.id_responsavel
JOIN TAB_EVENTO_LOCAL el ON e.id_evento = el.id_evento
JOIN TAB_LOCAL l ON el.id_local = l.id_local
GROUP BY e.id_evento, e.nome_evento
ORDER BY e.nome_evento;

SELECT 
    u.nome_sobrenome AS participante,
    a.nome_atividade AS atividade,
    p.valor AS valor_pago,
    p.forma_pagamento AS forma_pagamento
FROM 
    TAB_PAGAMENTO p
JOIN TAB_USUARIO u ON p.id_usuario = u.id_usuario
JOIN TAB_ATIVIDADE a ON p.id_atividade = a.id_atividade
ORDER BY u.nome_sobrenome, a.nome_atividade;

SELECT 
    f.nome_funcao AS funcao,
    a.tipo AS tipo_atividade,
    COUNT(DISTINCT cf.id_contratado) AS total_contratados
FROM 
    TAB_ATIVIDADE_CONTRATADO_FUNCAO cf
JOIN TAB_FUNCAO f ON cf.id_funcao = f.id_funcao
JOIN TAB_ATIVIDADE a ON cf.id_atividade = a.id_atividade
GROUP BY f.nome_funcao, a.tipo
ORDER BY f.nome_funcao, a.tipo;

SELECT 
    e.nome_evento AS evento,
    a.nome_atividade AS atividade,
    c.nome_completo AS contratado,
    f.nome_funcao AS funcao,
    l.endereco AS local
FROM 
    TAB_ATIVIDADE a
JOIN TAB_EVENTO e ON a.id_evento = e.id_evento
JOIN TAB_ATIVIDADE_CONTRATADO_FUNCAO acf ON a.id_atividade = acf.id_atividade
JOIN TAB_CONTRATADO c ON acf.id_contratado = c.id_contratado
JOIN TAB_FUNCAO f ON acf.id_funcao = f.id_funcao
JOIN TAB_EVENTO_LOCAL el ON e.id_evento = el.id_evento
JOIN TAB_LOCAL l ON el.id_local = l.id_local
ORDER BY e.nome_evento, a.nome_atividade, c.nome_completo;

SELECT 
    u.nome_sobrenome AS participante,
    e.nome_evento AS evento,
    l.endereco AS local,
    p.valor AS valor_pago
FROM 
    TAB_PAGAMENTO p
JOIN TAB_USUARIO u ON p.id_usuario = u.id_usuario
JOIN TAB_ATIVIDADE a ON p.id_atividade = a.id_atividade
JOIN TAB_EVENTO e ON a.id_evento = e.id_evento
JOIN TAB_EVENTO_LOCAL el ON e.id_evento = el.id_evento
JOIN TAB_LOCAL l ON el.id_local = l.id_local
ORDER BY u.nome_sobrenome, e.nome_evento, l.endereco;

SELECT 
    e.tipo AS tipo_evento,
    AVG(l.capacidade) AS capacidade_media
FROM 
    TAB_EVENTO e
JOIN TAB_EVENTO_LOCAL el ON e.id_evento = el.id_evento
JOIN TAB_LOCAL l ON el.id_local = l.id_local
GROUP BY e.tipo
ORDER BY e.tipo;

SELECT 
    id_evento,
    nome_evento,
    data_inicio,
    data_termino,
    (data_termino - data_inicio) AS duracao_dias
FROM 
    TAB_EVENTO
ORDER BY duracao_dias DESC;

SELECT 
    c.id_contratado,
    c.nome_completo,
    COUNT(DISTINCT cf.id_atividade) AS total_atividades
FROM 
    TAB_ATIVIDADE_CONTRATADO_FUNCAO cf
JOIN TAB_CONTRATADO c ON cf.id_contratado = c.id_contratado
GROUP BY c.id_contratado, c.nome_completo
HAVING COUNT(DISTINCT cf.id_atividade) > 1
ORDER BY total_atividades DESC;

SELECT 
    u.id_usuario,
    u.nome_sobrenome,
    COUNT(DISTINCT p.id_atividade) AS total_atividades
FROM 
    TAB_PAGAMENTO p
JOIN TAB_USUARIO u ON p.id_usuario = u.id_usuario
GROUP BY u.id_usuario, u.nome_sobrenome
ORDER BY total_atividades DESC;