# Principais Entidades

### Pacient 
- Permite o cadastro, a consulta e a visualização do histórico de informações dos pacientes.

### HealthcareProfessionals 
- Visualização de informação e cadastro e atribuição de profissionais para exames e consultas.
- Verificação de convênio.

### Consultation e Prescription 
- A partir de Consultation, gera-se a Prescription com registros clínicos e/ou exames.

#### Disease 
Entidade que fornece informações sobre as doenças, criada para atender as formas normais(1FN e 2FN).

#### Speciality
Entidade que indica a especialização do professional de saúde(1FN e 2FN).

#### ConsultationExam e ResultsExam 
Entidade de que faz o relacionamento do(s) exame(s) e a consulta, sendo ResultsExam a entidade que traz informações após a finalização dos exames.

#### Medication
Entidade que descreve as medicações disponíveis(1FN e 2FN).

#### PacientSituation e PacientDisease
Entidades que fornecem informações importantes em relação aos pacientes.

#### Status
Informa se a consulta está em andamento, finalizada ou confirmada. (Ajustar futuramente para comportar o histórico das consultas).

#### HealthPlan
Descreve o convênio/plano de saúde dos pacientes e profissionais.