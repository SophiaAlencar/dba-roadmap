# Notas 
## 07/11/2026

### EXPLAIN 
Serve pra mostrar o plano de execução que o banco pretende usar pra rodar o script (sem executar ainda). Basicamente mostra o custo que levaria (não é necessariamente o tempo, já que o Postgres usa esses valores para comparar vários tipos diferentes de planos de execução), se vai usar algum índice ou vai varrer a tabela inteira (```sql Seq Scan on```), a ordem dos joins, a estimativa do número de linhas que a consulta retornaria e o tamanho médio estimado das linhas (em bytes=width).

Seria então:
1. Como os dados serão encontrados
2. Quanto tempo o PostgreSQL estima que vai custar
3. Quantas linhas serão esperadas
4. Tamanho esperado de cada linha

### EXPLAIN ANALYZE
Executa a consulta de verdade e mostra o plano junto com os números reais. É mais utilizado quando é preciso diagnosticar a lentidão de verdade (comparando real x estimativa). Apresenta outras informações além das presentes (estimativas) no explain, como:
1. Tempo real de execução
2. loops (quantas vezes a forma de encontrar os dados foi executada)
3. Tempo gasto planejando a consulta.
4. Tempo total de execução da consulta (Pode ser igual ao tempo real de execução).

> Cuidado ao executar o explain analyze, já que ele vai executar a consulta independente de ser um delete, insert ou update. 



