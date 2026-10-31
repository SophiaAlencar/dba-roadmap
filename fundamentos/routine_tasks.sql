/*
1- VACUUM:  Recupera o espaço em disco ocupado por registros mortos;
2- ANALYZE: Atualiza as estatísticas do bd para otimizar consultas. Pode ser usado em conjunto com o VACUUM.
3- REINDEX: Recria índices.
4- CLUSTER: Reorganiza a tabela com base em um índice específico.
*/

-- Um comando de delete/update não remove imediatamente o valor antigo da linha (MVCC = controle de concorrência multiversão). Ele fica marcado como obsoleto e ocupa espaço, que deve ser recuperado para reutilização de novas linhas através do VACUUM (inclui índices).
-- Programm vacuumdb https://www.postgresql.org/docs/current/app-vacuumdb.html
-- Os parâmetros do autovacuum podem ser modificados no postgresql.conf ou por tabela (Sempre é executado em segundo plano e não bloqueia a tabela).

ALTER TABLE nome_tabela SET (autovacuum_enabled = true);
VACUUM FULL; --recupera mais espaço em disco, mas bloqueia a tabela (acesso exclusivo para a varredura) e demora mais. Normalmente se evita esse comando, pois é preciso de espaço em disco extra para criar uma nova cópia da tabela.
STANDARD VACUUM --recupera menos espaço, mas não bloqueia a tabela. Ainda assim, comando que modificam a definição da tabela não podem ser executados durante o vacuum.

--OBS: o VACUUM não é preciso em temp tables.
--OBS2: o VACUUM pode causar desempenho ruim para outras sessões (comando pesado e consome muitos recursos do bd).
--OBS3: O ideal é fazer o standard vacuum regularmente (em horários de baixa utilização) para evitar o full vacuum.
--OBS4: Tem uma tabela que o conteúdo é removido frequentemente? Usa TRUNCATE, já que ele não deixa registros mortos.

--O analyze utiliza uma amostragem aleatória das linhas de uma tabela, em vez de ler uma por uma.
ANALYZE;
ANALYZE teste;
ANALYZE teste (c1, c2);
ANALYZE VERBOSE teste; --mostra o que está sendo feito e o tempo gasto.

ALTER TABLE teste SET (
    autovacuum_analyze_scale_factor = 0.05, -- Dispara quando 5% das linhas mudarem (padrão é 10%)
    autovacuum_analyze_threshold = 100       -- Mínimo de 100 linhas alteradas (padrão é 50)
);

SELECT 
    schemaname AS esquema,
    relname AS tabela,
    n_live_tup AS linhas_vivas,
    n_dead_tup AS linhas_mortas,
    last_vacuum AS ultimo_vacuum_manual,
    last_autovacuum AS ultimo_autovacuum,
    vacuum_count AS qtd_vacuums,
    autovacuum_count AS qtd_autovacuums,
    -- Analyze 
    last_analyze AS ultimo_analyze_manual,
    last_autoanalyze AS ultimo_autoanalyze,
    analyze_count AS qtd_analyzes,
    autoanalyze_count AS qtd_autoanalyzes
FROM 
    pg_stat_user_tables --view estatística que tem infos sobre o uso e o desempenho das tabelas (System Catalogs/Statistics Views)
ORDER BY 
    n_dead_tup DESC;

--Estatísticas de índices (verifica corrupção, espaço excessivo, problemas de desempenho, qtd de utilização, etc)
SELECT * FROM pg_stat_user_indexes;

--Estatísticas de atividades
SELECT * FROM pg_stat_database;

--Atividades/consultas em execução
SELECT * FROM pg_stat_activity;

SELECT datname, age(datfrozenxid) FROM pg_database; --Me mostra a idade do datfrozenxid. É importante acompanhar, pois se chegar a 2 bilhões de transações, o banco trava e precisa de um dump/restore para resetar o contador(Autovacuum normalmente mantém baixo).

-- E se meu índice estiver com espaço não utilizado ou corrompido?
REINDEX idc; --libera espaço e corrige problemas de corrupção.
REINDEX TABLE teste; --Recria todos os índices da tabela.
REINDEX DATABASE bd; --Recria todos os índices do banco.
REINDEX SCHEMA esquema; --Recria todos os índices do schema.
REINDEX INDEX CONCURRENTLY idc_teste_producao; --Tabela pode ser usada durante a reindexação, mas é mais lento.

--Comando para consultar os índices existentes
SELECT schemaname, tablename, indexname, indexdef
FROM pg_indexes
WHERE schemaname = 'esquema';

CLUSTER teste USING idc_teste_producao; --Reorganiza a tabela com base no índice especificado (bloqueia a tabela).

SELECT datname, pg_size_pretty(pg_database_size(datname)) AS tamanho
FROM pg_database; -- visualização dos bancos de um cluster

SELECT version(), current_database(),  current_user;
SHOW data_directory;

/*
Lembrando que o CLUSTER é mais indicado quando a organização física da tabela é crítica para o desempenho das consultas.
E um cluster PostgreSQL é uma *instância* de armazenamento e gerenciamento que reúne vários bds sob um mesmo servidor PostgreSQL.
*/