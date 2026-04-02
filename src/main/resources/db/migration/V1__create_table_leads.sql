CREATE TABLE leads (
    id BIGSERIAL PRIMARY KEY,

    person_type VARCHAR(2) NOT NULL,
    full_name VARCHAR(255),
    company_name VARCHAR(255),
    trade_name VARCHAR(255),

    document VARCHAR(14) NOT NULL,
    email VARCHAR(255) NOT NULL,
    phone VARCHAR(20),

    cep VARCHAR(8),
    street VARCHAR(255),
    number VARCHAR(20),
    complement VARCHAR(255),
    neighborhood VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(2),

    lead_source VARCHAR(30) NOT NULL DEFAULT 'MANUAL',
    status VARCHAR(30) NOT NULL DEFAULT 'NEW',
    temperature VARCHAR(20),
    notes TEXT,

    legal_nature VARCHAR(100),
    main_cnae_code VARCHAR(10),
    main_cnae_description VARCHAR(255),
    registration_status VARCHAR(30),
    registration_status_date DATE,
    activity_start_date DATE,
    is_head_office BOOLEAN,

    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW(),

    CONSTRAINT uq_leads_document UNIQUE (document),

    CONSTRAINT ck_leads_person_type
        CHECK (person_type IN ('PF', 'PJ')),

    CONSTRAINT ck_leads_lead_source
        CHECK (lead_source IN (
            'MANUAL',
            'IMPORT',
            'BRASIL_API',
            'CSV',
            'REFERRAL',
            'OTHER'
        )),

    CONSTRAINT ck_leads_status
        CHECK (status IN (
            'NEW',
            'QUALIFYING',
            'QUALIFIED',
            'DISQUALIFIED',
            'CONVERTED',
            'LOST'
        )),

    CONSTRAINT ck_leads_temperature
        CHECK (
            temperature IS NULL
            OR temperature IN ('COLD', 'WARM', 'HOT')
        ),

    CONSTRAINT ck_leads_state
        CHECK (
            state IS NULL
            OR state IN (
                'AC','AL','AP','AM','BA','CE','DF','ES','GO','MA',
                'MT','MS','MG','PA','PB','PR','PE','PI','RJ','RN',
                'RS','RO','RR','SC','SP','SE','TO'
            )
        ),

    CONSTRAINT ck_leads_document_digits
        CHECK (document ~ '^[0-9]{11}$|^[0-9]{14}$'),

    CONSTRAINT ck_leads_cep_digits
        CHECK (
            cep IS NULL
            OR cep ~ '^[0-9]{8}$'
        ),

    CONSTRAINT ck_leads_name_by_person_type
        CHECK (
            (person_type = 'PF' AND full_name IS NOT NULL)
            OR
            (person_type = 'PJ' AND company_name IS NOT NULL)
        )
);

CREATE INDEX idx_leads_status
    ON leads(status);

CREATE INDEX idx_leads_lead_source
    ON leads(lead_source);

CREATE INDEX idx_leads_person_type
    ON leads(person_type);

CREATE INDEX idx_leads_city_state
    ON leads(city, state);

CREATE INDEX idx_leads_created_at
    ON leads(created_at);

CREATE INDEX idx_leads_temperature
    ON leads(temperature);

CREATE OR REPLACE FUNCTION set_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at := NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_leads_set_updated_at
BEFORE UPDATE ON leads
FOR EACH ROW
EXECUTE FUNCTION set_updated_at();