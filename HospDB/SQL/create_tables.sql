create schema if not exists hospital;

--Criando as tabelas auxiliares primeiro
CREATE TABLE disease (
    id serial primary key not null,
    description varchar(255) not null,
    priority int
);

CREATE TABLE specialty (
    id serial primary key not null,
    description varchar(255) not null
);

CREATE TABLE exam (
    id serial primary key not null,
    description varchar(255) not null
);

CREATE TABLE medication (
    id serial primary key not null,
    description varchar(255) not null
);

CREATE TABLE healthplan (
    id serial primary key not null,
    description varchar(255) not null
);

CREATE TABLE status (
    id serial primary key not null,
    description varchar(255) not null
);

CREATE TABLE pacientsituation (
    id serial primary key not null,
    description varchar(255) not null
);

--Criando as tabelas principais e com dependências
CREATE TABLE pacient (
    id serial primary key not null,
    name varchar(255) not null,
    cpf varchar(11) not null,
    address varchar(255),
    phonenumber varchar(15),
    email varchar(100),
    datebirth date,
    neighborhood varchar(100),
    numberaddress varchar(10),
    city varchar(100),
    situation_id int references pacientsituation(id),
    healthplan_id int references healthplan(id)
);

CREATE TABLE pacientdisease (
    pacient_id int references pacient(id),
    disease_id int references disease(id),
    primary key (pacient_id, disease_id)
);

CREATE TABLE healthcareprofessional (
    id serial primary key not null,
    name varchar(255) not null,
    CRM varchar(20) not null,
    specialty_id int references specialty(id),
    email varchar(100),
    phonenumber varchar(15),
    agreement_id int references healthplan(id)
);

CREATE TABLE consultation (
    id serial primary key not null,
    dateconsultation date not null,
    reason varchar(255) not null,
    pacient_id int references pacient(id),
    professional_id int references healthcareprofessional(id),
    status_id int references status(id)
);

CREATE TABLE prescription (
    id serial primary key not null,
    dosage varchar(100) not null,
    frequency varchar(100) not null,
    duration varchar(100) not null,
    medication_id int references medication(id),
    consultation_id int references consultation(id)
);

CREATE TABLE consultationexam (
    consultation_id int references consultation(id),
    exam_id int references exam(id),
    primary key (consultation_id, exam_id)
);

CREATE TABLE resultsexam (
    exam_id int references exam(id),
    consultation_id int references consultation(id),
    examtechnician_id int references healthcareprofessional(id),
    dateexam date not null,
    descriptionresult varchar(255) not null
);