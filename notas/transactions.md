# Notas - Índices
## 02/11/2026

### TRANSAÇÕES
Operações SQL que devem ser tratadas como um único trabalho: todas são executadas ou nenhuma.
Exemplo de comando:
```sql
BEGIN TRANSACTION;
COMMIT; ROLLBACK; --confirma ou desfaz as operações realizadas.
```

As propriedades **ACID** são muito importantes quando se trata de transações:
- ATOMICIDADE > Todas ou nenhuma operação é realizada. Não existe transação pela metade.
- CONSISTÊNCIA > Transação deve respeitar as regras/restrições do banco, mantendo os dados válidos.
- **ISOLAMENTO** > Transações executadas simultaneamente não devem interferir umas nas outras para não produzir resultados diferentes.
- DURABILIDADE > Após o COMMIT, os dados devem continuar salvos, inclusive diante de falhas (conforme as garantias de durabilidade configuradas).

### LOCKS (BLOQUEIOS)
Mecanismo utilizado pelo bd para controlar o acesso simnultâneo aos dados e evitar conflito de transações (propriedade do isolamento).
Ou seja, se estou no meio de um begin transaction (sem commitar e sem desfazer) e outra pessoa tentar fazer uma modificação nessa mesma linha, o postgres coloca um bloqueio na linha até eu finalizar a transação.
OBS: Existem diferentes tipos de locks, incluindo um que bloqueia a tabela inteira ou somente a linha (como seria o caso do exemplo).
ALGUNS TIPOS DE LOCKS:
- ACCESS SHARE: Permite leitura e é utilizado pelo SELECT.
- ROW SHARE: Usado por operações como SELECT FOR UPDATE.
- ROW EXCLUSIVE: Usado por INSERT, UPDATE e DELETE.
- ACCESS EXCLUSIVE: Mais **restritivo**, impede até SELECT comum.

Visualização dos locks por meio de uma view:
```sql
SELECT
    locktype, --tipo do obj bloqueado
    database, --bd
    relation, --obj relacionado ao lock
    mode, --modo do block
    granted, --status do block (true=concedido ou false=aguardando lock)
    pid -- id do processo
FROM pg_locks;
```
### DEADLOCKS (IMPASSE)
Situaçao em que duas ou mais transações ficam bloqueadas indefinidamente porque cada uma está esperando por um recurso que está sendo retido pelo outro (basicamente, fica travado pra sempre).
Quando o postgres identifica  esse impasse, ele aborta uma das transações. 
É possível evitar/lidar deadlocks com boas práticas:
1- Acessar registros na mesma ordem entre as transações
2- Evitar transações longas
3- Não deixar transações abertas sem sentido
4- Atualizar de forma organizada
5- Identificar os processos que geram deadlocks

Consulta para **acompanhar sessões**:
```sql
SELECT
    pid, 
    usename,
    state,
    wait_event_type,
    wait_event,
    query
FROM pg_stat_activity;
```
