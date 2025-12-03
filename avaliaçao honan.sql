DROP DATABASE IF EXISTS controle_felipy;
CREATE DATABASE controle_felipy
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_c1;

USE controle_felipy;

CREATE TABLE usuarios (
	id_usuarios BIGINT UNSIGNED AUTO_INCREMENT,
    nome VARCHAR (100) NOT NULL,
    CPF CHAR (11) UNIQUE NOT NULL,
    email VARCHAR (100) UNIQUE NOT NULL,
    celular VARCHAR (15) NOT NULL,
    senha varchar (255) not null
);
    
CREATE TABLE movimento (
	id_movimento bigint unsigned auto_increment primary key,
    data_movimento DATE NOT NULL,
    usuario_1d BIGINT unsigned not null,
    tipo ENUM ('RECEITA', 'DESPESA') NOT NULL,
    descricao VARCHAR (255) not null,
    valor decimal (10,2) not null check (valor > 0),
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id_usuario)
);
	
    insert usuarios (nome, cpf, email, celular, senha) values
		('joao silva, 12345678901', 'joao@email.com', '1176565421', 'senha123'),
		('mateus gomes, 12597078901', 'joao@email.com', '1167335421', 'senha213'),
		('gabriely oliveira, 14139808901', 'joao@email.com', '1170091421', 'senha321');
    
    insert movimento (data_movimento, usuario_fk, tipo, descricao, valor)  values
		('2025-04-15', 1, 'receita', 'salario', 1200.00),
		('2025-04-15', 1, 'despesa', 'aluguel', 1790.00),
		('2025-04-15', 1, 'receita', 'mercado', 1500.00),
		('2025-04-15', 1, 'receita', 'freelance', 500.00),
		('2025-04-15', 'receita', 'salario', 4500.00),
		('2025-04-15', 'despesa', 'aluguel', 7800.00),
		('2025-04-15', 'despesa', 'academia', 2000.00),
		('2025-04-15', 'receita', 'vendas online', 700.00);
    
    update movimento  
		set descricao = 'salario janeiro', tipo = 'receita'
        where id_movimento = 1;
        
	update movimento
		set descricao = 'condominio', tipo = 'despesa'
        where id_movimento = 6;
        
	delete from movimento where id_movimento = 3;
    
    select * from usuarios;
    
    select 
		m.id_movimento,
        m.data_movimento,
        m.tipo,
        m.descricao,
        m.valor
	from movimento m
    where m.usuarios_id = 1
    order by m.data_movimento desc;
    
    select 
    u.nome AS usuario,
    sum(m.valor) AS soma_total,
    MAX(m.valor) AS maior_valor,
    MIN(m.valor) AS menor_valor,
    AVG(m.valor) AS media_valores
    from movimento m
    inner join usuarios u on m.usuarios_id = u.id_usuario
    group by u.id_usuario, u.nome
    order by u.nome;
    
    select 
    m.id_movimento,
    u.nome as usuario_responsavel,
    u.cpf,
    u.email, 
    m.data_movimento,
    m.tipo, 
    m.descricao,
    concat('R$ ', format(m.valor, 2, 'PT_BR')) as valor_formatado
    from movimento m
    inner join usuarios u on m.usuario_id = u.id_usuario
    order by m.data_movimento desc;
