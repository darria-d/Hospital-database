create table doctor (
    doctor_id serial primary key,
    name varchar(100) not null,
    speciality varchar(50) not null,
    phone_number varchar(20)
);

create table patient (
    patient_id serial primary key,
    name varchar(100) not null,
    birth_date date,
    adress varchar(200),
    phone_number varchar(20)
);

create table appointment (
    appointment_id serial primary key,
    doctor_id int references doctor(doctor_id),
    patient_id int references patient(patient_id),
    date timestamp not null,
    duration int not null -- в минутах
);


create table disease (
    disease_id serial primary key,
    name varchar(100) not null,
    symptoms text
);

create table treatment (
    treatment_id serial primary key,
    name varchar(100) not null,
    effect text,
    indications text,
    contraindications text,
    side_effects text,
    usage text
);

create table diagnosis (
    diagnosis_id serial primary key,
    appointment_id int references appointment(appointment_id),
    disease_id int references disease(disease_id),
    notes text
);

create table perscribed_treatment (
    diagnosis_id int references diagnosis(diagnosis_id),
    treatment_id int references treatment(treatment_id),
    primary key (diagnosis_id, treatment_id)
);

create table possible_treatment (
    diagnosis_id int references diagnosis(diagnosis_id),
    treatment_id int references treatment(treatment_id),
    primary key (diagnosis_id, treatment_id)
);