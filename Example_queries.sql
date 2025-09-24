--все врачи, отсортированные по специальности
select name, speciality ,phone_number _ from doctor order by name;

--приёмы пациентов, начиная с определённой даты
select a.date, p.name as patient_name, d.name as doctor_name, d.speciality, a.duration from appointment a join doctor d on a.doctor_id = d.doctor_id 
join patient p on a.patient_id = p.patient_id 
where a.date >= '2023-01-14 09:00:00.000'
order by a.date;

--количество приёмов у каждого врача (включая врачей, не ведущих приём в данном периоде)
select d.name, d.speciality, count(a.appointment_id) as count from appointment a
right join doctor d on a.doctor_id = d.doctor_id 
group by d.doctor_id
order by count desc;

--средняя продолжительность приёма каждого врача
select d.name, d.speciality, avg(a.duration) as avg from appointment a 
join doctor d on a.doctor_id = d.doctor_id 
group by d.doctor_id 
order by avg desc;

--полная информация о диагнозах (дата, пациент, врач, заболевание, симптомы и выписанные препараты)
select a.date, p.name as patient_name, doc.name as doctor_name, doc.speciality, dis.name as disease, dis.symptoms, t.name as treatment, t.usage 
from diagnosis d 
join appointment a on d.appointment_id = a.appointment_id 
join doctor doc on a.doctor_id = doc.doctor_id
join patient p on a.patient_id = p.patient_id
join disease dis on d.disease_id = dis.disease_id
left join perscribed_treatment pt on d.diagnosis_id = pt.diagnosis_id
left join treatment t on pt.treatment_id = t.treatment_id;

--поиск врачей с определённой специальностью с указанием количества пациентов
select d.name, d.speciality, count(distinct a.patient_id) as unique_patient
from appointment a 
join doctor d on a.doctor_id = d.doctor_id 
where d.speciality = 'Офтальмолог'
group by d.doctor_id;

--поиск врачей, у которых более одного приёма за выбранный период (работа с подзапросами)
select name, speciality,
(select count (*) from appointment a where a.doctor_id = d.doctor_id) as appointment_count
from doctor d
where (select count(*) from appointment a where a.doctor_id = d.doctor_id)>1
order by appointment_count desc;

--самые распространённые диагнозы
select dis.name, count(d.diagnosis_id) as diagnosis_count 
from diagnosis d
join disease dis on d.disease_id = dis.disease_id 
group by dis.disease_id  
order by diagnosis_count desc;