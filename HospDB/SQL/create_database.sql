CREATE DATABASE hospdb
WITH OWNER = postgres --superuser padrão
ENCODING = 'UTF8'
LC_CTYPE = 'C' --classificação de caracteres
template = template0 --modelo limpo
CONNECTION LIMIT = -1; --conexão ilimitada

ALTER DATABASE hospdb
SET search_path = hospital; --simula ambiente real e não utiliza o public
