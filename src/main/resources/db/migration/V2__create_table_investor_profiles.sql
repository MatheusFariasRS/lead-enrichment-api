CREATE TABLE investor_profiles (
    id BIGSERIAL PRIMARY KEY,
    lead_id BIGINT NOT NULL,

    monthly_income NUMERIC(15,2),
    estimated_assets NUMERIC(15,2),
    monthly_investment_capacity NUMERIC(15,2),

    risk_profile VARCHAR(30),
    investment_objective VARCHAR(50),
    liquidity_need VARCHAR(30),
    investment_horizon VARCHAR(30),
    investment_experience VARCHAR(30),

    has_emergency_reserve BOOLEAN,
    profession VARCHAR(100),
    notes TEXT,

    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW(),

    CONSTRAINT uq_investor_profiles_lead_id UNIQUE (lead_id),

    CONSTRAINT fk_investor_profiles_lead
        FOREIGN KEY (lead_id)
        REFERENCES leads(id)
        ON DELETE CASCADE,

    CONSTRAINT ck_investor_profiles_monthly_income
        CHECK (
            monthly_income IS NULL
            OR monthly_income >= 0
        ),

    CONSTRAINT ck_investor_profiles_estimated_assets
        CHECK (
            estimated_assets IS NULL
            OR estimated_assets >= 0
        ),

    CONSTRAINT ck_investor_profiles_monthly_investment_capacity
        CHECK (
            monthly_investment_capacity IS NULL
            OR monthly_investment_capacity >= 0
        ),

    CONSTRAINT ck_investor_profiles_risk_profile
        CHECK (
            risk_profile IS NULL
            OR risk_profile IN (
                'CONSERVATIVE',
                'MODERATE',
                'AGGRESSIVE'
            )
        ),

    CONSTRAINT ck_investor_profiles_investment_objective
        CHECK (
            investment_objective IS NULL
            OR investment_objective IN (
                'CAPITAL_PRESERVATION',
                'INCOME_GENERATION',
                'WEALTH_ACCUMULATION',
                'RETIREMENT',
                'DIVERSIFICATION'
            )
        ),

    CONSTRAINT ck_investor_profiles_liquidity_need
        CHECK (
            liquidity_need IS NULL
            OR liquidity_need IN (
                'LOW',
                'MEDIUM',
                'HIGH'
            )
        ),

    CONSTRAINT ck_investor_profiles_investment_horizon
        CHECK (
            investment_horizon IS NULL
            OR investment_horizon IN (
                'SHORT_TERM',
                'MEDIUM_TERM',
                'LONG_TERM'
            )
        ),

    CONSTRAINT ck_investor_profiles_investment_experience
        CHECK (
            investment_experience IS NULL
            OR investment_experience IN (
                'NONE',
                'BEGINNER',
                'INTERMEDIATE',
                'ADVANCED'
            )
        )
);

CREATE INDEX idx_investor_profiles_risk_profile
    ON investor_profiles(risk_profile);

CREATE INDEX idx_investor_profiles_investment_objective
    ON investor_profiles(investment_objective);

CREATE TRIGGER trg_investor_profiles_set_updated_at
BEFORE UPDATE ON investor_profiles
FOR EACH ROW
EXECUTE FUNCTION set_updated_at();