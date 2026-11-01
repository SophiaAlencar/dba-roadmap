/* É possível fazer um backup (pg_dump) ou a restauração (pg_restore) de um schema, de um banco, de tabelas, de funções, de views e outras estruturas em diferentes formatos.
Como o banco estudado é postgres, tanto o backup como a restauração podem ser feitos diretamente no pgAdmin (bem visual) ou no próprio terminal.
*/

--Comando para logar como determinado usuário no terminal (nesse caso, o usuário postgres):
psql -U postgres -d bd_teste 
sudo -u postgres psql --no linux

--Comando para visualizar os bancos e algumas infos como proprietário, codificação, acessos, etc no terminal:
\l

--Comando parar realizar o backup via terminal (PRECISA DE PERMISSÃO, que nesse caso, o user postgres tem):
pg_dump nome_banco > nome_backup.bkp

pg_dump -h localhost -U postgres -d bd_teste -F t -v > /home/user/backup/bd_teste.tar --A sintaxe desse comando pode variar, mas nesse caso, será feito um backup do banco "bd_teste" no formato tar, com verbose (para ver o que está sendo feito), e o arquivo será salvo no caminho especificado.

--Certo, fiz o backup. Se eu quiser apagar o banco e dps restaurar, preciso retirar todas as conexões e depois apagar o banco:
REVOKE CONNECT ON DATABASE bd_teste FROM PUBLIC; --evita novas conexões, já que eu tirei a permissão de connect do banco.
SELECT pg_terminate_backend(pg_stat_activity.pid) FROM pg_stat_activity WHERE pg_stat_activity.datname = 'bd_teste'; --identifica um processo (pid) que está conectado ao banco e termina a conexão.
DROP DATABASE bd_teste; --dropa o banco.

--Cria um banco vazio
CREATE DATABASE novo_bd_teste template template0;-- ENCODING 'UTF8' LC_COLLATE 'pt_BR.UTF-8' LC_CTYPE 'pt_BR.UTF-8' OWNER postgres; Vai de cada caso.

--Comando para restaurar o backup via terminal (TB PRECISA DE PERMISSÃO):
sudo -u postgres psql novo_bd_teste < /home/user/backup/BACKUP_TESTE.sql --A sintaxe também pode variar. Nesse comando, o banco irá receber o backup realizado (não seria possível fazer com o backup no formato TAR).
sudo -u postgres pg_restore -d novo_bd_teste /home/user/backup/bd_teste.tar

--RECOVERY E RESTORE SÃO PARECIDOS, MAS NÃO SÃO A MESMA COISA!
--O restore é feito a partir de um backup e o recovery é feito a partir de um WAL (Write Ahead Log - arquivo de log que registra todas as alterações do bd).
--O recovery é usado para restaurar o banco de dados para um estado anterior, enquanto o restore é usado para criar uma cópia do banco de dados a partir de um backup!!!!!!!
--Normalmente, isso está configurado no arquivo postgresql.conf, mas pode ser feito manualmente tbm.
--Precisa ter um backup físico também -> o pg_basebackup (cria uma cópia completa do banco de dados).

pg_basebackup -h localhost -p 5432 -U postgres -D /home/user/backup/base_backup --faz um backup físico do cluster e armazena os arquivos.
pg_basebackup -h localhost -U postgres -D /backup/pg_backup -P --mostra o progresso do backup.
pg_basebackup -h localhost -U postgres -D /backup/pg_backup -F t -P --armazena os arquivos no formator tar.
--Basicamente, também tem uma sintaxe que pode variar.
pg_basebackup -h localhost -U postgres -D /backup/pg_backup -X stream -P -- **backup com o WAL incluído = o backup consistente e que poderá ser restaurado para um estado específico** 
pg_basebackup -h localhost -U replicacao -D /var/lib/postgresql/data -R -P ---faz o backup do cluster e cria o recovery.conf para que o banco possa ser restaurado a partir do backup (podendo assim atuar como RÉPLICA!!)

--inclusive, para utilizar o pg_basebackup, é preciso permissão REPLICATION ou ser superusuário.
CREATE ROLE replicacao WITH LOGIN REPLICATION PASSWORD 'teste123'; --cria um usuário com permissão de replicação, como visto no arquivo de permissions.sql