--USERS > -U
--Comando que cria um user, seguindo padrão de nomeclatura de variáveis 
CREATE USER sophia;

--Apagar um user
DROP USER sophia;

--Os dois comandos retornam "create role" e "drop role" respectivamente.
--Shell script é similar: createuser sophia2 - dropuser sophia2 
--Verificação dos usuários existentes
SELECT usename FROM pg_user; 

--ATRIBUTOS DE USUÁRIOS
/*
superuser > ignora todas as verificações de permissão e pode criar novos usuários.
database creation > para criar um banco, o usuário precisa necessariamente dessa permissão.
password > só é relevante se o método de autenticação exigir uma senha para conectar ao bd.
*/
CREATE USER admin SUPERUSER;
CREATE USER criador_bd CREATEDB;
CREATE USER admin PASSWORD 'Senha123@'; CREATE USER admin2 WITH PASSWORD 'Senha123@';
CREATE USER teste1 WITH PASSWORD 'teste1' CREATEDB VALID UNTIL '2026-10-30';

--É possível alterar os atributos
ALTER USER criador_db 
SET enable_indexscan TO off; --impede de usar índices/obriga o banco a fazer uma varredura SEQUENCIAL

--Comando para desfazer alterações de atributos
ALTER USER criador_db RESET enable_indexscan;

--Visualizar os atributos de todos/algum usuário
SELECT * FROM pg_roles 
WHERE rolname = 'admin';
--OBS: Ao visualizar os atributos de algum usuário super, alguns estarão com o valor de "false",
--mas os privilégios especiais do super usuário se sobrepõem a essas restrições. (IGNORA AS POLÍTICAS DE ROW-LEVEL SECURITY)

--GROUPS 
--Basicamente, serve para manusear os privilégios dos usuários mais rapidamente
CREATE GROUP turma;
DROP GROUP turma; --apaga somente o GRUPO e não os USERS

--Visualização dos grupos:
SELECT * FROM pg_group

--Visualização dos usuários nos grupos:
SELECT g.groname AS nome_grupo, u.usename AS nome_usuario
FROM pg_group g JOIN pg_user u ON u.usesysid = ANY(g.grolist) --pega o ID do user e compara com os IDs 
WHERE g.groname = 'turma';

--Comandos para add/rm usuários de um grupo
ALTER GROUP turma ADD USER admin;
ALTER GROUP turma DROP USER admin;

--PRIVILÉGIOS
-- Usa-se o comando GRANT para atribuir privilégios (SELECT, INSERT, UPDATE, DELETE, RULE, REFERENCES, TRIGGER, CREATE, TEMPORARY TABLES, EXECUTE, USAGE)
-- Se um estagiário chega na empresa e precisa de acesso a tabelas restritas é possível:
GRANT SELECT ON tabela_ficticia TO sophia; -- o user sophia pode agora realizar selects na tabela ficticia

GRANT ALL PRIVILEGES ON filmes TO admin;

--E se forem vários novos estagiários?
CREATE GROUP estagio;
ALTER GROUP estagio ADD USER estagiario1,estagiario2,estagiario3;
GRANT SELECT ON tabela_ficticia TO GROUP estagio;


--Comando para revogar o privilégio:
REVOKE ALL ON tabela_ficticia from PUBLIC; 
--a palavra reservada PUBLIC representa todos os usuários e roles do banco. 
--Nessa caso, foi revogada todas (ALL) as permissões que o PUBLIC possui sobre a tabela ficticia.
--Vai funcionar pros estagiários? Não, pois eles receberam diretamente o privilégio 
--O REVOKE afeta apenas a origem da permissão especificada no FROM, não removendo automaticamente permissões concedidas por outras origens.

--Comando para conferir as permissões
SELECT has_table_privilege('estagiario1','tabela_ficticia','SELECT');


--ROLES
-- O padrão, assim que o banco é iniciado, é a role que tem o mesmo nome do user que criou o cluster do banco (caso não especificado) = postgres. 
-- Por isso, se quiser criar outra role tem que conectar primeiro como postgres OU conectar a alguma role que tenha o atributo CREATEROLE OU ainda um superuser.
SELECT CURRENT_USER; --role efetiva no momento
SELECT SESSION_USER; --role que iniciou a conexão

CREATE ROLE teste;
DROP ROLE teste;

--A verificação de roles existentes segue a mesma premissa:
SELECT * FROM pg_roles
SELECT rolname FROM pg_roles WHERE rolcanlogin; --roles que podem fazer login

--PRIVILÉGIOS DAS ROLES
CREATE ROLE teste2 LOGIN; --privilegio de login
CREATE ROLE teste3 SUPERUSER; 
CREATE ROLE teste4 CREATEDB; 
CREATE ROLE teste5 CREATEROLE; --privilégio de criar/dropar/alterar outras roles
--o CREATEROLE não ultrapassa as permissões dos superusers e nem pode criar superusers roles
CREATE ROLE teste6 REPLICATION LOGIN; --permissão para iniciar replicação por fluxo
CREATE ROLE teste7 PASSWORD 'teste7@'; 
CREATE ROLE teste8 NOINHERIT; --Ao criar uma role, ela herdará os privilégios daquela que a criou. Esse comando serve para não herdar esses privilégios.
CREATE ROLE teste9 BYPASSRLS; --A role agora pode ignorar todas as políticas de segurança em nível de linha (RLS)
CREATE ROLE teste10 CONNECTION LIMIT 'integer'; --Especifica quantas conexões ativas uma role pode ter (padrão é -1 = sem limites.)

-- Uma role também pode ter valores padrão específicos (mesma premissa)
ALTER ROLE teste SET enable_indexscan TO off;
ALTER ROLE testee RESET enable_indexscan;

/*
Os comandos são parecidos e tem conceitos muito próximos, o que ajuda no entedimento.
Porém, ROLE e GROUP podem se misturar no caminho.
ROLE -> identidade que pode ter permissões no banco (funciona como usuário/aplicação ou grupo).
O atributo login permite que as roles sejam usadas para estabelecer uma conexão com o banco.
É UM CONCEITO DO POSTGRES!

GROUP -> Reune várias roles para compartilhar permissões. No caso dos estágiarios, ao invés de dar permissão individualmente,
uma alternativa era criar uma role que funcione como grupo (nesse caso eu fiz ao contrário).
Ou seja, o GROUP é uma forma de utilizar uma ROLE, que TAMBÉM é uma ROLE.

Resumindo: Os comandos de GROUP são de uma sintaxe antiga que ainda está dispoível, sendo a ROLE a forma mais geral e moderna.
Então se existem novos usuários, basta associá-los a role ou criar uma nova conforme necessidade.
*/