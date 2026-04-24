-- ============================================================
--  ZERODECH Oracle Database Schema
--  Run this script as the "school" user in SQL*Plus or
--  SQL Developer: @zerodech_schema.sql
-- ============================================================

-- ============================================================
--  DROP existing objects (safe re-run)
-- ============================================================
BEGIN
    FOR t IN (SELECT table_name FROM user_tables
              WHERE table_name IN ('FEEDBACK','PAYMENTS','PICKUPS',
                                   'SUBSCRIPTIONS','SUBSCRIPTION_PLANS','USERS'))
    LOOP
        EXECUTE IMMEDIATE 'DROP TABLE ' || t.table_name || ' CASCADE CONSTRAINTS';
    END LOOP;
END;
/

BEGIN
    FOR s IN (SELECT sequence_name FROM user_sequences
              WHERE sequence_name IN ('SEQ_USERS','SEQ_SUBSCRIPTION_PLANS',
                                      'SEQ_SUBSCRIPTIONS','SEQ_PICKUPS',
                                      'SEQ_PAYMENTS','SEQ_FEEDBACK'))
    LOOP
        EXECUTE IMMEDIATE 'DROP SEQUENCE ' || s.sequence_name;
    END LOOP;
END;
/

-- ============================================================
--  SEQUENCES
-- ============================================================
CREATE SEQUENCE SEQ_USERS             START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE SEQ_SUBSCRIPTION_PLANS START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE SEQ_SUBSCRIPTIONS     START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE SEQ_PICKUPS           START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE SEQ_PAYMENTS          START WITH 1 INCREMENT BY 1 NOCACHE;
CREATE SEQUENCE SEQ_FEEDBACK          START WITH 1 INCREMENT BY 1 NOCACHE;

-- ============================================================
--  TABLE: USERS
-- ============================================================
CREATE TABLE users (
    id          NUMBER(10)    PRIMARY KEY,
    full_name   VARCHAR2(120) NOT NULL,
    email       VARCHAR2(150) NOT NULL UNIQUE,
    password    VARCHAR2(255) NOT NULL,
    role        VARCHAR2(20)  NOT NULL CHECK (role IN ('CLIENT','COLLECTOR','ADMIN')),
    phone       VARCHAR2(20),
    address     VARCHAR2(255),
    created_at  DATE          DEFAULT SYSDATE NOT NULL
);

CREATE OR REPLACE TRIGGER trg_users_id
BEFORE INSERT ON users
FOR EACH ROW
BEGIN
    IF :NEW.id IS NULL THEN
        SELECT SEQ_USERS.NEXTVAL INTO :NEW.id FROM DUAL;
    END IF;
END;
/

-- ============================================================
--  TABLE: SUBSCRIPTION_PLANS
-- ============================================================
CREATE TABLE subscription_plans (
    id          NUMBER(10)     PRIMARY KEY,
    name        VARCHAR2(50)   NOT NULL UNIQUE,
    price       NUMBER(10,2)   NOT NULL,
    description VARCHAR2(500),
    duration_days NUMBER(5)    DEFAULT 30 NOT NULL
);

CREATE OR REPLACE TRIGGER trg_sub_plans_id
BEFORE INSERT ON subscription_plans
FOR EACH ROW
BEGIN
    IF :NEW.id IS NULL THEN
        SELECT SEQ_SUBSCRIPTION_PLANS.NEXTVAL INTO :NEW.id FROM DUAL;
    END IF;
END;
/

-- ============================================================
--  TABLE: SUBSCRIPTIONS
-- ============================================================
CREATE TABLE subscriptions (
    id          NUMBER(10)   PRIMARY KEY,
    user_id     NUMBER(10)   NOT NULL REFERENCES users(id),
    plan_id     NUMBER(10)   NOT NULL REFERENCES subscription_plans(id),
    start_date  DATE         DEFAULT SYSDATE NOT NULL,
    end_date    DATE         NOT NULL,
    status      VARCHAR2(20) DEFAULT 'ACTIVE' CHECK (status IN ('ACTIVE','EXPIRED','CANCELLED'))
);

CREATE OR REPLACE TRIGGER trg_subscriptions_id
BEFORE INSERT ON subscriptions
FOR EACH ROW
BEGIN
    IF :NEW.id IS NULL THEN
        SELECT SEQ_SUBSCRIPTIONS.NEXTVAL INTO :NEW.id FROM DUAL;
    END IF;
END;
/

-- ============================================================
--  TABLE: PICKUPS
-- ============================================================
CREATE TABLE pickups (
    id           NUMBER(10)    PRIMARY KEY,
    client_id    NUMBER(10)    NOT NULL REFERENCES users(id),
    collector_id NUMBER(10)    REFERENCES users(id),
    waste_type   VARCHAR2(100) DEFAULT 'Mixed',
    location     VARCHAR2(300) NOT NULL,
    pickup_date  DATE          NOT NULL,
    status       VARCHAR2(30)  DEFAULT 'PENDING'
                               CHECK (status IN ('PENDING','ASSIGNED','IN_PROGRESS','COMPLETED','CANCELLED')),
    notes        VARCHAR2(500),
    collector_note VARCHAR2(500),
    created_at   DATE          DEFAULT SYSDATE NOT NULL,
    completed_at DATE
);

CREATE OR REPLACE TRIGGER trg_pickups_id
BEFORE INSERT ON pickups
FOR EACH ROW
BEGIN
    IF :NEW.id IS NULL THEN
        SELECT SEQ_PICKUPS.NEXTVAL INTO :NEW.id FROM DUAL;
    END IF;
END;
/

-- ============================================================
--  TABLE: PAYMENTS
-- ============================================================
CREATE TABLE payments (
    id             NUMBER(10)    PRIMARY KEY,
    client_id      NUMBER(10)    NOT NULL REFERENCES users(id),
    pickup_id      NUMBER(10)    REFERENCES pickups(id),
    amount         NUMBER(12,2)  NOT NULL,
    payment_method VARCHAR2(50)  DEFAULT 'MOBILE_MONEY',
    payment_date   DATE          DEFAULT SYSDATE NOT NULL,
    created_at     DATE          DEFAULT SYSDATE NOT NULL
);

CREATE OR REPLACE TRIGGER trg_payments_id
BEFORE INSERT ON payments
FOR EACH ROW
BEGIN
    IF :NEW.id IS NULL THEN
        SELECT SEQ_PAYMENTS.NEXTVAL INTO :NEW.id FROM DUAL;
    END IF;
END;
/

-- ============================================================
--  TABLE: FEEDBACK
-- ============================================================
CREATE TABLE feedback (
    id           NUMBER(10)    PRIMARY KEY,
    collector_id NUMBER(10)    NOT NULL REFERENCES users(id),
    pickup_id    NUMBER(10)    NOT NULL REFERENCES pickups(id),
    comments     VARCHAR2(1000),
    rating       NUMBER(1)     CHECK (rating BETWEEN 1 AND 5),
    created_at   DATE          DEFAULT SYSDATE NOT NULL
);

CREATE OR REPLACE TRIGGER trg_feedback_id
BEFORE INSERT ON feedback
FOR EACH ROW
BEGIN
    IF :NEW.id IS NULL THEN
        SELECT SEQ_FEEDBACK.NEXTVAL INTO :NEW.id FROM DUAL;
    END IF;
END;
/

-- ============================================================
--  SAMPLE DATA
-- ============================================================

-- Subscription Plans
INSERT INTO subscription_plans (name, price, description, duration_days)
VALUES ('Basic', 4000, 'Collect 1x per week - standard household waste', 30);

INSERT INTO subscription_plans (name, price, description, duration_days)
VALUES ('Standard', 7000, 'Collect 2x per week - all types of waste', 30);

INSERT INTO subscription_plans (name, price, description, duration_days)
VALUES ('Premium', 12000, 'Daily collection - top priority - all neighborhoods', 30);

-- Admin user (password: admin123)
INSERT INTO users (full_name, email, password, role, phone, address)
VALUES ('Super Admin', 'admin@zerodech.cm', 'admin123', 'ADMIN', '+237600000001', 'Douala, Cameroon');

-- Sample Collector (password: collector123)
INSERT INTO users (full_name, email, password, role, phone, address)
VALUES ('John Collector', 'collector@zerodech.cm', 'collector123', 'COLLECTOR', '+237600000002', 'Yaounde, Cameroon');

-- Sample Client (password: client123)
INSERT INTO users (full_name, email, password, role, phone, address)
VALUES ('Mary Client', 'client@zerodech.cm', 'client123', 'CLIENT', '+237677000003', 'Douala Akwa, Cameroon');

COMMIT;

-- ============================================================
--  VERIFICATION QUERIES (run to confirm setup)
-- ============================================================
-- SELECT table_name FROM user_tables ORDER BY 1;
-- SELECT * FROM subscription_plans;
-- SELECT * FROM users;
-- SELECT sequence_name FROM user_sequences ORDER BY 1;
