--valores gerados por IA.

INSERT INTO disease (description, priority)
SELECT
    descricao,
    prioridade
FROM (
    VALUES
    ('Hipertensão Arterial', 3),
    ('Diabetes Mellitus Tipo 2', 3),
    ('Asma', 2),
    ('Gastrite', 1),
    ('Enxaqueca', 2),
    ('Obesidade', 2),
    ('Anemia', 2),
    ('Hipotireoidismo', 2),
    ('Dengue', 3),
    ('Pneumonia', 3),
    ('Insuficiência Cardíaca', 4),
    ('Doença Renal Crônica', 4),
    ('Artrite', 1),
    ('Depressão', 2),
    ('Ansiedade', 1),
    ('Bronquite', 2),
    ('Colesterol Alto', 2),
    ('Refluxo Gastroesofágico', 1),
    ('Osteoporose', 2),
    ('Arritmia Cardíaca', 3),
    ('Dermatite', 1),
    ('Rinite', 1),
    ('Sinusite', 1),
    ('Hepatite', 3),
    ('Fibromialgia', 2),
    ('Parkinson', 4),
    ('Alzheimer', 4),
    ('Epilepsia', 4),
    ('Cistite', 1),
    ('Artrose', 1)
) AS t(descricao, prioridade);


INSERT INTO specialty (description)
SELECT descricao
FROM (
    VALUES
    ('Cardiologia'),
    ('Clínica Geral'),
    ('Endocrinologia'),
    ('Pneumologia'),
    ('Neurologia'),
    ('Gastroenterologia'),
    ('Dermatologia'),
    ('Ortopedia'),
    ('Psiquiatria'),
    ('Nefrologia'),
    ('Pediatria'),
    ('Ginecologia'),
    ('Urologia'),
    ('Oftalmologia'),
    ('Otorrinolaringologia'),
    ('Hematologia'),
    ('Reumatologia'),
    ('Oncologia'),
    ('Infectologia'),
    ('Cirurgia Geral')
) AS t(descricao);


INSERT INTO exam (description)
SELECT descricao
FROM (
    VALUES
    ('Hemograma Completo'),
    ('Glicemia em Jejum'),
    ('Hemoglobina Glicada'),
    ('Colesterol Total'),
    ('HDL'),
    ('LDL'),
    ('Triglicerídeos'),
    ('Eletrocardiograma'),
    ('Raio-X de Tórax'),
    ('Ultrassonografia Abdominal'),
    ('Tomografia de Crânio'),
    ('Ressonância Magnética'),
    ('Creatinina'),
    ('TSH'),
    ('T4 Livre'),
    ('Exame de Urina'),
    ('Urocultura'),
    ('Espirometria'),
    ('Endoscopia Digestiva'),
    ('Colonoscopia'),
    ('Mamografia'),
    ('Ultrassom de Mama'),
    ('Papanicolau'),
    ('Densitometria Óssea'),
    ('Teste Ergométrico'),
    ('Ecocardiograma'),
    ('Holter 24h'),
    ('PCR'),
    ('Ferritina'),
    ('Vitamina B12'),
    ('Vitamina D'),
    ('Ácido Úrico'),
    ('Transaminase TGO'),
    ('Transaminase TGP'),
    ('Bilirrubina'),
    ('Cálcio'),
    ('Sódio'),
    ('Potássio'),
    ('Proteína C Reativa'),
    ('Coagulograma'),
    ('GASOMETRIA')
) AS t(descricao);


INSERT INTO medication (description)
SELECT descricao
FROM (
    VALUES
    ('Losartana 50mg'),
    ('Metformina 850mg'),
    ('Salbutamol 100mcg'),
    ('Omeprazol 20mg'),
    ('Dipirona 500mg'),
    ('Paracetamol 750mg'),
    ('Levotiroxina 50mcg'),
    ('Atorvastatina 20mg'),
    ('Amoxicilina 500mg'),
    ('Sertralina 50mg'),
    ('Enalapril 10mg'),
    ('Hidroclorotiazida 25mg'),
    ('Ibuprofeno 600mg'),
    ('Azitromicina 500mg'),
    ('Atenolol 50mg'),
    ('Amlodipino 5mg'),
    ('Propranolol 40mg'),
    ('Clonazepam 2mg'),
    ('Fluoxetina 20mg'),
    ('Prednisona 20mg'),
    ('Cetirizina 10mg'),
    ('Loratadina 10mg'),
    ('Pantoprazol 40mg'),
    ('Domperidona 10mg'),
    ('Rosuvastatina 10mg'),
    ('Insulina NPH 100UI'),
    ('Insulina Regular 100UI'),
    ('Furosemida 40mg'),
    ('Espironolactona 25mg'),
    ('AAS 100mg'),
    ('Warfarina 5mg'),
    ('Gabapentina 300mg'),
    ('Pregabalina 75mg'),
    ('Carbamazepina 200mg'),
    ('Levodopa 250mg'),
    ('Dexametasona 4mg'),
    ('Ciprofloxacino 500mg'),
    ('Metronidazol 250mg'),
    ('Diclofenaco 50mg'),
    ('Naproxeno 500mg')
) AS t(descricao);


INSERT INTO healthplan (description)
VALUES
('SUS'),
('Unimed'),
('Amil'),
('Bradesco Saúde'),
('Hapvida'),
('NotreDame Intermédica'),
('SulAmérica'),
('Porto Seguro Saúde'),
('Assim Saúde'),
('Geap');


INSERT INTO status (description)
VALUES
('Agendada'),
('Realizada'),
('Cancelada'),
('Não compareceu'),
('Em atendimento'),
('Reagendada');


INSERT INTO pacientsituation (description)
VALUES
('Ativo'),
('Inativo'),
('Em acompanhamento'),
('Alta médica'),
('Transferido');

INSERT INTO pacient
(
    name,
    cpf,
    address,
    phonenumber,
    email,
    datebirth,
    neighborhood,
    numberaddress,
    city,
    situation_id,
    healthplan_id
)
SELECT
    CASE
        WHEN gs % 97 = 0 THEN 'Paciente Teste'
        ELSE
            (ARRAY[
                'Ana','Carlos','Mariana','João','Fernanda',
                'Rafael','Juliana','Lucas','Camila','Pedro',
                'Larissa','Bruno','Beatriz','Gustavo','Isabela',
                'Thiago','Natalia','Diego','Aline','Marcelo',
                'Amanda','Gabriel','Leticia','Vinicius','Sofia'
            ])[1 + floor(random()*25)::int]
            || ' ' ||
            (ARRAY[
                'Silva','Santos','Oliveira','Souza','Costa',
                'Almeida','Lima','Rocha','Ferreira','Gomes',
                'Mendes','Barbosa','Pereira','Carvalho','Martins'
            ])[1 + floor(random()*15)::int]
    END,

    CASE
        WHEN gs % 113 = 0 THEN
            '12345678901'
        ELSE
            lpad(gs::text, 11, '0')
    END,

    'Rua ' ||
    (ARRAY[
        'das Flores',
        'do Sol',
        'da Aurora',
        'Recife',
        'das Acácias',
        'do Futuro',
        'Imperial',
        'Benfica',
        'do Riachuelo',
        'Conselheiro Aguiar'
    ])[1 + floor(random()*10)::int],

    '81' || lpad((900000000 + gs)::text, 9, '0'),

    CASE
        WHEN gs % 131 = 0 THEN NULL
        ELSE lower(
            'paciente' || gs || '@email.com'
        )
    END,

    DATE '1940-01-01'
        + floor(random() * 25000)::int,

    (ARRAY[
        'Boa Viagem',
        'Casa Amarela',
        'Madalena',
        'Torre',
        'Graças',
        'Cordeiro',
        'Imbiribeira',
        'Espinheiro',
        'Derby',
        'Boa Vista',
        'Santo Amaro',
        'Ilha do Leite'
    ])[1 + floor(random()*12)::int],

    (1 + floor(random()*2000))::text,

    (ARRAY[
        'Recife',
        'Olinda',
        'Jaboatão dos Guararapes',
        'Paulista',
        'Camaragibe'
    ])[1 + floor(random()*5)::int],

    CASE
        WHEN gs % 71 = 0 THEN 2
        WHEN gs % 83 = 0 THEN 4
        ELSE 1 + floor(random()*3)::int
    END,

    1 + floor(random()*10)::int

FROM generate_series(1,1000) gs;

INSERT INTO pacientdisease (pacient_id, disease_id)
SELECT DISTINCT
    p.id,
    1 + floor(random()*30)::int
FROM pacient p
CROSS JOIN LATERAL
generate_series(
    1,
    CASE
        WHEN random() < 0.15 THEN 4
        WHEN random() < 0.50 THEN 2
        ELSE 1
    END
);

INSERT INTO healthcareprofessional
(
    name,
    crm,
    specialty_id,
    email,
    phonenumber,
    agreement_id
)
SELECT
    'Dr(a). ' ||
    (ARRAY[
        'Ricardo Almeida',
        'Patricia Gomes',
        'Marcelo Ferreira',
        'Camila Rodrigues',
        'Felipe Santos',
        'Juliana Martins',
        'Eduardo Lima',
        'Renata Souza',
        'André Carvalho',
        'Marina Alves',
        'Gustavo Rocha',
        'Laura Mendes',
        'Daniel Costa',
        'Beatriz Silva',
        'Henrique Souza'
    ])[1 + floor(random()*15)::int],

    'CRM-PE-' || lpad(gs::text, 5, '0'),

    1 + floor(random()*20)::int,

    'profissional' || gs || '@hospital.com',

    '81' || lpad((800000000 + gs)::text, 9, '0'),

    1 + floor(random()*10)::int

FROM generate_series(1,120) gs;

INSERT INTO consultation
(
    dateconsultation,
    reason,
    pacient_id,
    professional_id,
    status_id
)
SELECT
    DATE '2025-01-01'
        + floor(random()*670)::int,

    (ARRAY[
        'Consulta de rotina',
        'Acompanhamento clínico',
        'Dor de cabeça',
        'Dor abdominal',
        'Dor no peito',
        'Controle de diabetes',
        'Controle de hipertensão',
        'Acompanhamento respiratório',
        'Avaliação de exames',
        'Retorno médico',
        'Queixa de tontura',
        'Dor muscular',
        'Alteração na pressão',
        'Acompanhamento de tratamento',
        'Consulta preventiva'
    ])[1 + floor(random()*15)::int],

    1 + floor(random()*1000)::int,

    1 + floor(random()*120)::int,

    CASE
        WHEN random() < 0.70 THEN 2
        WHEN random() < 0.80 THEN 1
        WHEN random() < 0.90 THEN 3
        WHEN random() < 0.95 THEN 4
        ELSE 5
    END

FROM generate_series(1,8000);

INSERT INTO prescription
(
    dosage,
    frequency,
    duration,
    medication_id,
    consultation_id
)
SELECT
    (ARRAY[
        '5mg',
        '10mg',
        '20mg',
        '25mg',
        '50mg',
        '75mg',
        '100mg',
        '250mg',
        '500mg',
        '750mg',
        '850mg'
    ])[1 + floor(random()*11)::int],

    (ARRAY[
        '1 vez ao dia',
        '2 vezes ao dia',
        '3 vezes ao dia',
        'A cada 6 horas',
        'A cada 8 horas',
        'Quando necessário'
    ])[1 + floor(random()*6)::int],

    (ARRAY[
        '5 dias',
        '7 dias',
        '15 dias',
        '30 dias',
        '60 dias',
        '90 dias'
    ])[1 + floor(random()*6)::int],

    1 + floor(random()*40)::int,

    c.id

FROM consultation c
WHERE c.status_id IN (1,2,5)
AND random() < 0.65;

INSERT INTO consultationexam
(
    consultation_id,
    exam_id
)
SELECT DISTINCT
    c.id,
    1 + floor(random()*40)::int
FROM consultation c
CROSS JOIN LATERAL
generate_series(
    1,
    CASE
        WHEN random() < 0.10 THEN 4
        WHEN random() < 0.40 THEN 2
        ELSE 1
    END
)
WHERE c.status_id IN (1,2,5);

INSERT INTO resultsexam
(
    exam_id,
    consultation_id,
    examtechnician_id,
    dateexam,
    descriptionresult
)
SELECT
    ce.exam_id,

    ce.consultation_id,

    1 + floor(random()*120)::int,

    c.dateconsultation
        + floor(random()*8)::int,

    (ARRAY[
        'Resultado dentro dos valores de referência',
        'Resultado acima do valor de referência',
        'Resultado abaixo do valor de referência',
        'Sem alterações significativas',
        'Alteração discreta identificada',
        'Necessita avaliação médica',
        'Resultado compatível com acompanhamento clínico',
        'Exame inconclusivo',
        'Alterações observadas no exame'
    ])[1 + floor(random()*9)::int]

FROM consultationexam ce
JOIN consultation c
    ON c.id = ce.consultation_id
WHERE random() < 0.82;