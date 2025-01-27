-- Criando a sequência para TAB_USUARIO
CREATE SEQUENCE seq_tab_usuario START 1;

-- Criando a tabela usuario 
CREATE TABLE TAB_USUARIO (
    id_usuario INTEGER DEFAULT nextval('seq_tab_usuario') PRIMARY KEY,
    cpf VARCHAR(11) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL, -- implementar um hash no Back para não armazenar a senha direta do usuario
    dica_senha VARCHAR(255) DEFAULT NULL, 
    nome_sobrenome VARCHAR(50) NOT NULL,
    ultimo_nome VARCHAR(50) NOT NULL,
    instituicao VARCHAR(50) DEFAULT NULL, 
    escolaridade VARCHAR(100) NOT NULL,
    telefone VARCHAR(15) NOT NULL, 
    email VARCHAR(255) NOT NULL,
    sexo CHAR(1) NOT NULL
);

-- Criando a sequência para TAB_LOCAL
CREATE SEQUENCE seq_tab_local START 1;

-- Criando a tabela local
CREATE TABLE TAB_LOCAL (
    id_local INTEGER DEFAULT nextval('seq_tab_local') PRIMARY KEY,
    endereco VARCHAR(255) NOT NULL,
    capacidade INTEGER NOT NULL,
    tipo_local VARCHAR(50)
);

-- Criando a sequência para TAB_EVENTO
CREATE SEQUENCE seq_tab_evento START 1;

-- Criando a tabela evento
CREATE TABLE TAB_EVENTO (
    id_evento INTEGER DEFAULT nextval('seq_tab_evento') PRIMARY KEY,
    nome_evento VARCHAR(255) NOT NULL,
    data_inicio DATE NOT NULL,
    data_termino DATE NOT NULL,
    tipo VARCHAR(255) NOT NULL,
    status VARCHAR(100) NOT NULL,
    gratuidade VARCHAR(3) NOT NULL
);

-- Criando a sequência para TAB_FUNCAO
CREATE SEQUENCE seq_tab_funcao START 1;

-- Criando a tabela função
CREATE TABLE TAB_FUNCAO (
    id_funcao INTEGER DEFAULT nextval('seq_tab_funcao') PRIMARY KEY,
    nome_funcao VARCHAR(100) NOT NULL
);

-- Criando a sequência para TAB_ATIVIDADE
CREATE SEQUENCE seq_tab_atividade START 1;

-- Criando a tabela atividade
CREATE TABLE TAB_ATIVIDADE (
    id_atividade INTEGER DEFAULT nextval('seq_tab_atividade') PRIMARY KEY,
    nome_atividade VARCHAR(255) NOT NULL,
    tipo VARCHAR(100) NOT NULL,
    area VARCHAR(255) NOT NULL,
    resumo VARCHAR(255) NOT NULL,
    data_inicio DATE NOT NULL,
    data_termino DATE NOT NULL,
    id_evento INTEGER NOT NULL REFERENCES TAB_EVENTO(id_evento)
);

-- Criando a sequência para TAB_PAGAMENTO
CREATE SEQUENCE seq_tab_pagamento START 1;

-- Criando a tabela pagamento
CREATE TABLE TAB_PAGAMENTO (
    id_pagamento INTEGER DEFAULT nextval('seq_tab_pagamento') PRIMARY KEY,
    valor NUMERIC(15,2) NOT NULL,
    forma_pagamento VARCHAR(100) NOT NULL,
    status_pagamento VARCHAR(100) NOT NULL,
    id_usuario INTEGER NOT NULL REFERENCES TAB_USUARIO(id_usuario),
    id_atividade INTEGER NOT NULL REFERENCES TAB_ATIVIDADE(id_atividade),
    UNIQUE (id_usuario, id_atividade)
);

-- Criando a sequência para TAB_CONTRATADO
CREATE SEQUENCE seq_tab_contratado START 1;

-- Criando a tabela contratado
CREATE TABLE TAB_CONTRATADO (
    id_contratado INTEGER DEFAULT nextval('seq_tab_contratado') PRIMARY KEY,
    nome_completo VARCHAR(50) NOT NULL,
    cpf VARCHAR(11) UNIQUE NOT NULL
);

-- Criando a sequência para TAB_RESPONSAVEL
CREATE SEQUENCE seq_tab_responsavel START 1;

-- Criando a tabela responsavel
CREATE TABLE TAB_RESPONSAVEL (
    id_responsavel INTEGER DEFAULT nextval('seq_tab_responsavel') PRIMARY KEY,
    nome_completo VARCHAR(50),
    cpf VARCHAR(11),
    senha VARCHAR(255),
    UNIQUE (cpf)
);

-- Criando a tabela de relacionamento evento local
CREATE TABLE TAB_EVENTO_LOCAL (
    id_evento INTEGER NOT NULL REFERENCES TAB_EVENTO(id_evento),
    id_local INTEGER NOT NULL REFERENCES TAB_LOCAL(id_local),
    PRIMARY KEY (id_evento, id_local)
);

-- Criando a tabela de relacionamento atividade contratado função
CREATE TABLE TAB_ATIVIDADE_CONTRATADO_FUNCAO (
    id_atividade INTEGER NOT NULL REFERENCES TAB_ATIVIDADE(id_atividade),
    id_contratado INTEGER NOT NULL REFERENCES TAB_CONTRATADO(id_contratado),
    id_funcao INTEGER NOT NULL REFERENCES TAB_FUNCAO(id_funcao),
    UNIQUE (id_atividade, id_contratado, id_funcao)
);

-- Criando a tabela de relacionamento evento responsavel
CREATE TABLE TAB_EVENTO_RESPONSAVEL (
    id_evento INTEGER NOT NULL REFERENCES TAB_EVENTO(id_evento),
    id_responsavel INTEGER NOT NULL REFERENCES TAB_RESPONSAVEL(id_responsavel),
    PRIMARY KEY (id_evento, id_responsavel)
);
