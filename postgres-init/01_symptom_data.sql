--
-- PostgreSQL database dump
--

-- \restrict HryOXyPJqKc6yz0qidQRCaTHf8AOZqHaHqhhRVbO8w9rj3rmEkuGRFvdoO8d9UM

-- Dumped from database version 15.14
-- Dumped by pg_dump version 15.14

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: diagnose_disease_ids; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.diagnose_disease_ids (
    diagnose_session_id uuid NOT NULL,
    disease_id bigint
);


--
-- Name: diagnose_session; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.diagnose_session (
    id uuid NOT NULL,
    pet_name character varying(255),
    pet_type character varying(255),
    symptoms json,
    user_id bigint,
    disease_id bigint,
    main_disease_id bigint,
    confidence_percentage integer,
    CONSTRAINT diagnose_session_pet_type_check CHECK (((pet_type)::text = ANY ((ARRAY['CANINE'::character varying, 'FELINE'::character varying, 'EQUINE'::character varying, 'BOVINE'::character varying, 'OVINE'::character varying, 'CAPRINE'::character varying, 'AVIAN'::character varying, 'REPTILIAN'::character varying, 'SMALL_ANIMAL'::character varying, 'EXOTIC'::character varying, 'PORCINE'::character varying, 'MARINE'::character varying, 'WILD'::character varying])::text[])))
);


--
-- Name: diagnosis; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.diagnosis (
    id bigint NOT NULL,
    disease_id bigint NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(50) NOT NULL,
    per_description character varying(255),
    per_name character varying(255)
);


--
-- Name: diagnosis_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.diagnosis_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: diagnosis_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.diagnosis_id_seq OWNED BY public.diagnosis.id;


--
-- Name: disease; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.disease (
    id bigint NOT NULL,
    description character varying(255),
    name character varying(255),
    differential_diseases_str character varying(1000),
    from_valid_sources boolean NOT NULL,
    source character varying(255),
    sub_type character varying(255),
    symptoms_str character varying(1000),
    type character varying(255),
    why_important character varying(255),
    main_symptom character varying(255),
    per_name character varying(255),
    per_description character varying(255),
    per_why_important character varying(255)
);


--
-- Name: disease_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.disease_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: disease_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.disease_id_seq OWNED BY public.disease.id;


--
-- Name: disease_species; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.disease_species (
    disease_id bigint NOT NULL,
    species character varying(255)
);


--
-- Name: disease_symptom_enums; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.disease_symptom_enums (
    disease_id bigint NOT NULL,
    symptom_enum character varying(255) NOT NULL
);


--
-- Name: medicine; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.medicine (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(50) NOT NULL,
    description character varying(255),
    dog_dosage character varying(200),
    cat_dosage character varying(200),
    contraindications text,
    per_description character varying(255),
    per_name character varying(255)
);


--
-- Name: medicine_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.medicine_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: medicine_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.medicine_id_seq OWNED BY public.medicine.id;


--
-- Name: stage; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.stage (
    id bigint NOT NULL,
    disease_id bigint NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    per_description character varying(255),
    per_name character varying(255)
);


--
-- Name: stage_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.stage_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: stage_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.stage_id_seq OWNED BY public.stage.id;


--
-- Name: stage_symptom_enums; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.stage_symptom_enums (
    stage_id bigint NOT NULL,
    symptom_enum character varying(255) NOT NULL
);


--
-- Name: text_data; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.text_data (
    id bigint NOT NULL,
    main_title character varying(255),
    page smallint NOT NULL,
    section character varying(255),
    subtitle character varying(255),
    symptom integer,
    text_book integer
);


--
-- Name: text_data_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.text_data_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: text_data_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.text_data_id_seq OWNED BY public.text_data.id;


--
-- Name: treatment; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.treatment (
    id bigint NOT NULL,
    disease_id bigint NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(50) NOT NULL,
    per_description character varying(255),
    per_name character varying(255)
);


--
-- Name: treatment_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.treatment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: treatment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.treatment_id_seq OWNED BY public.treatment.id;


--
-- Name: treatment_medicine; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.treatment_medicine (
    treatment_id bigint NOT NULL,
    medicine_id bigint NOT NULL
);


--
-- Name: diagnosis id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.diagnosis ALTER COLUMN id SET DEFAULT nextval('public.diagnosis_id_seq'::regclass);


--
-- Name: disease id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.disease ALTER COLUMN id SET DEFAULT nextval('public.disease_id_seq'::regclass);


--
-- Name: medicine id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.medicine ALTER COLUMN id SET DEFAULT nextval('public.medicine_id_seq'::regclass);


--
-- Name: stage id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stage ALTER COLUMN id SET DEFAULT nextval('public.stage_id_seq'::regclass);


--
-- Name: text_data id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.text_data ALTER COLUMN id SET DEFAULT nextval('public.text_data_id_seq'::regclass);


--
-- Name: treatment id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.treatment ALTER COLUMN id SET DEFAULT nextval('public.treatment_id_seq'::regclass);


--
-- Name: diagnose_session diagnose_session_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.diagnose_session
    ADD CONSTRAINT diagnose_session_pkey PRIMARY KEY (id);


--
-- Name: diagnosis diagnosis_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.diagnosis
    ADD CONSTRAINT diagnosis_pkey PRIMARY KEY (id);


--
-- Name: disease disease_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.disease
    ADD CONSTRAINT disease_pkey PRIMARY KEY (id);


--
-- Name: disease_symptom_enums disease_symptom_enums_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.disease_symptom_enums
    ADD CONSTRAINT disease_symptom_enums_pkey PRIMARY KEY (disease_id, symptom_enum);


--
-- Name: medicine medicine_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.medicine
    ADD CONSTRAINT medicine_name_key UNIQUE (name);


--
-- Name: medicine medicine_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.medicine
    ADD CONSTRAINT medicine_pkey PRIMARY KEY (id);


--
-- Name: stage stage_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stage
    ADD CONSTRAINT stage_pkey PRIMARY KEY (id);


--
-- Name: stage_symptom_enums stage_symptom_enums_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stage_symptom_enums
    ADD CONSTRAINT stage_symptom_enums_pkey PRIMARY KEY (stage_id, symptom_enum);


--
-- Name: text_data text_data_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.text_data
    ADD CONSTRAINT text_data_pkey PRIMARY KEY (id);


--
-- Name: treatment_medicine treatment_medicine_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.treatment_medicine
    ADD CONSTRAINT treatment_medicine_pkey PRIMARY KEY (treatment_id, medicine_id);


--
-- Name: treatment treatment_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.treatment
    ADD CONSTRAINT treatment_pkey PRIMARY KEY (id);


--
-- Name: idx_diagnosis_disease; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_diagnosis_disease ON public.diagnosis USING btree (disease_id);


--
-- Name: idx_disease_species; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_disease_species ON public.disease_species USING btree (species);


--
-- Name: idx_disease_symptom_enum; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_disease_symptom_enum ON public.disease_symptom_enums USING btree (symptom_enum);


--
-- Name: idx_medicine_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_medicine_name ON public.medicine USING btree (name);


--
-- Name: idx_stage_disease; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_stage_disease ON public.stage USING btree (disease_id);


--
-- Name: idx_stage_symptom_enum; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_stage_symptom_enum ON public.stage_symptom_enums USING btree (symptom_enum);


--
-- Name: idx_treatment_disease; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_treatment_disease ON public.treatment USING btree (disease_id);


--
-- Name: idx_treatment_medicine_medicine; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_treatment_medicine_medicine ON public.treatment_medicine USING btree (medicine_id);


--
-- Name: diagnosis diagnosis_disease_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.diagnosis
    ADD CONSTRAINT diagnosis_disease_id_fkey FOREIGN KEY (disease_id) REFERENCES public.disease(id) ON DELETE CASCADE;


--
-- Name: disease_symptom_enums disease_symptom_enums_disease_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.disease_symptom_enums
    ADD CONSTRAINT disease_symptom_enums_disease_id_fkey FOREIGN KEY (disease_id) REFERENCES public.disease(id) ON DELETE CASCADE;


--
-- Name: disease_species fk87leowsufcg3mls3srwt5yjau; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.disease_species
    ADD CONSTRAINT fk87leowsufcg3mls3srwt5yjau FOREIGN KEY (disease_id) REFERENCES public.disease(id);


--
-- Name: diagnose_session fkgvxrnecuwdxjiofdfovnxunpx; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.diagnose_session
    ADD CONSTRAINT fkgvxrnecuwdxjiofdfovnxunpx FOREIGN KEY (main_disease_id) REFERENCES public.disease(id);


--
-- Name: diagnose_session fkn2iexsphg4t3t95pvx9p858ax; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.diagnose_session
    ADD CONSTRAINT fkn2iexsphg4t3t95pvx9p858ax FOREIGN KEY (disease_id) REFERENCES public.disease(id);


--
-- Name: diagnose_disease_ids fkn3droh9b1jfk8sq032osdrbec; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.diagnose_disease_ids
    ADD CONSTRAINT fkn3droh9b1jfk8sq032osdrbec FOREIGN KEY (diagnose_session_id) REFERENCES public.diagnose_session(id);


--
-- Name: stage stage_disease_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stage
    ADD CONSTRAINT stage_disease_id_fkey FOREIGN KEY (disease_id) REFERENCES public.disease(id) ON DELETE CASCADE;


--
-- Name: stage_symptom_enums stage_symptom_enums_stage_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stage_symptom_enums
    ADD CONSTRAINT stage_symptom_enums_stage_id_fkey FOREIGN KEY (stage_id) REFERENCES public.stage(id) ON DELETE CASCADE;


--
-- Name: treatment treatment_disease_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.treatment
    ADD CONSTRAINT treatment_disease_id_fkey FOREIGN KEY (disease_id) REFERENCES public.disease(id) ON DELETE CASCADE;


--
-- Name: treatment_medicine treatment_medicine_medicine_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.treatment_medicine
    ADD CONSTRAINT treatment_medicine_medicine_id_fkey FOREIGN KEY (medicine_id) REFERENCES public.medicine(id) ON DELETE CASCADE;


--
-- Name: treatment_medicine treatment_medicine_treatment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.treatment_medicine
    ADD CONSTRAINT treatment_medicine_treatment_id_fkey FOREIGN KEY (treatment_id) REFERENCES public.treatment(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

-- \unrestrict HryOXyPJqKc6yz0qidQRCaTHf8AOZqHaHqhhRVbO8w9rj3rmEkuGRFvdoO8d9UM

--
-- PostgreSQL database dump
--

-- \restrict bBJjJGpzw4iLuO9eAUgJ75TEsuJw9W8hcbI4VbeESS9ciCP1p2bxKU7vGWG6zsu

-- Dumped from database version 15.14
-- Dumped by pg_dump version 15.14

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: disease; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.disease VALUES (3, 'Tearing of aortic intima with blood tracking within media, causing ischemia or rupture.', 'Aortic Dissection', 'aortic aneurysm, myocarditis', true, 'MERCK_VET_MANUAL', NULL, 'bradycardia, pain in chest or abdomen, collapse', 'VASCULAR', 'Medical emergency with >80% mortality; diagnosis requires advanced imaging (CT/echo).', 'BRADYCARDIA', 'دیسکسیون آئورت', 'پارگی لایه اندوتلیال آئورت و نفوذ خون به لایه مدیا، که می‌تواند منجر به ایسکمی یا پارگی شود.', 'اورژانس پزشکی با مرگ‌ومیر بیش از ۸۰٪؛ تشخیص نیازمند تصویربرداری پیشرفته (سی‌تی/اکو) است.');
INSERT INTO public.disease VALUES (4, 'Obstruction to left ventricular outflow, commonly subvalvular in dogs.', 'Aortic Stenosis', 'hypertrophic cardiomyopathy, dilated cardiomyopathy', true, 'MERCK_VET_MANUAL', 'SUBAORTIC_STENOSIS', 'decreased appetite, syncope, murmur', 'CONGENITAL', '#1 congenital heart defect in large-breed dogs (e.g., Boxers); causes sudden death in young athletes.', 'DECREASED_APPETITE', 'تنگی آئورت', 'متابازداری خروجی بطن چپ، که در سگ‌ها معمولاً زیر دریچه‌ای است.', 'شایع‌ترین ناهنجاری مادرزادی قلب در سگ‌های نژاد بزرگ (مانند باکسر)؛ باعث مرگ ناگهانی در ورزشکاران جوان می‌شود.');
INSERT INTO public.disease VALUES (7, 'Fibrofatty replacement of RV myocardium, leading to ventricular arrhythmias.', 'Arrhythmogenic Right Ventricular Cardiomyopathy (ARVC)', 'dilated cardiomyopathy, myocarditis', true, 'MERCK_VET_MANUAL', 'BOXER_CARDIOMYOPATHY', 'swelling, syncope, sudden death', 'PRIMARY_CARDIOMYOPATHY', 'Breed-specific (Boxers); leading cause of sudden death in young adults — screening ECG vital.', 'SWELLING', 'کاردیومیوپاتی آریتموژنیک بطن راست (ARVC)', 'جایگزینی فیبروچرب در میوکارد بطن راست که منجر به آریتمی‌های بطنی می‌شود.', 'وابسته به نژاد (باکسر)؛ شایع‌ترین علت مرگ ناگهانی در بزرگسالان جوان — نوار قلب غربالگری حیاتی است.');
INSERT INTO public.disease VALUES (9, 'Congenital opening in atrial septum causing left-to-right shunt.', 'Atrial Septal Defect (ASD)', 'ventricular septal defect, patent ductus arteriosus', true, 'MERCK_VET_MANUAL', NULL, 'decreased appetite, murmur, lethargy', 'CONGENITAL', 'Often silent in small defects; large shunts cause right heart failure — correctable surgically.', 'DECREASED_APPETITE', 'ناهنجاری سپتوم دهلیزی (ASD)', 'سوراخ مادرزادی در سپتوم دهلیزی که باعث شانت چپ به راست می‌شود.', 'در نقص‌های کوچک اغلب بی‌عرضه است؛ شانت‌های بزرگ باعث نارسایی قلب راست می‌شوند — از نظر جراحی قابل اصلاح است.');
INSERT INTO public.disease VALUES (12, 'Hemodynamic compromise due to pericardial fluid compressing the heart.', 'Cardiac Tamponade', 'pericardial effusion, hypovolemic shock', true, 'MERCK_VET_MANUAL', NULL, 'syncope, jugular vein distension, muffled heart sounds', 'PERICARDIAL', 'True emergency: muffled heart sounds + JVD + pulsus paradoxus = tamponade — requires pericardiocentesis NOW.', 'SYNCOPE', 'تامپوناد قلبی', 'ناهماهنگی همودینامیک ناشی از تجمع مایع پریکاردی که قلب را فشار می‌دهد.', 'اورژانس واقعی: صداهای قلب کم‌صدات + ورید ژوگولار بارز + پولسوس پارادوکسوس = تامپوناد — نیازمند پریکاردیوسنتز فوری است.');
INSERT INTO public.disease VALUES (13, 'Neuroendocrine tumor arising from aortic/carotid bodies, compressing great vessels.', 'Chemodectoma (Heart Base Tumor)', 'lymphoma, thymoma', true, 'MERCK_VET_MANUAL', NULL, 'polyuria, dyspnea, coughing', 'NEOPLASTIC', 'Slow-growing but causes SVC syndrome (JVD, facial edema); surgical resection possible in early stages.', 'POLYURIA', 'کمو دِکتوما (تومور پایه قلب)', 'تومور نورواندوکرین ناشی از جسم‌های آئورتی/کاروتیدی که عروق بزرگ را فشار می‌دهد.', 'رشد کند اما باعث سندرم ورید کاوا علیا (ورید ژوگولار بارز، ورم صورت) می‌شود؛ در مراحل اولیه برداشت جراحی امکان‌پذیر است.');
INSERT INTO public.disease VALUES (15, 'Right heart failure secondary to chronic pulmonary hypertension from lung disease.', 'Chronic Lung Diseases leading to Cor Pulmonale', 'pulmonary thromboembolism, primary pulmonary hypertension', true, 'MERCK_VET_MANUAL', NULL, 'lethargy, dyspnea, ascites', 'METABOLIC_ENDOCRINE', 'End-stage consequence of chronic bronchitis/interstitial lung disease — focus on underlying lung pathology.', 'LETHARGY', 'بیماری‌های مزمن ریوی منجر به کُر پولموناله', 'نارسایی قلب راست ثانویه به فشار خون ریوی مزمن ناشی از بیماری ریه.', 'عارضه پایانی مزمن برونشیت مزمن/بیماری ریوی بینابینی — تمرکز بر بیماری زمینه‌ای ریه است.');
INSERT INTO public.disease VALUES (17, 'Impaired electrical conduction (e.g., AV block, bundle branch block).', 'Conduction Blocks', 'sick sinus syndrome, myocarditis', true, 'MERCK_VET_MANUAL', NULL, 'painful limbs, weakness, syncope', 'ARRHYTHMIA', 'High-grade AV block causes Stokes-Adams attacks — pacemaker often required for survival.', 'PAINFUL_LIMBS', 'بلوک‌های هدایتی', 'اختلال در هدایت الکتریکی (مانند بلوک AV، بلوک شاخه‌های دسته هیس).', 'بلوک درجه بالای آتریوونتریکولار باعث حملات استوکس-آدامز می‌شود — اغلب برای بقا نیاز به پیس‌میکر دارد.');
INSERT INTO public.disease VALUES (19, 'Congenital membrane dividing left atrium, obstructing pulmonary venous return.', 'Cor Triatriatum', 'mitral stenosis, pulmonary veno-occlusive disease', true, 'MERCK_VET_MANUAL', NULL, 'lethargy, dyspnea, coughing', 'CONGENITAL', 'Often missed on echo; causes severe PH and CHF in young dogs — surgical resection is definitive.', 'LETHARGY', 'کُر تری‌آتریاتوم', 'غشای مادرزادی که دهلیز چپ را تقسیم کرده و بازگشت وریدی ریوی را مسدود می‌کند.', 'اغلب در اکوکاردیوگرافی از دست می‌رود؛ در سگ‌های جوان باعث فشار خون ریوی شدید و نارسایی قلبی می‌شود — برداشت جراحی درمان قطعی است.');
INSERT INTO public.disease VALUES (24, 'Reversal of shunt direction (left-to-right → right-to-left) due to pulmonary hypertension.', 'Eisenmenger’s Syndrome', 'primary pulmonary hypertension, heartworm disease', true, 'MERCK_VET_MANUAL', NULL, 'pain in chest or abdomen, cyanosis, syncope', 'CONGENITAL', 'End-stage complication of unrepaired VSD/PDA; cyanosis and polycythemia develop — prognosis poor.', 'PAIN_IN_CHEST_OR_ABDOMEN', 'سندرم آیزن‌منگر', 'وارونگی جهت شانت (چپ-به-راست → راست-به-چپ) ناشی از فشار خون ریوی بالا.', 'عارضه پایانی ترمیم‌نشده نقص سپتوم بطنی/داکتوس آرتریوزوس باز؛ سیانوز و پلی‌سیتمی توسعه می‌یابد — پیش‌آگهی ضعیف است.');
INSERT INTO public.disease VALUES (27, 'Inflammation of endocardium and myocardium, often viral or immune-mediated.', 'Endomyocarditis', 'dilated cardiomyopathy, myocarditis', true, 'MERCK_VET_MANUAL', NULL, 'sudden death, lethargy, dyspnea', 'INFECTIOUS', 'Acute fulminant form causes rapid CHF — differentiate from DCM via PCR/serology for viruses.', 'SUDDEN_DEATH', 'اندو میوکاردیت', 'التهاب آندوکارد و میوکارد، که اغلب ویروسی یا ایمنی‌میانجی است.', 'شکل حاد فولمینان باعث نارسایی قلبی سریع می‌شود — از طریق پی‌سی‌آر/سرولوژی ویروسی از کاردیومیوپاتی انبساطی متمایز شود.');
INSERT INTO public.disease VALUES (28, 'Pulmonary arterial and right heart pathology from Dirofilaria immitis infection.', 'Heartworm Disease (Dirofilariasis)', 'chronic bronchitis, pulmonary hypertension', true, 'MERCK_VET_MANUAL', 'DIROFILARIA_IMMITIS', 'pale gums, coughing, dyspnea', 'INFECTIOUS', '#1 preventable cardiopulmonary disease in dogs; endemic in many regions — annual testing essential.', 'PALE_GUMS', 'بیماری کرم قلبی (دیروفیلاریازیس)', 'آسیب‌های شریان ریوی و قلب راست ناشی از عفونت دیروفیلاریا ایمیتیس.', 'شایع‌ترین بیماری قلبی-ریوی قابل پیشگیری در سگ‌ها؛ در بسیاری از مناطق اندمیک است — تست سالانه ضروری است.');
INSERT INTO public.disease VALUES (34, 'Primary myocardial disorder with left ventricular hypertrophy in absence of loading conditions.', 'Hypertrophic Cardiomyopathy (HCM)', 'restrictive cardiomyopathy, systemic hypertension', true, 'MERCK_VET_MANUAL', NULL, 'dyspnea, syncope, murmur', 'PRIMARY_CARDIOMYOPATHY', '#1 heart disease in cats; leading cause of sudden death and aortic thromboembolism — early diagnosis critical.', 'DYSPNEA', 'کاردیومیوپاتی هایپرتروفیک (HCM)', 'اختلال اولیه میوکارد با هایپرتروفی بطن چپ در غیاب شرایط بارگذاری.', 'شایع‌ترین بیماری قلبی در گربه‌ها؛ علت اصلی مرگ ناگهانی و ترومبواستمبولی آئورت — تشخیص زودهنگام حیاتی است.');
INSERT INTO public.disease VALUES (35, 'Low calcium causing prolonged QT, arrhythmias, and myocardial depression.', 'Hypocalcemia', 'eclampsia, hypoparathyroidism', true, 'MERCK_VET_MANUAL', NULL, 'shock, muscle tremors, seizures', 'METABOLIC_ENDOCRINE', 'Prolonged QT increases risk of torsades de pointes — common in lactating bitches (eclampsia).', 'SHOCK', 'هیپوکلسمی', 'کاهش کلسیم خون که منجر به طولانی‌شدن QT، آریتمی و افسردگی میوکارد می‌شود.', 'طولانی‌شدن کیو‌تی خطر تورساد دو پوانت را افزایش می‌دهد — شایع در سگ‌های شیرده (اکلامپسی).');
INSERT INTO public.disease VALUES (36, 'Low potassium causing ST depression, U-waves, and ventricular arrhythmias.', 'Hypokalemia', 'chronic kidney disease, vomiting', true, 'MERCK_VET_MANUAL', NULL, 'coughing, weakness, muscle weakness', 'METABOLIC_ENDOCRINE', 'Common in cats with CKD; contributes to ventroflexion and arrhythmias — correct slowly to avoid rebound hyperkalemia.', 'COUGHING', 'هیپوکالمی', 'کاهش پتاسیم خون که باعث افت ST، امواج U و آریتمی‌های بطنی می‌شود.', 'شایع در گربه‌های مبتلا به بیماری کلیوی مزمن؛ به ونتروفلکشن و آریتمی کمک می‌کند — به آرامی اصلاح کنید تا از هایپرکالمی واکنشی جلوگیری شود.');
INSERT INTO public.disease VALUES (38, 'Neoplastic infiltration of myocardium/pericardium, causing arrhythmias or effusion.', 'Lymphoma (cardiac involvement)', 'hemangiosarcoma, chemodectoma', true, 'MERCK_VET_MANUAL', NULL, 'polyuria, weakness, pericardial effusion', 'NEOPLASTIC', 'Rare but aggressive; pericardial effusion may be first sign — cytology of fluid often diagnostic.', 'POLYURIA', 'لنفوم (درگیری قلبی)', 'تهاجم توموری به میوکارد/پریکارد که باعث آریتمی یا افیوژن می‌شود.', 'نادر اما تهاجمی؛ افیوژن پریکاردیال ممکن است اولین نشانه باشد — سیتولوژی مایع اغلب تشخیصی است.');
INSERT INTO public.disease VALUES (41, 'Inflammatory infiltration of myocardium, causing systolic dysfunction and arrhythmias.', 'Myocarditis', 'dilated cardiomyopathy, endocarditis', true, 'MERCK_VET_MANUAL', NULL, 'skin ulcers or lesions, lethargy, sudden death', 'INFECTIOUS', 'Often viral (parvovirus, distemper); acute form mimics DCM — PCR on biopsy gold standard.', 'SKIN_ULCERS_OR_LESIONS', 'میوکاردیت', 'تهاجم التهابی به میوکارد که باعث نارسایی سیستولیک و آریتمی می‌شود.', 'اغلب ویروسی (پاروویروس، دیستمپر)؛ شکل حاد تقلیدکننده کاردیومیوپاتی انبساطی — پی‌سی‌آر روی بیوپسی استاندارد طلایی است.');
INSERT INTO public.disease VALUES (42, 'Histologic term for valve matrix disruption in degenerative valve disease.', 'Myxomatous Degeneration', 'mitral valve disease, tricuspid dysplasia', true, 'MERCK_VET_MANUAL', NULL, 'fever, murmur, coughing', 'VALVULAR', 'Pathologic basis of MVD — not a clinical diagnosis per se, but explains progression of valve disease.', 'FEVER', 'دژنراسیون میکزوماتوس', 'اصطلاح هیستولوژیک برای اختلال ماتریکس دریچه در بیماری دژنراتیو دریچه.', 'پایه پاتولوژیک بیماری دریچه میترال — خود یک تشخیص بالینی نیست، اما پیشرفت بیماری دریچه را توضیح می‌دهد.');
INSERT INTO public.disease VALUES (43, 'Clinical term for MVD in small-breed dogs with myxomatous degeneration.', 'Myxomatous Mitral Valve Disease (MMVD)', 'tricuspid valve disease, dilated cardiomyopathy', true, 'MERCK_VET_MANUAL', NULL, 'pale gums, murmur, coughing', 'VALVULAR', 'Synonym for MVD — emphasized to distinguish from other mitral pathologies (e.g., endocarditis).', 'PALE_GUMS', 'بیماری میکزوماتوس دریچه میترال (MMVD)', 'اصطلاح بالینی برای MVD در سگ‌های نژادهای کوچک با دژنراسیون میکزوماتوس.', 'مترادف بیماری دریچه میترال میکزوماتوس — برای تمایز از سایر آسیب‌های میترال (مانند آندوکاردیت) تأکید شده است.');
INSERT INTO public.disease VALUES (44, 'Failure of ductus arteriosus to close after birth, causing left heart volume overload.', 'Patent Ductus Arteriosus (PDA)', 'ventricular septal defect, aortic stenosis', true, 'MERCK_VET_MANUAL', NULL, 'decreased appetite, murmur, weakness', 'CONGENITAL', 'Most common treatable congenital heart defect; coil occlusion has >95% success — untreated leads to CHF by 1 year.', 'DECREASED_APPETITE', 'داکتوس آرتریوزوس باز (PDA)', 'ناتوانی در بسته شدن داکتوس آرتریوزوس پس از تولد که باعث بار حجمی بطن چپ می‌شود.', 'شایع‌ترین ناهنجاری مادرزادی قابل درمان؛ اکلوزیون با کویل موفقیت بیش از ۹۵٪ دارد — در صورت عدم درمان تا ۱ سالگی به نارسایی قلبی منجر می‌شود.');
INSERT INTO public.disease VALUES (46, 'Fluid accumulation in pericardial sac, potentially causing tamponade.', 'Pericardial Effusion', 'cardiac tamponade, pericarditis', true, 'MERCK_VET_MANUAL', NULL, 'lethargy, jugular vein distension, muffled heart sounds', 'PERICARDIAL', 'Most common cardiac emergency in large-breed dogs — hemangiosarcoma accounts for 70% of malignant cases.', 'LETHARGY', 'افیوژن پریکاردی', 'تجمع مایع در کیسه پریکارد که ممکن است منجر به تامپوناد شود.', 'شایع‌ترین اورژانس قلبی در سگ‌های نژاد بزرگ — همانگیوسارکوم ۷۰٪ موارد بدخیم را تشکیل می‌دهد.');
INSERT INTO public.disease VALUES (49, 'Stenosis/occlusion of peripheral arteries, reducing limb perfusion.', 'Peripheral Vascular Disease', 'aortic thromboembolism, vasculitis', true, 'MERCK_VET_MANUAL', NULL, 'regurgitation, cold extremities, lameness', 'VASCULAR', 'Often secondary to hyperadrenocorticism or diabetes — “cold limb” syndrome mimics saddle thrombus.', 'REGURGITATION', 'بیماری عروق محیطی', 'تنگی/اُنسداد شریان‌های محیطی که باعث کاهش خونرسانی به اندام‌ها می‌شود.', 'اغلب ثانویه به هایپرآدرنوکورتیسیسم یا دیابت — سندرم "اندام سرد" تقلیدکننده ترومبوز سرجوخ است.');
INSERT INTO public.disease VALUES (51, 'Acute obstruction of pulmonary arteries by thrombus, fat, or air.', 'Pulmonary Embolism', 'pulmonary thromboembolism, heartworm disease', true, 'MERCK_VET_MANUAL', NULL, 'lethargy, dyspnea, sudden death', 'THROMBOEMBOLIC', 'Often fatal if massive; subtle cases present as exercise intolerance — D-dimer not validated in vet med.', 'LETHARGY', 'امبولی ریوی', 'متابازداری حاد شریان‌های ریوی توسط ترومب، چربی یا هوا.', 'در صورت حجیم بودن اغلب کشنده است؛ موارد ظریف به‌صورت عدم تحمل ورزش ارائه می‌شوند — دی-دایمر در دامپزشکی اعتبارسنجی نشده است.');
INSERT INTO public.disease VALUES (54, 'Malformation of pulmonary valve leaflets causing stenosis or regurgitation.', 'Pulmonary Valve Dysplasia', 'pulmonic stenosis, tetralogy of Fallot', true, 'MERCK_VET_MANUAL', NULL, 'decreased appetite, murmur, exercise intolerance', 'CONGENITAL', 'Spectrum from mild (asymptomatic) to severe (cyanosis); echo essential for grading severity.', 'DECREASED_APPETITE', 'دیسپلازی دریچه ریوی', 'ناهنجاری ساختاری لخته‌های دریچه ریوی که باعث تنگی یا رِگورژیتاسیون می‌شود.', 'طیفی از خفیف (بی‌عرضه) تا شدید (سیانوز)؛ اکوکاردیوگرافی برای درجه‌بندی شدت ضروری است.');
INSERT INTO public.disease VALUES (55, 'Obstruction at pulmonary valve level, causing right ventricular hypertrophy.', 'Pulmonic Stenosis', 'pulmonary artery stenosis, tetralogy of Fallot', true, 'MERCK_VET_MANUAL', NULL, 'decreased appetite, murmur, syncope', 'CONGENITAL', 'Most common congenital defect in Bulldogs; balloon valvuloplasty reduces gradient by 50% in 80% of cases.', 'DECREASED_APPETITE', 'تنگی دریچه ریوی', 'متابازداری در سطح دریچه ریوی که باعث هایپرتروفی بطن راست می‌شود.', 'شایع‌ترین ناهنجاری مادرزادی در بولداگ‌ها؛ والوولوپلاستی با بالون گرادیان را در ۸۰٪ موارد ۵۰٪ کاهش می‌دهد.');
INSERT INTO public.disease VALUES (59, 'Dysfunction of sinoatrial node causing bradycardia-tachycardia or pauses.', 'Sick Sinus Syndrome (SSS)', 'atrial standstill, conduction blocks', true, 'MERCK_VET_MANUAL', NULL, 'swelling, syncope, weakness', 'ARRHYTHMIA', 'Most common in Miniature Schnauzers; syncope episodes correlate with asystole >8 sec — pacemaker indicated.', 'SWELLING', 'سندرم سینوسی سُست (SSS)', 'ناکارآمدی گره سینوآتریال که باعث برادی‌کاردی-تاکی‌کاردی یا وقفه می‌شود.', 'شایع‌ترین در اشنائوسرهای کوچک؛ حملات سنکوپ با آسیستول بیش از ۸ ثانیه همبستگی دارد — پیس‌میکر نشان‌دهنده است.');
INSERT INTO public.disease VALUES (61, 'Elevated systemic blood pressure (>160 mmHg), often secondary to CKD or hyperthyroidism.', 'Systemic Arterial Hypertension', 'hyperthyroidism, hyperadrenocorticism', true, 'MERCK_VET_MANUAL', NULL, 'jugular vein distension, sudden blindness, murmur', 'HYPERTENSIVE', '#1 cause of sudden blindness in cats; target organ damage (retina, kidney, brain) — treat to <150 mmHg.', 'JUGULAR_VEIN_DISTENSION', 'فشار خون سیستمیک بالا', 'فشار خون سیستمیک بالاتر از ۱۶۰ میلی‌متر جیوه، که اغلب ثانویه به بیماری کلیوی مزمن یا هایپرتیروئیدی است.', 'شایع‌ترین علت نابینایی ناگهانی در گربه‌ها؛ آسیب به اندام هدف (شبكیه، کلیه، مغز) — درمان تا زیر ۱۵۰ میلی‌متر جیوه.');
INSERT INTO public.disease VALUES (63, 'Sepsis, endotoxemia, or bacteremia causing myocardial depression or vasodilation.', 'Systemic Infections with cardiac implications', 'endocarditis, myocarditis', true, 'MERCK_VET_MANUAL', NULL, 'sudden death, fever, shock', 'INFECTIOUS', 'Myocardial dysfunction in sepsis increases mortality 3-fold — early fluid resuscitation critical.', 'SUDDEN_DEATH', 'عفونت‌های سیستمیک با عوارض قلبی', 'سپسیس، اندوتوکسمی یا باکترمی که باعث افسردگی میوکارد یا گشادی عروقی می‌شود.', 'نارسایی میوکاردی در سپسیس مرگ‌ومیر را ۳ برابر افزایش می‌دهد — رزوسیتاسیون مایعات زودهنگام حیاتی است.');
INSERT INTO public.disease VALUES (8, 'Rapid, irregular atrial activation causing loss of atrial kick and tachycardia.', 'Atrial Fibrillation', 'mitral valve disease, dilated cardiomyopathy', true, 'MERCK_VET_MANUAL', NULL, 'exercise intolerance, weakness, murmur', 'ARRHYTHMIA', 'Most common sustained arrhythmia in dogs; reduces cardiac output by 20–30% — requires rate control.', 'EXERCISE_INTOLERANCE', 'فیبریلاسیون دهلیزی', 'فعالیت سریع و نامنظم دهلیزی که منجر به از دست رفتن پُرش دهلیزی و تاکی‌کاردی می‌گردد.', 'شایع‌ترین آریتمی مداوم در سگ‌ها؛ خروجی قلب را ۲۰–۳۰٪ کاهش می‌دهد — نیازمند کنترل ضربان قلب است.');
INSERT INTO public.disease VALUES (11, 'Extracellular deposition of amyloid fibrils in myocardium, causing restrictive physiology.', 'Cardiac Amyloidosis', 'restrictive cardiomyopathy, pericardial effusion', true, 'MERCK_VET_MANUAL', NULL, 'polyuria, lethargy, ascites', 'PRIMARY_CARDIOMYOPATHY', 'Underdiagnosed in cats (especially Abyssinians); mimics RCM — definitive diagnosis requires biopsy.', 'POLYURIA', 'آمیلوئیدوز قلبی', 'رسوب خارج سلولی فیبریل‌های آمیلوئید در میوکارد که باعث فیزیولوژی محدودکننده می‌شود.', 'در گربه‌ها (به‌ویژه آبیسینی) کم‌تشخیص است؛ تقلیدکننده کاردیومیوپاتی رستریکتیو — تشخیص قطعی نیازمند بیوپسی است.');
INSERT INTO public.disease VALUES (18, 'Abnormal direct artery-to-vein shunting, causing high-output failure.', 'Congenital Arteriovenous Fistulas', 'patent ductus arteriosus, vascular ring anomalies', true, 'MERCK_VET_MANUAL', NULL, 'fever, murmur, swelling', 'CONGENITAL', 'Rare; causes localized warmth, edema, and cardiac overload — coil embolization is curative.', 'FEVER', 'فیستول‌های شریانی-وریدی مادرزادی', 'ارتباط غیرطبیعی مستقیم بین شریان و ورید که باعث نارسایی دبی بالا می‌شود.', 'نادر؛ باعث گرما و ورم موضعی و بار اضافی قلب می‌شود — امبلیزاسیون با کویل درمان قطعی است.');
INSERT INTO public.disease VALUES (31, 'Elevated calcium causing shortened QT, bradycardia, and vascular calcification.', 'Hypercalcemia', 'hyperparathyroidism, lymphoma', true, 'MERCK_VET_MANUAL', NULL, 'weight gain, weakness, polyuria', 'METABOLIC_ENDOCRINE', 'QT shortening predisposes to ventricular arrhythmias — rule out apocrine gland adenocarcinoma in dogs.', 'WEIGHT_GAIN', 'هایپرکلسمی', 'افزایش کلسیم خون که منجر به کوتاه‌شدن QT، برادی‌کاردی و کلسیفیکاسیون عروقی می‌شود.', 'کوتاه‌شدن کیو‌تی مستعد آریتمی بطنی می‌کند — آدنوکارسینوم غده آپوکرین را در سگ‌ها رد کنید.');
INSERT INTO public.disease VALUES (25, 'Diffuse thickening of left ventricular endocardium, causing restrictive physiology.', 'Endocardial Fibroelastosis (Fibroelastosis)', 'hypertrophic cardiomyopathy, myocarditis', true, 'MERCK_VET_MANUAL', NULL, 'polyuria, dyspnea, failure to thrive', 'PRIMARY_CARDIOMYOPATHY', 'Typically in young puppies/kittens; historically linked to panleukopenia virus — often fatal despite therapy.', 'POLYURIA', 'فیبروالاستوز آندوکاردیال (فیبروالاستوز)', 'ضخیم‌شدگی منتشر اندوکارد بطن چپ که باعث فیزیولوژی محدودکننده می‌شود.', 'معمولاً در توله‌سگ‌ها/گربه‌های کوچک؛ سابقه ارتباط با ویروس پان‌لوکوپنی — اغلب علیرغم درمان کشنده است.');
INSERT INTO public.disease VALUES (33, 'Secondary HCM-like changes from chronic tachycardia and hypertension in hyperthyroid cats.', 'Hyperthyroidism-Induced Cardiomyopathy (cats)', 'primary hypertrophic cardiomyopathy', true, 'MERCK_VET_MANUAL', NULL, 'lameness, weight loss, tachycardia', 'METABOLIC_ENDOCRINE', 'Reversible with thyroid treatment — echo should normalize in 3–6 months after euthyroidism achieved.', 'LAMENESS', 'کاردیومیوپاتی ناشی از هایپرتیروئیدی (در گربه‌ها)', 'تغییرات ثانویه شبیه HCM ناشی از تاکی‌کاردی مزمن و فشار خون بالا در گربه‌های هایپرتیروئید.', 'با درمان تیروئید برگشت‌پذیر است — اکوکاردیوگرافی باید ۳–۶ ماه پس از رسیدن به وضعیت اوتیروئید نرمال شود.');
INSERT INTO public.disease VALUES (47, 'Idiopathic or inflammatory effusion without neoplasia.', 'Pericardial Effusion (non-cancerous)', 'cardiac tamponade, pericarditis', true, 'MERCK_VET_MANUAL', 'IDIOPATHIC', 'lethargy, jugular vein distension, muffled heart sounds', 'PERICARDIAL', 'Better prognosis than neoplastic effusion; many resolve after pericardiocentesis — consider pericardial window.', 'LETHARGY', 'افیوژن پریکاردی (غیرسرطانی)', 'افیوژن ایدیوپاتیک یا التهابی بدون علت نئوپلاستیک.', 'پیش‌آگهی بهتر از افیوژن نئوپلاستیک؛ بسیاری پس از پریکاردیوسنتز بهبود می‌یابند — پنجره پریکاردیال را در نظر بگیرید.');
INSERT INTO public.disease VALUES (64, 'Combination of VSD, pulmonic stenosis, overriding aorta, and RV hypertrophy.', 'Tetralogy of Fallot', 'pulmonic stenosis, ventricular septal defect', true, 'MERCK_VET_MANUAL', NULL, 'pain in chest or abdomen, cyanosis, exercise intolerance', 'CONGENITAL', 'Most common cyanotic congenital defect in dogs; “tet spells” cause acute cyanosis — beta-blockers reduce hypoxia.', 'PAIN_IN_CHEST_OR_ABDOMEN', 'تترالوژی فالو', 'ترکیبی از ناهنجاری سپتوم بطنی، تنگی دریچه ریوی، آئورت رویی‌رفته و هایپرتروفی بطن راست.', 'شایع‌ترین ناهنجاری مادرزادی سیانوتیک در سگ‌ها؛ "حملات تت" باعث سیانوز حاد می‌شوند — بتا بلاکرها هیپوکسی را کاهش می‌دهند.');
INSERT INTO public.disease VALUES (67, 'Inflammatory destruction of vessel walls, causing ischemia, thrombosis, or hemorrhage.', 'Vasculitis (inflammation of the blood vessels)', 'hyperadrenocorticism, immune-mediated disease', true, 'MERCK_VET_MANUAL', NULL, 'regurgitation, skin ulcers or lesions, lameness', 'VASCULAR', 'Cutaneous vasculitis common in cats (vaccine-related); systemic forms cause multi-organ failure — immunosuppression key.', 'REGURGITATION', 'وازکولیت (التهاب عروق‌ها)', 'تخریب التهابی دیواره عروق که باعث ایسکمی، ترومبوز یا خونریزی می‌شود.', 'واسکولیت پوستی شایع در گربه‌ها (وابسته به واکسن)؛ اشکال سیستمیک باعث نارسایی چندعضوی می‌شود — سرکوب ایمنی کلیدی است.');
INSERT INTO public.disease VALUES (29, 'Caval syndrome, pulmonary hypertension, and cor pulmonale from long-term infection.', 'Heartworm Disease complications (Chronic)', 'pericardial effusion, pulmonary thromboembolism', true, 'MERCK_VET_MANUAL', 'CAVAL_SYNDROME', 'lethargy, jugular vein distension, collapse', 'INFECTIOUS', 'Caval syndrome is surgical emergency — requires rapid heartworm extraction via jugular venotomy.', 'LETHARGY', 'عوارض مزمن بیماری کرم قلبی', 'سندرم وِنا کاوا، فشار خون ریوی بالا و کُر پولموناله ناشی از عفونت طولانی‌مدت.', 'سندرم کوال اورژانس جراحی است — نیازمند استخراج سریع کرم قلبی از طریق ونوتومی ژوگولار است.');
INSERT INTO public.disease VALUES (32, 'Elevated potassium causing bradycardia, conduction blocks, and asystole.', 'Hyperkalemia', 'hypoadrenocorticism, urethral obstruction', true, 'MERCK_VET_MANUAL', NULL, 'polydipsia, weakness, bradycardia', 'METABOLIC_ENDOCRINE', 'True emergency: peaked T-waves → loss of P-waves → sine wave → cardiac arrest — treat with calcium gluconate NOW.', 'POLYDIPSIA', 'هایپرکالمی', 'افزایش پتاسیم خون که باعث برادی‌کاردی، بلوک هدایتی و آسیستول می‌شود.', 'اورژانس واقعی: امواج تی تیز → از دست رفتن امواج پی → موج سینوسی → توقف قلب — بلافاصله با گلوکنات کلسیم درمان کنید.');
INSERT INTO public.disease VALUES (21, 'Diabetic cardiomyopathy: myocardial fibrosis, diastolic dysfunction, and microangiopathy.', 'Diabetes Mellitus (cardiac complications)', 'hyperadrenocorticism, hypothyroidism', true, 'MERCK_VET_MANUAL', NULL, 'weight gain, polyuria, weakness', 'METABOLIC_ENDOCRINE', 'Silent myocardial damage even with good glucose control — annual echo recommended in diabetic dogs.', 'WEIGHT_GAIN', 'عوارض قلبی دیابت شیرین', 'کاردیومیوپاتی دیابتی: فیبروز میوکارد، نارسایی دیاستولیک و میکروآنژیوپاتی.', 'آسیب میوکاردی ساکت حتی با کنترل خوب گلوکز — اکوکاردیوگرافی سالانه در سگ‌های دیابتی توصیه می‌شود.');
INSERT INTO public.disease VALUES (45, 'Persistent opening in atrial septum at fossa ovalis, usually hemodynamically insignificant.', 'Patent Foramen Ovale (PFO)', 'atrial septal defect, Eisenmenger’s syndrome', true, 'MERCK_VET_MANUAL', NULL, 'fever, murmur, exercise intolerance', 'CONGENITAL', 'Often incidental; significant only if causing paradoxical embolism or right-to-left shunting under stress.', 'FEVER', 'فورامن اووال باز (PFO)', 'سوراخ باقیمانده در سپتوم دهلیزی در محل فوسا اووالیس، که معمولاً از نظر همودینامیک بی‌اهمیت است.', 'اغلب تصادفی؛ فقط در صورت ایجاد امبولی پارادوکسیکال یا شانت راست به چپ تحت استرس قابل توجه است.');
INSERT INTO public.disease VALUES (50, 'Obstruction of pulmonary arterial outflow, commonly valvular in dogs.', 'Pulmonary Artery Stenosis', 'pulmonic stenosis, tetralogy of Fallot', true, 'MERCK_VET_MANUAL', NULL, 'decreased appetite, murmur, syncope', 'CONGENITAL', 'Common in Bulldogs, Boxers; severe cases cause right heart failure — balloon valvuloplasty effective.', 'DECREASED_APPETITE', 'تنگی شریان ریوی', 'متابازداری خروجی شریان ریوی، که در سگ‌ها معمولاً در سطح دریچه‌ای است.', 'شایع در بولداگ‌ها، باکسرها؛ موارد شدید باعث نارسایی قلب راست می‌شوند — والوولوپلاستی با بالون مؤثر است.');
INSERT INTO public.disease VALUES (53, 'Thrombus formation in pulmonary arteries, often secondary to hypercoagulability.', 'Pulmonary Thromboembolism', 'pulmonary embolism, heartworm disease', true, 'MERCK_VET_MANUAL', NULL, 'lethargy, dyspnea, tachypnea', 'THROMBOEMBOLIC', 'Common in protein-losing nephropathy/enteropathy — consider anticoagulation in high-risk patients.', 'LETHARGY', 'ترومبومبولی ریوی', 'تشکیل ترومب در شریان‌های ریوی، که اغلب ثانویه به هایپرکواگولابیلیته است.', 'شایع در نفروپاتی/انتروپاتی از دست‌دهنده پروتئین — در بیماران پرخطر ضد انعقاد را در نظر بگیرید.');
INSERT INTO public.disease VALUES (58, 'Myocardial depression from inflammatory mediators in systemic infection.', 'Sepsis-Induced Cardiac Dysfunction', 'hypovolemic shock, cardiogenic shock', true, 'MERCK_VET_MANUAL', NULL, 'lethargy, weakness, hypotension', 'METABOLIC_ENDOCRINE', 'Reversible with sepsis control; troponin elevation correlates with mortality — avoid inotropic overuse.', 'LETHARGY', 'نارسایی میوکاردی ناشی از سپسیس', 'افسردگی میوکارد ناشی از مُدیاتورهای التهابی در عفونت سیستمیک.', 'با کنترل سپسیس برگشت‌پذیر است؛ افزایش تروپونین با مرگ‌ومیر همبستگی دارد — از استفاده بیش از حد اینوتروپیک‌ها اجتناب کنید.');
INSERT INTO public.disease VALUES (60, 'Fibrous ridge below aortic valve causing LVOT obstruction.', 'Subaortic Stenosis (SAS)', 'aortic stenosis, hypertrophic cardiomyopathy', true, 'MERCK_VET_MANUAL', NULL, 'decreased appetite, murmur, syncope', 'CONGENITAL', 'Most common congenital defect in large breeds (Newfoundlands, Golden Retrievers); sudden death risk mandates echo screening.', 'DECREASED_APPETITE', 'تنگی زیر آئورتی (SAS)', 'رشته فیبروز زیر دریچه آئورت که موجب متابازداری خروجی بطن چپ می‌شود.', 'شایع‌ترین ناهنجاری مادرزادی در نژادهای بزرگ (نیوفاندلندز، گلدن رتریور)؛ خطر مرگ ناگهانی غربالگری با اکوکاردیوگرافی را الزامی می‌کند.');
INSERT INTO public.disease VALUES (66, 'Congenital malformations of aortic arch vessels causing esophageal compression.', 'Vascular Ring Anomalies', 'megaesophagus, hiatal hernia', true, 'MERCK_VET_MANUAL', NULL, 'tissue death, regurgitation, dysphagia', 'CONGENITAL', 'Persistent right aortic arch most common; causes regurgitation after weaning — surgical correction curative.', 'TISSUE_DEATH', 'ناهنجاری‌های حلقه عروقی', 'ناهنجاری‌های مادرزادی عروق قوس آئورت که باعث فشار بر مری می‌شوند.', 'قوس آئورت راست باقی‌مانده شایع‌ترین است؛ پس از شیرگیری باعث رگورژیتاسیون می‌شود — تصحیح جراحی درمانی است.');
INSERT INTO public.disease VALUES (1, 'High-output heart failure due to reduced oxygen-carrying capacity increasing cardiac workload.', 'Anemia-related Cardiac Stress', 'chronic kidney disease, hemorrhage', true, 'MERCK_VET_MANUAL', NULL, 'lameness, weakness, tachycardia, pale gums', 'METABOLIC_ENDOCRINE', 'Leads to high-output CHF; reversible if anemia corrected — critical to identify underlying cause.', 'LAMENESS', 'استرس قلبی ناشی از کم‌خونی', 'نارسایی قلبی با دبی بالا به دلیل کاهش ظرفیت حمل اکسیژن و افزایش بار کاری قلب.', 'منجر به نارسایی قلبی با دبی بالا می‌شود؛ در صورت اصلاح کم‌خونی برگشت‌پذیر است — شناسایی علت زمینه‌ای بسیار حیاتی است.');
INSERT INTO public.disease VALUES (2, 'Focal dilation of the aortic wall, risk of rupture and sudden death.', 'Aortic Aneurysm', 'aortic dissection, neoplasia', true, 'MERCK_VET_MANUAL', NULL, 'coughing, dyspnea, sudden death', 'VASCULAR', 'Rare but catastrophic; rupture causes rapid exsanguination — often undiagnosed ante-mortem.', 'COUGHING', 'آنوریسم آئورت', 'اتساع موضعی دیواره آئورت که خطر پارگی و مرگ ناگهانی را افزایش می‌دهد.', 'نادر اما فاجعه‌بار؛ پارگی باعث خونریزی سریع و مرگ می‌شود — اغلب پیش از مرگ تشخیص داده نمی‌شود.');
INSERT INTO public.disease VALUES (5, 'Acute arterial occlusion at aortic trifurcation causing bilateral hindlimb paralysis.', 'Aortic Thromboembolism (saddle thrombus in cats)', 'spinal trauma, polyneuropathy', true, 'MERCK_VET_MANUAL', 'SECONDARY_TO_HCM', 'hind limb paralysis, painful limbs, cold extremities', 'THROMBOEMBOLIC', '#1 cause of acute paralysis in cats; 50% mortality at 48h — hallmark of advanced HCM.', 'HIND_LIMB_PARALYSIS', 'ترومبومبولی آئورتی (ترومب سرجوخ در گربه‌ها)', 'اُنسداد حاد شریانی در محل تقسیم سه‌گانه آئورت که باعث فلج دوطرفه اندام‌های عقبی می‌شود.', 'شایع‌ترین علت فلج حاد در گربه‌ها؛ مرگ‌ومیر ۵۰٪ در ۴۸ ساعت — نشانه کلاسیک کاردیومیوپاتی هیپرتروفیک پیشرفته.');
INSERT INTO public.disease VALUES (6, 'Primary electrical disorders (e.g., SSS, AV block) without myocardial pathology.', 'Arrhythmias without structural heart disease', 'hypothyroidism, intoxication', true, 'MERCK_VET_MANUAL', NULL, 'polydipsia, syncope, weakness', 'ARRHYTHMIA', 'Often overlooked; may be only sign of systemic illness — correctable if identified early.', 'POLYDIPSIA', 'آریتمی‌های بدون بیماری ساختاری قلب', 'اختلالات الکتریکی اولیه (مانند سندرم سینوسی سُست، بلوک AV) بدون آسیب میوکاردی.', 'اغلب نادیده گرفته می‌شود؛ ممکن است تنها نشانه بیماری سیستمیک باشد — در صورت شناسایی زودهنگام قابل اصلاح است.');
INSERT INTO public.disease VALUES (10, 'Loss of atrial electrical activity, often due to hyperkalemia or myocardial disease.', 'Atrial Standstill', 'hyperkalemia, myocarditis', true, 'MERCK_VET_MANUAL', NULL, 'painful limbs, weakness, bradycardia', 'ARRHYTHMIA', 'Medical emergency when secondary to hyperkalemia (e.g., uroabdomen); treat underlying cause immediately.', 'PAINFUL_LIMBS', 'توقف دهلیزی', 'از دست رفتن فعالیت الکتریکی دهلیز، که اغلب ناشی از هایپرکالمی یا بیماری میوکاردی است.', 'اورژانس پزشکی هنگامی که ثانویه به هایپرکالمی (مثلاً ادرار در شکم) باشد؛ بلافاصله علت زمینه‌ای را درمان کنید.');
INSERT INTO public.disease VALUES (14, 'Uremic cardiomyopathy, hypertension, and accelerated atherosclerosis.', 'Chronic Kidney Disease with cardiac implications', 'hyperthyroidism, diabetes mellitus', true, 'MERCK_VET_MANUAL', 'UREMIC_CARDIOMYOPATHY', 'weight gain, hypertension, lethargy', 'METABOLIC_ENDOCRINE', 'CKD and CVD form a vicious cycle — #1 comorbidity in geriatric cats; control BP to slow progression.', 'WEIGHT_GAIN', 'بیماری مزمن کلیوی با عوارض قلبی', 'کاردیومیوپاتی اورمیک، فشار خون بالا و تسریع آترواسکلروز.', 'بیماری کلیوی مزمن و بیماری قلبی-عروقی چرخه معیوبی ایجاد می‌کنند — شایع‌ترین بیماری همراه در گربه‌های سالخورده؛ کنترل فشار خون برای کند کردن پیشرفت حیاتی است.');
INSERT INTO public.disease VALUES (16, 'Persistent pulmonary hypertension due to unresolved pulmonary thromboemboli.', 'Chronic Thromboembolic Pulmonary Hypertension (CTEPH)', 'primary pulmonary hypertension, heartworm disease', true, 'MERCK_VET_MANUAL', NULL, 'lethargy, dyspnea, syncope', 'THROMBOEMBOLIC', 'Rare but treatable with pulmonary endarterectomy — high suspicion needed in refractory PH cases.', 'LETHARGY', 'فشار خون ریوی ترومبومبولیک مزمن (CTEPH)', 'فشار خون ریوی مزمن ناشی از ترومبومبولی‌های ریوی حل‌نشده.', 'نادر اما قابل درمان با آنداکترکتومی ریوی — نیاز به شک بالا در موارد فشار خون ریوی مقاوم.');
INSERT INTO public.disease VALUES (20, 'Excess cortisol causing hypertension, thrombosis, and myocardial fibrosis.', 'Cushing’s Disease (Hyperadrenocorticism)', 'diabetes mellitus, hypothyroidism', true, 'MERCK_VET_MANUAL', NULL, 'weight gain, polyuria, polydipsia', 'METABOLIC_ENDOCRINE', 'Major risk factor for thromboembolism and systemic hypertension — screen cardiac status before treatment.', 'WEIGHT_GAIN', 'بیماری کوشینگ (هایپرآدرنوکورتیسیسم)', 'افزایش کورتیزول که منجر به فشار خون بالا، ترومبوز و فیبروز میوکارد می‌شود.', 'عامل خطر عمده برای ترومبواستمبولی و فشار خون سیستمیک — قبل از درمان وضعیت قلبی را غربالگری کنید.');
INSERT INTO public.disease VALUES (69, 'Congenital opening in interventricular septum, causing left-to-right shunt.', 'Ventricular Septal Defect (VSD)', 'patent ductus arteriosus, atrial septal defect', true, 'MERCK_VET_MANUAL', NULL, 'decreased appetite, murmur, failure to thrive', 'CONGENITAL', 'Small defects often close spontaneously; large defects cause Eisenmenger’s — surgical closure possible in select cases.', 'DECREASED_APPETITE', 'ناهنجاری سپتوم بطنی (VSD)', 'سوراخ مادرزادی در سپتوم بین بطنی که باعث شانت چپ به راست می‌شود.', 'نقص‌های کوچک اغلب خودبه‌خود بسته می‌شوند؛ نقص‌های بزرگ باعث سندرم آیزن‌منگر می‌شوند — بستن جراحی در موارد منتخب امکان‌پذیر است.');
INSERT INTO public.disease VALUES (22, 'Ventricular dilation and systolic dysfunction, common in large-breed dogs.', 'Dilated Cardiomyopathy (DCM)', 'mitral valve disease, pericardial effusion', true, 'MERCK_VET_MANUAL', 'TAURINE_DEFICIENCY', 'skin ulcers or lesions, weakness, collapse', 'PRIMARY_CARDIOMYOPATHY', '#2 most common heart disease in dogs; taurine-responsive forms exist — early pimobendan improves survival.', 'SKIN_ULCERS_OR_LESIONS', 'کاردیومیوپاتی اتساعی (DCM)', 'اتساع بطنی و نارسایی سیستولیک، شایع در سگ‌های نژادهای بزرگ.', 'دومین بیماری قلبی شایع در سگ‌ها؛ اشکال‌های پاسخ‌دهنده به تورین وجود دارد — پیمووندان زودهنگام بقا را بهبود می‌بخشد.');
INSERT INTO public.disease VALUES (23, 'Apical displacement of tricuspid valve leaflets, causing atrialization of RV.', 'Ebstein’s Anomaly', 'tricuspid dysplasia, atrial septal defect', true, 'MERCK_VET_MANUAL', NULL, 'decreased appetite, murmur, ascites', 'CONGENITAL', 'Rare; causes severe tricuspid regurgitation and right heart failure — palliative surgery options limited.', 'DECREASED_APPETITE', 'ناهنجاری ابشتاین', 'جابه‌جایی اپی‌کاردی دریچه سه‌لختی که باعث «دهلیزی‌شدن» بطن راست می‌شود.', 'نادر؛ باعث رگورژیتاسیون سه‌لختی شدید و نارسایی قلب راست می‌شود — گزینه‌های جراحی تسکینی محدود است.');
INSERT INTO public.disease VALUES (26, 'Infection of endocardial surfaces (usually valves), causing vegetations and emboli.', 'Endocarditis', 'myocarditis, vasculitis', true, 'MERCK_VET_MANUAL', NULL, 'sudden death, fever, murmur', 'INFECTIOUS', 'Often missed: “fever of unknown origin” + new murmur = endocarditis — blood cultures critical.', 'SUDDEN_DEATH', 'اندوکاردیت', 'عفونت سطوح آندوکاردی (معمولاً دریچه‌ها) که باعث ایجاد وِژِتاسیون و امبولی می‌شود.', 'اغلب از دست می‌رود: "تب با علت نامشخص" + مرمر جدید = آندوکاردیت — کشت خون حیاتی است.');
INSERT INTO public.disease VALUES (30, 'Malignant endothelial tumor, commonly in right atrium, causing pericardial effusion.', 'Hemangiosarcoma (cardiac tumors affecting blood vessels)', 'chemodectoma, lymphoma', true, 'MERCK_VET_MANUAL', NULL, 'syncope, weakness, pericardial effusion', 'NEOPLASTIC', '#1 cardiac tumor in dogs (esp. Golden Retrievers); pericardial effusion often first sign — median survival <3 months.', 'SYNCOPE', 'همانژیوسارکوم (تومورهای قلبی عروقی)', 'تومور بدخیم اندوتلیال، معمولاً در دهلیز راست، که باعث افیوژن پریکاردی می‌شود.', 'شایع‌ترین تومور قلبی در سگ‌ها (به‌ویژه گلدن رتریور)؛ افیوژن پریکاردیال اغلب اولین نشانه است — میانگین بقا کمتر از ۳ ماه.');
INSERT INTO public.disease VALUES (37, 'Myocardial mucin accumulation causing diastolic dysfunction, bradycardia, and mild chamber enlargement.', 'Hypothyroidism (dogs, leading to bradycardia and cardiac enlargement)', 'dilated cardiomyopathy, sick sinus syndrome', true, 'MERCK_VET_MANUAL', NULL, 'skin ulcers or lesions, lethargy, bradycardia', 'METABOLIC_ENDOCRINE', 'Reversible with levothyroxine — avoid misdiagnosis as primary heart disease in Dobermans/Goldens.', 'SKIN_ULCERS_OR_LESIONS', 'هیپوتیروئیدی (در سگ‌ها)', 'تجمع موکین در میوکارد که منجر به نارسایی دیاستولیک، برادی‌کاردی و بزرگی خفیف حفره‌های قلبی می‌شود.', 'با لووتیروکسین برگشت‌پذیر است — از تشخیص اشتباه به‌عنوان بیماری قلبی اولیه در دوبرمن‌ها/گلدن‌ها اجتناب کنید.');
INSERT INTO public.disease VALUES (39, 'Degenerative mitral valve changes causing regurgitation, most common in small-breed dogs.', 'Mitral Valve Disease (MVD)', 'tricuspid valve disease, dilated cardiomyopathy', true, 'MERCK_VET_MANUAL', 'MYXOMATOUS_DEGENERATION', 'pale gums, murmur, coughing', 'VALVULAR', '#1 heart disease in dogs (esp. Cavalier King Charles); ACVIM staging guides pimobendan timing to delay CHF.', 'PALE_GUMS', 'بیماری دریچه میترال (MVD)', 'تغییرات دژنراتیو دریچه میترال که باعث رِگورژیتاسیون می‌شود و شایع‌ترین در سگ‌های نژادهای کوچک است.', 'شایع‌ترین بیماری قلبی در سگ‌ها (به‌ویژه کینگ چارلز کاوالیر)؛ استیجینگ ای‌سی‌وی‌آی‌ام زمان‌بندی پیمووندان را برای تأخیر در نارسایی قلبی هدایت می‌کند.');
INSERT INTO public.disease VALUES (40, 'Systolic displacement of mitral leaflets into left atrium, often benign.', 'Mitral Valve Prolapse (MVP)', 'mitral valve disease, hypertrophic cardiomyopathy', true, 'MERCK_VET_MANUAL', NULL, 'fever, murmur, exercise intolerance', 'VALVULAR', 'Mostly incidental in dogs; significant prolapse can cause severe MR — echo needed for grading.', 'FEVER', 'پرولاپس دریچه میترال (MVP)', 'جابه‌جایی سیستولیک لخته‌های میترال به داخل دهلیز چپ، که اغلب خوش‌خیم است.', 'عمدتاً تصادفی در سگ‌ها؛ پرولاپس قابل توجه می‌تواند باعث رگورژیتاسیون میترال شدید شود — برای درجه‌بندی به اکوکاردیوگرافی نیاز است.');
INSERT INTO public.disease VALUES (48, 'Inflammation of pericardium, often with effusion or constriction.', 'Pericarditis', 'pericardial effusion, myocarditis', true, 'MERCK_VET_MANUAL', NULL, 'lethargy, pain in chest or abdomen, fever', 'PERICARDIAL', 'Rare in dogs/cats; often secondary to infection, uremia, or neoplasia — constriction causes diastolic failure.', 'LETHARGY', 'پریکاردیت', 'التهاب پریکارد، که اغلب همراه با افیوژن یا سخت‌شدگی است.', 'نادر در سگ/گربه؛ اغلب ثانویه به عفونت، اورمی یا نئوپلازی — تنگی باعث نارسایی دیاستولیک می‌شود.');
INSERT INTO public.disease VALUES (52, 'Elevated pulmonary arterial pressure from various causes (Group I-V).', 'Pulmonary Hypertension', 'heartworm disease, pulmonary thromboembolism', true, 'MERCK_VET_MANUAL', NULL, 'decreased appetite, syncope, dyspnea', 'HYPERTENSIVE', 'Tricuspid regurgitation velocity >3.0 m/s on echo diagnostic; sildenafil improves quality of life.', 'DECREASED_APPETITE', 'فشار خون ریوی بالا', 'افزایش فشار شریان ریوی ناشی از علل مختلف (گروه‌های I تا V).', 'سرعت رگورژیتاسیون تریکوسپید بیش از ۳٫۰ متر بر ثانیه در اکوکاردیوگرافی تشخیصی است؛ سیلدنافیل کیفیت زندگی را بهبود می‌بخشد.');
INSERT INTO public.disease VALUES (56, 'Impaired ventricular filling due to stiff myocardium, common in cats.', 'Restrictive Cardiomyopathy (RCM)', 'hypertrophic cardiomyopathy, cardiac amyloidosis', true, 'MERCK_VET_MANUAL', NULL, 'lethargy, dyspnea, ascites', 'PRIMARY_CARDIOMYOPATHY', 'Often misdiagnosed as HCM; biatrial enlargement with normal wall thickness is hallmark — poor prognosis.', 'LETHARGY', 'کاردیومیوپاتی محدودکننده (RCM)', 'اختلال در پر شدن بطن‌ها به دلیل سفتی میوکارد، شایع در گربه‌ها.', 'اغلب به‌اشتباه به‌عنوان کاردیومیوپاتی هیپرتروفیک تشخیص داده می‌شود؛ بزرگ‌شدن دو دهلیز با ضخامت دیواره نرمال نشانه کلاسیک است — پیش‌آگهی ضعیف است.');
INSERT INTO public.disease VALUES (57, 'Synonym for ARVC in Boxers — fibrofatty RV replacement.', 'Right Ventricular Cardiomyopathy (Boxer Cardiomyopathy)', 'dilated cardiomyopathy, myocarditis', true, 'MERCK_VET_MANUAL', 'ARRHYTHMOGENIC', 'swelling, syncope, sudden death', 'PRIMARY_CARDIOMYOPATHY', 'Breed-specific; Holter monitoring detects VPCs before symptoms — sotalol reduces sudden death risk.', 'SWELLING', 'کاردیومیوپاتی بطن راست (کاردیومیوپاتی باکسر)', 'همسان با ARVC در سگ‌های باکسر — جایگزینی فیبروچرب در بطن راست.', 'وابسته به نژاد؛ هولتر مانیتورینگ وی‌پی‌سی‌ها را قبل از علائم تشخیص می‌دهد — سوتالول خطر مرگ ناگهانی را کاهش می‌دهد.');
INSERT INTO public.disease VALUES (62, 'Hypertension due to identifiable underlying disease (CKD, Cushing’s, etc.).', 'Systemic Hypertension (often secondary to kidney disease, hyperadrenocorticism, etc.)', 'primary hypertension, pheochromocytoma', true, 'MERCK_VET_MANUAL', 'SECONDARY', 'jugular vein distension, sudden blindness, proteinuria', 'HYPERTENSIVE', '95% of feline hypertension is secondary — always search for underlying cause before labeling “essential”.', 'JUGULAR_VEIN_DISTENSION', 'فشار خون سیستمیک (معمولاً ثانویه به بیماری کلیه، کوشینگ و غیره)', 'فشار خون بالا ناشی از بیماری زمینه‌ای قابل شناسایی (بیماری کلیوی مزمن، کوشینگ و غیره).', '۹۵٪ فشار خون گربه‌ها ثانویه است — همیشه قبل از برچسب "اولیه" به دنبال علت زمینه‌ای باشید.');
INSERT INTO public.disease VALUES (65, 'Malformation of tricuspid valve apparatus causing regurgitation and RA/RV enlargement.', 'Tricuspid Valve Dysplasia (TVD)', 'Ebstein’s anomaly, constrictive pericarditis', true, 'MERCK_VET_MANUAL', NULL, 'weakness, jugular vein distension, ascites', 'CONGENITAL', 'Common in Labrador Retrievers; severe cases present with right-sided CHF in puppyhood — palliative care only.', 'WEAKNESS', 'دیسپلازی دریچه سه‌لختی (TVD)', 'ناهنجاری مادرزادی دستگاه دریچه سه‌لختی که باعث رِگورژیتاسیون و بزرگی دهلیز/بطن راست می‌شود.', 'شایع در لبرادور رتریورها؛ موارد شدید در دوران نوزادی با نارسایی قلب راست ارائه می‌شوند — فقط مراقبت تسکینی.');
INSERT INTO public.disease VALUES (68, 'Premature ventricular contractions, VT, or VF causing hemodynamic compromise.', 'Ventricular Arrhythmias', 'ARVC, myocarditis', true, 'MERCK_VET_MANUAL', NULL, 'swelling, syncope, sudden death', 'ARRHYTHMIA', 'VPC burden >100/24h or R-on-T increases sudden death risk — Holter monitoring guides antiarrhythmic therapy.', 'SWELLING', 'آریتمی‌های بطنی', 'کنتراکسیون‌های زودرس بطنی، تاکی‌کاردی یا فیبریلاسیون بطنی که باعث ناهماهنگی همودینامیک می‌شوند.', 'بار وی‌پی‌سی بیش از ۱۰۰ در ۲۴ ساعت یا آر-آن-تی خطر مرگ ناگهانی را افزایش می‌دهد — هولتر مانیتورینگ درمان آریتمی ضدرا هدایت می‌کند.');


--
-- Data for Name: diagnose_session; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.diagnose_session VALUES ('f24d039d-debd-40e8-af90-b57820cf5922', 'رکس ', 'CANINE', '["JUGULAR_VEIN_DISTENSION"]', 0, NULL, NULL, NULL);
INSERT INTO public.diagnose_session VALUES ('dba3b419-e29a-4f73-93ca-5373234a50c2', 'رکس ', 'CANINE', '["JUGULAR_VEIN_DISTENSION"]', 0, NULL, NULL, NULL);
INSERT INTO public.diagnose_session VALUES ('60e1566a-712f-47de-94dd-1d4f89a7c990', 'jame', 'CANINE', '["IRREGULAR_HEART_RATE"]', 0, NULL, NULL, NULL);
INSERT INTO public.diagnose_session VALUES ('719398c4-c6f9-4edf-ac46-7b2001755eef', 'jame', 'CANINE', '["IRREGULAR_HEART_RATE"]', 0, NULL, NULL, NULL);
INSERT INTO public.diagnose_session VALUES ('0f15542a-1ba3-421e-88a6-f7b87eb3ee94', 'sdffd', 'CANINE', '["HYPERTENSION"]', 0, NULL, 61, NULL);
INSERT INTO public.diagnose_session VALUES ('210ceaf7-b25c-40ab-ba09-793f8fc4acba', 'sdffd', 'CANINE', '["HYPERTENSION"]', 0, NULL, 61, NULL);
INSERT INTO public.diagnose_session VALUES ('175b8369-9592-4b94-8dc3-e3efec8341c7', 'jack', 'CANINE', '["HYPERTENSION"]', 0, NULL, 61, NULL);
INSERT INTO public.diagnose_session VALUES ('58291297-8694-4e71-b27d-fd51f4cf245e', 'jack', 'CANINE', '["HYPERTENSION"]', 0, NULL, 61, NULL);
INSERT INTO public.diagnose_session VALUES ('1b1e93bb-4979-417f-9842-ce53141bad3d', 'liaa', 'CANINE', '["HYPERTENSION"]', 0, NULL, 61, 64);
INSERT INTO public.diagnose_session VALUES ('936788e8-6e59-454f-82ea-6b6ee9565092', 'liaa', 'CANINE', '["HYPERTENSION"]', 0, NULL, 61, 54);
INSERT INTO public.diagnose_session VALUES ('4b9813e6-de69-4de5-9c2c-1d161ad350ac', 'valla', 'FELINE', '["VOMITING", "RESTLESSNESS", "RESPIRATORY_DISTRESS"]', 0, NULL, 35, 63);
INSERT INTO public.diagnose_session VALUES ('24d0c8ac-4307-4967-b51d-3558cd8728dd', 'valla', 'FELINE', '["VOMITING", "RESTLESSNESS", "RESPIRATORY_DISTRESS"]', 0, NULL, 35, 61);
INSERT INTO public.diagnose_session VALUES ('a4a235ef-8751-4679-8170-75b069fa1faa', 'رکس', 'CANINE', '["JUGULAR_VEIN_DISTENSION", "COUGHING", "MUFFLED_HEART_SOUNDS"]', 0, NULL, 19, 57);
INSERT INTO public.diagnose_session VALUES ('cf4f16f9-d1d0-4f7a-8c99-964cc0b97a85', 'رکس', 'CANINE', '["JUGULAR_VEIN_DISTENSION", "COUGHING", "MUFFLED_HEART_SOUNDS"]', 0, NULL, 19, 68);
INSERT INTO public.diagnose_session VALUES ('9d828814-a8a6-4122-81f1-5596f81d2d1d', 'alex', 'CANINE', '["POLYURIA", "MUFFLED_HEART_SOUNDS"]', 0, NULL, 31, 60);
INSERT INTO public.diagnose_session VALUES ('81a78c56-94cf-4bb8-ae95-033a13f1e198', 'alex', 'CANINE', '["POLYURIA", "MUFFLED_HEART_SOUNDS"]', 0, NULL, 31, 66);
INSERT INTO public.diagnose_session VALUES ('ff2d28d3-1d7e-4af3-b20e-712ef25edf4a', 'sdsd', 'CANINE', '["HYPERTENSION"]', 0, NULL, 61, 56);
INSERT INTO public.diagnose_session VALUES ('64a0edcf-9dcc-436e-a3db-621fab928c88', 'sdsd', 'CANINE', '["HYPERTENSION"]', 0, NULL, 61, 60);
INSERT INTO public.diagnose_session VALUES ('04c850fd-2802-41aa-94af-eea31c4dc5a7', 'fghfdg', 'CANINE', '["EXERCISE_INTOLERANCE"]', 0, NULL, 4, 69);
INSERT INTO public.diagnose_session VALUES ('21e89b3a-6b4c-401f-977b-9ea3fa28cf76', 'fghfdg', 'CANINE', '["EXERCISE_INTOLERANCE"]', 0, NULL, 4, 56);
INSERT INTO public.diagnose_session VALUES ('6a06844e-d109-43db-934a-a821ae7a4886', 'cxgg', 'CANINE', '["LETHARGY", "EXERCISE_INTOLERANCE", "SEIZURES"]', 0, NULL, 35, 51);
INSERT INTO public.diagnose_session VALUES ('b3a821f7-3f01-4b2c-b24c-a93aeab531a7', 'cxgg', 'CANINE', '["LETHARGY", "EXERCISE_INTOLERANCE", "SEIZURES"]', 0, NULL, 35, 52);


--
-- Data for Name: diagnose_disease_ids; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.diagnose_disease_ids VALUES ('210ceaf7-b25c-40ab-ba09-793f8fc4acba', 20);
INSERT INTO public.diagnose_disease_ids VALUES ('210ceaf7-b25c-40ab-ba09-793f8fc4acba', 61);
INSERT INTO public.diagnose_disease_ids VALUES ('210ceaf7-b25c-40ab-ba09-793f8fc4acba', 14);
INSERT INTO public.diagnose_disease_ids VALUES ('210ceaf7-b25c-40ab-ba09-793f8fc4acba', 62);
INSERT INTO public.diagnose_disease_ids VALUES ('175b8369-9592-4b94-8dc3-e3efec8341c7', 20);
INSERT INTO public.diagnose_disease_ids VALUES ('175b8369-9592-4b94-8dc3-e3efec8341c7', 61);
INSERT INTO public.diagnose_disease_ids VALUES ('175b8369-9592-4b94-8dc3-e3efec8341c7', 14);
INSERT INTO public.diagnose_disease_ids VALUES ('175b8369-9592-4b94-8dc3-e3efec8341c7', 62);
INSERT INTO public.diagnose_disease_ids VALUES ('4b9813e6-de69-4de5-9c2c-1d161ad350ac', 33);
INSERT INTO public.diagnose_disease_ids VALUES ('4b9813e6-de69-4de5-9c2c-1d161ad350ac', 35);
INSERT INTO public.diagnose_disease_ids VALUES ('4b9813e6-de69-4de5-9c2c-1d161ad350ac', 14);
INSERT INTO public.diagnose_disease_ids VALUES ('4b9813e6-de69-4de5-9c2c-1d161ad350ac', 31);
INSERT INTO public.diagnose_disease_ids VALUES ('a4a235ef-8751-4679-8170-75b069fa1faa', 48);
INSERT INTO public.diagnose_disease_ids VALUES ('a4a235ef-8751-4679-8170-75b069fa1faa', 66);
INSERT INTO public.diagnose_disease_ids VALUES ('a4a235ef-8751-4679-8170-75b069fa1faa', 19);
INSERT INTO public.diagnose_disease_ids VALUES ('a4a235ef-8751-4679-8170-75b069fa1faa', 29);
INSERT INTO public.diagnose_disease_ids VALUES ('a4a235ef-8751-4679-8170-75b069fa1faa', 62);
INSERT INTO public.diagnose_disease_ids VALUES ('9d828814-a8a6-4122-81f1-5596f81d2d1d', 20);
INSERT INTO public.diagnose_disease_ids VALUES ('9d828814-a8a6-4122-81f1-5596f81d2d1d', 21);
INSERT INTO public.diagnose_disease_ids VALUES ('9d828814-a8a6-4122-81f1-5596f81d2d1d', 14);
INSERT INTO public.diagnose_disease_ids VALUES ('9d828814-a8a6-4122-81f1-5596f81d2d1d', 31);
INSERT INTO public.diagnose_disease_ids VALUES ('64a0edcf-9dcc-436e-a3db-621fab928c88', 20);
INSERT INTO public.diagnose_disease_ids VALUES ('64a0edcf-9dcc-436e-a3db-621fab928c88', 61);
INSERT INTO public.diagnose_disease_ids VALUES ('64a0edcf-9dcc-436e-a3db-621fab928c88', 14);
INSERT INTO public.diagnose_disease_ids VALUES ('64a0edcf-9dcc-436e-a3db-621fab928c88', 62);
INSERT INTO public.diagnose_disease_ids VALUES ('b3a821f7-3f01-4b2c-b24c-a93aeab531a7', 35);
INSERT INTO public.diagnose_disease_ids VALUES ('b3a821f7-3f01-4b2c-b24c-a93aeab531a7', 67);
INSERT INTO public.diagnose_disease_ids VALUES ('b3a821f7-3f01-4b2c-b24c-a93aeab531a7', 37);
INSERT INTO public.diagnose_disease_ids VALUES ('b3a821f7-3f01-4b2c-b24c-a93aeab531a7', 22);
INSERT INTO public.diagnose_disease_ids VALUES ('b3a821f7-3f01-4b2c-b24c-a93aeab531a7', 41);
INSERT INTO public.diagnose_disease_ids VALUES ('58291297-8694-4e71-b27d-fd51f4cf245e', 20);
INSERT INTO public.diagnose_disease_ids VALUES ('58291297-8694-4e71-b27d-fd51f4cf245e', 61);
INSERT INTO public.diagnose_disease_ids VALUES ('58291297-8694-4e71-b27d-fd51f4cf245e', 14);
INSERT INTO public.diagnose_disease_ids VALUES ('58291297-8694-4e71-b27d-fd51f4cf245e', 62);
INSERT INTO public.diagnose_disease_ids VALUES ('24d0c8ac-4307-4967-b51d-3558cd8728dd', 33);
INSERT INTO public.diagnose_disease_ids VALUES ('24d0c8ac-4307-4967-b51d-3558cd8728dd', 35);
INSERT INTO public.diagnose_disease_ids VALUES ('24d0c8ac-4307-4967-b51d-3558cd8728dd', 14);
INSERT INTO public.diagnose_disease_ids VALUES ('24d0c8ac-4307-4967-b51d-3558cd8728dd', 31);
INSERT INTO public.diagnose_disease_ids VALUES ('cf4f16f9-d1d0-4f7a-8c99-964cc0b97a85', 48);
INSERT INTO public.diagnose_disease_ids VALUES ('cf4f16f9-d1d0-4f7a-8c99-964cc0b97a85', 66);
INSERT INTO public.diagnose_disease_ids VALUES ('cf4f16f9-d1d0-4f7a-8c99-964cc0b97a85', 19);
INSERT INTO public.diagnose_disease_ids VALUES ('cf4f16f9-d1d0-4f7a-8c99-964cc0b97a85', 29);
INSERT INTO public.diagnose_disease_ids VALUES ('cf4f16f9-d1d0-4f7a-8c99-964cc0b97a85', 62);
INSERT INTO public.diagnose_disease_ids VALUES ('81a78c56-94cf-4bb8-ae95-033a13f1e198', 20);
INSERT INTO public.diagnose_disease_ids VALUES ('81a78c56-94cf-4bb8-ae95-033a13f1e198', 21);
INSERT INTO public.diagnose_disease_ids VALUES ('81a78c56-94cf-4bb8-ae95-033a13f1e198', 14);
INSERT INTO public.diagnose_disease_ids VALUES ('81a78c56-94cf-4bb8-ae95-033a13f1e198', 31);
INSERT INTO public.diagnose_disease_ids VALUES ('ff2d28d3-1d7e-4af3-b20e-712ef25edf4a', 20);
INSERT INTO public.diagnose_disease_ids VALUES ('ff2d28d3-1d7e-4af3-b20e-712ef25edf4a', 61);
INSERT INTO public.diagnose_disease_ids VALUES ('ff2d28d3-1d7e-4af3-b20e-712ef25edf4a', 14);
INSERT INTO public.diagnose_disease_ids VALUES ('ff2d28d3-1d7e-4af3-b20e-712ef25edf4a', 62);
INSERT INTO public.diagnose_disease_ids VALUES ('6a06844e-d109-43db-934a-a821ae7a4886', 35);
INSERT INTO public.diagnose_disease_ids VALUES ('6a06844e-d109-43db-934a-a821ae7a4886', 67);
INSERT INTO public.diagnose_disease_ids VALUES ('6a06844e-d109-43db-934a-a821ae7a4886', 37);
INSERT INTO public.diagnose_disease_ids VALUES ('6a06844e-d109-43db-934a-a821ae7a4886', 22);
INSERT INTO public.diagnose_disease_ids VALUES ('6a06844e-d109-43db-934a-a821ae7a4886', 41);
INSERT INTO public.diagnose_disease_ids VALUES ('936788e8-6e59-454f-82ea-6b6ee9565092', 20);
INSERT INTO public.diagnose_disease_ids VALUES ('936788e8-6e59-454f-82ea-6b6ee9565092', 61);
INSERT INTO public.diagnose_disease_ids VALUES ('936788e8-6e59-454f-82ea-6b6ee9565092', 14);
INSERT INTO public.diagnose_disease_ids VALUES ('936788e8-6e59-454f-82ea-6b6ee9565092', 62);
INSERT INTO public.diagnose_disease_ids VALUES ('04c850fd-2802-41aa-94af-eea31c4dc5a7', 50);
INSERT INTO public.diagnose_disease_ids VALUES ('21e89b3a-6b4c-401f-977b-9ea3fa28cf76', 50);
INSERT INTO public.diagnose_disease_ids VALUES ('04c850fd-2802-41aa-94af-eea31c4dc5a7', 4);
INSERT INTO public.diagnose_disease_ids VALUES ('21e89b3a-6b4c-401f-977b-9ea3fa28cf76', 4);
INSERT INTO public.diagnose_disease_ids VALUES ('04c850fd-2802-41aa-94af-eea31c4dc5a7', 69);
INSERT INTO public.diagnose_disease_ids VALUES ('21e89b3a-6b4c-401f-977b-9ea3fa28cf76', 69);
INSERT INTO public.diagnose_disease_ids VALUES ('04c850fd-2802-41aa-94af-eea31c4dc5a7', 55);
INSERT INTO public.diagnose_disease_ids VALUES ('21e89b3a-6b4c-401f-977b-9ea3fa28cf76', 55);
INSERT INTO public.diagnose_disease_ids VALUES ('04c850fd-2802-41aa-94af-eea31c4dc5a7', 60);
INSERT INTO public.diagnose_disease_ids VALUES ('21e89b3a-6b4c-401f-977b-9ea3fa28cf76', 60);
INSERT INTO public.diagnose_disease_ids VALUES ('1b1e93bb-4979-417f-9842-ce53141bad3d', 20);
INSERT INTO public.diagnose_disease_ids VALUES ('1b1e93bb-4979-417f-9842-ce53141bad3d', 61);
INSERT INTO public.diagnose_disease_ids VALUES ('1b1e93bb-4979-417f-9842-ce53141bad3d', 14);
INSERT INTO public.diagnose_disease_ids VALUES ('1b1e93bb-4979-417f-9842-ce53141bad3d', 62);
INSERT INTO public.diagnose_disease_ids VALUES ('0f15542a-1ba3-421e-88a6-f7b87eb3ee94', 20);
INSERT INTO public.diagnose_disease_ids VALUES ('0f15542a-1ba3-421e-88a6-f7b87eb3ee94', 61);
INSERT INTO public.diagnose_disease_ids VALUES ('0f15542a-1ba3-421e-88a6-f7b87eb3ee94', 14);
INSERT INTO public.diagnose_disease_ids VALUES ('0f15542a-1ba3-421e-88a6-f7b87eb3ee94', 62);


--
-- Data for Name: diagnosis; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.diagnosis VALUES (3, 2, 'Thoracic Radiography', 'Identify cranial mediastinal mass or aortic dilation', 'IMAGING', 'شناسایی توده مدیاستین قدامی یا اتساع آئورت.', 'رادیوگرافی قفسه سینه');
INSERT INTO public.diagnosis VALUES (5, 3, 'Emergency Echocardiogram', 'Detect intimal flap and false lumen', 'ECHO', 'تشخیص لایه اینتیمال پاره‌شده و لومن کاذب.', 'اکوکاردیوگرافی اورژانسی');
INSERT INTO public.diagnosis VALUES (7, 4, 'Echocardiogram', 'Measure LVOT gradient (Doppler); visualize subvalvular ridge', 'ECHO', 'اندازه‌گیری گرادیان خروجی بطن چپ (با داپلر)؛ مشاهده رشته زیردریچه‌ای.', 'اکوکاردیوگرافی');
INSERT INTO public.diagnosis VALUES (10, 5, 'Doppler Ultrasound', 'Confirm absent arterial flow in iliac/femoral arteries', 'IMAGING', 'تأیید فقدان جریان شریانی در شریان‌های ایلیاک/رانی.', 'داپلر اولتراسونوگرافی');
INSERT INTO public.diagnosis VALUES (12, 6, '24-hr Holter Monitoring', 'Quantify VPC burden and detect pauses', 'ECG', 'کمّی‌سازی بار VPC و تشخیص وقفه‌ها.', 'مونیتورینگ هولتر ۲۴ ساعته');
INSERT INTO public.diagnosis VALUES (13, 6, 'Echocardiogram', 'Rule out structural heart disease', 'ECHO', 'رد بیماری ساختاری قلب.', 'اکوکاردیوگرافی');
INSERT INTO public.diagnosis VALUES (15, 7, 'Echocardiogram', 'Assess RV size/function (often normal early)', 'ECHO', 'ارزیابی اندازه/عملکرد بطن راست (در مراحل اولیه اغلب طبیعی است).', 'اکوکاردیوگرافی');
INSERT INTO public.diagnosis VALUES (17, 8, 'ECG', 'Confirm irregularly irregular rhythm, absence of P-waves', 'ECG', 'تأیید ریتم نامنظم بدون الگو، فقدان امواج P.', 'نوار قلب (ECG)');
INSERT INTO public.diagnosis VALUES (19, 9, 'Echocardiogram', 'Visualize shunt (color Doppler) and measure Qp:Qs ratio', 'ECHO', 'مشاهده شانت (با داپلر رنگی) و اندازه‌گیری نسبت Qp:Qs.', 'اکوکاردیوگرافی');
INSERT INTO public.diagnosis VALUES (21, 10, 'ECG', 'Absent P-waves with junctional/ventricular rhythm', 'ECG', 'فقدان امواج P با ریتم گرهی/بطنی.', 'نوار قلب (ECG)');
INSERT INTO public.diagnosis VALUES (23, 11, 'Echocardiogram', 'Granular sparkling myocardium, biatrial enlargement', 'ECHO', 'میوکارد درخشان دانه‌ای، بزرگی دو دهلیز.', 'اکوکاردیوگرافی');
INSERT INTO public.diagnosis VALUES (25, 12, 'Echocardiogram', 'Pericardial effusion + diastolic collapse of RA/RV', 'ECHO', 'افیوژن پریکاردی + فروریزت دیاستولیک دهلیز/بطن راست.', 'اکوکاردیوگرافی');
INSERT INTO public.diagnosis VALUES (27, 13, 'Thoracic Radiography', 'Cranial mediastinal mass with tracheal elevation', 'IMAGING', 'توده مدیاستین قدامی با بالارفتن تراشه.', 'رادیوگرافی قفسه سینه');
INSERT INTO public.diagnosis VALUES (29, 14, 'Blood Pressure Measurement', 'Systolic BP >160 mmHg (Doppler/oscillometric)', 'PHYSICAL_EXAMINATION', 'فشار سیستولی > ۱۶۰ mmHg (با روش داپلر/اسیلومتریک).', 'اندازه‌گیری فشار خون');
INSERT INTO public.diagnosis VALUES (32, 15, 'Echocardiogram', 'RV hypertrophy, pulmonary hypertension (TR jet >3.0 m/s)', 'ECHO', 'هایپرتروفی بطن راست، فشار خون ریوی بالا (جریان تریکوسپید رِگورژیتاسیون > ۳٫۰ m/s).', 'اکوکاردیوگرافی');
INSERT INTO public.diagnosis VALUES (34, 16, 'Pulmonary Angiography', 'Confirm chronic thrombus (gold standard)', 'IMAGING', 'تأیید ترومب مزمن (استاندارد طلایی).', 'آنژیوگرافی ریوی');
INSERT INTO public.diagnosis VALUES (35, 17, 'ECG', 'Identify AV block grade (1st, 2nd, 3rd degree)', 'ECG', 'شناسایی درجه بلوک AV (درجه یک، دو، سه).', 'نوار قلب (ECG)');
INSERT INTO public.diagnosis VALUES (37, 18, 'Echocardiogram', 'High-velocity shunt on color Doppler', 'ECHO', 'شانت با سرعت بالا در داپلر رنگی.', 'اکوکاردیوگرافی');
INSERT INTO public.diagnosis VALUES (39, 19, 'Echocardiogram', 'Membrane in LA obstructing pulmonary venous return', 'ECHO', 'غشایی در دهلیز چپ که بازگشت وریدی ریوی را مسدود می‌کند.', 'اکوکاردیوگرافی');
INSERT INTO public.diagnosis VALUES (41, 20, 'ACTH Stimulation Test', 'Confirm hyperadrenocorticism', 'LABORATORY_TESTING', 'تأیید هایپرآدرنوکورتیسیسم.', 'تست تحریک ACTH');
INSERT INTO public.diagnosis VALUES (43, 21, 'Fructosamine/Glucose Curve', 'Assess glycemic control', 'LABORATORY_TESTING', 'ارزیابی کنترل قند خون.', 'فرکتوزآمین/منحنی گلوکز');
INSERT INTO public.diagnosis VALUES (45, 22, 'Echocardiogram', 'LV dilation (LVIDd >4.5 cm in dogs), FS <25%', 'ECHO', 'اتساع بطن چپ (LVIDd > ۴٫۵ cm در سگ‌ها)، کسر تخلیه < ۲۵٪.', 'اکوکاردیوگرافی');
INSERT INTO public.diagnosis VALUES (47, 23, 'Echocardiogram', 'Apical displacement of tricuspid valve (>8 mm/m²)', 'ECHO', 'جابه‌جایی اپی‌کاردی دریچه سه‌لختی (> ۸ mm/m²).', 'اکوکاردیوگرافی');
INSERT INTO public.diagnosis VALUES (49, 24, 'Echocardiogram', 'Right-to-left shunt (contrast study), severe PAH', 'ECHO', 'شانت راست-به-چپ (مطالعه با کنتراست)، فشار خون ریوی شدید بالا.', 'اکوکاردیوگرافی');
INSERT INTO public.diagnosis VALUES (51, 25, 'Echocardiogram', 'Diffuse LV endocardial brightening, reduced compliance', 'ECHO', 'درخشش منتشر اندوکارد بطن چپ، کاهش انطباق‌پذیری.', 'اکوکاردیوگرافی');
INSERT INTO public.diagnosis VALUES (53, 26, 'Blood Cultures', 'Aerobic/anaerobic cultures (3 sets)', 'CULTURE', 'کشت هوازی/بی‌هوازی (۳ نمونه).', 'کشت خون');
INSERT INTO public.diagnosis VALUES (55, 27, 'PCR Testing', 'Parvovirus, distemper, or bacterial DNA in blood', 'LABORATORY_TESTING', 'شناسایی ژنوم ویروسی (پاروویروس، دیستمپر) یا DNA باکتریایی در خون.', 'تست PCR');
INSERT INTO public.diagnosis VALUES (57, 28, 'Antigen Test', 'Detect adult female worms (SNAP® 4Dx®)', 'ANTIGEN_TEST', 'تشخیص کرم‌های بالغ ماده (SNAP® 4Dx®).', 'تست آنتی‌ژن');
INSERT INTO public.diagnosis VALUES (58, 28, 'Microfilaria Test', 'Knotts concentration test or filter', 'MICROFILARIA_TEST', 'تست غلظت کِنوتز یا فیلتراسیون.', 'تست میکروفیلاری');
INSERT INTO public.diagnosis VALUES (60, 29, 'Echocardiogram', 'Caval syndrome: worms in RA/RV', 'ECHO', 'سندرم کاوا: کرم‌ها در دهلیز/بطن راست.', 'اکوکاردیوگرافی');
INSERT INTO public.diagnosis VALUES (62, 30, 'Echocardiogram', 'Mass in right atrium with pericardial effusion', 'ECHO', 'توده در دهلیز راست با افیوژن پریکاردی.', 'اکوکاردیوگرافی');
INSERT INTO public.diagnosis VALUES (64, 31, 'Serum Calcium/Phosphorus', 'Ionized calcium >1.4 mmol/L', 'LABORATORY_TESTING', 'کلسیم یونیزه > ۱٫۴ mmol/L.', 'کلسیم و فسفر سرم');
INSERT INTO public.diagnosis VALUES (65, 31, 'ECG', 'Shortened QT interval', 'ECG', 'کوتاه‌شدن فاصله QT.', 'نوار قلب (ECG)');
INSERT INTO public.diagnosis VALUES (67, 32, 'ECG', 'Peaked T-waves → loss of P-waves → sine wave', 'ECG', 'امواج T بلند → فقدان امواج P → موج سینوسی.', 'نوار قلب (ECG)');
INSERT INTO public.diagnosis VALUES (68, 33, 'Total T4', 'Elevated T4 (>4.0 µg/dL)', 'LABORATORY_TESTING', 'T4 بالا (> ۴٫۰ µg/dL).', 'T4 کل');
INSERT INTO public.diagnosis VALUES (1, 1, 'CBC and Biochemistry', 'Confirm anemia (Hct <30%) and rule out CKD/liver disease', 'LABORATORY_TESTING', 'تأیید کم‌خونی (هماتوکریت <۳۰٪) و رد بیماری کلیوی مزمن/کبدی.', 'شمارش کامل خون و بیوشیمی');
INSERT INTO public.diagnosis VALUES (2, 1, 'Echocardiogram', 'Assess for high-output failure (hyperdynamic LV, low SVR)', 'ECHO', 'ارزیابی نارسایی دبی بالا (بطن چپ هایپردینامیک، مقاومت سیستمیک عروقی پایین).', 'اکوکاردیوگرافی');
INSERT INTO public.diagnosis VALUES (4, 2, 'Echocardiogram', 'Visualize aortic root dilation (>1.5x normal)', 'ECHO', 'مشاهده اتساع ریشه آئورت (>۱٫۵ برابر حد طبیعی).', 'اکوکاردیوگرافی');
INSERT INTO public.diagnosis VALUES (71, 34, 'NT-proBNP', 'Biomarker for myocardial stretch (feline-specific)', 'LABORATORY_TESTING', 'بیومارکر کشش میوکارد (نسخه اختصاصی گربه).', 'NT-proBNP');
INSERT INTO public.diagnosis VALUES (72, 35, 'Ionized Calcium', 'iCa <1.0 mmol/L', 'LABORATORY_TESTING', 'iCa < ۱٫۰ mmol/L.', 'کلسیم یونیزه');
INSERT INTO public.diagnosis VALUES (73, 35, 'ECG', 'Prolonged QT interval', 'ECG', 'طولانی‌شدن فاصله QT.', 'نوار قلب (ECG)');
INSERT INTO public.diagnosis VALUES (75, 36, 'ECG', 'ST depression, U-waves', 'ECG', 'افت ST، امواج U.', 'نوار قلب (ECG)');
INSERT INTO public.diagnosis VALUES (76, 37, 'Total T4 + TSH', 'Low T4, high TSH', 'LABORATORY_TESTING', 'T4 پایین، TSH بالا.', 'T4 کل + TSH');
INSERT INTO public.diagnosis VALUES (78, 38, 'Pericardial Fluid Cytology', 'Lymphoblasts in effusion', 'LABORATORY_TESTING', 'لنفوبلاست در افیوژن.', 'سیتولوژی مایع پریکاردی');
INSERT INTO public.diagnosis VALUES (81, 39, 'Thoracic Radiography', 'Assess for pulmonary edema (Stage C)', 'IMAGING', 'ارزیابی ادم ریوی (مرحله C).', 'رادیوگرافی قفسه سینه');
INSERT INTO public.diagnosis VALUES (82, 40, 'Echocardiogram', 'Systolic displacement of mitral leaflets into LA', 'ECHO', 'جابه‌جایی سیستولیک لخته‌های میترال به داخل دهلیز چپ.', 'اکوکاردیوگرافی');
INSERT INTO public.diagnosis VALUES (84, 41, 'Echocardiogram', 'LV dysfunction, pericardial effusion', 'ECHO', 'نارسایی سیستولیک بطن چپ، افیوژن پریکاردی.', 'اکوکاردیوگرافی');
INSERT INTO public.diagnosis VALUES (87, 43, 'Echocardiogram', 'Same as mitral valve disease (clinical synonym)', 'ECHO', 'همانند بیماری دریچه میترال (مترادف بالینی).', 'اکوکاردیوگرافی');
INSERT INTO public.diagnosis VALUES (89, 44, 'Thoracic Radiography', 'Pulmonary overcirculation, LA/LV enlargement', 'IMAGING', 'افزایش جریان ریوی، بزرگی دهلیز/بطن چپ.', 'رادیوگرافی قفسه سینه');
INSERT INTO public.diagnosis VALUES (91, 46, 'Echocardiogram', 'Anechoic space around heart, possible tamponade', 'ECHO', 'فضای آنکوئویک اطراف قلب، احتمال تامپوناد.', 'اکوکاردیوگرافی');
INSERT INTO public.diagnosis VALUES (92, 46, 'Pericardial Fluid Analysis', 'Cytology, culture, biochemistry', 'LABORATORY_TESTING', 'سیتولوژی، کشت، بیوشیمی.', 'آنالیز مایع پریکاردی');
INSERT INTO public.diagnosis VALUES (95, 48, 'Echocardiogram', 'Pericardial thickening ± effusion', 'ECHO', 'ضخیم‌شدگی پریکارد ± افیوژن.', 'اکوکاردیوگرافی');
INSERT INTO public.diagnosis VALUES (96, 48, 'Pericardial Biopsy', 'Histopathology for inflammation/fibrosis', 'BIOPSY', 'هیستوپاتولوژی برای التهاب/فیبروز.', 'بیوپسی پریکارد');
INSERT INTO public.diagnosis VALUES (98, 49, 'Blood Pressure Measurement', 'Differential BP between limbs', 'PHYSICAL_EXAMINATION', 'تفاوت فشار خون بین اندام‌ها.', 'اندازه‌گیری فشار خون');
INSERT INTO public.diagnosis VALUES (100, 50, 'ECG', 'Right axis deviation, RV hypertrophy', 'ECG', 'انحراف محور راست، هایپرتروفی بطن راست.', 'نوار قلب (ECG)');
INSERT INTO public.diagnosis VALUES (101, 51, 'D-dimer', 'Elevated (though not validated in vet med)', 'LABORATORY_TESTING', 'افزایش (هرچند در دامپزشکی اعتبارسنجی نشده است).', 'D-dimer');
INSERT INTO public.diagnosis VALUES (104, 52, 'Thoracic Radiography', 'Enlarged pulmonary arteries', 'IMAGING', 'اتساع شریان‌های ریوی.', 'رادیوگرافی قفسه سینه');
INSERT INTO public.diagnosis VALUES (105, 53, 'D-dimer', 'Elevated in acute PTE', 'LABORATORY_TESTING', 'افزایش در PTE حاد.', 'D-dimer');
INSERT INTO public.diagnosis VALUES (106, 53, 'Echocardiogram', 'RV dilation, pulmonary hypertension', 'ECHO', 'اتساع بطن راست، فشار خون ریوی بالا.', 'اکوکاردیوگرافی');
INSERT INTO public.diagnosis VALUES (108, 55, 'Echocardiogram', 'Valvular stenosis, post-stenotic dilation', 'ECHO', 'تنگی دریچه‌ای، اتساع پس از تنگی.', 'اکوکاردیوگرافی');
INSERT INTO public.diagnosis VALUES (110, 56, 'Cardiac MRI', 'Late gadolinium enhancement for fibrosis', 'IMAGING', 'تقویت گادولینیوم در مراحل عقب‌مانده برای تشخیص فیبروز.', 'MRI قلبی');
INSERT INTO public.diagnosis VALUES (112, 57, 'Genetic Testing', 'STRN gene mutation', 'GENETIC_TESTING', 'جهش ژن STRN.', 'آزمایش ژنتیکی');
INSERT INTO public.diagnosis VALUES (114, 58, 'Echocardiogram', 'LV systolic dysfunction, reduced FS', 'ECHO', 'نارسایی سیستولیک بطن چپ، کسر تخلیه کاهش‌یافته.', 'اکوکاردیوگرافی');
INSERT INTO public.diagnosis VALUES (116, 59, 'Atropine Response Test', 'Assess for autonomic dysfunction', 'PHYSICAL_EXAMINATION', 'ارزیابی نارسایی اتوانومیک.', 'تست پاسخ به آتروپین');
INSERT INTO public.diagnosis VALUES (118, 60, 'ECG', 'LV hypertrophy', 'ECG', 'هایپرتروفی بطن چپ.', 'نوار قلب (ECG)');
INSERT INTO public.diagnosis VALUES (119, 61, 'Blood Pressure Measurement', 'Systolic BP >160 mmHg (Doppler method)', 'PHYSICAL_EXAMINATION', 'فشار سیستولی > ۱۶۰ mmHg (روش داپلر).', 'اندازه‌گیری فشار خون');
INSERT INTO public.diagnosis VALUES (121, 62, 'Blood Pressure Measurement', 'Same as systemic hypertension', 'PHYSICAL_EXAMINATION', 'همانند فشار خون سیستمیک بالا.', 'اندازه‌گیری فشار خون');
INSERT INTO public.diagnosis VALUES (123, 63, 'Blood Cultures', 'Identify septic source', 'CULTURE', 'شناسایی منبع سپسیس.', 'کشت خون');
INSERT INTO public.diagnosis VALUES (124, 63, 'cTnI', 'Myocardial injury marker', 'LABORATORY_TESTING', 'مارکر آسیب میوکاردی.', 'cTnI');
INSERT INTO public.diagnosis VALUES (126, 64, 'Thoracic Radiography', '"Boot-shaped" heart, diminished pulmonary vasculature', 'IMAGING', 'قلب به شکل «کفش اسکی»، عروق ریوی کم‌خون‌شده.', 'رادیوگرافی قفسه سینه');
INSERT INTO public.diagnosis VALUES (128, 66, 'Barium Esophagogram', 'Esophageal constriction at base of heart', 'IMAGING', 'تنگی مری در پایه قلب.', 'اِزوفاگوگرام با باریم');
INSERT INTO public.diagnosis VALUES (129, 66, 'CT Angiography', 'Define vascular anatomy', 'IMAGING', 'تعیین آناتومی عروقی.', 'آنژیوگرافی سی‌تی');
INSERT INTO public.diagnosis VALUES (131, 67, 'ANA/Titer', 'Rule out SLE', 'LABORATORY_TESTING', 'رد لوپوس سیستمیک (SLE).', 'آنتی‌بادی ضد هسته‌ای (ANA)');
INSERT INTO public.diagnosis VALUES (133, 68, 'Echocardiogram', 'Rule out structural heart disease', 'ECHO', 'رد بیماری ساختاری قلب.', 'اکوکاردیوگرافی');
INSERT INTO public.diagnosis VALUES (6, 3, 'CT Angiography', 'Gold standard for confirmation (if stable)', 'IMAGING', 'استاندارد طلایی برای تأیید (در صورت پایدار بودن بیمار).', 'آنژیوگرافی سی‌تی');
INSERT INTO public.diagnosis VALUES (8, 4, 'ECG', 'Detect LV hypertrophy or arrhythmias', 'ECG', 'تشخیص هایپرتروفی بطن چپ یا آریتمی.', 'نوار قلب (ECG)');
INSERT INTO public.diagnosis VALUES (9, 5, 'Physical Examination', 'Painful, cold, pulseless hindlimbs; absence of femoral pulses', 'PHYSICAL_EXAMINATION', 'اندام‌های عقبی دردناک، سرد و بدون نبض؛ فقدان نبض شریان رانی.', 'معاینه فیزیکال');
INSERT INTO public.diagnosis VALUES (11, 5, 'Echocardiogram', 'Identify underlying HCM (LA enlargement, LV hypertrophy)', 'ECHO', 'شناسایی علت زمینه‌ای HCM (بزرگی دهلیز چپ، هایپرتروفی بطن چپ).', 'اکوکاردیوگرافی');
INSERT INTO public.diagnosis VALUES (14, 7, '24-hr Holter Monitoring', 'Detect >100 VPCs/24h or ventricular tachycardia', 'ECG', 'تشخیص بیش از ۱۰۰ VPC در ۲۴ ساعت یا تاکی‌کاردی بطنی.', 'مونیتورینگ هولتر ۲۴ ساعته');
INSERT INTO public.diagnosis VALUES (16, 7, 'Genetic Testing', 'Boxer ARVC mutation screening (STRN gene)', 'GENETIC_TESTING', 'غربالگری جهش ARVC در سگ‌های باکسر (ژن STRN).', 'آزمایش ژنتیکی');
INSERT INTO public.diagnosis VALUES (18, 8, 'Echocardiogram', 'Identify underlying cause (MVD, DCM, etc.)', 'ECHO', 'شناسایی علت زمینه‌ای (بیماری دریچه میترال، DCM و غیره).', 'اکوکاردیوگرافی');
INSERT INTO public.diagnosis VALUES (20, 9, 'Thoracic Radiography', 'Assess for right heart enlargement', 'IMAGING', 'ارزیابی بزرگی قلب راست.', 'رادیوگرافی قفسه سینه');
INSERT INTO public.diagnosis VALUES (22, 10, 'Serum Electrolytes', 'Check for hyperkalemia (K+ >6.0 mEq/L)', 'LABORATORY_TESTING', 'بررسی هایپرکالمی (K⁺ > ۶٫۰ mEq/L).', 'الکترولیت‌های سرمی');
INSERT INTO public.diagnosis VALUES (24, 11, 'Endomyocardial Biopsy', 'Congo red staining for amyloid deposits (definitive)', 'BIOPSY', 'رنگ‌آمیزی کنگو رد برای رسوبات آمیلوئید (قطعی).', 'بیوپسی آندومیوکاردیال');
INSERT INTO public.diagnosis VALUES (26, 12, 'Physical Examination', 'Muffled heart sounds, JVD, pulsus paradoxus', 'PHYSICAL_EXAMINATION', 'صدای قلب کُرُن، ورید ژوگولار پر، پولسوس پارادوکسوس.', 'معاینه فیزیکال');
INSERT INTO public.diagnosis VALUES (28, 13, 'Echocardiogram', 'Mass at heart base compressing great vessels', 'ECHO', 'توده در پایه قلب که عروق بزرگ را فشار می‌دهد.', 'اکوکاردیوگرافی');
INSERT INTO public.diagnosis VALUES (30, 14, 'Echocardiogram', 'Assess for LV hypertrophy and diastolic dysfunction', 'ECHO', 'ارزیابی هایپرتروفی بطن چپ و نارسایی دیاستولیک.', 'اکوکاردیوگرافی');
INSERT INTO public.diagnosis VALUES (31, 15, 'Thoracic Radiography', 'Identify underlying lung disease (e.g., fibrosis, bronchiectasis)', 'IMAGING', 'شناسایی بیماری زمینه‌ای ریه (مثلاً فیبروز، برونشیکتازی).', 'رادیوگرافی قفسه سینه');
INSERT INTO public.diagnosis VALUES (33, 16, 'Echocardiogram', 'Pulmonary hypertension with web-like structures in PA', 'ECHO', 'فشار خون ریوی بالا با ساختارهای شبکه‌ای در شریان ریوی.', 'اکوکاردیوگرافی');
INSERT INTO public.diagnosis VALUES (36, 17, '24-hr Holter Monitoring', 'Correlate blocks with symptoms (syncope)', 'ECG', 'همبستگی بلوک‌ها با علائم (سنکوپ).', 'مونیتورینگ هولتر ۲۴ ساعته');
INSERT INTO public.diagnosis VALUES (38, 18, 'Angiography', 'Define anatomy for embolization planning', 'IMAGING', 'تعیین آناتومی برای برنامه‌ریزی امبولیزاسیون.', 'آنژیوگرافی');
INSERT INTO public.diagnosis VALUES (40, 19, 'Cardiac MRI', '3D anatomy for surgical planning', 'IMAGING', 'آناتومی سه‌بعدی برای برنامه‌ریزی جراحی.', 'MRI قلبی');
INSERT INTO public.diagnosis VALUES (42, 20, 'Echocardiogram', 'Assess for LV hypertrophy and thrombus risk', 'ECHO', 'ارزیابی هایپرتروفی بطن چپ و خطر ترومبوز.', 'اکوکاردیوگرافی');
INSERT INTO public.diagnosis VALUES (44, 21, 'Echocardiogram', 'Detect diastolic dysfunction (impaired relaxation)', 'ECHO', 'تشخیص نارسایی دیاستولیک (اختلال در شل‌شدگی).', 'اکوکاردیوگرافی');
INSERT INTO public.diagnosis VALUES (46, 22, 'Taurine Levels', 'Plasma/whole blood taurine (critical in cats/spaniels)', 'LABORATORY_TESTING', 'تورین پلاسما/کل خون (حیاتی در گربه‌ها و اسپانیل‌ها).', 'سطح تورین');
INSERT INTO public.diagnosis VALUES (48, 23, 'ECG', 'Prolonged PR interval, right axis deviation', 'ECG', 'طولانی‌شدن فاصله PR، انحراف محور راست.', 'نوار قلب (ECG)');
INSERT INTO public.diagnosis VALUES (50, 24, 'Arterial Blood Gas', 'Hypoxemia with compensatory polycythemia', 'LABORATORY_TESTING', 'هیپوکسی با پلی‌سیتمی جبرانی.', 'گازهای خونی شریانی');
INSERT INTO public.diagnosis VALUES (52, 25, 'Necropsy', 'Histopathology: endocardial fibrosis (definitive)', 'NECROPSY', 'هیستوپاتولوژی: فیبروز اندوکارد (قطعی).', 'اُتوپسی');
INSERT INTO public.diagnosis VALUES (54, 26, 'Echocardiogram', 'Vegetations on valves (sensitivity >80% with TEE)', 'ECHO', 'وِژِتاسیون روی دریچه‌ها (حساسیت > ۸۰٪ با Echocardiography Transesophageal).', 'اکوکاردیوگرافی');
INSERT INTO public.diagnosis VALUES (56, 27, 'Endomyocardial Biopsy', 'Inflammatory infiltrates (definitive but high risk)', 'BIOPSY', 'تهاجم سلول‌های التهابی (قطعی، اما با ریسک بالا).', 'بیوپسی آندومیوکاردیال');
INSERT INTO public.diagnosis VALUES (59, 28, 'Echocardiogram', 'Adult worms in main PA ("equal sign" artifact)', 'ECHO', 'کرم‌های بالغ در شریان ریوی اصلی (آرتیفکت «علامت مساوی»).', 'اکوکاردیوگرافی');
INSERT INTO public.diagnosis VALUES (61, 29, 'Thoracic Radiography', 'Enlarged pulmonary arteries, right heart enlargement', 'IMAGING', 'اتساع شریان‌های ریوی، بزرگی قلب راست.', 'رادیوگرافی قفسه سینه');
INSERT INTO public.diagnosis VALUES (63, 30, 'Pericardial Fluid Cytology', 'Hemorrhagic fluid with neoplastic cells', 'LABORATORY_TESTING', 'مایع خونریزی‌دار با سلول‌های نئوپلاستیک.', 'سیتولوژی مایع پریکاردی');
INSERT INTO public.diagnosis VALUES (66, 32, 'Serum Electrolytes', 'K+ >5.5 mEq/L', 'LABORATORY_TESTING', 'K⁺ > ۵٫۵ mEq/L.', 'الکترولیت‌های سرمی');
INSERT INTO public.diagnosis VALUES (69, 33, 'Echocardiogram', 'LV hypertrophy reversible with treatment', 'ECHO', 'هایپرتروفی بطن چپ قابل برگشت با درمان.', 'اکوکاردیوگرافی');
INSERT INTO public.diagnosis VALUES (70, 34, 'Echocardiogram', 'Gold standard: LV wall thickness >6 mm, LA enlargement', 'ECHO', 'استاندارد طلایی: ضخامت دیواره بطن چپ > ۶ mm، بزرگی دهلیز چپ.', 'اکوکاردیوگرافی');
INSERT INTO public.diagnosis VALUES (74, 36, 'Serum Potassium', 'K+ <3.5 mEq/L', 'LABORATORY_TESTING', 'K⁺ < ۳٫۵ mEq/L.', 'پتاسیم سرمی');
INSERT INTO public.diagnosis VALUES (77, 37, 'Echocardiogram', 'Mild LV/RV dilation, bradycardia', 'ECHO', 'اتساع خفیف بطن چپ/راست، برادی‌کاردی.', 'اکوکاردیوگرافی');
INSERT INTO public.diagnosis VALUES (79, 38, 'Flow Cytometry', 'Immunophenotyping of cells', 'LABORATORY_TESTING', 'ایمونوفنوتایپینگ سلول‌ها.', 'فلو سایتومتری');
INSERT INTO public.diagnosis VALUES (80, 39, 'Echocardiogram', 'Mitral regurgitation jet, LA enlargement (ACVIM staging)', 'ECHO', 'جریان رِگورژیتاسیون میترال، بزرگی دهلیز چپ (طبقه‌بندی ACVIM).', 'اکوکاردیوگرافی');
INSERT INTO public.diagnosis VALUES (83, 41, 'cTnI/cTnT', 'Cardiac troponin elevation', 'LABORATORY_TESTING', 'افزایش تروپونین قلبی.', 'cTnI/cTnT');
INSERT INTO public.diagnosis VALUES (85, 41, 'PCR Testing', 'Viral genomes (parvovirus, etc.)', 'LABORATORY_TESTING', 'ژنوم ویروسی (پاروویروس و غیره).', 'تست PCR');
INSERT INTO public.diagnosis VALUES (86, 42, 'Echocardiogram', 'Valve thickening, prolapse, regurgitation', 'ECHO', 'ضخیم‌شدگی دریچه، پرولاپس، رِگورژیتاسیون.', 'اکوکاردیوگرافی');
INSERT INTO public.diagnosis VALUES (88, 44, 'Echocardiogram', 'Continuous "machinery" murmur on Doppler, LA/LV enlargement', 'ECHO', 'هاس سیستولیک-دیاستولیک «ماشین» در داپلر، بزرگی دهلیز/بطن چپ.', 'اکوکاردیوگرافی');
INSERT INTO public.diagnosis VALUES (90, 45, 'Echocardiogram with Bubble Study', 'Agitated saline injection shows right-to-left shunt', 'ECHO', 'تزریق سالین ناگهانی: نشان‌دهنده شانت راست-به-چپ.', 'اکوکاردیوگرافی با تست حباب');
INSERT INTO public.diagnosis VALUES (93, 47, 'Echocardiogram', 'Same as pericardial effusion', 'ECHO', 'همانند افیوژن پریکاردی.', 'اکوکاردیوگرافی');
INSERT INTO public.diagnosis VALUES (94, 47, 'Pericardial Fluid Analysis', 'Idiopathic: clear, low protein/cell count', 'LABORATORY_TESTING', 'ایدیوپاتیک: شفاف، پروتئین/شمارش سلولی پایین.', 'آنالیز مایع پریکاردی');
INSERT INTO public.diagnosis VALUES (97, 49, 'Doppler Ultrasound', 'Reduced/absent peripheral arterial flow', 'IMAGING', 'کاهش/فقدان جریان شریانی محیطی.', 'داپلر اولتراسونوگرافی');
INSERT INTO public.diagnosis VALUES (99, 50, 'Echocardiogram', 'Turbulent flow at PA, RV hypertrophy', 'ECHO', 'جریان آشفته در شریان ریوی، هایپرتروفی بطن راست.', 'اکوکاردیوگرافی');
INSERT INTO public.diagnosis VALUES (102, 51, 'CT Pulmonary Angiography', 'Gold standard (if available)', 'IMAGING', 'استاندارد طلایی (در صورت دسترسی).', 'آنژیوگرافی سی‌تی ریوی');
INSERT INTO public.diagnosis VALUES (103, 52, 'Echocardiogram', 'TR jet velocity >3.0 m/s (sPAP >50 mmHg)', 'ECHO', 'سرعت جریان تریکوسپید رِگورژیتاسیون > ۳٫۰ m/s (فشار شریان ریوی سیستولیک > ۵۰ mmHg).', 'اکوکاردیوگرافی');
INSERT INTO public.diagnosis VALUES (107, 54, 'Echocardiogram', 'Dysplastic valve leaflets, turbulent flow', 'ECHO', 'لخته‌های ناهنجار دریچه، جریان آشفته.', 'اکوکاردیوگرافی');
INSERT INTO public.diagnosis VALUES (109, 56, 'Echocardiogram', 'Biatrial enlargement, normal wall thickness, restrictive filling', 'ECHO', 'بزرگی دو دهلیز، ضخامت دیواره طبیعی، پر شدن محدودکننده.', 'اکوکاردیوگرافی');
INSERT INTO public.diagnosis VALUES (111, 57, '24-hr Holter Monitoring', 'VPC burden >100/24h or runs of VT', 'ECG', 'بار VPC > ۱۰۰/۲۴h یا سری‌های تاکی‌کاردی بطنی.', 'مونیتورینگ هولتر ۲۴ ساعته');
INSERT INTO public.diagnosis VALUES (113, 58, 'cTnI', 'Elevated troponin correlates with mortality', 'LABORATORY_TESTING', 'افزایش تروپونین مرتبط با مرگ‌ومیر است.', 'cTnI');
INSERT INTO public.diagnosis VALUES (115, 59, '24-hr Holter Monitoring', 'Asystole >8 sec correlating with syncope', 'ECG', 'آسیستول > ۸ ثانیه مرتبط با سنکوپ.', 'مونیتورینگ هولتر ۲۴ ساعته');
INSERT INTO public.diagnosis VALUES (117, 60, 'Echocardiogram', 'Fibrous ridge below AV, LVOT gradient >50 mmHg', 'ECHO', 'رشته فیبروز زیر دریچه آئورت، گرادیان خروجی بطن چپ > ۵۰ mmHg.', 'اکوکاردیوگرافی');
INSERT INTO public.diagnosis VALUES (120, 61, 'Fundic Exam', 'Retinal hemorrhage/detachment (target organ damage)', 'PHYSICAL_EXAMINATION', 'خونریزی/جدایی شبکیه (آسیب عضو هدف).', 'معاینه چشمی با اُفتالموسکوپ');
INSERT INTO public.diagnosis VALUES (122, 62, 'Urinalysis', 'Proteinuria (UPC >0.5)', 'LABORATORY_TESTING', 'پروتئینوری (نسبت پروتئین به کراتینین > ۰٫۵).', 'آنالیز ادرار');
INSERT INTO public.diagnosis VALUES (125, 64, 'Echocardiogram', 'VSD, pulmonic stenosis, overriding aorta, RVH', 'ECHO', 'ناهنجاری سپتوم بطنی، تنگی دریچه ریوی، آئورت رویی‌رفته، هایپرتروفی بطن راست.', 'اکوکاردیوگرافی');
INSERT INTO public.diagnosis VALUES (127, 65, 'Echocardiogram', 'Dysplastic tricuspid valve, RA/RV enlargement', 'ECHO', 'دریچه سه‌لختی ناهنجار، بزرگی دهلیز/بطن راست.', 'اکوکاردیوگرافی');
INSERT INTO public.diagnosis VALUES (130, 67, 'Skin Biopsy', 'Leukocytoclastic vasculitis (cutaneous form)', 'BIOPSY', 'وازکولیت لِوکوسیتوکلاستیک (شکل پوستی).', 'بیوپسی پوست');
INSERT INTO public.diagnosis VALUES (132, 68, '24-hr Holter Monitoring', 'Quantify VPC burden and morphology', 'ECG', 'کمّی‌سازی بار VPC و مورفولوژی.', 'مونیتورینگ هولتر ۲۴ ساعته');
INSERT INTO public.diagnosis VALUES (134, 69, 'Echocardiogram', 'Turbulent flow across IVS, LA/LV volume overload', 'ECHO', 'جریان آشفته در سپتوم بین بطنی، بار حجمی دهلیز/بطن چپ.', 'اکوکاردیوگرافی');


--
-- Data for Name: disease_species; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.disease_species VALUES (1, 'CANINE');
INSERT INTO public.disease_species VALUES (1, 'FELINE');
INSERT INTO public.disease_species VALUES (2, 'CANINE');
INSERT INTO public.disease_species VALUES (3, 'CANINE');
INSERT INTO public.disease_species VALUES (3, 'FELINE');
INSERT INTO public.disease_species VALUES (4, 'CANINE');
INSERT INTO public.disease_species VALUES (5, 'FELINE');
INSERT INTO public.disease_species VALUES (6, 'CANINE');
INSERT INTO public.disease_species VALUES (6, 'FELINE');
INSERT INTO public.disease_species VALUES (7, 'CANINE');
INSERT INTO public.disease_species VALUES (8, 'CANINE');
INSERT INTO public.disease_species VALUES (8, 'FELINE');
INSERT INTO public.disease_species VALUES (9, 'CANINE');
INSERT INTO public.disease_species VALUES (9, 'FELINE');
INSERT INTO public.disease_species VALUES (10, 'CANINE');
INSERT INTO public.disease_species VALUES (10, 'FELINE');
INSERT INTO public.disease_species VALUES (11, 'FELINE');
INSERT INTO public.disease_species VALUES (12, 'CANINE');
INSERT INTO public.disease_species VALUES (12, 'FELINE');
INSERT INTO public.disease_species VALUES (13, 'CANINE');
INSERT INTO public.disease_species VALUES (14, 'CANINE');
INSERT INTO public.disease_species VALUES (14, 'FELINE');
INSERT INTO public.disease_species VALUES (15, 'CANINE');
INSERT INTO public.disease_species VALUES (15, 'FELINE');
INSERT INTO public.disease_species VALUES (16, 'CANINE');
INSERT INTO public.disease_species VALUES (16, 'FELINE');
INSERT INTO public.disease_species VALUES (17, 'CANINE');
INSERT INTO public.disease_species VALUES (17, 'FELINE');
INSERT INTO public.disease_species VALUES (18, 'CANINE');
INSERT INTO public.disease_species VALUES (19, 'CANINE');
INSERT INTO public.disease_species VALUES (19, 'FELINE');
INSERT INTO public.disease_species VALUES (20, 'CANINE');
INSERT INTO public.disease_species VALUES (21, 'CANINE');
INSERT INTO public.disease_species VALUES (21, 'FELINE');
INSERT INTO public.disease_species VALUES (22, 'CANINE');
INSERT INTO public.disease_species VALUES (22, 'FELINE');
INSERT INTO public.disease_species VALUES (23, 'CANINE');
INSERT INTO public.disease_species VALUES (24, 'CANINE');
INSERT INTO public.disease_species VALUES (24, 'FELINE');
INSERT INTO public.disease_species VALUES (25, 'CANINE');
INSERT INTO public.disease_species VALUES (25, 'FELINE');
INSERT INTO public.disease_species VALUES (26, 'CANINE');
INSERT INTO public.disease_species VALUES (26, 'FELINE');
INSERT INTO public.disease_species VALUES (27, 'CANINE');
INSERT INTO public.disease_species VALUES (27, 'FELINE');
INSERT INTO public.disease_species VALUES (28, 'CANINE');
INSERT INTO public.disease_species VALUES (29, 'CANINE');
INSERT INTO public.disease_species VALUES (30, 'CANINE');
INSERT INTO public.disease_species VALUES (31, 'CANINE');
INSERT INTO public.disease_species VALUES (31, 'FELINE');
INSERT INTO public.disease_species VALUES (32, 'CANINE');
INSERT INTO public.disease_species VALUES (32, 'FELINE');
INSERT INTO public.disease_species VALUES (33, 'FELINE');
INSERT INTO public.disease_species VALUES (34, 'FELINE');
INSERT INTO public.disease_species VALUES (35, 'CANINE');
INSERT INTO public.disease_species VALUES (35, 'FELINE');
INSERT INTO public.disease_species VALUES (36, 'FELINE');
INSERT INTO public.disease_species VALUES (37, 'CANINE');
INSERT INTO public.disease_species VALUES (38, 'CANINE');
INSERT INTO public.disease_species VALUES (38, 'FELINE');
INSERT INTO public.disease_species VALUES (39, 'CANINE');
INSERT INTO public.disease_species VALUES (40, 'CANINE');
INSERT INTO public.disease_species VALUES (40, 'FELINE');
INSERT INTO public.disease_species VALUES (41, 'CANINE');
INSERT INTO public.disease_species VALUES (41, 'FELINE');
INSERT INTO public.disease_species VALUES (42, 'CANINE');
INSERT INTO public.disease_species VALUES (43, 'CANINE');
INSERT INTO public.disease_species VALUES (44, 'CANINE');
INSERT INTO public.disease_species VALUES (44, 'FELINE');
INSERT INTO public.disease_species VALUES (45, 'CANINE');
INSERT INTO public.disease_species VALUES (45, 'FELINE');
INSERT INTO public.disease_species VALUES (46, 'CANINE');
INSERT INTO public.disease_species VALUES (46, 'FELINE');
INSERT INTO public.disease_species VALUES (47, 'CANINE');
INSERT INTO public.disease_species VALUES (47, 'FELINE');
INSERT INTO public.disease_species VALUES (48, 'CANINE');
INSERT INTO public.disease_species VALUES (48, 'FELINE');
INSERT INTO public.disease_species VALUES (49, 'CANINE');
INSERT INTO public.disease_species VALUES (49, 'FELINE');
INSERT INTO public.disease_species VALUES (50, 'CANINE');
INSERT INTO public.disease_species VALUES (51, 'CANINE');
INSERT INTO public.disease_species VALUES (51, 'FELINE');
INSERT INTO public.disease_species VALUES (52, 'CANINE');
INSERT INTO public.disease_species VALUES (52, 'FELINE');
INSERT INTO public.disease_species VALUES (53, 'CANINE');
INSERT INTO public.disease_species VALUES (53, 'FELINE');
INSERT INTO public.disease_species VALUES (54, 'CANINE');
INSERT INTO public.disease_species VALUES (55, 'CANINE');
INSERT INTO public.disease_species VALUES (56, 'FELINE');
INSERT INTO public.disease_species VALUES (57, 'CANINE');
INSERT INTO public.disease_species VALUES (58, 'CANINE');
INSERT INTO public.disease_species VALUES (58, 'FELINE');
INSERT INTO public.disease_species VALUES (59, 'CANINE');
INSERT INTO public.disease_species VALUES (60, 'CANINE');
INSERT INTO public.disease_species VALUES (61, 'CANINE');
INSERT INTO public.disease_species VALUES (61, 'FELINE');
INSERT INTO public.disease_species VALUES (62, 'CANINE');
INSERT INTO public.disease_species VALUES (62, 'FELINE');
INSERT INTO public.disease_species VALUES (63, 'CANINE');
INSERT INTO public.disease_species VALUES (63, 'FELINE');
INSERT INTO public.disease_species VALUES (64, 'CANINE');
INSERT INTO public.disease_species VALUES (65, 'CANINE');
INSERT INTO public.disease_species VALUES (66, 'CANINE');
INSERT INTO public.disease_species VALUES (67, 'CANINE');
INSERT INTO public.disease_species VALUES (67, 'FELINE');
INSERT INTO public.disease_species VALUES (68, 'CANINE');
INSERT INTO public.disease_species VALUES (68, 'FELINE');
INSERT INTO public.disease_species VALUES (69, 'CANINE');
INSERT INTO public.disease_species VALUES (69, 'FELINE');


--
-- Data for Name: disease_symptom_enums; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.disease_symptom_enums VALUES (1, 'LAMENESS');
INSERT INTO public.disease_symptom_enums VALUES (1, 'WEAKNESS');
INSERT INTO public.disease_symptom_enums VALUES (1, 'TACHYCARDIA');
INSERT INTO public.disease_symptom_enums VALUES (1, 'PALE_GUMS');
INSERT INTO public.disease_symptom_enums VALUES (1, 'LETHARGY');
INSERT INTO public.disease_symptom_enums VALUES (2, 'COUGHING');
INSERT INTO public.disease_symptom_enums VALUES (2, 'DYSPNEA');
INSERT INTO public.disease_symptom_enums VALUES (2, 'SUDDEN_DEATH');
INSERT INTO public.disease_symptom_enums VALUES (2, 'PAIN_IN_CHEST_OR_ABDOMEN');
INSERT INTO public.disease_symptom_enums VALUES (3, 'BRADYCARDIA');
INSERT INTO public.disease_symptom_enums VALUES (3, 'PAIN_IN_CHEST_OR_ABDOMEN');
INSERT INTO public.disease_symptom_enums VALUES (3, 'COLLAPSE');
INSERT INTO public.disease_symptom_enums VALUES (3, 'SHOCK');
INSERT INTO public.disease_symptom_enums VALUES (4, 'DECREASED_APPETITE');
INSERT INTO public.disease_symptom_enums VALUES (4, 'SYNCOPE');
INSERT INTO public.disease_symptom_enums VALUES (4, 'HEART_MURMUR');
INSERT INTO public.disease_symptom_enums VALUES (4, 'WEAKNESS');
INSERT INTO public.disease_symptom_enums VALUES (4, 'SUDDEN_DEATH');
INSERT INTO public.disease_symptom_enums VALUES (5, 'HIND_LIMB_PARALYSIS');
INSERT INTO public.disease_symptom_enums VALUES (5, 'PAINFUL_LIMBS');
INSERT INTO public.disease_symptom_enums VALUES (5, 'COLD_EXTREMITIES');
INSERT INTO public.disease_symptom_enums VALUES (5, 'REDUCED_PULSE_IN_AFFECTED_LIMBS');
INSERT INTO public.disease_symptom_enums VALUES (5, 'PAIN_IN_CHEST_OR_ABDOMEN');
INSERT INTO public.disease_symptom_enums VALUES (6, 'POLYDIPSIA');
INSERT INTO public.disease_symptom_enums VALUES (6, 'SYNCOPE');
INSERT INTO public.disease_symptom_enums VALUES (6, 'WEAKNESS');
INSERT INTO public.disease_symptom_enums VALUES (6, 'IRREGULAR_HEART_RATE');
INSERT INTO public.disease_symptom_enums VALUES (7, 'SWELLING');
INSERT INTO public.disease_symptom_enums VALUES (7, 'SYNCOPE');
INSERT INTO public.disease_symptom_enums VALUES (7, 'SUDDEN_DEATH');
INSERT INTO public.disease_symptom_enums VALUES (7, 'VENTRICULAR_ARRHYTHMIAS');
INSERT INTO public.disease_symptom_enums VALUES (8, 'EXERCISE_INTOLERANCE');
INSERT INTO public.disease_symptom_enums VALUES (8, 'WEAKNESS');
INSERT INTO public.disease_symptom_enums VALUES (8, 'HEART_MURMUR');
INSERT INTO public.disease_symptom_enums VALUES (8, 'IRREGULAR_HEART_RATE');
INSERT INTO public.disease_symptom_enums VALUES (9, 'DECREASED_APPETITE');
INSERT INTO public.disease_symptom_enums VALUES (9, 'HEART_MURMUR');
INSERT INTO public.disease_symptom_enums VALUES (9, 'LETHARGY');
INSERT INTO public.disease_symptom_enums VALUES (9, 'WEAKNESS');
INSERT INTO public.disease_symptom_enums VALUES (10, 'PAINFUL_LIMBS');
INSERT INTO public.disease_symptom_enums VALUES (10, 'WEAKNESS');
INSERT INTO public.disease_symptom_enums VALUES (10, 'BRADYCARDIA');
INSERT INTO public.disease_symptom_enums VALUES (10, 'COLLAPSE');
INSERT INTO public.disease_symptom_enums VALUES (11, 'POLYURIA');
INSERT INTO public.disease_symptom_enums VALUES (11, 'LETHARGY');
INSERT INTO public.disease_symptom_enums VALUES (11, 'ASCITES');
INSERT INTO public.disease_symptom_enums VALUES (11, 'DYSPNEA');
INSERT INTO public.disease_symptom_enums VALUES (12, 'SYNCOPE');
INSERT INTO public.disease_symptom_enums VALUES (12, 'JUGULAR_VEIN_DISTENSION');
INSERT INTO public.disease_symptom_enums VALUES (12, 'MUFFLED_HEART_SOUNDS');
INSERT INTO public.disease_symptom_enums VALUES (12, 'WEAK_PULSE');
INSERT INTO public.disease_symptom_enums VALUES (12, 'COLLAPSE');
INSERT INTO public.disease_symptom_enums VALUES (13, 'POLYURIA');
INSERT INTO public.disease_symptom_enums VALUES (13, 'DYSPNEA');
INSERT INTO public.disease_symptom_enums VALUES (13, 'COUGHING');
INSERT INTO public.disease_symptom_enums VALUES (13, 'JUGULAR_VEIN_DISTENSION');
INSERT INTO public.disease_symptom_enums VALUES (14, 'WEIGHT_GAIN');
INSERT INTO public.disease_symptom_enums VALUES (14, 'HYPERTENSION');
INSERT INTO public.disease_symptom_enums VALUES (14, 'LETHARGY');
INSERT INTO public.disease_symptom_enums VALUES (14, 'POLYURIA');
INSERT INTO public.disease_symptom_enums VALUES (15, 'LETHARGY');
INSERT INTO public.disease_symptom_enums VALUES (15, 'DYSPNEA');
INSERT INTO public.disease_symptom_enums VALUES (15, 'COUGHING');
INSERT INTO public.disease_symptom_enums VALUES (15, 'ASCITES');
INSERT INTO public.disease_symptom_enums VALUES (16, 'LETHARGY');
INSERT INTO public.disease_symptom_enums VALUES (16, 'DYSPNEA');
INSERT INTO public.disease_symptom_enums VALUES (16, 'SYNCOPE');
INSERT INTO public.disease_symptom_enums VALUES (16, 'TACHYPNEA');
INSERT INTO public.disease_symptom_enums VALUES (17, 'PAINFUL_LIMBS');
INSERT INTO public.disease_symptom_enums VALUES (17, 'WEAKNESS');
INSERT INTO public.disease_symptom_enums VALUES (17, 'SYNCOPE');
INSERT INTO public.disease_symptom_enums VALUES (17, 'BRADYCARDIA');
INSERT INTO public.disease_symptom_enums VALUES (18, 'FEVER');
INSERT INTO public.disease_symptom_enums VALUES (18, 'HEART_MURMUR');
INSERT INTO public.disease_symptom_enums VALUES (18, 'SWELLING');
INSERT INTO public.disease_symptom_enums VALUES (18, 'WEAKNESS');
INSERT INTO public.disease_symptom_enums VALUES (19, 'LETHARGY');
INSERT INTO public.disease_symptom_enums VALUES (19, 'DYSPNEA');
INSERT INTO public.disease_symptom_enums VALUES (19, 'COUGHING');
INSERT INTO public.disease_symptom_enums VALUES (19, 'JUGULAR_VEIN_DISTENSION');
INSERT INTO public.disease_symptom_enums VALUES (20, 'WEIGHT_GAIN');
INSERT INTO public.disease_symptom_enums VALUES (20, 'POLYURIA');
INSERT INTO public.disease_symptom_enums VALUES (20, 'POLYDIPSIA');
INSERT INTO public.disease_symptom_enums VALUES (20, 'WEAKNESS');
INSERT INTO public.disease_symptom_enums VALUES (21, 'WEIGHT_GAIN');
INSERT INTO public.disease_symptom_enums VALUES (21, 'POLYURIA');
INSERT INTO public.disease_symptom_enums VALUES (21, 'WEAKNESS');
INSERT INTO public.disease_symptom_enums VALUES (21, 'LETHARGY');
INSERT INTO public.disease_symptom_enums VALUES (22, 'SKIN_ULCERS_OR_LESIONS');
INSERT INTO public.disease_symptom_enums VALUES (22, 'WEAKNESS');
INSERT INTO public.disease_symptom_enums VALUES (22, 'COLLAPSE');
INSERT INTO public.disease_symptom_enums VALUES (22, 'HEART_MURMUR');
INSERT INTO public.disease_symptom_enums VALUES (22, 'JUGULAR_VEIN_DISTENSION');
INSERT INTO public.disease_symptom_enums VALUES (23, 'DECREASED_APPETITE');
INSERT INTO public.disease_symptom_enums VALUES (23, 'HEART_MURMUR');
INSERT INTO public.disease_symptom_enums VALUES (23, 'ASCITES');
INSERT INTO public.disease_symptom_enums VALUES (23, 'DYSPNEA');
INSERT INTO public.disease_symptom_enums VALUES (24, 'PAIN_IN_CHEST_OR_ABDOMEN');
INSERT INTO public.disease_symptom_enums VALUES (24, 'CYANOSIS');
INSERT INTO public.disease_symptom_enums VALUES (24, 'SYNCOPE');
INSERT INTO public.disease_symptom_enums VALUES (24, 'WEAKNESS');
INSERT INTO public.disease_symptom_enums VALUES (25, 'POLYURIA');
INSERT INTO public.disease_symptom_enums VALUES (25, 'DYSPNEA');
INSERT INTO public.disease_symptom_enums VALUES (25, 'FAILURE_TO_THRIVE');
INSERT INTO public.disease_symptom_enums VALUES (25, 'SUDDEN_DEATH');
INSERT INTO public.disease_symptom_enums VALUES (26, 'SUDDEN_DEATH');
INSERT INTO public.disease_symptom_enums VALUES (26, 'FEVER');
INSERT INTO public.disease_symptom_enums VALUES (26, 'HEART_MURMUR');
INSERT INTO public.disease_symptom_enums VALUES (26, 'WEAKNESS');
INSERT INTO public.disease_symptom_enums VALUES (27, 'SUDDEN_DEATH');
INSERT INTO public.disease_symptom_enums VALUES (27, 'LETHARGY');
INSERT INTO public.disease_symptom_enums VALUES (27, 'DYSPNEA');
INSERT INTO public.disease_symptom_enums VALUES (27, 'FEVER');
INSERT INTO public.disease_symptom_enums VALUES (28, 'PALE_GUMS');
INSERT INTO public.disease_symptom_enums VALUES (28, 'COUGHING');
INSERT INTO public.disease_symptom_enums VALUES (28, 'DYSPNEA');
INSERT INTO public.disease_symptom_enums VALUES (28, 'LETHARGY');
INSERT INTO public.disease_symptom_enums VALUES (29, 'LETHARGY');
INSERT INTO public.disease_symptom_enums VALUES (29, 'JUGULAR_VEIN_DISTENSION');
INSERT INTO public.disease_symptom_enums VALUES (29, 'COLLAPSE');
INSERT INTO public.disease_symptom_enums VALUES (29, 'DYSPNEA');
INSERT INTO public.disease_symptom_enums VALUES (30, 'SYNCOPE');
INSERT INTO public.disease_symptom_enums VALUES (30, 'WEAKNESS');
INSERT INTO public.disease_symptom_enums VALUES (30, 'PERICARDIAL_EFFUSION');
INSERT INTO public.disease_symptom_enums VALUES (30, 'COLLAPSE');
INSERT INTO public.disease_symptom_enums VALUES (31, 'WEIGHT_GAIN');
INSERT INTO public.disease_symptom_enums VALUES (31, 'WEAKNESS');
INSERT INTO public.disease_symptom_enums VALUES (31, 'POLYURIA');
INSERT INTO public.disease_symptom_enums VALUES (31, 'MUSCLE_WEAKNESS');
INSERT INTO public.disease_symptom_enums VALUES (32, 'POLYDIPSIA');
INSERT INTO public.disease_symptom_enums VALUES (32, 'WEAKNESS');
INSERT INTO public.disease_symptom_enums VALUES (32, 'BRADYCARDIA');
INSERT INTO public.disease_symptom_enums VALUES (32, 'COLLAPSE');
INSERT INTO public.disease_symptom_enums VALUES (33, 'LAMENESS');
INSERT INTO public.disease_symptom_enums VALUES (33, 'WEIGHT_LOSS');
INSERT INTO public.disease_symptom_enums VALUES (33, 'TACHYCARDIA');
INSERT INTO public.disease_symptom_enums VALUES (33, 'DYSPNEA');
INSERT INTO public.disease_symptom_enums VALUES (34, 'DYSPNEA');
INSERT INTO public.disease_symptom_enums VALUES (34, 'SYNCOPE');
INSERT INTO public.disease_symptom_enums VALUES (34, 'HEART_MURMUR');
INSERT INTO public.disease_symptom_enums VALUES (34, 'LETHARGY');
INSERT INTO public.disease_symptom_enums VALUES (34, 'SUDDEN_DEATH');
INSERT INTO public.disease_symptom_enums VALUES (35, 'SHOCK');
INSERT INTO public.disease_symptom_enums VALUES (35, 'MUSCLE_TREMORS');
INSERT INTO public.disease_symptom_enums VALUES (35, 'SEIZURES');
INSERT INTO public.disease_symptom_enums VALUES (35, 'PAINFUL_LIMBS');
INSERT INTO public.disease_symptom_enums VALUES (36, 'COUGHING');
INSERT INTO public.disease_symptom_enums VALUES (36, 'WEAKNESS');
INSERT INTO public.disease_symptom_enums VALUES (36, 'MUSCLE_WEAKNESS');
INSERT INTO public.disease_symptom_enums VALUES (36, 'LETHARGY');
INSERT INTO public.disease_symptom_enums VALUES (37, 'SKIN_ULCERS_OR_LESIONS');
INSERT INTO public.disease_symptom_enums VALUES (37, 'LETHARGY');
INSERT INTO public.disease_symptom_enums VALUES (37, 'BRADYCARDIA');
INSERT INTO public.disease_symptom_enums VALUES (37, 'WEIGHT_GAIN');
INSERT INTO public.disease_symptom_enums VALUES (38, 'POLYURIA');
INSERT INTO public.disease_symptom_enums VALUES (38, 'WEAKNESS');
INSERT INTO public.disease_symptom_enums VALUES (38, 'PERICARDIAL_EFFUSION');
INSERT INTO public.disease_symptom_enums VALUES (38, 'LETHARGY');
INSERT INTO public.disease_symptom_enums VALUES (39, 'PALE_GUMS');
INSERT INTO public.disease_symptom_enums VALUES (39, 'HEART_MURMUR');
INSERT INTO public.disease_symptom_enums VALUES (39, 'COUGHING');
INSERT INTO public.disease_symptom_enums VALUES (39, 'DYSPNEA');
INSERT INTO public.disease_symptom_enums VALUES (39, 'LETHARGY');
INSERT INTO public.disease_symptom_enums VALUES (40, 'FEVER');
INSERT INTO public.disease_symptom_enums VALUES (40, 'HEART_MURMUR');
INSERT INTO public.disease_symptom_enums VALUES (40, 'EXERCISE_INTOLERANCE');
INSERT INTO public.disease_symptom_enums VALUES (40, 'DYSPNEA');
INSERT INTO public.disease_symptom_enums VALUES (41, 'SKIN_ULCERS_OR_LESIONS');
INSERT INTO public.disease_symptom_enums VALUES (41, 'LETHARGY');
INSERT INTO public.disease_symptom_enums VALUES (41, 'SUDDEN_DEATH');
INSERT INTO public.disease_symptom_enums VALUES (41, 'FEVER');
INSERT INTO public.disease_symptom_enums VALUES (42, 'FEVER');
INSERT INTO public.disease_symptom_enums VALUES (42, 'HEART_MURMUR');
INSERT INTO public.disease_symptom_enums VALUES (42, 'COUGHING');
INSERT INTO public.disease_symptom_enums VALUES (42, 'LETHARGY');
INSERT INTO public.disease_symptom_enums VALUES (43, 'PALE_GUMS');
INSERT INTO public.disease_symptom_enums VALUES (43, 'HEART_MURMUR');
INSERT INTO public.disease_symptom_enums VALUES (43, 'COUGHING');
INSERT INTO public.disease_symptom_enums VALUES (43, 'DYSPNEA');
INSERT INTO public.disease_symptom_enums VALUES (44, 'DECREASED_APPETITE');
INSERT INTO public.disease_symptom_enums VALUES (44, 'HEART_MURMUR');
INSERT INTO public.disease_symptom_enums VALUES (44, 'WEAKNESS');
INSERT INTO public.disease_symptom_enums VALUES (44, 'DYSPNEA');
INSERT INTO public.disease_symptom_enums VALUES (45, 'FEVER');
INSERT INTO public.disease_symptom_enums VALUES (45, 'HEART_MURMUR');
INSERT INTO public.disease_symptom_enums VALUES (45, 'EXERCISE_INTOLERANCE');
INSERT INTO public.disease_symptom_enums VALUES (45, 'SYNCOPE');
INSERT INTO public.disease_symptom_enums VALUES (46, 'LETHARGY');
INSERT INTO public.disease_symptom_enums VALUES (46, 'JUGULAR_VEIN_DISTENSION');
INSERT INTO public.disease_symptom_enums VALUES (46, 'MUFFLED_HEART_SOUNDS');
INSERT INTO public.disease_symptom_enums VALUES (46, 'WEAK_PULSE');
INSERT INTO public.disease_symptom_enums VALUES (47, 'LETHARGY');
INSERT INTO public.disease_symptom_enums VALUES (47, 'JUGULAR_VEIN_DISTENSION');
INSERT INTO public.disease_symptom_enums VALUES (47, 'MUFFLED_HEART_SOUNDS');
INSERT INTO public.disease_symptom_enums VALUES (47, 'WEAK_PULSE');
INSERT INTO public.disease_symptom_enums VALUES (48, 'LETHARGY');
INSERT INTO public.disease_symptom_enums VALUES (48, 'PAIN_IN_CHEST_OR_ABDOMEN');
INSERT INTO public.disease_symptom_enums VALUES (48, 'FEVER');
INSERT INTO public.disease_symptom_enums VALUES (48, 'JUGULAR_VEIN_DISTENSION');
INSERT INTO public.disease_symptom_enums VALUES (49, 'REGURGITATION');
INSERT INTO public.disease_symptom_enums VALUES (49, 'COLD_EXTREMITIES');
INSERT INTO public.disease_symptom_enums VALUES (49, 'LAMENESS');
INSERT INTO public.disease_symptom_enums VALUES (49, 'WEAKNESS');
INSERT INTO public.disease_symptom_enums VALUES (50, 'DECREASED_APPETITE');
INSERT INTO public.disease_symptom_enums VALUES (50, 'HEART_MURMUR');
INSERT INTO public.disease_symptom_enums VALUES (50, 'SYNCOPE');
INSERT INTO public.disease_symptom_enums VALUES (50, 'WEAKNESS');
INSERT INTO public.disease_symptom_enums VALUES (51, 'LETHARGY');
INSERT INTO public.disease_symptom_enums VALUES (51, 'DYSPNEA');
INSERT INTO public.disease_symptom_enums VALUES (51, 'SUDDEN_DEATH');
INSERT INTO public.disease_symptom_enums VALUES (51, 'TACHYPNEA');
INSERT INTO public.disease_symptom_enums VALUES (52, 'DECREASED_APPETITE');
INSERT INTO public.disease_symptom_enums VALUES (52, 'SYNCOPE');
INSERT INTO public.disease_symptom_enums VALUES (52, 'DYSPNEA');
INSERT INTO public.disease_symptom_enums VALUES (52, 'TACHYPNEA');
INSERT INTO public.disease_symptom_enums VALUES (53, 'LETHARGY');
INSERT INTO public.disease_symptom_enums VALUES (53, 'DYSPNEA');
INSERT INTO public.disease_symptom_enums VALUES (53, 'TACHYPNEA');
INSERT INTO public.disease_symptom_enums VALUES (53, 'WEAKNESS');
INSERT INTO public.disease_symptom_enums VALUES (54, 'DECREASED_APPETITE');
INSERT INTO public.disease_symptom_enums VALUES (54, 'HEART_MURMUR');
INSERT INTO public.disease_symptom_enums VALUES (54, 'EXERCISE_INTOLERANCE');
INSERT INTO public.disease_symptom_enums VALUES (54, 'DYSPNEA');
INSERT INTO public.disease_symptom_enums VALUES (55, 'DECREASED_APPETITE');
INSERT INTO public.disease_symptom_enums VALUES (55, 'HEART_MURMUR');
INSERT INTO public.disease_symptom_enums VALUES (55, 'SYNCOPE');
INSERT INTO public.disease_symptom_enums VALUES (55, 'WEAKNESS');
INSERT INTO public.disease_symptom_enums VALUES (56, 'LETHARGY');
INSERT INTO public.disease_symptom_enums VALUES (56, 'DYSPNEA');
INSERT INTO public.disease_symptom_enums VALUES (56, 'ASCITES');
INSERT INTO public.disease_symptom_enums VALUES (56, 'JUGULAR_VEIN_DISTENSION');
INSERT INTO public.disease_symptom_enums VALUES (57, 'SWELLING');
INSERT INTO public.disease_symptom_enums VALUES (57, 'SYNCOPE');
INSERT INTO public.disease_symptom_enums VALUES (57, 'SUDDEN_DEATH');
INSERT INTO public.disease_symptom_enums VALUES (57, 'VENTRICULAR_ARRHYTHMIAS');
INSERT INTO public.disease_symptom_enums VALUES (58, 'LETHARGY');
INSERT INTO public.disease_symptom_enums VALUES (58, 'WEAKNESS');
INSERT INTO public.disease_symptom_enums VALUES (58, 'HYPOTENSION');
INSERT INTO public.disease_symptom_enums VALUES (58, 'SHOCK');
INSERT INTO public.disease_symptom_enums VALUES (59, 'SWELLING');
INSERT INTO public.disease_symptom_enums VALUES (59, 'SYNCOPE');
INSERT INTO public.disease_symptom_enums VALUES (59, 'WEAKNESS');
INSERT INTO public.disease_symptom_enums VALUES (59, 'BRADYCARDIA');
INSERT INTO public.disease_symptom_enums VALUES (60, 'DECREASED_APPETITE');
INSERT INTO public.disease_symptom_enums VALUES (60, 'HEART_MURMUR');
INSERT INTO public.disease_symptom_enums VALUES (60, 'SYNCOPE');
INSERT INTO public.disease_symptom_enums VALUES (60, 'SUDDEN_DEATH');
INSERT INTO public.disease_symptom_enums VALUES (61, 'JUGULAR_VEIN_DISTENSION');
INSERT INTO public.disease_symptom_enums VALUES (61, 'SUDDEN_BLINDNESS');
INSERT INTO public.disease_symptom_enums VALUES (61, 'HEART_MURMUR');
INSERT INTO public.disease_symptom_enums VALUES (61, 'WEAKNESS');
INSERT INTO public.disease_symptom_enums VALUES (62, 'JUGULAR_VEIN_DISTENSION');
INSERT INTO public.disease_symptom_enums VALUES (62, 'SUDDEN_BLINDNESS');
INSERT INTO public.disease_symptom_enums VALUES (62, 'PROTEINURIA');
INSERT INTO public.disease_symptom_enums VALUES (62, 'WEIGHT_LOSS');
INSERT INTO public.disease_symptom_enums VALUES (63, 'SUDDEN_DEATH');
INSERT INTO public.disease_symptom_enums VALUES (63, 'FEVER');
INSERT INTO public.disease_symptom_enums VALUES (63, 'SHOCK');
INSERT INTO public.disease_symptom_enums VALUES (63, 'WEAKNESS');
INSERT INTO public.disease_symptom_enums VALUES (64, 'PAIN_IN_CHEST_OR_ABDOMEN');
INSERT INTO public.disease_symptom_enums VALUES (64, 'CYANOSIS');
INSERT INTO public.disease_symptom_enums VALUES (64, 'EXERCISE_INTOLERANCE');
INSERT INTO public.disease_symptom_enums VALUES (64, 'SYNCOPE');
INSERT INTO public.disease_symptom_enums VALUES (65, 'WEAKNESS');
INSERT INTO public.disease_symptom_enums VALUES (65, 'JUGULAR_VEIN_DISTENSION');
INSERT INTO public.disease_symptom_enums VALUES (65, 'ASCITES');
INSERT INTO public.disease_symptom_enums VALUES (65, 'HEART_MURMUR');
INSERT INTO public.disease_symptom_enums VALUES (66, 'TISSUE_DEATH');
INSERT INTO public.disease_symptom_enums VALUES (66, 'REGURGITATION');
INSERT INTO public.disease_symptom_enums VALUES (66, 'DYSPHAGIA');
INSERT INTO public.disease_symptom_enums VALUES (66, 'FAILURE_TO_THRIVE');
INSERT INTO public.disease_symptom_enums VALUES (67, 'REGURGITATION');
INSERT INTO public.disease_symptom_enums VALUES (67, 'SKIN_ULCERS_OR_LESIONS');
INSERT INTO public.disease_symptom_enums VALUES (67, 'LAMENESS');
INSERT INTO public.disease_symptom_enums VALUES (67, 'FEVER');
INSERT INTO public.disease_symptom_enums VALUES (68, 'SWELLING');
INSERT INTO public.disease_symptom_enums VALUES (68, 'SYNCOPE');
INSERT INTO public.disease_symptom_enums VALUES (68, 'SUDDEN_DEATH');
INSERT INTO public.disease_symptom_enums VALUES (68, 'IRREGULAR_HEART_RATE');
INSERT INTO public.disease_symptom_enums VALUES (69, 'DECREASED_APPETITE');
INSERT INTO public.disease_symptom_enums VALUES (69, 'HEART_MURMUR');
INSERT INTO public.disease_symptom_enums VALUES (69, 'FAILURE_TO_THRIVE');
INSERT INTO public.disease_symptom_enums VALUES (69, 'DYSPNEA');


--
-- Data for Name: medicine; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.medicine VALUES (1, 'Furosemide', 'DIURETIC', 'Loop diuretic for pulmonary edema/ascites', '1–4 mg/kg PO/IV/IM q6–12h', '1–2 mg/kg PO/IV q8–24h', 'Anuria, dehydration, electrolyte depletion', 'مدر حلقه‌ای برای ادم ریوی/آسیت.', 'فوروسماید');
INSERT INTO public.medicine VALUES (2, 'Spironolactone', 'DIURETIC', 'Aldosterone antagonist; adjunct in CHF', '1–2 mg/kg PO q24h', '1–2 mg/kg PO q24h', 'Hyperkalemia, renal insufficiency', 'آنتاگونیست آلدوسترون؛ مکمل در نارسایی قلبی.', 'اسپیرونولاکتون');
INSERT INTO public.medicine VALUES (3, 'Hydrochlorothiazide', 'DIURETIC', 'Thiazide diuretic for mild edema', '2–4 mg/kg PO q12–24h', 'Not recommended', 'Renal/hepatic impairment', 'مدر تیازیدی برای ادم خفیف.', 'هیدروکلروتیازید');
INSERT INTO public.medicine VALUES (4, 'Pimobendan', 'INODILATOR', 'PDE3 inhibitor + calcium sensitizer for systolic dysfunction', '0.25–0.3 mg/kg PO q12h', '1.25 mg/cat PO q12h (max 2.5 mg/cat)', 'Aortic stenosis, HOCM', 'مهارکننده PDE3 + حساس‌کننده کلسیم برای نارسایی سیستولیک.', 'پیمُبِنْدان');
INSERT INTO public.medicine VALUES (5, 'Milrinone', 'INODILATOR', 'IV inodilator for acute decompensated CHF', '0.5–1.0 mcg/kg/min CRI', '0.5–1.0 mcg/kg/min CRI', 'Hypotension, arrhythmias', 'اینودیلاتور وریدی برای نارسایی قلبی حاد و دکمپانسه.', 'میلرینون');
INSERT INTO public.medicine VALUES (6, 'Enalapril', 'ACE_INHIBITOR', 'Reduce afterload, slow CHF progression', '0.5 mg/kg PO q12–24h', '0.25–0.5 mg/kg PO q24h', 'Hypotension, azotemia', 'کاهش پس‌بار و کندکردن پیشرفت نارسایی قلبی.', 'انالاپریل');
INSERT INTO public.medicine VALUES (7, 'Benazepril', 'ACE_INHIBITOR', 'Long-acting ACEi; palatable for cats', '0.25–0.5 mg/kg PO q24h', '0.25–0.5 mg/kg PO q24h', 'Same as enalapril', 'مهارکننده ACE با اثر طولانی؛ قابل تحمل برای گربه‌ها.', 'بنازِپریل');
INSERT INTO public.medicine VALUES (8, 'Ramipril', 'ACE_INHIBITOR', 'Alternative ACEi for refractory cases', '0.125–0.25 mg/kg PO q24h', '0.125 mg/kg PO q24h', 'Same as enalapril', 'مهارکننده ACE جایگزین برای موارد مقاوم.', 'رامی‌پریل');
INSERT INTO public.medicine VALUES (9, 'Sotalol', 'ANTIARRHYTHMIC', 'Beta-blocker + Class III for VT/VPCs', '1–3 mg/kg PO q12h', '1 mg/kg PO q12h', 'Asthma, bradycardia, CHF', 'بتا-بلوکر + کلاس III برای تاکی‌کاردی/کنتراکسیون زودرس بطنی.', 'سوتالول');
INSERT INTO public.medicine VALUES (10, 'Amiodarone', 'ANTIARRHYTHMIC', 'Broad-spectrum for refractory VT/AF', '5–10 mg/kg/day PO loading, then 5 mg/kg q24h', '5–10 mg/kg/day PO loading, then 5 mg/kg q24–48h', 'Hepatotoxicity, pulmonary fibrosis', 'طیف وسیع برای تاکی‌کاردی/فیبریلاسیون دهلیزی مقاوم.', 'آمیودارون');
INSERT INTO public.medicine VALUES (11, 'Diltiazem', 'ANTIARRHYTHMIC', 'Rate control for atrial fibrillation', '1.5–3 mg/kg PO q8h', '7.5–15 mg/cat PO q8–12h', 'Hypotension, bradycardia', 'کنترل ضربان در فیبریلاسیون دهلیزی.', 'دیلتیازم');
INSERT INTO public.medicine VALUES (12, 'Clopidogrel', 'ANTICOAGULANT', 'Antiplatelet for thromboprophylaxis', 'Not standard', '18.75 mg/cat PO q24h', 'Active bleeding, thrombocytopenia', 'ضد پلاکت برای پیشگیری از ترومبوز.', 'کلوپیدوگرل');
INSERT INTO public.medicine VALUES (13, 'Aspirin', 'ANTICOAGULANT', 'Low-dose antiplatelet', '1–2 mg/kg PO q48–72h', 'Not recommended (toxic)', 'GI ulceration, bleeding', 'ضد پلاکت با دوز پایین.', 'آسپیرین');
INSERT INTO public.medicine VALUES (14, 'Heparin (UFH)', 'ANTICOAGULANT', 'Acute anticoagulation (e.g., saddle thrombus)', '150–250 U/kg SC q8h', '100–200 U/kg SC q6–8h', 'Bleeding, HIT', 'ضد انعقاد حاد (مثلاً در ترومب سرجوخ).', 'هپارین (UFH)');
INSERT INTO public.medicine VALUES (15, 'Enoxaparin', 'ANTICOAGULANT', 'LMWH; preferred over UFH for outpatient', '1 mg/kg SC q12h', '1 mg/kg SC q12–24h', 'Bleeding, renal impairment', 'هپارین با وزن مولکولی پایین (LMWH)؛ ترجیحاً به جای UFH برای درمان سرپایی.', 'انوکساپارین');
INSERT INTO public.medicine VALUES (16, 'Amlodipine', 'VASODILATOR', 'Calcium channel blocker for hypertension', '0.05–0.1 mg/kg PO q24h', '0.625–1.25 mg/cat PO q24h', 'Hypotension, heart failure', 'مهارکننده کانال کلسیم برای فشار خون بالا.', 'آملودیپین');
INSERT INTO public.medicine VALUES (17, 'Hydralazine', 'VASODILATOR', 'Arterial vasodilator for severe hypertension/CHF', '0.5–2 mg/kg PO q8–12h', 'Not recommended', 'Reflex tachycardia, hypotension', 'واگشادکننده شریانی برای فشار خون بالای شدید/نارسایی قلبی.', 'هیدرالازین');
INSERT INTO public.medicine VALUES (18, 'Sildenafil', 'VASODILATOR', 'PDE5 inhibitor for pulmonary hypertension', '1–3 mg/kg PO q8–12h', '1 mg/kg PO q12h', 'Systemic hypotension', 'مهارکننده PDE5 برای فشار خون ریوی بالا.', 'سیلدِنافیل');
INSERT INTO public.medicine VALUES (19, 'Digoxin', 'CARDIAC_GLYCOSIDE', 'Rate control for AF; mild inotrope', '0.005–0.01 mg/kg PO q12h (max 0.25 mg/dose)', '0.0025–0.005 mg/kg PO q24h (max 0.125 mg/dose)', 'Hypokalemia, renal failure, AV block', 'کنترل ضربان در فیبریلاسیون دهلیزی؛ اینوتروپ خفیف.', 'دیگوکسین');
INSERT INTO public.medicine VALUES (20, 'Doxycycline', 'ANTIBIOTIC', 'Heartworm adulticide adjunct; rickettsial diseases', '5–10 mg/kg PO q12–24h', '5–10 mg/kg PO q12–24h', 'Esophageal stricture (give with water)', 'مکمل درمان کرم بالغ + بیماری‌های ریکتسیایی.', 'دوکسی‌سایکلین');
INSERT INTO public.medicine VALUES (21, 'Enrofloxacin', 'ANTIBIOTIC', 'Gram-negative coverage (e.g., endocarditis)', '5–10 mg/kg PO q24h (max 2.5 mg/kg for cats)', '5 mg/kg PO q24h (max 5 mg/kg)', 'Retinal toxicity in cats >5 mg/kg', 'پوشش گرم منفی (مثلاً در اندوکاردیت).', 'انروفلوکساسین');
INSERT INTO public.medicine VALUES (22, 'Melarsomine', 'ANTIPARASITIC', 'Adulticide for heartworm disease', '2.5 mg/kg IM q24h x2, then 1 month later 2.5 mg/kg IM x2', 'Not used in cats', 'Severe pulmonary thromboembolism', 'داروی کشندۀ کرم بالغ در بیماری کرم قلبی.', 'مِلارسومین');
INSERT INTO public.medicine VALUES (23, 'Ivermectin', 'ANTIPARASITIC', 'Heartworm prevention', '6–12 mcg/kg PO q30d', '24 mcg/kg PO q30d (selamectin preferred in cats)', 'MDR1 mutation (Collies)', 'پیشگیری از کرم قلبی.', 'ایورمکتین');
INSERT INTO public.medicine VALUES (24, 'Buprenorphine', 'ANALGESIC', 'Opioid for acute pain (e.g., saddle thrombus)', '0.01–0.03 mg/kg IV/IM/SC q6–12h', '0.01–0.03 mg/kg IV/IM/SC q6–12h', 'Respiratory depression', 'اپیوئید برای درد حاد (مثلاً در ترومب سرجوخ).', 'بوپرنورفین');
INSERT INTO public.medicine VALUES (25, 'Fentanyl Patch', 'ANALGESIC', 'Transdermal for sustained pain control', '2–5 mcg/kg/h patch q72h', '12–25 mcg/h patch (small cat)', 'Hyperthermia, agitation', 'تراپی پوستی برای کنترل طولانی‌مدت درد.', 'پچ فنتانیل');
INSERT INTO public.medicine VALUES (27, 'L-Carnitine', 'NUTRITIONAL', 'Adjunct in DCM (esp. Boxers)', '50–100 mg/kg/day PO divided q12h', '250–500 mg/cat q12h', 'None', 'مکمل در کاردیومیوپاتی اتساعی (به‌ویژه در سگ‌های باکسر).', 'ال-کارنیتین');
INSERT INTO public.medicine VALUES (29, 'Dextrose 50%', 'EMERGENCY', 'Hypoglycemia (e.g., insulinoma)', '0.5–1 mL/kg IV (diluted 1:4)', '0.5 mL/kg IV (diluted 1:4)', 'Hyperglycemia, fluid overload', 'هیپوگلیسمی (مثلاً در انسولینوما).', 'دکستروز ۵۰٪');
INSERT INTO public.medicine VALUES (26, 'Taurine', 'NUTRITIONAL', 'Essential amino acid for DCM (esp. cats)', '500–1000 mg/dog q12h', '250–500 mg/cat q12h', 'None', 'اسید آمینه ضروری برای کاردیومیوپاتی اتساعی (به‌ویژه در گربه‌ها).', 'تورین');
INSERT INTO public.medicine VALUES (28, 'Calcium Gluconate', 'EMERGENCY', 'Hyperkalemia, hypocalcemia', '100–200 mg/kg 10% solution IV slow (max 0.5–1.5 mL/min)', '100 mg/kg 10% solution IV slow', 'Digitalis toxicity, hypercalcemia', 'درمان هایپرکالمی و هیپوکلسمی.', 'گلوکونات کلسیم');


--
-- Data for Name: stage; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.stage VALUES (3, 2, 'Asymptomatic', 'Incidental finding on imaging', 'یافته تصادفی در تصویربرداری.', 'بی‌علامت');
INSERT INTO public.stage VALUES (4, 2, 'Symptomatic', 'Compression of adjacent structures', 'فشار بر ساختارهای مجاور.', 'علامت‌دار');
INSERT INTO public.stage VALUES (6, 3, 'Acute (<24h)', 'Tearing chest pain, hypotension', 'درد سینه پاره‌کننده، هیپوتانسیون.', 'حاد (<۲۴ ساعت)');
INSERT INTO public.stage VALUES (8, 4, 'Mild (Gradient <50 mmHg)', 'Asymptomatic, murmur only', 'بی‌علامت، تنها هاس.', 'خفیف (گرادیان < ۵۰ mmHg)');
INSERT INTO public.stage VALUES (10, 4, 'Severe (>80 mmHg)', 'Syncope, CHF, sudden death', 'سنکوپ، نارسایی قلبی، مرگ ناگهانی.', 'شدید (> ۸۰ mmHg)');
INSERT INTO public.stage VALUES (12, 5, 'Subacute (12-72h)', 'Partial recovery or deterioration', 'بهبودی جزئی یا تشدید.', 'زیرحاد (۱۲–۷۲ ساعت)');
INSERT INTO public.stage VALUES (14, 6, 'Asymptomatic', 'Incidental arrhythmia on ECG', 'آریتمی تصادفی در نوار قلب.', 'بی‌علامت');
INSERT INTO public.stage VALUES (15, 6, 'Symptomatic', 'Syncope or weakness from pauses', 'سنکوپ یا ضعف ناشی از وقفه.', 'علامت‌دار');
INSERT INTO public.stage VALUES (17, 7, 'Stage 2: Electrical', 'Ventricular arrhythmias', 'آریتمی‌های بطنی.', 'مرحله ۲: الکتریکی');
INSERT INTO public.stage VALUES (19, 8, 'Controlled Rate', 'Ventricular rate <160 bpm', 'ضربان بطنی < ۱۶۰ ضربان در دقیقه.', 'ضربان کنترل‌شده');
INSERT INTO public.stage VALUES (21, 9, 'Small Shunt (Qp:Qs <1.5)', 'Asymptomatic', 'بی‌علامت.', 'شانت کوچک (Qp:Qs < ۱٫۵)');
INSERT INTO public.stage VALUES (22, 9, 'Moderate Shunt (1.5-2.0)', 'Exercise intolerance', 'عدم تحمل ورزش.', 'شانت متوسط (۱٫۵–۲٫۰)');
INSERT INTO public.stage VALUES (24, 10, 'Compensated', 'Junctional rhythm, stable', 'ریتم گرهی، پایدار.', 'جبران‌شده');
INSERT INTO public.stage VALUES (26, 11, 'Early', 'Mild diastolic dysfunction', 'نارسایی دیاستولیک خفیف.', 'ابتدایی');
INSERT INTO public.stage VALUES (28, 12, 'Compensated', 'Effusion without hemodynamic compromise', 'افیوژن بدون ناهماهنگی همودینامیک.', 'جبران‌شده');
INSERT INTO public.stage VALUES (30, 13, 'Localized', 'Asymptomatic mass', 'توده بی‌علامت.', 'موضعی');
INSERT INTO public.stage VALUES (31, 13, 'SVC Syndrome', 'JVD, facial edema', 'ورید ژوگولار پر، ادم صورت.', 'سندرم SVC');
INSERT INTO public.stage VALUES (34, 15, 'Compensated', 'Chronic cough, no PH', 'سرفه مزمن، بدون فشار خون ریوی بالا.', 'جبران‌شده');
INSERT INTO public.stage VALUES (36, 16, 'Mild PH', 'TR jet 3.0-4.0 m/s', 'سرعت جریان تریکوسپید رِگورژیتاسیون ۳٫۰–۴٫۰ m/s.', 'فشار خون ریوی خفیف');
INSERT INTO public.stage VALUES (38, 17, '1st Degree', 'Prolonged PR interval', 'طولانی‌شدن فاصله PR.', 'درجه یک');
INSERT INTO public.stage VALUES (39, 17, '2nd Degree', 'Intermittent non-conducted P-waves', 'امواج P گاه‌به‌گاه غیرهدایتی.', 'درجه دو');
INSERT INTO public.stage VALUES (41, 18, 'Small Shunt', 'Asymptomatic', 'بی‌علامت.', 'شانت کوچک');
INSERT INTO public.stage VALUES (42, 18, 'Large Shunt', 'High-output failure', 'نارسایی دبی بالا.', 'شانت بزرگ');
INSERT INTO public.stage VALUES (45, 20, 'Compensated', 'Mild clinical signs', 'علائم بالینی خفیف.', 'جبران‌شده');
INSERT INTO public.stage VALUES (46, 20, 'Decompensated', 'Thrombosis, hypertension', 'ترومبوز، فشار خون بالا.', 'جبران‌نشده');
INSERT INTO public.stage VALUES (48, 21, 'Diabetic Cardiomyopathy', 'Diastolic dysfunction', 'نارسایی دیاستولیک.', 'کاردیومیوپاتی دیابتی');
INSERT INTO public.stage VALUES (50, 22, 'Overt CHF', 'Pulmonary edema/ascites', 'ادم ریوی/آسیت.', 'نارسایی قلبی آشکار');
INSERT INTO public.stage VALUES (51, 23, 'Mild TR', 'Asymptomatic', 'بی‌علامت.', 'رِگورژیتاسیون تریکوسپید خفیف');
INSERT INTO public.stage VALUES (53, 24, 'Early Cyanosis', 'Mild hypoxemia', 'هیپوکسی خفیف.', 'سیانوز ابتدایی');
INSERT INTO public.stage VALUES (55, 25, 'Infantile', 'Failure to thrive, CHF', 'عدم رشد، نارسایی قلبی.', 'نوزادی');
INSERT INTO public.stage VALUES (56, 26, 'Acute', 'Fever, new murmur', 'تب، هاس جدید.', 'حاد');
INSERT INTO public.stage VALUES (59, 27, 'Chronic', 'Progressive systolic dysfunction', 'نارسایی سیستولیک پیشرونده.', 'مزمن');
INSERT INTO public.stage VALUES (60, 28, 'Class I', 'Asymptomatic or mild cough', 'بی‌علامت یا سرفه خفیف.', 'کلاس I');
INSERT INTO public.stage VALUES (62, 28, 'Class III', 'Severe CHF', 'نارسایی قلبی شدید.', 'کلاس III');
INSERT INTO public.stage VALUES (65, 29, 'Caval Syndrome', 'Same as Class IV heartworm', 'همانند کلاس IV بیماری کرم قلبی.', 'سندرم کاوا');
INSERT INTO public.stage VALUES (66, 30, 'Localized', 'Incidental finding', 'یافته تصادفی.', 'موضعی');
INSERT INTO public.stage VALUES (67, 30, 'Effusion', 'Pericardial tamponade', 'تامپوناد پریکاردی.', 'افیوژن');
INSERT INTO public.stage VALUES (69, 31, 'Mild (iCa 1.4-1.6)', 'Asymptomatic', 'بی‌علامت.', 'خفیف (کلسیم یونیزه ۱٫۴–۱٫۶)');
INSERT INTO public.stage VALUES (71, 32, 'Mild (K+ 5.5-6.0)', 'Asymptomatic', 'بی‌علامت.', 'خفیف (K⁺ ۵٫۵–۶٫۰)');
INSERT INTO public.stage VALUES (73, 32, 'Severe (>6.5)', 'Cardiac arrest risk', 'خطر ایست قلبی.', 'شدید (> ۶٫۵)');
INSERT INTO public.stage VALUES (74, 33, 'Compensated', 'Tachycardia, HCM changes', 'تاکی‌کاردی، تغییرات HCM.', 'جبران‌شده');
INSERT INTO public.stage VALUES (77, 34, 'Mild CHF', 'Lung crackles, mild dyspnea', 'خش‌خش ریه، تنگی نفس خفیف.', 'نارسایی قلبی خفیف');
INSERT INTO public.stage VALUES (79, 35, 'Mild (iCa 0.9-1.0)', 'Asymptomatic', 'بی‌علامت.', 'خفیف (کلسیم یونیزه ۰٫۹–۱٫۰)');
INSERT INTO public.stage VALUES (80, 35, 'Moderate (0.8-0.9)', 'Neuromuscular signs', 'علائم عصبی-عضلانی.', 'متوسط (۰٫۸–۰٫۹)');
INSERT INTO public.stage VALUES (82, 36, 'Mild (K+ 3.0-3.5)', 'Asymptomatic', 'بی‌علامت.', 'خفیف (K⁺ ۳٫۰–۳٫۵)');
INSERT INTO public.stage VALUES (83, 36, 'Moderate (2.5-3.0)', 'Muscle weakness', 'ضعف عضلانی.', 'متوسط (۲٫۵–۳٫۰)');
INSERT INTO public.stage VALUES (85, 37, 'Compensated', 'Mild bradycardia', 'برادی‌کاردی خفیف.', 'جبران‌شده');
INSERT INTO public.stage VALUES (87, 38, 'Localized', 'Pericardial effusion only', 'فقط افیوژن پریکاردی.', 'موضعی');
INSERT INTO public.stage VALUES (88, 38, 'Systemic', 'Multicentric disease', 'بیماری چندمرکزی.', 'سیستمیک');
INSERT INTO public.stage VALUES (90, 39, 'ACVIM B2', 'Murmur + LA/LV enlargement', 'هاس + بزرگی دهلیز/بطن چپ.', 'ACVIM B2');
INSERT INTO public.stage VALUES (92, 39, 'ACVIM D', 'Refractory CHF', 'نارسایی قلبی مقاوم.', 'ACVIM D');
INSERT INTO public.stage VALUES (94, 40, 'Severe', 'Significant MR', 'رِگورژیتاسیون میترال معنادار.', 'شدید');
INSERT INTO public.stage VALUES (137, 64, 'Acyanotic', 'Mild PS, left-to-right shunt', 'تنگی خفیف دریچه ریوی، شانت چپ-به-راست.', 'آسیانوتیک');
INSERT INTO public.stage VALUES (135, 63, 'Compensated Sepsis', 'Fever, tachycardia', NULL, NULL);
INSERT INTO public.stage VALUES (136, 63, 'Septic Shock', 'Hypotension, organ failure', NULL, NULL);
INSERT INTO public.stage VALUES (1, 1, 'Compensated', 'Mild anemia (Hct 25-30%), no cardiac signs', 'کم‌خونی خفیف (هماتوکریت ۲۵–۳۰٪)، بدون علائم قلبی.', 'جبران‌شده');
INSERT INTO public.stage VALUES (2, 1, 'Decompensated', 'Severe anemia (Hct <20%), high-output failure', 'کم‌خونی شدید (هماتوکریت < ۲۰٪)، نارسایی دبی بالا.', 'جبران‌نشده');
INSERT INTO public.stage VALUES (5, 2, 'Ruptured', 'Acute hemorrhage, shock', 'خونریزی حاد، شوک.', 'پاره‌شده');
INSERT INTO public.stage VALUES (7, 3, 'Chronic', 'Stabilized dissection, risk of rupture', 'دیسکسیون تثبیت‌شده، خطر پارگی.', 'مزمن');
INSERT INTO public.stage VALUES (9, 4, 'Moderate (50-80 mmHg)', 'Exercise intolerance', 'عدم تحمل ورزش.', 'متوسط (۵۰–۸۰ mmHg)');
INSERT INTO public.stage VALUES (11, 5, 'Acute (<12h)', 'Sudden paralysis, vocalization', 'فلج ناگهانی، صدازدن.', 'حاد (<۱۲ ساعت)');
INSERT INTO public.stage VALUES (13, 5, 'Chronic (>72h)', 'Reperfusion injury or resolution', 'آسیب ناشی از دوباره‌خونرسانی یا بهبودی.', 'مزمن (> ۷۲ ساعت)');
INSERT INTO public.stage VALUES (16, 7, 'Stage 1: Concealed', 'No symptoms, VPCs on Holter', 'بدون علامت، VPC در هولتر.', 'مرحله ۱: پنهان');
INSERT INTO public.stage VALUES (18, 7, 'Stage 3: Structural', 'RV dysfunction, CHF', 'نارسایی بطن راست، نارسایی قلبی.', 'مرحله ۳: ساختاری');
INSERT INTO public.stage VALUES (20, 8, 'Uncontrolled Rate', 'Ventricular rate >180 bpm, tachycardia-induced cardiomyopathy', 'ضربان بطنی > ۱۸۰ ضربان در دقیقه، کاردیومیوپاتی ناشی از تاکی‌کاردی.', 'ضربان کنترل‌نشده');
INSERT INTO public.stage VALUES (23, 9, 'Large Shunt (>2.0)', 'Right heart failure', 'نارسایی قلب راست.', 'شانت بزرگ (> ۲٫۰)');
INSERT INTO public.stage VALUES (25, 10, 'Decompensated', 'Bradycardia, low cardiac output', 'برادی‌کاردی، دبی قلبی پایین.', 'جبران‌نشده');
INSERT INTO public.stage VALUES (27, 11, 'Late', 'Restrictive physiology, effusions', 'فیزیولوژی محدودکننده، افیوژن.', 'پایانی');
INSERT INTO public.stage VALUES (29, 12, 'Decompensated', 'Tamponade physiology', 'فیزیولوژی تامپوناد.', 'جبران‌نشده');
INSERT INTO public.stage VALUES (32, 14, 'IRIS Stage 2', 'Mild hypertension', 'فشار خون بالای خفیف.', 'مرحله ۲ IRIS');
INSERT INTO public.stage VALUES (33, 14, 'IRIS Stage 3-4', 'Severe hypertension, LVH', 'فشار خون بالای شدید، هایپرتروفی بطن چپ.', 'مراحل ۳–۴ IRIS');
INSERT INTO public.stage VALUES (35, 15, 'Decompensated', 'Cor pulmonale, right heart failure', 'کُر پولموناله، نارسایی قلب راست.', 'جبران‌نشده');
INSERT INTO public.stage VALUES (37, 16, 'Severe PH', 'TR jet >4.5 m/s, right heart failure', 'سرعت جریان تریکوسپید رِگورژیتاسیون > ۴٫۵ m/s، نارسایی قلب راست.', 'فشار خون ریوی شدید');
INSERT INTO public.stage VALUES (40, 17, '3rd Degree', 'Complete AV dissociation', 'جدایی کامل AV.', 'درجه سه');
INSERT INTO public.stage VALUES (43, 19, 'Mild Obstruction', 'Asymptomatic', 'بی‌علامت.', 'اُنسداد خفیف');
INSERT INTO public.stage VALUES (44, 19, 'Severe Obstruction', 'Pulmonary venous hypertension', 'فشار خون وریدی ریوی بالا.', 'اُنسداد شدید');
INSERT INTO public.stage VALUES (47, 21, 'Well-Controlled', 'No cardiac involvement', 'بدون درگیری قلبی.', 'کنترل‌شده');
INSERT INTO public.stage VALUES (49, 22, 'Preclinical', 'Echocardiographic changes only', 'تغییرات فقط در اکوکاردیوگرافی.', 'پیش‌بالینی');
INSERT INTO public.stage VALUES (97, 42, 'Early', 'Valve thickening only', 'فقط ضخیم‌شدگی دریچه.', 'ابتدایی');
INSERT INTO public.stage VALUES (100, 44, 'Compensated', 'Left heart volume overload', 'بار حجمی بطن چپ.', 'جبران‌شده');
INSERT INTO public.stage VALUES (101, 44, 'Decompensated', 'CHF before 1 year', 'نارسایی قلبی قبل از ۱ سالگی.', 'جبران‌نشده');
INSERT INTO public.stage VALUES (103, 45, 'Provoked Shunting', 'Right-to-left under stress', 'شانت راست-به-چپ تحت استرس.', 'شانت القایی');
INSERT INTO public.stage VALUES (104, 46, 'Small', 'Asymptomatic', 'بی‌علامت.', 'کوچک');
INSERT INTO public.stage VALUES (106, 46, 'Large', 'Overt tamponade', 'تامپوناد آشکار.', 'بزرگ');
INSERT INTO public.stage VALUES (108, 48, 'Acute', 'Chest pain, fever', 'درد سینه، تب.', 'حاد');
INSERT INTO public.stage VALUES (109, 48, 'Chronic Constrictive', 'Diastolic failure', 'نارسایی دیاستولیک.', 'مزمن محدودکننده');
INSERT INTO public.stage VALUES (111, 49, 'Severe Ischemia', 'Tissue necrosis', 'نکروز بافتی.', 'ایسکمی شدید');
INSERT INTO public.stage VALUES (113, 50, 'Severe (>80 mmHg)', 'Right heart failure', 'نارسایی قلب راست.', 'شدید (> ۸۰ mmHg)');
INSERT INTO public.stage VALUES (114, 51, 'Submassive', 'Moderate hypoxemia', 'هیپوکسی متوسط.', 'زیرماژنوم');
INSERT INTO public.stage VALUES (117, 52, 'Severe (>4.5)', 'Right heart failure', 'نارسایی قلب راست.', 'شدید (> ۴٫۵)');
INSERT INTO public.stage VALUES (118, 53, 'Acute', 'Sudden dyspnea', 'تنگی نفس ناگهانی.', 'حاد');
INSERT INTO public.stage VALUES (119, 53, 'Chronic', 'Cor pulmonale', 'کُر پولموناله.', 'مزمن');
INSERT INTO public.stage VALUES (120, 54, 'Mild', 'Asymptomatic', 'بی‌علامت.', 'خفیف');
INSERT INTO public.stage VALUES (123, 56, 'Early', 'Diastolic dysfunction only', 'فقط نارسایی دیاستولیک.', 'ابتدایی');
INSERT INTO public.stage VALUES (124, 56, 'Late', 'Biatrial enlargement, effusions', 'بزرگی دو دهلیز، افیوژن.', 'پایانی');
INSERT INTO public.stage VALUES (126, 58, 'Compensated', 'Tachycardia, normal BP', 'تب، تاکی‌کاردی.', 'سپسیس جبران‌شده');
INSERT INTO public.stage VALUES (128, 59, 'Asymptomatic', 'Bradycardia only', 'فقط برادی‌کاردی.', 'بی‌علامت');
INSERT INTO public.stage VALUES (129, 59, 'Symptomatic', 'Syncope from asystole', 'سنکوپ ناشی از آسیستول.', 'علامت‌دار');
INSERT INTO public.stage VALUES (131, 61, 'Mild (SBP 150-159)', 'No target organ damage', 'بدون آسیب عضو هدف.', 'خفیف (فشار سیستولی ۱۵۰–۱۵۹)');
INSERT INTO public.stage VALUES (133, 61, 'Severe (>180)', 'End-organ damage', 'آسیب انتهایی اندام.', 'شدید (> ۱۸۰)');
INSERT INTO public.stage VALUES (138, 64, 'Cyanotic', 'Right-to-left shunt', 'شانت راست-به-چپ.', 'سیانوتیک');
INSERT INTO public.stage VALUES (139, 65, 'Mild TR', 'Asymptomatic', 'بی‌علامت.', 'رِگورژیتاسیون تریکوسپید خفیف');
INSERT INTO public.stage VALUES (141, 66, 'Mild Compression', 'Regurgitation after weaning', 'رِگورژیتاسیون پس از فطام.', 'فشار خفیف');
INSERT INTO public.stage VALUES (143, 67, 'Cutaneous', 'Skin ulcers, necrosis', 'زخم‌های پوستی، نکروز.', 'پوستی');
INSERT INTO public.stage VALUES (144, 67, 'Systemic', 'Multi-organ involvement', 'درگیری چند اندام.', 'سیستمیک');
INSERT INTO public.stage VALUES (147, 69, 'Small', 'Asymptomatic', 'بی‌علامت.', 'کوچک');
INSERT INTO public.stage VALUES (148, 69, 'Large', 'Pulmonary overcirculation', 'افزایش جریان ریوی.', 'بزرگ');
INSERT INTO public.stage VALUES (52, 23, 'Severe TR', 'Right heart failure', 'نارسایی قلب راست.', 'رِگورژیتاسیون تریکوسپید شدید');
INSERT INTO public.stage VALUES (54, 24, 'Advanced', 'Polycythemia, syncope', 'پلی‌سیتمی، سنکوپ.', 'پیشرفته');
INSERT INTO public.stage VALUES (57, 26, 'Complicated', 'Embolization, CHF', 'امبولی، نارسایی قلبی.', 'پیچیده');
INSERT INTO public.stage VALUES (58, 27, 'Acute Fulminant', 'Rapid CHF onset', 'شروع ناگهانی نارسایی قلبی.', 'فولمینان حاد');
INSERT INTO public.stage VALUES (61, 28, 'Class II', 'Moderate symptoms', 'علائم متوسط.', 'کلاس II');
INSERT INTO public.stage VALUES (63, 28, 'Caval Syndrome', 'Worms in RA/RV', 'کرم‌ها در دهلیز/بطن راست.', 'سندرم کاوا');
INSERT INTO public.stage VALUES (64, 29, 'Pulmonary Hypertension', 'TR jet >3.5 m/s', 'سرعت جریان تریکوسپید رِگورژیتاسیون > ۳٫۵ m/s.', 'فشار خون ریوی بالا');
INSERT INTO public.stage VALUES (68, 30, 'Metastatic', 'Systemic spread', 'گسترش سیستمیک.', 'متاستاتیک');
INSERT INTO public.stage VALUES (70, 31, 'Severe (iCa >1.8)', 'Cardiac/neurologic signs', 'علائم قلبی/عصبی.', 'شدید (کلسیم یونیزه > ۱٫۸)');
INSERT INTO public.stage VALUES (72, 32, 'Moderate (6.0-6.5)', 'ECG changes', 'تغییرات نوار قلب.', 'متوسط (۶٫۰–۶٫۵)');
INSERT INTO public.stage VALUES (75, 33, 'Decompensated', 'CHF or thromboembolism', 'نارسایی قلبی یا ترومبومبولی.', 'جبران‌نشده');
INSERT INTO public.stage VALUES (76, 34, 'Asymptomatic', 'LVH on echo, no signs', 'هایپرتروفی بطن چپ در اکوکاردیوگرافی، بدون علامت.', 'بی‌علامت');
INSERT INTO public.stage VALUES (78, 34, 'Overt CHF/Thromboembolism', 'Pulmonary edema or saddle thrombus', 'ادم ریوی یا ترومب سرجوخ.', 'نارسایی قلبی آشکار/ترومبومبولی');
INSERT INTO public.stage VALUES (81, 35, 'Severe (<0.8)', 'Seizures, cardiac arrest', 'تشنج، ایست قلبی.', 'شدید (< ۰٫۸)');
INSERT INTO public.stage VALUES (84, 36, 'Severe (<2.5)', 'Respiratory paralysis', 'فلج تنفسی.', 'شدید (< ۲٫۵)');
INSERT INTO public.stage VALUES (86, 37, 'Decompensated', 'CHF (rare)', 'نارسایی قلبی (نادر).', 'جبران‌نشده');
INSERT INTO public.stage VALUES (89, 39, 'ACVIM B1', 'Murmur, no remodeling', 'هاس، بدون تغییر ساختاری.', 'ACVIM B1');
INSERT INTO public.stage VALUES (91, 39, 'ACVIM C', 'Current/past CHF', 'نارسایی قلبی کنونی یا گذشته.', 'ACVIM C');
INSERT INTO public.stage VALUES (93, 40, 'Mild', 'Asymptomatic prolapse', 'پرولاپس بی‌علامت.', 'خفیف');
INSERT INTO public.stage VALUES (95, 41, 'Acute', 'Sudden CHF onset', 'شروع ناگهانی نارسایی قلبی.', 'حاد');
INSERT INTO public.stage VALUES (96, 41, 'Chronic', 'Dilated phenotype', 'الگوی اتساعی.', 'مزمن');
INSERT INTO public.stage VALUES (98, 42, 'Advanced', 'Valve prolapse, regurgitation', 'پرولاپس دریچه، رِگورژیتاسیون.', 'پیشرفته');
INSERT INTO public.stage VALUES (99, 43, 'Same as MVD', 'Clinical synonym', 'مترادف بالینی.', 'همانند بیماری دریچه میترال');
INSERT INTO public.stage VALUES (102, 45, 'Asymptomatic', 'No shunting at rest', 'بدون شانت در حالت استراحت.', 'بی‌علامت');
INSERT INTO public.stage VALUES (105, 46, 'Moderate', 'Compensated tamponade', 'تامپوناد جبران‌شده.', 'متوسط');
INSERT INTO public.stage VALUES (107, 47, 'Same as Pericardial Effusion', 'Idiopathic/benign course', 'مسیر ایدیوپاتیک/خوش‌خیم.', 'همانند افیوژن پریکاردی');
INSERT INTO public.stage VALUES (110, 49, 'Mild Ischemia', 'Cool limbs, weak pulses', 'اندام‌های سرد، نبض ضعیف.', 'ایسکمی خفیف');
INSERT INTO public.stage VALUES (112, 50, 'Mild (Gradient <50 mmHg)', 'Asymptomatic', 'بی‌علامت.', 'خفیف (گرادیان < ۵۰ mmHg)');
INSERT INTO public.stage VALUES (115, 51, 'Massive', 'Cardiovascular collapse', 'فروریزت سیستم قلبی-عروقی.', 'ماژنوم');
INSERT INTO public.stage VALUES (116, 52, 'Mild (TR jet 3.0-3.5)', 'Exercise intolerance', 'عدم تحمل ورزش.', 'خفیف (سرعت جریان تریکوسپید رِگورژیتاسیون ۳٫۰–۳٫۵)');
INSERT INTO public.stage VALUES (121, 54, 'Severe', 'RV failure', 'نارسایی بطن راست.', 'شدید');
INSERT INTO public.stage VALUES (122, 55, 'Same as Pulmonary Artery Stenosis', 'Valvular subtype', 'زیرگروه دریچه‌ای.', 'همانند تنگی شریان ریوی');
INSERT INTO public.stage VALUES (125, 57, 'Same as ARVC', 'Breed-specific ARVC', 'ARVC وابسته به نژاد.', 'همانند ARVC');
INSERT INTO public.stage VALUES (127, 58, 'Decompensated', 'Myocardial depression', 'هیپوتانسیون، نارسایی اندام.', 'شوک سپتیک');
INSERT INTO public.stage VALUES (130, 60, 'Same as Aortic Stenosis', 'Subvalvular subtype', 'زیرگروه زیردریچه‌ای.', 'همانند تنگی آئورت');
INSERT INTO public.stage VALUES (132, 61, 'Moderate (160-179)', 'Retinal changes', 'تغییرات شبکیه.', 'متوسط (۱۶۰–۱۷۹)');
INSERT INTO public.stage VALUES (134, 62, 'Same as Systemic Hypertension', 'Secondary etiology', 'علت ثانویه.', 'همانند فشار خون سیستمیک بالا');
INSERT INTO public.stage VALUES (140, 65, 'Severe TR', 'Right heart failure', 'نارسایی قلب راست.', 'رِگورژیتاسیون تریکوسپید شدید');
INSERT INTO public.stage VALUES (142, 66, 'Severe Compression', 'Dysphagia, aspiration', 'ناهنجاری بلع، آسپیراسیون.', 'فشار شدید');
INSERT INTO public.stage VALUES (145, 68, 'Benign', '<50 VPCs/24h', '< ۵۰ VPC در ۲۴ ساعت.', 'خوش‌خیم');
INSERT INTO public.stage VALUES (146, 68, 'Malignant', '>1000 VPCs/24h or VT', '> ۱۰۰۰ VPC در ۲۴ ساعت یا تاکی‌کاردی بطنی.', 'بدخیم');


--
-- Data for Name: stage_symptom_enums; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.stage_symptom_enums VALUES (1, 'WEAKNESS');
INSERT INTO public.stage_symptom_enums VALUES (1, 'LETHARGY');
INSERT INTO public.stage_symptom_enums VALUES (2, 'DYSPNEA');
INSERT INTO public.stage_symptom_enums VALUES (2, 'TACHYCARDIA');
INSERT INTO public.stage_symptom_enums VALUES (2, 'PALE_GUMS');
INSERT INTO public.stage_symptom_enums VALUES (3, 'NONE');
INSERT INTO public.stage_symptom_enums VALUES (4, 'COUGHING');
INSERT INTO public.stage_symptom_enums VALUES (4, 'DYSPNEA');
INSERT INTO public.stage_symptom_enums VALUES (5, 'COLLAPSE');
INSERT INTO public.stage_symptom_enums VALUES (5, 'SHOCK');
INSERT INTO public.stage_symptom_enums VALUES (5, 'SUDDEN_DEATH');
INSERT INTO public.stage_symptom_enums VALUES (6, 'PAIN_IN_CHEST_OR_ABDOMEN');
INSERT INTO public.stage_symptom_enums VALUES (6, 'BRADYCARDIA');
INSERT INTO public.stage_symptom_enums VALUES (6, 'COLLAPSE');
INSERT INTO public.stage_symptom_enums VALUES (7, 'WEAKNESS');
INSERT INTO public.stage_symptom_enums VALUES (7, 'EXERCISE_INTOLERANCE');
INSERT INTO public.stage_symptom_enums VALUES (8, 'HEART_MURMUR');
INSERT INTO public.stage_symptom_enums VALUES (9, 'EXERCISE_INTOLERANCE');
INSERT INTO public.stage_symptom_enums VALUES (9, 'WEAKNESS');
INSERT INTO public.stage_symptom_enums VALUES (10, 'SYNCOPE');
INSERT INTO public.stage_symptom_enums VALUES (10, 'DYSPNEA');
INSERT INTO public.stage_symptom_enums VALUES (10, 'SUDDEN_DEATH');
INSERT INTO public.stage_symptom_enums VALUES (11, 'HIND_LIMB_PARALYSIS');
INSERT INTO public.stage_symptom_enums VALUES (11, 'PAINFUL_LIMBS');
INSERT INTO public.stage_symptom_enums VALUES (11, 'COLD_EXTREMITIES');
INSERT INTO public.stage_symptom_enums VALUES (12, 'WEAKNESS');
INSERT INTO public.stage_symptom_enums VALUES (12, 'DYSPNEA');
INSERT INTO public.stage_symptom_enums VALUES (12, 'PAINFUL_LIMBS');
INSERT INTO public.stage_symptom_enums VALUES (13, 'LAMENESS');
INSERT INTO public.stage_symptom_enums VALUES (13, 'MUSCLE_WEAKNESS');
INSERT INTO public.stage_symptom_enums VALUES (14, 'NONE');
INSERT INTO public.stage_symptom_enums VALUES (15, 'SYNCOPE');
INSERT INTO public.stage_symptom_enums VALUES (15, 'WEAKNESS');
INSERT INTO public.stage_symptom_enums VALUES (15, 'IRREGULAR_HEART_RATE');
INSERT INTO public.stage_symptom_enums VALUES (16, 'NONE');
INSERT INTO public.stage_symptom_enums VALUES (17, 'SYNCOPE');
INSERT INTO public.stage_symptom_enums VALUES (17, 'VENTRICULAR_ARRHYTHMIAS');
INSERT INTO public.stage_symptom_enums VALUES (18, 'DYSPNEA');
INSERT INTO public.stage_symptom_enums VALUES (18, 'ASCITES');
INSERT INTO public.stage_symptom_enums VALUES (18, 'SUDDEN_DEATH');
INSERT INTO public.stage_symptom_enums VALUES (19, 'HEART_MURMUR');
INSERT INTO public.stage_symptom_enums VALUES (19, 'EXERCISE_INTOLERANCE');
INSERT INTO public.stage_symptom_enums VALUES (20, 'DYSPNEA');
INSERT INTO public.stage_symptom_enums VALUES (20, 'WEAKNESS');
INSERT INTO public.stage_symptom_enums VALUES (20, 'COLLAPSE');
INSERT INTO public.stage_symptom_enums VALUES (21, 'HEART_MURMUR');
INSERT INTO public.stage_symptom_enums VALUES (22, 'EXERCISE_INTOLERANCE');
INSERT INTO public.stage_symptom_enums VALUES (22, 'WEAKNESS');
INSERT INTO public.stage_symptom_enums VALUES (23, 'DYSPNEA');
INSERT INTO public.stage_symptom_enums VALUES (23, 'ASCITES');
INSERT INTO public.stage_symptom_enums VALUES (23, 'JUGULAR_VEIN_DISTENSION');
INSERT INTO public.stage_symptom_enums VALUES (24, 'NONE');
INSERT INTO public.stage_symptom_enums VALUES (25, 'WEAKNESS');
INSERT INTO public.stage_symptom_enums VALUES (25, 'SYNCOPE');
INSERT INTO public.stage_symptom_enums VALUES (25, 'BRADYCARDIA');
INSERT INTO public.stage_symptom_enums VALUES (26, 'LETHARGY');
INSERT INTO public.stage_symptom_enums VALUES (26, 'EXERCISE_INTOLERANCE');
INSERT INTO public.stage_symptom_enums VALUES (27, 'DYSPNEA');
INSERT INTO public.stage_symptom_enums VALUES (27, 'ASCITES');
INSERT INTO public.stage_symptom_enums VALUES (27, 'JUGULAR_VEIN_DISTENSION');
INSERT INTO public.stage_symptom_enums VALUES (28, 'LETHARGY');
INSERT INTO public.stage_symptom_enums VALUES (28, 'WEAK_PULSE');
INSERT INTO public.stage_symptom_enums VALUES (29, 'SYNCOPE');
INSERT INTO public.stage_symptom_enums VALUES (29, 'MUFFLED_HEART_SOUNDS');
INSERT INTO public.stage_symptom_enums VALUES (29, 'JUGULAR_VEIN_DISTENSION');
INSERT INTO public.stage_symptom_enums VALUES (29, 'COLLAPSE');
INSERT INTO public.stage_symptom_enums VALUES (30, 'NONE');
INSERT INTO public.stage_symptom_enums VALUES (31, 'JUGULAR_VEIN_DISTENSION');
INSERT INTO public.stage_symptom_enums VALUES (31, 'DYSPNEA');
INSERT INTO public.stage_symptom_enums VALUES (31, 'COUGHING');
INSERT INTO public.stage_symptom_enums VALUES (32, 'HYPERTENSION');
INSERT INTO public.stage_symptom_enums VALUES (32, 'WEIGHT_LOSS');
INSERT INTO public.stage_symptom_enums VALUES (33, 'SUDDEN_BLINDNESS');
INSERT INTO public.stage_symptom_enums VALUES (33, 'DYSPNEA');
INSERT INTO public.stage_symptom_enums VALUES (33, 'WEAKNESS');
INSERT INTO public.stage_symptom_enums VALUES (34, 'COUGHING');
INSERT INTO public.stage_symptom_enums VALUES (34, 'LETHARGY');
INSERT INTO public.stage_symptom_enums VALUES (35, 'DYSPNEA');
INSERT INTO public.stage_symptom_enums VALUES (35, 'ASCITES');
INSERT INTO public.stage_symptom_enums VALUES (35, 'JUGULAR_VEIN_DISTENSION');
INSERT INTO public.stage_symptom_enums VALUES (36, 'EXERCISE_INTOLERANCE');
INSERT INTO public.stage_symptom_enums VALUES (36, 'LETHARGY');
INSERT INTO public.stage_symptom_enums VALUES (37, 'DYSPNEA');
INSERT INTO public.stage_symptom_enums VALUES (37, 'SYNCOPE');
INSERT INTO public.stage_symptom_enums VALUES (37, 'ASCITES');
INSERT INTO public.stage_symptom_enums VALUES (38, 'NONE');
INSERT INTO public.stage_symptom_enums VALUES (39, 'WEAKNESS');
INSERT INTO public.stage_symptom_enums VALUES (39, 'EXERCISE_INTOLERANCE');
INSERT INTO public.stage_symptom_enums VALUES (40, 'SYNCOPE');
INSERT INTO public.stage_symptom_enums VALUES (40, 'BRADYCARDIA');
INSERT INTO public.stage_symptom_enums VALUES (40, 'COLLAPSE');
INSERT INTO public.stage_symptom_enums VALUES (41, 'HEART_MURMUR');
INSERT INTO public.stage_symptom_enums VALUES (42, 'DYSPNEA');
INSERT INTO public.stage_symptom_enums VALUES (42, 'WEAKNESS');
INSERT INTO public.stage_symptom_enums VALUES (42, 'SWELLING');
INSERT INTO public.stage_symptom_enums VALUES (43, 'NONE');
INSERT INTO public.stage_symptom_enums VALUES (44, 'DYSPNEA');
INSERT INTO public.stage_symptom_enums VALUES (44, 'COUGHING');
INSERT INTO public.stage_symptom_enums VALUES (44, 'JUGULAR_VEIN_DISTENSION');
INSERT INTO public.stage_symptom_enums VALUES (45, 'WEIGHT_GAIN');
INSERT INTO public.stage_symptom_enums VALUES (45, 'POLYURIA');
INSERT INTO public.stage_symptom_enums VALUES (45, 'POLYDIPSIA');
INSERT INTO public.stage_symptom_enums VALUES (46, 'DYSPNEA');
INSERT INTO public.stage_symptom_enums VALUES (46, 'HIND_LIMB_PARALYSIS');
INSERT INTO public.stage_symptom_enums VALUES (46, 'SUDDEN_BLINDNESS');
INSERT INTO public.stage_symptom_enums VALUES (47, 'POLYURIA');
INSERT INTO public.stage_symptom_enums VALUES (47, 'POLYDIPSIA');
INSERT INTO public.stage_symptom_enums VALUES (48, 'DYSPNEA');
INSERT INTO public.stage_symptom_enums VALUES (48, 'EXERCISE_INTOLERANCE');
INSERT INTO public.stage_symptom_enums VALUES (48, 'WEAKNESS');
INSERT INTO public.stage_symptom_enums VALUES (49, 'HEART_MURMUR');
INSERT INTO public.stage_symptom_enums VALUES (49, 'TACHYCARDIA');
INSERT INTO public.stage_symptom_enums VALUES (50, 'DYSPNEA');
INSERT INTO public.stage_symptom_enums VALUES (50, 'COUGHING');
INSERT INTO public.stage_symptom_enums VALUES (50, 'ASCITES');
INSERT INTO public.stage_symptom_enums VALUES (50, 'COLLAPSE');
INSERT INTO public.stage_symptom_enums VALUES (51, 'HEART_MURMUR');
INSERT INTO public.stage_symptom_enums VALUES (52, 'DYSPNEA');
INSERT INTO public.stage_symptom_enums VALUES (52, 'ASCITES');
INSERT INTO public.stage_symptom_enums VALUES (52, 'JUGULAR_VEIN_DISTENSION');
INSERT INTO public.stage_symptom_enums VALUES (53, 'CYANOSIS');
INSERT INTO public.stage_symptom_enums VALUES (53, 'EXERCISE_INTOLERANCE');
INSERT INTO public.stage_symptom_enums VALUES (54, 'CYANOSIS');
INSERT INTO public.stage_symptom_enums VALUES (54, 'SYNCOPE');
INSERT INTO public.stage_symptom_enums VALUES (54, 'WEAKNESS');
INSERT INTO public.stage_symptom_enums VALUES (55, 'DYSPNEA');
INSERT INTO public.stage_symptom_enums VALUES (55, 'FAILURE_TO_THRIVE');
INSERT INTO public.stage_symptom_enums VALUES (55, 'SUDDEN_DEATH');
INSERT INTO public.stage_symptom_enums VALUES (56, 'FEVER');
INSERT INTO public.stage_symptom_enums VALUES (56, 'HEART_MURMUR');
INSERT INTO public.stage_symptom_enums VALUES (56, 'LETHARGY');
INSERT INTO public.stage_symptom_enums VALUES (57, 'DYSPNEA');
INSERT INTO public.stage_symptom_enums VALUES (57, 'SUDDEN_DEATH');
INSERT INTO public.stage_symptom_enums VALUES (57, 'WEAKNESS');
INSERT INTO public.stage_symptom_enums VALUES (58, 'DYSPNEA');
INSERT INTO public.stage_symptom_enums VALUES (58, 'COLLAPSE');
INSERT INTO public.stage_symptom_enums VALUES (58, 'SUDDEN_DEATH');
INSERT INTO public.stage_symptom_enums VALUES (59, 'WEAKNESS');
INSERT INTO public.stage_symptom_enums VALUES (59, 'LETHARGY');
INSERT INTO public.stage_symptom_enums VALUES (59, 'DYSPNEA');
INSERT INTO public.stage_symptom_enums VALUES (60, 'COUGHING');
INSERT INTO public.stage_symptom_enums VALUES (60, 'LETHARGY');
INSERT INTO public.stage_symptom_enums VALUES (61, 'COUGHING');
INSERT INTO public.stage_symptom_enums VALUES (61, 'DYSPNEA');
INSERT INTO public.stage_symptom_enums VALUES (61, 'WEAKNESS');
INSERT INTO public.stage_symptom_enums VALUES (62, 'DYSPNEA');
INSERT INTO public.stage_symptom_enums VALUES (62, 'HEMOPTYSIS');
INSERT INTO public.stage_symptom_enums VALUES (62, 'JUGULAR_VEIN_DISTENSION');
INSERT INTO public.stage_symptom_enums VALUES (63, 'COLLAPSE');
INSERT INTO public.stage_symptom_enums VALUES (63, 'HEMOGLOBINURIA');
INSERT INTO public.stage_symptom_enums VALUES (63, 'SUDDEN_DEATH');
INSERT INTO public.stage_symptom_enums VALUES (64, 'DYSPNEA');
INSERT INTO public.stage_symptom_enums VALUES (64, 'SYNCOPE');
INSERT INTO public.stage_symptom_enums VALUES (65, 'COLLAPSE');
INSERT INTO public.stage_symptom_enums VALUES (65, 'HEMOGLOBINURIA');
INSERT INTO public.stage_symptom_enums VALUES (65, 'SUDDEN_DEATH');
INSERT INTO public.stage_symptom_enums VALUES (66, 'NONE');
INSERT INTO public.stage_symptom_enums VALUES (67, 'SYNCOPE');
INSERT INTO public.stage_symptom_enums VALUES (67, 'MUFFLED_HEART_SOUNDS');
INSERT INTO public.stage_symptom_enums VALUES (67, 'WEAK_PULSE');
INSERT INTO public.stage_symptom_enums VALUES (68, 'WEAKNESS');
INSERT INTO public.stage_symptom_enums VALUES (68, 'PALLOR');
INSERT INTO public.stage_symptom_enums VALUES (68, 'SUDDEN_DEATH');
INSERT INTO public.stage_symptom_enums VALUES (69, 'NONE');
INSERT INTO public.stage_symptom_enums VALUES (70, 'WEAKNESS');
INSERT INTO public.stage_symptom_enums VALUES (70, 'BRADYCARDIA');
INSERT INTO public.stage_symptom_enums VALUES (70, 'SHOCK');
INSERT INTO public.stage_symptom_enums VALUES (71, 'NONE');
INSERT INTO public.stage_symptom_enums VALUES (72, 'WEAKNESS');
INSERT INTO public.stage_symptom_enums VALUES (72, 'BRADYCARDIA');
INSERT INTO public.stage_symptom_enums VALUES (73, 'COLLAPSE');
INSERT INTO public.stage_symptom_enums VALUES (73, 'FLACCID_PARALYSIS');
INSERT INTO public.stage_symptom_enums VALUES (73, 'ASYSTOLE');
INSERT INTO public.stage_symptom_enums VALUES (74, 'TACHYCARDIA');
INSERT INTO public.stage_symptom_enums VALUES (74, 'WEIGHT_LOSS');
INSERT INTO public.stage_symptom_enums VALUES (74, 'HEART_MURMUR');
INSERT INTO public.stage_symptom_enums VALUES (75, 'DYSPNEA');
INSERT INTO public.stage_symptom_enums VALUES (75, 'HIND_LIMB_PARALYSIS');
INSERT INTO public.stage_symptom_enums VALUES (75, 'SUDDEN_DEATH');
INSERT INTO public.stage_symptom_enums VALUES (76, 'HEART_MURMUR');
INSERT INTO public.stage_symptom_enums VALUES (76, 'TACHYCARDIA');
INSERT INTO public.stage_symptom_enums VALUES (77, 'DYSPNEA');
INSERT INTO public.stage_symptom_enums VALUES (77, 'LETHARGY');
INSERT INTO public.stage_symptom_enums VALUES (77, 'EXERCISE_INTOLERANCE');
INSERT INTO public.stage_symptom_enums VALUES (78, 'DYSPNEA');
INSERT INTO public.stage_symptom_enums VALUES (78, 'SYNCOPE');
INSERT INTO public.stage_symptom_enums VALUES (78, 'HIND_LIMB_PARALYSIS');
INSERT INTO public.stage_symptom_enums VALUES (78, 'PAINFUL_LIMBS');
INSERT INTO public.stage_symptom_enums VALUES (79, 'NONE');
INSERT INTO public.stage_symptom_enums VALUES (80, 'MUSCLE_TREMORS');
INSERT INTO public.stage_symptom_enums VALUES (80, 'PAINFUL_LIMBS');
INSERT INTO public.stage_symptom_enums VALUES (81, 'SEIZURES');
INSERT INTO public.stage_symptom_enums VALUES (81, 'BRADYCARDIA');
INSERT INTO public.stage_symptom_enums VALUES (81, 'SHOCK');
INSERT INTO public.stage_symptom_enums VALUES (82, 'NONE');
INSERT INTO public.stage_symptom_enums VALUES (83, 'MUSCLE_WEAKNESS');
INSERT INTO public.stage_symptom_enums VALUES (83, 'LETHARGY');
INSERT INTO public.stage_symptom_enums VALUES (84, 'DYSPNEA');
INSERT INTO public.stage_symptom_enums VALUES (84, 'FLACCID_PARALYSIS');
INSERT INTO public.stage_symptom_enums VALUES (84, 'COLLAPSE');
INSERT INTO public.stage_symptom_enums VALUES (85, 'LETHARGY');
INSERT INTO public.stage_symptom_enums VALUES (85, 'WEIGHT_GAIN');
INSERT INTO public.stage_symptom_enums VALUES (85, 'BRADYCARDIA');
INSERT INTO public.stage_symptom_enums VALUES (86, 'DYSPNEA');
INSERT INTO public.stage_symptom_enums VALUES (86, 'WEAKNESS');
INSERT INTO public.stage_symptom_enums VALUES (86, 'ASCITES');
INSERT INTO public.stage_symptom_enums VALUES (87, 'LETHARGY');
INSERT INTO public.stage_symptom_enums VALUES (87, 'JUGULAR_VEIN_DISTENSION');
INSERT INTO public.stage_symptom_enums VALUES (88, 'WEIGHT_LOSS');
INSERT INTO public.stage_symptom_enums VALUES (88, 'DYSPNEA');
INSERT INTO public.stage_symptom_enums VALUES (88, 'SUDDEN_DEATH');
INSERT INTO public.stage_symptom_enums VALUES (89, 'HEART_MURMUR');
INSERT INTO public.stage_symptom_enums VALUES (90, 'COUGHING');
INSERT INTO public.stage_symptom_enums VALUES (90, 'HEART_MURMUR');
INSERT INTO public.stage_symptom_enums VALUES (91, 'DYSPNEA');
INSERT INTO public.stage_symptom_enums VALUES (91, 'COUGHING');
INSERT INTO public.stage_symptom_enums VALUES (91, 'PANTING');
INSERT INTO public.stage_symptom_enums VALUES (91, 'LETHARGY');
INSERT INTO public.stage_symptom_enums VALUES (92, 'DYSPNEA');
INSERT INTO public.stage_symptom_enums VALUES (92, 'ORTHOPNOEA');
INSERT INTO public.stage_symptom_enums VALUES (92, 'ASCITES');
INSERT INTO public.stage_symptom_enums VALUES (93, 'HEART_MURMUR');
INSERT INTO public.stage_symptom_enums VALUES (94, 'DYSPNEA');
INSERT INTO public.stage_symptom_enums VALUES (94, 'EXERCISE_INTOLERANCE');
INSERT INTO public.stage_symptom_enums VALUES (95, 'DYSPNEA');
INSERT INTO public.stage_symptom_enums VALUES (95, 'COLLAPSE');
INSERT INTO public.stage_symptom_enums VALUES (95, 'SUDDEN_DEATH');
INSERT INTO public.stage_symptom_enums VALUES (96, 'WEAKNESS');
INSERT INTO public.stage_symptom_enums VALUES (96, 'LETHARGY');
INSERT INTO public.stage_symptom_enums VALUES (96, 'DYSPNEA');
INSERT INTO public.stage_symptom_enums VALUES (97, 'HEART_MURMUR');
INSERT INTO public.stage_symptom_enums VALUES (98, 'COUGHING');
INSERT INTO public.stage_symptom_enums VALUES (98, 'DYSPNEA');
INSERT INTO public.stage_symptom_enums VALUES (98, 'HEART_MURMUR');
INSERT INTO public.stage_symptom_enums VALUES (99, 'HEART_MURMUR');
INSERT INTO public.stage_symptom_enums VALUES (100, 'HEART_MURMUR');
INSERT INTO public.stage_symptom_enums VALUES (100, 'WEAKNESS');
INSERT INTO public.stage_symptom_enums VALUES (101, 'DYSPNEA');
INSERT INTO public.stage_symptom_enums VALUES (101, 'COUGHING');
INSERT INTO public.stage_symptom_enums VALUES (101, 'FAILURE_TO_THRIVE');
INSERT INTO public.stage_symptom_enums VALUES (102, 'NONE');
INSERT INTO public.stage_symptom_enums VALUES (103, 'CYANOSIS');
INSERT INTO public.stage_symptom_enums VALUES (103, 'EXERCISE_INTOLERANCE');
INSERT INTO public.stage_symptom_enums VALUES (104, 'NONE');
INSERT INTO public.stage_symptom_enums VALUES (105, 'LETHARGY');
INSERT INTO public.stage_symptom_enums VALUES (105, 'WEAK_PULSE');
INSERT INTO public.stage_symptom_enums VALUES (106, 'SYNCOPE');
INSERT INTO public.stage_symptom_enums VALUES (106, 'MUFFLED_HEART_SOUNDS');
INSERT INTO public.stage_symptom_enums VALUES (106, 'JUGULAR_VEIN_DISTENSION');
INSERT INTO public.stage_symptom_enums VALUES (107, 'LETHARGY');
INSERT INTO public.stage_symptom_enums VALUES (107, 'WEAK_PULSE');
INSERT INTO public.stage_symptom_enums VALUES (108, 'PAIN_IN_CHEST_OR_ABDOMEN');
INSERT INTO public.stage_symptom_enums VALUES (108, 'FEVER');
INSERT INTO public.stage_symptom_enums VALUES (108, 'LETHARGY');
INSERT INTO public.stage_symptom_enums VALUES (109, 'DYSPNEA');
INSERT INTO public.stage_symptom_enums VALUES (109, 'ASCITES');
INSERT INTO public.stage_symptom_enums VALUES (109, 'JUGULAR_VEIN_DISTENSION');
INSERT INTO public.stage_symptom_enums VALUES (110, 'COLD_EXTREMITIES');
INSERT INTO public.stage_symptom_enums VALUES (110, 'WEAK_PULSE');
INSERT INTO public.stage_symptom_enums VALUES (111, 'TISSUE_DEATH');
INSERT INTO public.stage_symptom_enums VALUES (111, 'PAINFUL_LIMBS');
INSERT INTO public.stage_symptom_enums VALUES (111, 'LAMENESS');
INSERT INTO public.stage_symptom_enums VALUES (112, 'HEART_MURMUR');
INSERT INTO public.stage_symptom_enums VALUES (113, 'DYSPNEA');
INSERT INTO public.stage_symptom_enums VALUES (113, 'ASCITES');
INSERT INTO public.stage_symptom_enums VALUES (113, 'SYNCOPE');
INSERT INTO public.stage_symptom_enums VALUES (114, 'DYSPNEA');
INSERT INTO public.stage_symptom_enums VALUES (114, 'TACHYPNEA');
INSERT INTO public.stage_symptom_enums VALUES (114, 'ANXIETY');
INSERT INTO public.stage_symptom_enums VALUES (115, 'COLLAPSE');
INSERT INTO public.stage_symptom_enums VALUES (115, 'SHOCK');
INSERT INTO public.stage_symptom_enums VALUES (115, 'SUDDEN_DEATH');
INSERT INTO public.stage_symptom_enums VALUES (116, 'EXERCISE_INTOLERANCE');
INSERT INTO public.stage_symptom_enums VALUES (116, 'LETHARGY');
INSERT INTO public.stage_symptom_enums VALUES (117, 'DYSPNEA');
INSERT INTO public.stage_symptom_enums VALUES (117, 'SYNCOPE');
INSERT INTO public.stage_symptom_enums VALUES (117, 'ASCITES');
INSERT INTO public.stage_symptom_enums VALUES (118, 'DYSPNEA');
INSERT INTO public.stage_symptom_enums VALUES (118, 'TACHYPNEA');
INSERT INTO public.stage_symptom_enums VALUES (118, 'ANXIETY');
INSERT INTO public.stage_symptom_enums VALUES (119, 'DYSPNEA');
INSERT INTO public.stage_symptom_enums VALUES (119, 'ASCITES');
INSERT INTO public.stage_symptom_enums VALUES (119, 'JUGULAR_VEIN_DISTENSION');
INSERT INTO public.stage_symptom_enums VALUES (120, 'HEART_MURMUR');
INSERT INTO public.stage_symptom_enums VALUES (121, 'DYSPNEA');
INSERT INTO public.stage_symptom_enums VALUES (121, 'ASCITES');
INSERT INTO public.stage_symptom_enums VALUES (121, 'WEAKNESS');
INSERT INTO public.stage_symptom_enums VALUES (122, 'HEART_MURMUR');
INSERT INTO public.stage_symptom_enums VALUES (122, 'SYNCOPE');
INSERT INTO public.stage_symptom_enums VALUES (123, 'LETHARGY');
INSERT INTO public.stage_symptom_enums VALUES (123, 'EXERCISE_INTOLERANCE');
INSERT INTO public.stage_symptom_enums VALUES (124, 'DYSPNEA');
INSERT INTO public.stage_symptom_enums VALUES (124, 'ASCITES');
INSERT INTO public.stage_symptom_enums VALUES (124, 'JUGULAR_VEIN_DISTENSION');
INSERT INTO public.stage_symptom_enums VALUES (125, 'SYNCOPE');
INSERT INTO public.stage_symptom_enums VALUES (125, 'VENTRICULAR_ARRHYTHMIAS');
INSERT INTO public.stage_symptom_enums VALUES (125, 'SUDDEN_DEATH');
INSERT INTO public.stage_symptom_enums VALUES (126, 'FEVER');
INSERT INTO public.stage_symptom_enums VALUES (126, 'TACHYCARDIA');
INSERT INTO public.stage_symptom_enums VALUES (126, 'LETHARGY');
INSERT INTO public.stage_symptom_enums VALUES (127, 'HYPOTENSION');
INSERT INTO public.stage_symptom_enums VALUES (127, 'WEAKNESS');
INSERT INTO public.stage_symptom_enums VALUES (127, 'SHOCK');
INSERT INTO public.stage_symptom_enums VALUES (128, 'BRADYCARDIA');
INSERT INTO public.stage_symptom_enums VALUES (129, 'SYNCOPE');
INSERT INTO public.stage_symptom_enums VALUES (129, 'WEAKNESS');
INSERT INTO public.stage_symptom_enums VALUES (129, 'COLLAPSE');
INSERT INTO public.stage_symptom_enums VALUES (130, 'HEART_MURMUR');
INSERT INTO public.stage_symptom_enums VALUES (130, 'SYNCOPE');
INSERT INTO public.stage_symptom_enums VALUES (130, 'SUDDEN_DEATH');
INSERT INTO public.stage_symptom_enums VALUES (131, 'NONE');
INSERT INTO public.stage_symptom_enums VALUES (132, 'SUDDEN_BLINDNESS');
INSERT INTO public.stage_symptom_enums VALUES (132, 'HYPERTENSION');
INSERT INTO public.stage_symptom_enums VALUES (133, 'DYSPNEA');
INSERT INTO public.stage_symptom_enums VALUES (133, 'WEAKNESS');
INSERT INTO public.stage_symptom_enums VALUES (133, 'SEIZURES');
INSERT INTO public.stage_symptom_enums VALUES (134, 'SUDDEN_BLINDNESS');
INSERT INTO public.stage_symptom_enums VALUES (134, 'PROTEINURIA');
INSERT INTO public.stage_symptom_enums VALUES (135, 'FEVER');
INSERT INTO public.stage_symptom_enums VALUES (135, 'TACHYCARDIA');
INSERT INTO public.stage_symptom_enums VALUES (135, 'LETHARGY');
INSERT INTO public.stage_symptom_enums VALUES (136, 'HYPOTENSION');
INSERT INTO public.stage_symptom_enums VALUES (136, 'SHOCK');
INSERT INTO public.stage_symptom_enums VALUES (136, 'SUDDEN_DEATH');
INSERT INTO public.stage_symptom_enums VALUES (137, 'HEART_MURMUR');
INSERT INTO public.stage_symptom_enums VALUES (138, 'CYANOSIS');
INSERT INTO public.stage_symptom_enums VALUES (138, 'EXERCISE_INTOLERANCE');
INSERT INTO public.stage_symptom_enums VALUES (138, 'SYNCOPE');
INSERT INTO public.stage_symptom_enums VALUES (139, 'HEART_MURMUR');
INSERT INTO public.stage_symptom_enums VALUES (140, 'DYSPNEA');
INSERT INTO public.stage_symptom_enums VALUES (140, 'ASCITES');
INSERT INTO public.stage_symptom_enums VALUES (140, 'JUGULAR_VEIN_DISTENSION');
INSERT INTO public.stage_symptom_enums VALUES (141, 'REGURGITATION');
INSERT INTO public.stage_symptom_enums VALUES (141, 'FAILURE_TO_THRIVE');
INSERT INTO public.stage_symptom_enums VALUES (142, 'DYSPHAGIA');
INSERT INTO public.stage_symptom_enums VALUES (142, 'PNEUMONIA');
INSERT INTO public.stage_symptom_enums VALUES (142, 'TISSUE_DEATH');
INSERT INTO public.stage_symptom_enums VALUES (143, 'SKIN_ULCERS_OR_LESIONS');
INSERT INTO public.stage_symptom_enums VALUES (143, 'PAINFUL_LIMBS');
INSERT INTO public.stage_symptom_enums VALUES (144, 'FEVER');
INSERT INTO public.stage_symptom_enums VALUES (144, 'WEAKNESS');
INSERT INTO public.stage_symptom_enums VALUES (144, 'SUDDEN_DEATH');
INSERT INTO public.stage_symptom_enums VALUES (145, 'NONE');
INSERT INTO public.stage_symptom_enums VALUES (146, 'SYNCOPE');
INSERT INTO public.stage_symptom_enums VALUES (146, 'VENTRICULAR_ARRHYTHMIAS');
INSERT INTO public.stage_symptom_enums VALUES (146, 'SUDDEN_DEATH');
INSERT INTO public.stage_symptom_enums VALUES (147, 'HEART_MURMUR');
INSERT INTO public.stage_symptom_enums VALUES (148, 'DYSPNEA');
INSERT INTO public.stage_symptom_enums VALUES (148, 'FAILURE_TO_THRIVE');
INSERT INTO public.stage_symptom_enums VALUES (148, 'WEAKNESS');


--
-- Data for Name: text_data; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: treatment; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.treatment VALUES (3, 3, 'Emergency BP & HR Control', 'Reduce aortic wall stress immediately', 'EMERGENCY', 'کاهش فوری استرس دیواره آئورت.', 'کنترل اورژانسی فشار خون و ضربان قلب');
INSERT INTO public.treatment VALUES (5, 5, 'Acute Pain & Anticoagulation', 'Buprenorphine + clopidogrel ± enoxaparin', 'PHARMACOLOGICAL', 'بوپرنورفین + کلوپیدوگرل ± انوکساپارین.', 'درمان اورژانسی درد و ضد انعقادی');
INSERT INTO public.treatment VALUES (7, 7, 'Sotalol for VPC Suppression', 'Reduces risk of sudden death in Boxers', 'PHARMACOLOGICAL', 'کاهش خطر مرگ ناگهانی در سگ‌های باکسر.', 'سوتالول برای سرکوب VPC');
INSERT INTO public.treatment VALUES (9, 9, 'Surgical Repair (If Symptomatic)', 'Balloon occlusion or surgical closure', 'OTHER', 'اُکلوزیون با بالون یا بستن جراحی.', 'تعمیر جراحی (در صورت علامت‌دار بودن)');
INSERT INTO public.treatment VALUES (12, 12, 'Pericardiocentesis + Diuretics', 'Emergency fluid drainage + furosemide for pulmonary edema', 'EMERGENCY', 'تخلیه اورژانسی مایع + فوروسماید برای ادم ریوی.', 'پریکاردیوسنتز + مدر');
INSERT INTO public.treatment VALUES (13, 13, 'Surgical Resection (If Feasible)', 'Debulking to relieve SVC syndrome', 'OTHER', 'کاهش حجم توده برای تسکین سندرم SVC.', 'برداشت جراحی (در صورت امکان)');
INSERT INTO public.treatment VALUES (15, 15, 'Treat Underlying Lung Disease', 'Bronchodilators, oxygen, antibiotics as needed', 'OTHER', 'موسع‌کننده‌های راه هوایی، اکسیژن و آنتی‌بیوتیک بر حسب نیاز.', 'درمان بیماری زمینه‌ای ریه');
INSERT INTO public.treatment VALUES (17, 17, 'Pacemaker Implantation', 'For symptomatic high-grade AV block', 'OTHER', 'برای بلوک AV درجه بالا با علائم بالینی.', 'کاشت ضربان‌ساز');
INSERT INTO public.treatment VALUES (19, 19, 'Surgical Membrane Resection', 'Definitive treatment for obstruction', 'OTHER', 'درمان قطعی برای اُنسداد.', 'برداشت جراحی غشا');
INSERT INTO public.treatment VALUES (21, 21, 'Glycemic Control', 'Insulin therapy to prevent diabetic cardiomyopathy progression', 'PHARMACOLOGICAL', 'درمان با انسولین برای جلوگیری از پیشرفت کاردیومیوپاتی دیابتی.', 'کنترل قند خون');
INSERT INTO public.treatment VALUES (23, 22, 'Taurine Supplementation', 'If deficient (cats, spaniels, etc.)', 'NUTRITIONAL', 'در صورت کمبود (گربه‌ها، اسپانیل‌ها و غیره).', 'مکمل‌سازی تورین');
INSERT INTO public.treatment VALUES (25, 24, 'Palliative Vasodilation', 'Sildenafil for symptom relief (no cure)', 'PHARMACOLOGICAL', 'سیلدِنافیل برای تسکین علائم (بدون درمان قطعی).', 'واگشادی تسکینی');
INSERT INTO public.treatment VALUES (27, 26, 'Long-Term Antibiotics', 'Doxycycline/enrofloxacin based on culture', 'ANTIBIOTIC', 'دوکسی‌سایکلین/انروفلوکساسین بر اساس نتیجه کشت.', 'آنتی‌بیوتیک طولانی‌مدت');
INSERT INTO public.treatment VALUES (29, 28, 'Melarsomine Adulticide Protocol', '3-dose protocol + doxycycline + prednisone', 'PHARMACOLOGICAL', 'پروتکل ۳ دوزه + دوکسی‌سایکلین + پردنیزون.', 'پروتکل مِلارسومین برای کرم بالغ');
INSERT INTO public.treatment VALUES (31, 30, 'Pericardiocentesis + Chemotherapy', 'Palliative care; median survival <3 months', 'PHARMACOLOGICAL', 'مراقبت تسکینی؛ میانگین بقا < ۳ ماه.', 'پریکاردیوسنتز + شیمی‌درمانی');
INSERT INTO public.treatment VALUES (33, 32, 'Emergency Hyperkalemia Protocol', 'Calcium gluconate (cardioprotection) + insulin/glucose', 'EMERGENCY', 'گلوکونات کلسیم (محافظت قلبی) + انسولین/گلوکز.', 'پروتکل اورژانسی هایپرکالمی');
INSERT INTO public.treatment VALUES (35, 34, 'Asymptomatic Management', 'Monitor; no drugs unless LA enlargement', 'MONITORING', 'نظارت؛ بدون دارو مگر در صورت بزرگی دهلیز چپ.', 'مدیریت بی‌علامت');
INSERT INTO public.treatment VALUES (37, 34, 'Thromboprophylaxis', 'Clopidogrel to prevent saddle thrombus', 'ANTICOAGULANT', 'کلوپیدوگرل برای جلوگیری از ترومب سرجوخ.', 'پیشگیری از ترومبوز');
INSERT INTO public.treatment VALUES (39, 36, 'Oral Potassium Supplementation', 'Potassium gluconate for chronic management', 'NUTRITIONAL', 'گلوکونات پتاسیم برای مدیریت مزمن.', 'مکمل‌سازی پتاسیم خوراکی');
INSERT INTO public.treatment VALUES (41, 38, 'CHOP Chemotherapy Protocol', 'Standard for multicentric lymphoma', 'OTHER', 'استاندارد برای لنفوم چندمرکزی.', 'پروتکل شیمی‌درمانی CHOP');
INSERT INTO public.treatment VALUES (43, 39, 'ACVIM Stage C: CHF Protocol', 'Furosemide + pimobendan + spironolactone', 'PHARMACOLOGICAL', 'فوروسماید + پیمُبِنْدان + اسپیرونولاکتون.', 'مرحله C ACVIM: پروتکل نارسایی قلبی');
INSERT INTO public.treatment VALUES (45, 41, 'Immunosuppression + Supportive Care', 'Prednisone for immune-mediated cases', 'PHARMACOLOGICAL', 'پردنیزون برای موارد ایمنی‌میانجی.', 'سرکوب ایمنی + مراقبت حمایتی');
INSERT INTO public.treatment VALUES (47, 43, 'Same as Mitral Valve Disease', 'Clinical synonym for MVD', 'PHARMACOLOGICAL', 'مترادف بالینی بیماری دریچه میترال.', 'همانند بیماری دریچه میترال');
INSERT INTO public.treatment VALUES (48, 44, 'Coil Occlusion', 'Minimally invasive closure; >95% success', 'OTHER', 'بستن کم‌تهاجمی؛ موفقیت > ۹۵٪.', 'اُکلوزیون با کویل');
INSERT INTO public.treatment VALUES (51, 47, 'Pericardial Window', 'Surgical drainage to prevent recurrence', 'OTHER', 'تخلیه جراحی برای جلوگیری از عود.', 'دریچه پریکاردی');
INSERT INTO public.treatment VALUES (52, 48, 'Anti-inflammatory Therapy', 'NSAIDs or colchicine for idiopathic cases', 'NSAID_ANTI_INFLAMMATORY', 'داروهای ضدالتهاب غیراستروئیدی یا کلشی‌سین برای موارد ایدیوپاتیک.', 'درمان ضدالتهابی');
INSERT INTO public.treatment VALUES (54, 50, 'Balloon Valvuloplasty', 'First-line for severe pulmonic stenosis', 'OTHER', 'خط اول برای تنگی شدید شریان ریوی.', 'واگشادی دریچه با بالون');
INSERT INTO public.treatment VALUES (55, 51, 'Anticoagulation', 'Enoxaparin for acute PE', 'ANTICOAGULANT', 'انوکساپارین برای PE حاد.', 'ضد انعقادی');
INSERT INTO public.treatment VALUES (58, 54, 'Balloon Valvuloplasty', 'If severe obstruction', 'OTHER', 'در صورت اُنسداد شدید.', 'واگشادی دریچه با بالون');
INSERT INTO public.treatment VALUES (59, 55, 'Balloon Valvuloplasty', 'Standard for moderate-severe cases', 'OTHER', 'استاندارد برای موارد متوسط تا شدید.', 'واگشادی دریچه با بالون');
INSERT INTO public.treatment VALUES (61, 57, 'Sotalol for VPC Suppression', 'Reduces sudden death risk in Boxers', 'PHARMACOLOGICAL', 'کاهش خطر مرگ ناگهانی در سگ‌های باکسر.', 'سوتالول برای سرکوب VPC');
INSERT INTO public.treatment VALUES (63, 59, 'Pacemaker Implantation', 'For symptomatic bradycardia', 'OTHER', 'برای برادی‌کاردی علامت‌دار.', 'کاشت ضربان‌ساز');
INSERT INTO public.treatment VALUES (1, 1, 'Correct Underlying Anemia', 'Treat cause (e.g., hemorrhage, hemolysis, CKD)', 'OTHER', 'درمان علت (مثلاً خونریزی، همولیز یا بیماری کلیوی مزمن).', 'درمان علت زمینه‌ای کم‌خونی');
INSERT INTO public.treatment VALUES (2, 2, 'Blood Pressure Control', 'Reduce shear stress on aortic wall', 'PHARMACOLOGICAL', 'کاهش استرس برشی بر دیواره آئورت.', 'کنترل فشار خون');
INSERT INTO public.treatment VALUES (4, 4, 'Beta-Blockade for Symptomatic Cases', 'Reduce myocardial O2 demand, prevent sudden death', 'PHARMACOLOGICAL', 'کاهش نیاز اکسیژن میوکارد و پیشگیری از مرگ ناگهانی.', 'بتابلوک برای موارد علامت‌دار');
INSERT INTO public.treatment VALUES (6, 6, 'Antiarrhythmic Therapy', 'Sotalol for ventricular arrhythmias; diltiazem for AF', 'PHARMACOLOGICAL', 'سوتالول برای آریتمی‌های بطنی؛ دیلتیازم برای فیبریلاسیون دهلیزی.', 'درمان آریتمی با داروهای ضدآریتمی');
INSERT INTO public.treatment VALUES (8, 8, 'Rate Control Protocol', 'Diltiazem ± digoxin for ventricular rate control', 'PHARMACOLOGICAL', 'دیلتیازم ± دیگوکسین برای کنترل ضربان بطنی.', 'پروتکل کنترل ضربان');
INSERT INTO public.treatment VALUES (10, 10, 'Treat Underlying Cause', 'Correct hyperkalemia if present', 'PHARMACOLOGICAL', 'تصحیح هایپرکالمی در صورت وجود.', 'درمان علت زمینه‌ای');
INSERT INTO public.treatment VALUES (11, 11, 'Supportive CHF Management', 'Diuretics for effusions; avoid aggressive afterload reduction', 'PHARMACOLOGICAL', 'مدرها برای افیوژن؛ از کاهش پس‌بار تهاجمی خودداری شود.', 'مدیریت حمایتی نارسایی قلبی');
INSERT INTO public.treatment VALUES (14, 14, 'Hypertension Control', 'Amlodipine to reduce cardiac afterload and renal damage', 'PHARMACOLOGICAL', 'آملودیپین برای کاهش پس‌بار قلبی و آسیب کلیوی.', 'کنترل فشار خون');
INSERT INTO public.treatment VALUES (16, 16, 'Pulmonary Vasodilation', 'Sildenafil for pulmonary artery pressure reduction', 'PHARMACOLOGICAL', 'سیلدِنافیل برای کاهش فشار شریان ریوی.', 'واگشادی عروق ریوی');
INSERT INTO public.treatment VALUES (18, 18, 'Coil Embolization', 'Endovascular occlusion of fistula', 'OTHER', 'اُکلوزیون آندواسکولار فیستول.', 'امبولیزاسیون با کویل');
INSERT INTO public.treatment VALUES (20, 20, 'Treat Hyperadrenocorticism', 'Trilostane to reduce cortisol and thrombotic risk', 'PHARMACOLOGICAL', 'تریلوستان برای کاهش کورتیزول و خطر ترومبوز.', 'درمان هایپرآدرنوکورتیسیسم');
INSERT INTO public.treatment VALUES (22, 22, 'Standard CHF Protocol', 'Furosemide + pimobendan + ACEi', 'PHARMACOLOGICAL', 'فوروسماید + پیمُبِنْدان + مهارکننده ACE.', 'پروتکل استاندارد نارسایی قلبی');
INSERT INTO public.treatment VALUES (24, 23, 'Diuretics for Right Heart Failure', 'Furosemide for ascites/edema', 'PHARMACOLOGICAL', 'فوروسماید برای آسیت/ادم.', 'مدرها برای نارسایی قلب راست');
INSERT INTO public.treatment VALUES (26, 25, 'Supportive CHF Management', 'Furosemide + digoxin for systolic dysfunction', 'PHARMACOLOGICAL', 'فوروسماید + دیگوکسین برای نارسایی سیستولیک.', 'مدیریت حمایتی نارسایی قلبی');
INSERT INTO public.treatment VALUES (28, 27, 'Antiviral + Immunosuppression', 'If viral/immune-mediated (e.g., parvovirus)', 'ANTIBIOTIC', 'در صورت علت ویروسی/ایمنی‌میانجی (مثلاً پاروویروس).', 'ضدویروسی + سرکوب ایمنی');
INSERT INTO public.treatment VALUES (30, 29, 'Caval Syndrome Emergency', 'Surgical heartworm extraction + supportive care', 'EMERGENCY', 'برداشت جراحی کرم قلبی + مراقبت حمایتی.', 'اورژانس سندرم کاوا');
INSERT INTO public.treatment VALUES (32, 31, 'Hydration + Diuretics', 'Saline diuresis to promote calcium excretion', 'PHARMACOLOGICAL', 'ادرارآوری با سالین برای دفع کلسیم.', 'هیدراتاسیون + مدر');
INSERT INTO public.treatment VALUES (34, 33, 'Treat Hyperthyroidism', 'Methimazole/radioiodine to reverse cardiac changes', 'PHARMACOLOGICAL', 'متی‌میزول/رادیویدین برای برگشت تغییرات قلبی.', 'درمان هایپرتیروئیدی');
INSERT INTO public.treatment VALUES (36, 34, 'CHF Management', 'Furosemide + pimobendan for pulmonary edema', 'PHARMACOLOGICAL', 'فوروسماید + پیمُبِنْدان برای ادم ریوی.', 'مدیریت نارسایی قلبی');
INSERT INTO public.treatment VALUES (38, 35, 'Calcium Replacement', 'Calcium gluconate IV for acute cases', 'EMERGENCY', 'گلوکونات کلسیم وریدی برای موارد حاد.', 'جایگزینی کلسیم');
INSERT INTO public.treatment VALUES (40, 37, 'Levothyroxine Replacement', 'Corrects bradycardia and cardiac changes', 'HORMONAL', 'تصحیح برادی‌کاردی و تغییرات قلبی.', 'جایگزینی لووتیروکسین');
INSERT INTO public.treatment VALUES (42, 39, 'ACVIM Stage B2: Pimobendan', 'Delays onset of CHF in dogs with LA enlargement', 'PHARMACOLOGICAL', 'تأخیر در شروع نارسایی قلبی در سگ‌های با بزرگی دهلیز چپ.', 'مرحله B2 ACVIM: پیمُبِنْدان');
INSERT INTO public.treatment VALUES (44, 40, 'Monitor Asymptomatic Cases', 'No treatment unless severe regurgitation', 'MONITORING', 'بدون درمان مگر در صورت رِگورژیتاسیون شدید.', 'نظارت بر موارد بی‌علامت');
INSERT INTO public.treatment VALUES (46, 42, 'Same as Mitral Valve Disease', 'Pathologic basis for MVD', 'PHARMACOLOGICAL', 'پایه پاتولوژیک بیماری دریچه میترال.', 'همانند بیماری دریچه میترال');
INSERT INTO public.treatment VALUES (49, 45, 'Monitor Asymptomatic Cases', 'No intervention unless paradoxical embolism', 'MONITORING', 'بدون مداخله مگر در صورت امبولی پارادوکسال.', 'نظارت بر موارد بی‌علامت');
INSERT INTO public.treatment VALUES (50, 46, 'Pericardiocentesis + Diuretics', 'Emergency drainage + furosemide if pulmonary edema', 'EMERGENCY', 'تخلیه اورژانسی + فوروسماید در صورت ادم ریوی.', 'پریکاردیوسنتز + مدر');
INSERT INTO public.treatment VALUES (53, 49, 'Treat Underlying Cause', 'Amlodipine for hypertension; insulin for DM', 'PHARMACOLOGICAL', 'آملودیپین برای فشار خون بالا؛ انسولین برای دیابت.', 'درمان علت زمینه‌ای');
INSERT INTO public.treatment VALUES (66, 62, 'Treat Underlying Cause + Amlodipine', 'Address CKD/Cushing’s + BP control', 'PHARMACOLOGICAL', 'درمان بیماری کلیوی مزمن/کوشینگ + کنترل فشار خون.', 'درمان علت زمینه‌ای + آملودیپین');
INSERT INTO public.treatment VALUES (69, 65, 'Diuretics for Right Heart Failure', 'Furosemide for ascites/jugular distension', 'PHARMACOLOGICAL', 'فوروسماید برای آسیت/ورید ژوگولار پر.', 'مدرها برای نارسایی قلب راست');
INSERT INTO public.treatment VALUES (70, 66, 'Surgical Correction', 'Division of vascular ring (e.g., PRAA)', 'OTHER', 'تقسیم حلقه عروقی (مثلاً PRAA).', 'تعمیر جراحی');
INSERT INTO public.treatment VALUES (72, 68, 'Antiarrhythmic Therapy', 'Sotalol for VPCs/VT; amiodarone for refractory cases', 'PHARMACOLOGICAL', 'سوتالول برای VPC/VT؛ آمیودارون برای موارد مقاوم.', 'درمان آریتمی با داروهای ضدآریتمی');
INSERT INTO public.treatment VALUES (56, 52, 'Sildenafil Therapy', 'First-line for pulmonary arterial hypertension', 'PHARMACOLOGICAL', 'خط اول برای فشار خون شریان ریوی بالا.', 'درمان با سیلدِنافیل');
INSERT INTO public.treatment VALUES (57, 53, 'Anticoagulation Protocol', 'Clopidogrel ± enoxaparin for high-risk patients', 'ANTICOAGULANT', 'کلوپیدوگرل ± انوکساپارین برای بیماران پرخطر.', 'پروتکل ضد انعقادی');
INSERT INTO public.treatment VALUES (60, 56, 'Diuretics for Effusions', 'Furosemide for ascites/pleural effusion; avoid over-diuresis', 'PHARMACOLOGICAL', 'فوروسماید برای آسیت/افیوژن پلور؛ از دیورز بیش‌ازحد خودداری شود.', 'مدرها برای افیوژن');
INSERT INTO public.treatment VALUES (62, 58, 'Sepsis Source Control + Fluids', 'Antibiotics + hemodynamic support', 'ANTIBIOTIC', 'آنتی‌بیوتیک + حمایت همودینامیک.', 'کنترل منبع سپسیس + مایعات');
INSERT INTO public.treatment VALUES (64, 60, 'Beta-Blockade', 'Atenolol/sotalol to reduce myocardial O2 demand', 'PHARMACOLOGICAL', 'آتنولول/سوتالول برای کاهش نیاز اکسیژن میوکارد.', 'بتابلوک');
INSERT INTO public.treatment VALUES (65, 61, 'Amlodipine First-Line', 'Goal SBP <150 mmHg to prevent target organ damage', 'PHARMACOLOGICAL', 'هدف: فشار سیستولی < ۱۵۰ mmHg برای جلوگیری از آسیب عضو هدف.', 'آملودیپین به‌عنوان خط اول');
INSERT INTO public.treatment VALUES (67, 63, 'Broad-Spectrum Antibiotics', 'Doxycycline for rickettsial; enrofloxacin for Gram-', 'ANTIBIOTIC', 'دوکسی‌سایکلین برای ریکتسیایی؛ انروفلوکساسین برای گرم منفی.', 'آنتی‌بیوتیک وسیع‌الطیف');
INSERT INTO public.treatment VALUES (68, 64, 'Beta-Blockers for Tet Spells', 'Propranolol/sotalol to reduce right ventricular outflow obstruction', 'PHARMACOLOGICAL', 'پروپرانولول/سوتالول برای کاهش اُنسداد خروجی بطن راست.', 'بتابلوک برای حملات تت');
INSERT INTO public.treatment VALUES (71, 67, 'Immunosuppression', 'Prednisone ± azathioprine for immune-mediated vasculitis', 'STEROID_ANTI_INFLAMMATORY', 'پردنیزون ± آزاتیوپرین برای واژکولیت ایمنی‌میانجی.', 'سرکوب ایمنی');
INSERT INTO public.treatment VALUES (73, 69, 'Surgical Repair (If Large)', 'Patch closure for hemodynamically significant VSD', 'OTHER', 'بستن با پچ برای VSDهای همودینامیکی معنادار.', 'تعمیر جراحی (در صورت بزرگ بودن)');


--
-- Data for Name: treatment_medicine; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.treatment_medicine VALUES (1, 20);
INSERT INTO public.treatment_medicine VALUES (2, 16);
INSERT INTO public.treatment_medicine VALUES (3, 16);
INSERT INTO public.treatment_medicine VALUES (3, 9);
INSERT INTO public.treatment_medicine VALUES (4, 9);
INSERT INTO public.treatment_medicine VALUES (5, 24);
INSERT INTO public.treatment_medicine VALUES (5, 12);
INSERT INTO public.treatment_medicine VALUES (5, 15);
INSERT INTO public.treatment_medicine VALUES (6, 9);
INSERT INTO public.treatment_medicine VALUES (7, 9);
INSERT INTO public.treatment_medicine VALUES (8, 11);
INSERT INTO public.treatment_medicine VALUES (8, 19);
INSERT INTO public.treatment_medicine VALUES (10, 28);
INSERT INTO public.treatment_medicine VALUES (11, 1);
INSERT INTO public.treatment_medicine VALUES (12, 1);
INSERT INTO public.treatment_medicine VALUES (14, 16);
INSERT INTO public.treatment_medicine VALUES (16, 18);
INSERT INTO public.treatment_medicine VALUES (22, 1);
INSERT INTO public.treatment_medicine VALUES (22, 4);
INSERT INTO public.treatment_medicine VALUES (22, 6);
INSERT INTO public.treatment_medicine VALUES (23, 26);
INSERT INTO public.treatment_medicine VALUES (23, 27);
INSERT INTO public.treatment_medicine VALUES (24, 1);
INSERT INTO public.treatment_medicine VALUES (25, 18);
INSERT INTO public.treatment_medicine VALUES (26, 1);
INSERT INTO public.treatment_medicine VALUES (26, 19);
INSERT INTO public.treatment_medicine VALUES (27, 20);
INSERT INTO public.treatment_medicine VALUES (28, 20);
INSERT INTO public.treatment_medicine VALUES (29, 22);
INSERT INTO public.treatment_medicine VALUES (29, 20);
INSERT INTO public.treatment_medicine VALUES (32, 1);
INSERT INTO public.treatment_medicine VALUES (33, 28);
INSERT INTO public.treatment_medicine VALUES (36, 1);
INSERT INTO public.treatment_medicine VALUES (36, 4);
INSERT INTO public.treatment_medicine VALUES (37, 12);
INSERT INTO public.treatment_medicine VALUES (38, 28);
INSERT INTO public.treatment_medicine VALUES (42, 4);
INSERT INTO public.treatment_medicine VALUES (43, 1);
INSERT INTO public.treatment_medicine VALUES (43, 4);
INSERT INTO public.treatment_medicine VALUES (43, 2);
INSERT INTO public.treatment_medicine VALUES (50, 1);
INSERT INTO public.treatment_medicine VALUES (53, 16);
INSERT INTO public.treatment_medicine VALUES (55, 15);
INSERT INTO public.treatment_medicine VALUES (56, 18);
INSERT INTO public.treatment_medicine VALUES (57, 12);
INSERT INTO public.treatment_medicine VALUES (57, 15);
INSERT INTO public.treatment_medicine VALUES (60, 1);
INSERT INTO public.treatment_medicine VALUES (61, 9);
INSERT INTO public.treatment_medicine VALUES (62, 20);
INSERT INTO public.treatment_medicine VALUES (64, 9);
INSERT INTO public.treatment_medicine VALUES (65, 16);
INSERT INTO public.treatment_medicine VALUES (66, 16);
INSERT INTO public.treatment_medicine VALUES (67, 20);
INSERT INTO public.treatment_medicine VALUES (68, 9);
INSERT INTO public.treatment_medicine VALUES (69, 1);
INSERT INTO public.treatment_medicine VALUES (72, 9);


--
-- Name: diagnosis_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.diagnosis_id_seq', 134, true);


--
-- Name: disease_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.disease_id_seq', 1, false);


--
-- Name: medicine_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.medicine_id_seq', 29, true);


--
-- Name: stage_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.stage_id_seq', 148, true);


--
-- Name: text_data_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.text_data_id_seq', 1, false);


--
-- Name: treatment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.treatment_id_seq', 1, false);


--
-- PostgreSQL database dump complete
--

-- \unrestrict bBJjJGpzw4iLuO9eAUgJ75TEsuJw9W8hcbI4VbeESS9ciCP1p2bxKU7vGWG6zsu

