-- =============================================================================
-- UNSTUCK DATABASE SCHEMA DDL
-- Database: PostgreSQL 16
-- System: UNSTUCK Intelligent Freelance Intelligence & Proposal Automation Hub
-- =============================================================================

-- Enable required extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- -----------------------------------------------------------------------------
-- 1. Table: users
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(150) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    is_verified BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    verified_at TIMESTAMP WITH TIME ZONE
);

CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);

COMMENT ON TABLE users IS 'Registered freelancers and platform administrators';
COMMENT ON COLUMN users.password_hash IS 'Salted bcrypt password hash (work factor 12)';
COMMENT ON COLUMN users.is_verified IS 'True once the 6-digit email OTP is validated';

-- -----------------------------------------------------------------------------
-- 2. Table: otp_verifications
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS otp_verifications (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL,
    otp_hash VARCHAR(255) NOT NULL,
    attempts INTEGER DEFAULT 0,
    max_attempts INTEGER DEFAULT 5,
    is_used BOOLEAN DEFAULT FALSE,
    expires_at TIMESTAMP WITH TIME ZONE NOT NULL,
    last_sent_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_otp_email ON otp_verifications(email);
CREATE INDEX IF NOT EXISTS idx_otp_expires_at ON otp_verifications(expires_at);

COMMENT ON TABLE otp_verifications IS 'Short-lived OTP verification requests for signup';
COMMENT ON COLUMN otp_verifications.otp_hash IS 'SHA-256 hash of the 6-digit OTP code';

-- -----------------------------------------------------------------------------
-- 3. Table: projects
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS projects (
    id SERIAL PRIMARY KEY,
    platform VARCHAR(100) NOT NULL,
    platform_key VARCHAR(50) NOT NULL,
    title TEXT NOT NULL,
    url TEXT UNIQUE NOT NULL,
    price VARCHAR(100),
    duration VARCHAR(100),
    published_at VARCHAR(100),
    brief TEXT,
    requirements JSONB DEFAULT '[]'::jsonb,
    scraped_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_projects_url ON projects(url);
CREATE INDEX IF NOT EXISTS idx_projects_platform_key ON projects(platform_key);
CREATE INDEX IF NOT EXISTS idx_projects_published_at ON projects(published_at DESC);
CREATE INDEX IF NOT EXISTS idx_projects_requirements_gin ON projects USING GIN (requirements);

COMMENT ON TABLE projects IS 'Scraped opportunities from Mostaql, Khamsat, Nafezly, and Freelancer';
COMMENT ON COLUMN projects.url IS 'Canonical URL acting as unique key for real-time UPSERT';

-- -----------------------------------------------------------------------------
-- 4. Table: user_saved_projects (Bookmarks)
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS user_saved_projects (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    project_id INTEGER NOT NULL REFERENCES projects(id) ON DELETE CASCADE,
    saved_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    user_notes TEXT,
    CONSTRAINT uq_user_project_saved UNIQUE (user_id, project_id)
);

CREATE INDEX IF NOT EXISTS idx_saved_user ON user_saved_projects(user_id);

-- -----------------------------------------------------------------------------
-- 5. Table: generated_proposals
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS generated_proposals (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    project_id INTEGER NOT NULL REFERENCES projects(id) ON DELETE CASCADE,
    proposal_text TEXT NOT NULL,
    tone VARCHAR(50) DEFAULT 'value',
    language VARCHAR(20) DEFAULT 'arabic',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_proposals_user ON generated_proposals(user_id);
CREATE INDEX IF NOT EXISTS idx_proposals_project ON generated_proposals(project_id);

-- -----------------------------------------------------------------------------
-- 6. Sample UPSERT Query Pattern Demonstration
-- -----------------------------------------------------------------------------
-- INSERT INTO projects (
--     platform, platform_key, title, url, price, duration,
--     published_at, brief, requirements, updated_at
-- ) VALUES (
--     'Mostaql', 'mostaql', 'Develop Intelligent Web Dashboard', 'https://mostaql.com/projects/12345',
--     '$150.00', '3 Days', '1 hour ago', 'Full-stack application requirement...', '["React", "FastAPI"]'::jsonb,
--     CURRENT_TIMESTAMP
-- )
-- ON CONFLICT (url) DO UPDATE SET
--     platform = EXCLUDED.platform,
--     platform_key = EXCLUDED.platform_key,
--     title = EXCLUDED.title,
--     price = EXCLUDED.price,
--     duration = EXCLUDED.duration,
--     published_at = EXCLUDED.published_at,
--     brief = EXCLUDED.brief,
--     requirements = EXCLUDED.requirements,
--     updated_at = CURRENT_TIMESTAMP;
