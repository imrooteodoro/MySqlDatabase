CREATE DATABASE BBA_AEROPORTOS;

USE BBA_AEROPORTOS;

CREATE TABLE aeroportos (
  codaerop integer PRIMARY KEY,
  nome character varying(30),
  LOCAL character varying(30),
  pais character varying(30)
);
 
CREATE TABLE modelos (
        codmodelo integer PRIMARY KEY,
        construtor character varying(20),
        versao character varying(20),
        nummotores character varying(20)
);
 
CREATE TABLE avioes (
        codaviao integer PRIMARY KEY,
        nome character varying(30),
        codmodelo integer,
		foreign key (codmodelo) REFERENCES modelos (codmodelo)
);
  
CREATE TABLE voos (
        codvoo integer PRIMARY KEY,
        decodaerop integer,
		paracodaerop integer,
		transportadora character varying(10),
        duracao integer,
        codaviao integer,
		foreign key (decodaerop)  REFERENCES aeroportos (codaerop),
		foreign key (paracodaerop) REFERENCES aeroportos (codaerop),
		foreign key (codaviao)  REFERENCES avioes (codaviao)
);
 
INSERT INTO aeroportos  VALUES  (1,'Sa Carneiro','Porto','Portugal');
INSERT INTO aeroportos  VALUES  (3,'Portela','Lisboa','Portugal');
INSERT INTO aeroportos  VALUES  (5,'Faro','Faro','Portugal');
INSERT INTO aeroportos  VALUES  (2,'Madeira','Funchal','Portugal');
INSERT INTO aeroportos  VALUES  (4,'Ponta Delgada','S. Miguel','Portugal');
INSERT INTO aeroportos  VALUES  (9,'Orly','Paris','Franca');
INSERT INTO aeroportos  VALUES  (8,'Charles de Gaule','Paris','Franca');
INSERT INTO aeroportos  VALUES  (11,'Heathrow','Londres','Reino Unido');
INSERT INTO aeroportos  VALUES  (12,'Gatwick','Londres','Reino Unido');

INSERT INTO modelos  VALUES  (1,'Douglas','DC-10','3');
INSERT INTO modelos  VALUES  (2,'Boing','737','2');
INSERT INTO modelos  VALUES  (3,'Boing','747','4');
INSERT INTO modelos  VALUES  (4,'Airbus','A300','2');
INSERT INTO modelos  VALUES  (5,'Airbus','A340','4');

INSERT INTO avioes  VALUES  (1,'Scott Adams',1);
INSERT INTO avioes  VALUES  (2,'Milo Manara',1);
INSERT INTO avioes  VALUES  (4,'Henki Bilal',3);
INSERT INTO avioes  VALUES  (5,'Gary Larson',4);
INSERT INTO avioes  VALUES  (6,'Bill Waterson',4);
INSERT INTO avioes  VALUES  (7,'J R R Tolkien',3);
INSERT INTO avioes  VALUES  (8,'Franquin',3);
INSERT INTO avioes  VALUES  (9,'Douglas Adams',1);
INSERT INTO avioes  VALUES  (3,'Serpieri',5);

INSERT INTO voos VALUES  (1001,1,2,'TAP',2,1);
INSERT INTO voos VALUES  (1002,2,3,'TAP',1,2);
INSERT INTO voos VALUES  (1010,12,4,'BA',3,3);
INSERT INTO voos VALUES  (1008,3,12,'Portugalia',3,4);
INSERT INTO voos VALUES  (1007,5,1,'TAP',1,5);
INSERT INTO voos VALUES  (1009,1,3,'Portugalia',1,2);
INSERT INTO voos VALUES  (1005,9,2,'AirFrance',2,3);
INSERT INTO voos VALUES  (1003,2,12,'BA',2,5);
INSERT INTO voos VALUES  (1006,8,11,'BA',1,5);
INSERT INTO voos VALUES  (1004,4,3,'SATA',3,6);
INSERT INTO voos VALUES  (1111,1,3,'TAP',2,3);

select *from aeroportos; 
select *from modelos ;
select *from avioes;
 select *from voos;

--Questao 1
select local, nome
from aeroportos 
where pais = "Portugal";

select nome 
from avioes 
inner join modelos on avioes.codmodelo = modelos.codmodelo
where versao = 'DC-10';

select a.nome as nome_aviao, m.nummotores as num_motores 
from avioes a
inner join modelos m on a.codmodelo = m.codmodelo;

select count(*)
from voos 
where duracao in (2,3);

select* 
from modelos
where versao like 'A3%';

select codvoo, duracao 
from voos
order by duracao desc, codvoo asc;

select v1.codvoo as cod_voo1, v2.codvoo as cod_voo2, v1.paracodaerop ascodigo_aeroporto_da_escala 
from voos v1, voos v2
where v1.paracodaerop = v2.decodaerop and v1.paracodaerop != 12 and v2.decodaerop !=1;

select pais, count(*) as contagem 
from aeroportos 
group by pais
order by contagem desc;

select v.codvoo as "codigo do voo", a1.nome as origem, a2.nome as destino 
from voos v
inner join aeroportos a1 on v.decodaerop = a1.codaerop
inner join aeroportos a2 on v.paracodaerop = a2.codaerop
order by v.codvoo;

select codvoo 
from voos 
where decodaerop = (select codaerop from aeroportos where nome = 'Porto')
	and paracodaerop = (select codaerop from aeroportos where nome = 'Lisboa');

select  pais, count(*) as contagem 
from aeroportos 
group by pais 
having count(*) > 2;

select pais, count(*) as contagem 
from aeroportos 
group by pais 
order by contagem DESC limit 1;

select v.codvoo as cod_voo, a1.nome as nome_aero_part, a2.nome as nome_aerop_cheg
from voos v
inner join aeroportos a1 on v.decodaerop = a1.codaerop 
inner join aeroportos a2 on v.paracodaerop = a2.codaerop
order by nome_aero_part, nome_aerop_cheg;

select  m.construtor, m.versao, count(a.codmodelo) as contagem
from modelos m 
left join avioes a on m.codmodelo = a.codmodelo
group by m.construtor, m.versao 
order by contagem;

select m.construtor, m.versao, count(a.codmodelo) as contagem 
from modelos m 
left join avioes a on m.codmodelo = a.codmodelo
group by m.construtor, m.versao 
order by contagem;







