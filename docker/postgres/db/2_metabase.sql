\connect metabase

--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.7
-- Dumped by pg_dump version 9.5.7

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: activity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE activity (
    id integer NOT NULL,
    topic character varying(32) NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    user_id integer,
    model character varying(16),
    model_id integer,
    database_id integer,
    table_id integer,
    custom_id character varying(48),
    details character varying NOT NULL
);


ALTER TABLE activity OWNER TO postgres;

--
-- Name: activity_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE activity_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE activity_id_seq OWNER TO postgres;

--
-- Name: activity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE activity_id_seq OWNED BY activity.id;


--
-- Name: card_label; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE card_label (
    id integer NOT NULL,
    card_id integer NOT NULL,
    label_id integer NOT NULL
);


ALTER TABLE card_label OWNER TO postgres;

--
-- Name: card_label_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE card_label_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE card_label_id_seq OWNER TO postgres;

--
-- Name: card_label_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE card_label_id_seq OWNED BY card_label.id;


--
-- Name: collection; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE collection (
    id integer NOT NULL,
    name text NOT NULL,
    slug character varying(254) NOT NULL,
    description text,
    color character(7) NOT NULL,
    archived boolean DEFAULT false NOT NULL
);


ALTER TABLE collection OWNER TO postgres;

--
-- Name: TABLE collection; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE collection IS 'Collections are an optional way to organize Cards and handle permissions for them.';


--
-- Name: COLUMN collection.name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN collection.name IS 'The unique, user-facing name of this Collection.';


--
-- Name: COLUMN collection.slug; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN collection.slug IS 'URL-friendly, sluggified, indexed version of name.';


--
-- Name: COLUMN collection.description; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN collection.description IS 'Optional description for this Collection.';


--
-- Name: COLUMN collection.color; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN collection.color IS 'Seven-character hex color for this Collection, including the preceding hash sign.';


--
-- Name: COLUMN collection.archived; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN collection.archived IS 'Whether this Collection has been archived and should be hidden from users.';


--
-- Name: collection_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE collection_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE collection_id_seq OWNER TO postgres;

--
-- Name: collection_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE collection_id_seq OWNED BY collection.id;


--
-- Name: collection_revision; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE collection_revision (
    id integer NOT NULL,
    before text NOT NULL,
    after text NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    remark text
);


ALTER TABLE collection_revision OWNER TO postgres;

--
-- Name: TABLE collection_revision; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE collection_revision IS 'Used to keep track of changes made to collections.';


--
-- Name: COLUMN collection_revision.before; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN collection_revision.before IS 'Serialized JSON of the collections graph before the changes.';


--
-- Name: COLUMN collection_revision.after; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN collection_revision.after IS 'Serialized JSON of the collections graph after the changes.';


--
-- Name: COLUMN collection_revision.user_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN collection_revision.user_id IS 'The ID of the admin who made this set of changes.';


--
-- Name: COLUMN collection_revision.created_at; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN collection_revision.created_at IS 'The timestamp of when these changes were made.';


--
-- Name: COLUMN collection_revision.remark; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN collection_revision.remark IS 'Optional remarks explaining why these changes were made.';


--
-- Name: collection_revision_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE collection_revision_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE collection_revision_id_seq OWNER TO postgres;

--
-- Name: collection_revision_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE collection_revision_id_seq OWNED BY collection_revision.id;


--
-- Name: computation_job; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE computation_job (
    id integer NOT NULL,
    creator_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    type character varying(254) NOT NULL,
    status character varying(254) NOT NULL,
    context text,
    ended_at timestamp without time zone
);


ALTER TABLE computation_job OWNER TO postgres;

--
-- Name: TABLE computation_job; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE computation_job IS 'Stores submitted async computation jobs.';


--
-- Name: computation_job_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE computation_job_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE computation_job_id_seq OWNER TO postgres;

--
-- Name: computation_job_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE computation_job_id_seq OWNED BY computation_job.id;


--
-- Name: computation_job_result; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE computation_job_result (
    id integer NOT NULL,
    job_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    permanence character varying(254) NOT NULL,
    payload text NOT NULL
);


ALTER TABLE computation_job_result OWNER TO postgres;

--
-- Name: TABLE computation_job_result; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE computation_job_result IS 'Stores results of async computation jobs.';


--
-- Name: computation_job_result_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE computation_job_result_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE computation_job_result_id_seq OWNER TO postgres;

--
-- Name: computation_job_result_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE computation_job_result_id_seq OWNED BY computation_job_result.id;


--
-- Name: core_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE core_session (
    id character varying(254) NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp with time zone NOT NULL
);


ALTER TABLE core_session OWNER TO postgres;

--
-- Name: core_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE core_user (
    id integer NOT NULL,
    email character varying(254) NOT NULL,
    first_name character varying(254) NOT NULL,
    last_name character varying(254) NOT NULL,
    password character varying(254) NOT NULL,
    password_salt character varying(254) DEFAULT 'default'::character varying NOT NULL,
    date_joined timestamp with time zone NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    is_active boolean NOT NULL,
    reset_token character varying(254),
    reset_triggered bigint,
    is_qbnewb boolean DEFAULT true NOT NULL,
    google_auth boolean DEFAULT false NOT NULL,
    ldap_auth boolean DEFAULT false NOT NULL
);


ALTER TABLE core_user OWNER TO postgres;

--
-- Name: core_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE core_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE core_user_id_seq OWNER TO postgres;

--
-- Name: core_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE core_user_id_seq OWNED BY core_user.id;


--
-- Name: dashboard_favorite; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE dashboard_favorite (
    id integer NOT NULL,
    user_id integer NOT NULL,
    dashboard_id integer NOT NULL
);


ALTER TABLE dashboard_favorite OWNER TO postgres;

--
-- Name: TABLE dashboard_favorite; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE dashboard_favorite IS 'Presence of a row here indicates a given User has favorited a given Dashboard.';


--
-- Name: COLUMN dashboard_favorite.user_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN dashboard_favorite.user_id IS 'ID of the User who favorited the Dashboard.';


--
-- Name: COLUMN dashboard_favorite.dashboard_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN dashboard_favorite.dashboard_id IS 'ID of the Dashboard favorited by the User.';


--
-- Name: dashboard_favorite_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE dashboard_favorite_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dashboard_favorite_id_seq OWNER TO postgres;

--
-- Name: dashboard_favorite_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE dashboard_favorite_id_seq OWNED BY dashboard_favorite.id;


--
-- Name: dashboardcard_series; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE dashboardcard_series (
    id integer NOT NULL,
    dashboardcard_id integer NOT NULL,
    card_id integer NOT NULL,
    "position" integer NOT NULL
);


ALTER TABLE dashboardcard_series OWNER TO postgres;

--
-- Name: dashboardcard_series_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE dashboardcard_series_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dashboardcard_series_id_seq OWNER TO postgres;

--
-- Name: dashboardcard_series_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE dashboardcard_series_id_seq OWNED BY dashboardcard_series.id;


--
-- Name: data_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE data_migrations (
    id character varying(254) NOT NULL,
    "timestamp" timestamp without time zone NOT NULL
);


ALTER TABLE data_migrations OWNER TO postgres;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE databasechangelog OWNER TO postgres;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE databasechangeloglock OWNER TO postgres;

--
-- Name: dependency; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE dependency (
    id integer NOT NULL,
    model character varying(32) NOT NULL,
    model_id integer NOT NULL,
    dependent_on_model character varying(32) NOT NULL,
    dependent_on_id integer NOT NULL,
    created_at timestamp with time zone NOT NULL
);


ALTER TABLE dependency OWNER TO postgres;

--
-- Name: dependency_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE dependency_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dependency_id_seq OWNER TO postgres;

--
-- Name: dependency_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE dependency_id_seq OWNED BY dependency.id;


--
-- Name: dimension; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE dimension (
    id integer NOT NULL,
    field_id integer NOT NULL,
    name character varying(254) NOT NULL,
    type character varying(254) NOT NULL,
    human_readable_field_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE dimension OWNER TO postgres;

--
-- Name: TABLE dimension; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE dimension IS 'Stores references to alternate views of existing fields, such as remapping an integer to a description, like an enum';


--
-- Name: COLUMN dimension.field_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN dimension.field_id IS 'ID of the field this dimension row applies to';


--
-- Name: COLUMN dimension.name; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN dimension.name IS 'Short description used as the display name of this new column';


--
-- Name: COLUMN dimension.type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN dimension.type IS 'Either internal for a user defined remapping or external for a foreign key based remapping';


--
-- Name: COLUMN dimension.human_readable_field_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN dimension.human_readable_field_id IS 'Only used with external type remappings. Indicates which field on the FK related table to use for display';


--
-- Name: COLUMN dimension.created_at; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN dimension.created_at IS 'The timestamp of when the dimension was created.';


--
-- Name: COLUMN dimension.updated_at; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN dimension.updated_at IS 'The timestamp of when these dimension was last updated.';


--
-- Name: dimension_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE dimension_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE dimension_id_seq OWNER TO postgres;

--
-- Name: dimension_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE dimension_id_seq OWNED BY dimension.id;


--
-- Name: label; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE label (
    id integer NOT NULL,
    name character varying(254) NOT NULL,
    slug character varying(254) NOT NULL,
    icon character varying(128)
);


ALTER TABLE label OWNER TO postgres;

--
-- Name: label_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE label_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE label_id_seq OWNER TO postgres;

--
-- Name: label_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE label_id_seq OWNED BY label.id;


--
-- Name: metabase_database; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE metabase_database (
    id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    name character varying(254) NOT NULL,
    description text,
    details text,
    engine character varying(254) NOT NULL,
    is_sample boolean DEFAULT false NOT NULL,
    is_full_sync boolean DEFAULT true NOT NULL,
    points_of_interest text,
    caveats text,
    metadata_sync_schedule character varying(254) DEFAULT '0 50 * * * ? *'::character varying NOT NULL,
    cache_field_values_schedule character varying(254) DEFAULT '0 50 0 * * ? *'::character varying NOT NULL,
    timezone character varying(254),
    is_on_demand boolean DEFAULT false NOT NULL
);


ALTER TABLE metabase_database OWNER TO postgres;

--
-- Name: COLUMN metabase_database.metadata_sync_schedule; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN metabase_database.metadata_sync_schedule IS 'The cron schedule string for when this database should undergo the metadata sync process (and analysis for new fields).';


--
-- Name: COLUMN metabase_database.cache_field_values_schedule; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN metabase_database.cache_field_values_schedule IS 'The cron schedule string for when FieldValues for eligible Fields should be updated.';


--
-- Name: COLUMN metabase_database.timezone; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN metabase_database.timezone IS 'Timezone identifier for the database, set by the sync process';


--
-- Name: COLUMN metabase_database.is_on_demand; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN metabase_database.is_on_demand IS 'Whether we should do On-Demand caching of FieldValues for this DB. This means FieldValues are updated when their Field is used in a Dashboard or Card param.';


--
-- Name: metabase_database_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE metabase_database_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE metabase_database_id_seq OWNER TO postgres;

--
-- Name: metabase_database_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE metabase_database_id_seq OWNED BY metabase_database.id;


--
-- Name: metabase_field; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE metabase_field (
    id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    name character varying(254) NOT NULL,
    base_type character varying(255) NOT NULL,
    special_type character varying(255),
    active boolean DEFAULT true NOT NULL,
    description text,
    preview_display boolean DEFAULT true NOT NULL,
    "position" integer DEFAULT 0 NOT NULL,
    table_id integer NOT NULL,
    parent_id integer,
    display_name character varying(254),
    visibility_type character varying(32) DEFAULT 'normal'::character varying NOT NULL,
    fk_target_field_id integer,
    raw_column_id integer,
    last_analyzed timestamp with time zone,
    points_of_interest text,
    caveats text,
    fingerprint text,
    fingerprint_version integer DEFAULT 0 NOT NULL
);


ALTER TABLE metabase_field OWNER TO postgres;

--
-- Name: COLUMN metabase_field.fingerprint; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN metabase_field.fingerprint IS 'Serialized JSON containing non-identifying information about this Field, such as min, max, and percent JSON. Used for classification.';


--
-- Name: COLUMN metabase_field.fingerprint_version; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN metabase_field.fingerprint_version IS 'The version of the fingerprint for this Field. Used so we can keep track of which Fields need to be analyzed again when new things are added to fingerprints.';


--
-- Name: metabase_field_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE metabase_field_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE metabase_field_id_seq OWNER TO postgres;

--
-- Name: metabase_field_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE metabase_field_id_seq OWNED BY metabase_field.id;


--
-- Name: metabase_fieldvalues; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE metabase_fieldvalues (
    id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    "values" text,
    human_readable_values text,
    field_id integer NOT NULL
);


ALTER TABLE metabase_fieldvalues OWNER TO postgres;

--
-- Name: metabase_fieldvalues_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE metabase_fieldvalues_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE metabase_fieldvalues_id_seq OWNER TO postgres;

--
-- Name: metabase_fieldvalues_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE metabase_fieldvalues_id_seq OWNED BY metabase_fieldvalues.id;


--
-- Name: metabase_table; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE metabase_table (
    id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    name character varying(254) NOT NULL,
    rows bigint,
    description text,
    entity_name character varying(254),
    entity_type character varying(254),
    active boolean NOT NULL,
    db_id integer NOT NULL,
    display_name character varying(254),
    visibility_type character varying(254),
    schema character varying(254),
    raw_table_id integer,
    points_of_interest text,
    caveats text,
    show_in_getting_started boolean DEFAULT false NOT NULL
);


ALTER TABLE metabase_table OWNER TO postgres;

--
-- Name: metabase_table_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE metabase_table_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE metabase_table_id_seq OWNER TO postgres;

--
-- Name: metabase_table_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE metabase_table_id_seq OWNED BY metabase_table.id;


--
-- Name: metric; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE metric (
    id integer NOT NULL,
    table_id integer NOT NULL,
    creator_id integer NOT NULL,
    name character varying(254) NOT NULL,
    description text,
    is_active boolean DEFAULT true NOT NULL,
    definition text NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    points_of_interest text,
    caveats text,
    how_is_this_calculated text,
    show_in_getting_started boolean DEFAULT false NOT NULL
);


ALTER TABLE metric OWNER TO postgres;

--
-- Name: metric_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE metric_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE metric_id_seq OWNER TO postgres;

--
-- Name: metric_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE metric_id_seq OWNED BY metric.id;


--
-- Name: metric_important_field; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE metric_important_field (
    id integer NOT NULL,
    metric_id integer NOT NULL,
    field_id integer NOT NULL
);


ALTER TABLE metric_important_field OWNER TO postgres;

--
-- Name: metric_important_field_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE metric_important_field_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE metric_important_field_id_seq OWNER TO postgres;

--
-- Name: metric_important_field_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE metric_important_field_id_seq OWNED BY metric_important_field.id;


--
-- Name: permissions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE permissions (
    id integer NOT NULL,
    object character varying(254) NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE permissions OWNER TO postgres;

--
-- Name: permissions_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE permissions_group (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE permissions_group OWNER TO postgres;

--
-- Name: permissions_group_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE permissions_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE permissions_group_id_seq OWNER TO postgres;

--
-- Name: permissions_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE permissions_group_id_seq OWNED BY permissions_group.id;


--
-- Name: permissions_group_membership; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE permissions_group_membership (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE permissions_group_membership OWNER TO postgres;

--
-- Name: permissions_group_membership_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE permissions_group_membership_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE permissions_group_membership_id_seq OWNER TO postgres;

--
-- Name: permissions_group_membership_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE permissions_group_membership_id_seq OWNED BY permissions_group_membership.id;


--
-- Name: permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE permissions_id_seq OWNER TO postgres;

--
-- Name: permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE permissions_id_seq OWNED BY permissions.id;


--
-- Name: permissions_revision; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE permissions_revision (
    id integer NOT NULL,
    before text NOT NULL,
    after text NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    remark text
);


ALTER TABLE permissions_revision OWNER TO postgres;

--
-- Name: TABLE permissions_revision; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE permissions_revision IS 'Used to keep track of changes made to permissions.';


--
-- Name: COLUMN permissions_revision.before; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN permissions_revision.before IS 'Serialized JSON of the permissions before the changes.';


--
-- Name: COLUMN permissions_revision.after; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN permissions_revision.after IS 'Serialized JSON of the permissions after the changes.';


--
-- Name: COLUMN permissions_revision.user_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN permissions_revision.user_id IS 'The ID of the admin who made this set of changes.';


--
-- Name: COLUMN permissions_revision.created_at; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN permissions_revision.created_at IS 'The timestamp of when these changes were made.';


--
-- Name: COLUMN permissions_revision.remark; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN permissions_revision.remark IS 'Optional remarks explaining why these changes were made.';


--
-- Name: permissions_revision_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE permissions_revision_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE permissions_revision_id_seq OWNER TO postgres;

--
-- Name: permissions_revision_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE permissions_revision_id_seq OWNED BY permissions_revision.id;


--
-- Name: pulse; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE pulse (
    id integer NOT NULL,
    creator_id integer NOT NULL,
    name character varying(254),
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    skip_if_empty boolean DEFAULT false NOT NULL,
    alert_condition character varying(254),
    alert_first_only boolean,
    alert_above_goal boolean
);


ALTER TABLE pulse OWNER TO postgres;

--
-- Name: COLUMN pulse.skip_if_empty; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN pulse.skip_if_empty IS 'Skip a scheduled Pulse if none of its questions have any results';


--
-- Name: COLUMN pulse.alert_condition; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN pulse.alert_condition IS 'Condition (i.e. "rows" or "goal") used as a guard for alerts';


--
-- Name: COLUMN pulse.alert_first_only; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN pulse.alert_first_only IS 'True if the alert should be disabled after the first notification';


--
-- Name: COLUMN pulse.alert_above_goal; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN pulse.alert_above_goal IS 'For a goal condition, alert when above the goal';


--
-- Name: pulse_card; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE pulse_card (
    id integer NOT NULL,
    pulse_id integer NOT NULL,
    card_id integer NOT NULL,
    "position" integer NOT NULL
);


ALTER TABLE pulse_card OWNER TO postgres;

--
-- Name: pulse_card_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE pulse_card_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pulse_card_id_seq OWNER TO postgres;

--
-- Name: pulse_card_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE pulse_card_id_seq OWNED BY pulse_card.id;


--
-- Name: pulse_channel; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE pulse_channel (
    id integer NOT NULL,
    pulse_id integer NOT NULL,
    channel_type character varying(32) NOT NULL,
    details text NOT NULL,
    schedule_type character varying(32) NOT NULL,
    schedule_hour integer,
    schedule_day character varying(64),
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    schedule_frame character varying(32),
    enabled boolean DEFAULT true NOT NULL
);


ALTER TABLE pulse_channel OWNER TO postgres;

--
-- Name: pulse_channel_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE pulse_channel_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pulse_channel_id_seq OWNER TO postgres;

--
-- Name: pulse_channel_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE pulse_channel_id_seq OWNED BY pulse_channel.id;


--
-- Name: pulse_channel_recipient; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE pulse_channel_recipient (
    id integer NOT NULL,
    pulse_channel_id integer NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE pulse_channel_recipient OWNER TO postgres;

--
-- Name: pulse_channel_recipient_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE pulse_channel_recipient_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pulse_channel_recipient_id_seq OWNER TO postgres;

--
-- Name: pulse_channel_recipient_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE pulse_channel_recipient_id_seq OWNED BY pulse_channel_recipient.id;


--
-- Name: pulse_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE pulse_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pulse_id_seq OWNER TO postgres;

--
-- Name: pulse_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE pulse_id_seq OWNED BY pulse.id;


--
-- Name: query; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE query (
    query_hash bytea NOT NULL,
    average_execution_time integer NOT NULL
);


ALTER TABLE query OWNER TO postgres;

--
-- Name: TABLE query; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE query IS 'Information (such as average execution time) for different queries that have been previously ran.';


--
-- Name: COLUMN query.query_hash; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN query.query_hash IS 'The hash of the query dictionary. (This is a 256-bit SHA3 hash of the query dict.)';


--
-- Name: COLUMN query.average_execution_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN query.average_execution_time IS 'Average execution time for the query, round to nearest number of milliseconds. This is updated as a rolling average.';


--
-- Name: query_cache; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE query_cache (
    query_hash bytea NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    results bytea NOT NULL
);


ALTER TABLE query_cache OWNER TO postgres;

--
-- Name: TABLE query_cache; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE query_cache IS 'Cached results of queries are stored here when using the DB-based query cache.';


--
-- Name: COLUMN query_cache.query_hash; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN query_cache.query_hash IS 'The hash of the query dictionary. (This is a 256-bit SHA3 hash of the query dict).';


--
-- Name: COLUMN query_cache.updated_at; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN query_cache.updated_at IS 'The timestamp of when these query results were last refreshed.';


--
-- Name: COLUMN query_cache.results; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN query_cache.results IS 'Cached, compressed results of running the query with the given hash.';


--
-- Name: query_execution; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE query_execution (
    id integer NOT NULL,
    hash bytea NOT NULL,
    started_at timestamp without time zone NOT NULL,
    running_time integer NOT NULL,
    result_rows integer NOT NULL,
    native boolean NOT NULL,
    context character varying(32),
    error text,
    executor_id integer,
    card_id integer,
    dashboard_id integer,
    pulse_id integer
);


ALTER TABLE query_execution OWNER TO postgres;

--
-- Name: TABLE query_execution; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TABLE query_execution IS 'A log of executed queries, used for calculating historic execution times, auditing, and other purposes.';


--
-- Name: COLUMN query_execution.hash; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN query_execution.hash IS 'The hash of the query dictionary. This is a 256-bit SHA3 hash of the query.';


--
-- Name: COLUMN query_execution.started_at; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN query_execution.started_at IS 'Timestamp of when this query started running.';


--
-- Name: COLUMN query_execution.running_time; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN query_execution.running_time IS 'The time, in milliseconds, this query took to complete.';


--
-- Name: COLUMN query_execution.result_rows; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN query_execution.result_rows IS 'Number of rows in the query results.';


--
-- Name: COLUMN query_execution.native; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN query_execution.native IS 'Whether the query was a native query, as opposed to an MBQL one (e.g., created with the GUI).';


--
-- Name: COLUMN query_execution.context; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN query_execution.context IS 'Short string specifying how this query was executed, e.g. in a Dashboard or Pulse.';


--
-- Name: COLUMN query_execution.error; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN query_execution.error IS 'Error message returned by failed query, if any.';


--
-- Name: COLUMN query_execution.executor_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN query_execution.executor_id IS 'The ID of the User who triggered this query execution, if any.';


--
-- Name: COLUMN query_execution.card_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN query_execution.card_id IS 'The ID of the Card (Question) associated with this query execution, if any.';


--
-- Name: COLUMN query_execution.dashboard_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN query_execution.dashboard_id IS 'The ID of the Dashboard associated with this query execution, if any.';


--
-- Name: COLUMN query_execution.pulse_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN query_execution.pulse_id IS 'The ID of the Pulse associated with this query execution, if any.';


--
-- Name: query_execution_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE query_execution_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE query_execution_id_seq OWNER TO postgres;

--
-- Name: query_execution_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE query_execution_id_seq OWNED BY query_execution.id;


--
-- Name: raw_column; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE raw_column (
    id integer NOT NULL,
    raw_table_id integer NOT NULL,
    active boolean NOT NULL,
    name character varying(255) NOT NULL,
    column_type character varying(128),
    is_pk boolean NOT NULL,
    fk_target_column_id integer,
    details text NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE raw_column OWNER TO postgres;

--
-- Name: raw_column_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE raw_column_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE raw_column_id_seq OWNER TO postgres;

--
-- Name: raw_column_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE raw_column_id_seq OWNED BY raw_column.id;


--
-- Name: raw_table; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE raw_table (
    id integer NOT NULL,
    database_id integer NOT NULL,
    active boolean NOT NULL,
    schema character varying(255),
    name character varying(255) NOT NULL,
    details text NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE raw_table OWNER TO postgres;

--
-- Name: raw_table_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE raw_table_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE raw_table_id_seq OWNER TO postgres;

--
-- Name: raw_table_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE raw_table_id_seq OWNED BY raw_table.id;


--
-- Name: report_card; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE report_card (
    id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    name character varying(254) NOT NULL,
    description text,
    display character varying(254) NOT NULL,
    dataset_query text NOT NULL,
    visualization_settings text NOT NULL,
    creator_id integer NOT NULL,
    database_id integer,
    table_id integer,
    query_type character varying(16),
    archived boolean DEFAULT false NOT NULL,
    collection_id integer,
    public_uuid character(36),
    made_public_by_id integer,
    enable_embedding boolean DEFAULT false NOT NULL,
    embedding_params text,
    cache_ttl integer,
    result_metadata text
);


ALTER TABLE report_card OWNER TO postgres;

--
-- Name: COLUMN report_card.collection_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN report_card.collection_id IS 'Optional ID of Collection this Card belongs to.';


--
-- Name: COLUMN report_card.public_uuid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN report_card.public_uuid IS 'Unique UUID used to in publically-accessible links to this Card.';


--
-- Name: COLUMN report_card.made_public_by_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN report_card.made_public_by_id IS 'The ID of the User who first publically shared this Card.';


--
-- Name: COLUMN report_card.enable_embedding; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN report_card.enable_embedding IS 'Is this Card allowed to be embedded in different websites (using a signed JWT)?';


--
-- Name: COLUMN report_card.embedding_params; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN report_card.embedding_params IS 'Serialized JSON containing information about required parameters that must be supplied when embedding this Card.';


--
-- Name: COLUMN report_card.cache_ttl; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN report_card.cache_ttl IS 'The maximum time, in seconds, to return cached results for this Card rather than running a new query.';


--
-- Name: COLUMN report_card.result_metadata; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN report_card.result_metadata IS 'Serialized JSON containing metadata about the result columns from running the query.';


--
-- Name: report_card_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE report_card_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE report_card_id_seq OWNER TO postgres;

--
-- Name: report_card_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE report_card_id_seq OWNED BY report_card.id;


--
-- Name: report_cardfavorite; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE report_cardfavorite (
    id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    card_id integer NOT NULL,
    owner_id integer NOT NULL
);


ALTER TABLE report_cardfavorite OWNER TO postgres;

--
-- Name: report_cardfavorite_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE report_cardfavorite_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE report_cardfavorite_id_seq OWNER TO postgres;

--
-- Name: report_cardfavorite_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE report_cardfavorite_id_seq OWNED BY report_cardfavorite.id;


--
-- Name: report_dashboard; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE report_dashboard (
    id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    name character varying(254) NOT NULL,
    description text,
    creator_id integer NOT NULL,
    parameters text NOT NULL,
    points_of_interest text,
    caveats text,
    show_in_getting_started boolean DEFAULT false NOT NULL,
    public_uuid character(36),
    made_public_by_id integer,
    enable_embedding boolean DEFAULT false NOT NULL,
    embedding_params text,
    archived boolean DEFAULT false NOT NULL,
    "position" integer
);


ALTER TABLE report_dashboard OWNER TO postgres;

--
-- Name: COLUMN report_dashboard.public_uuid; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN report_dashboard.public_uuid IS 'Unique UUID used to in publically-accessible links to this Dashboard.';


--
-- Name: COLUMN report_dashboard.made_public_by_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN report_dashboard.made_public_by_id IS 'The ID of the User who first publically shared this Dashboard.';


--
-- Name: COLUMN report_dashboard.enable_embedding; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN report_dashboard.enable_embedding IS 'Is this Dashboard allowed to be embedded in different websites (using a signed JWT)?';


--
-- Name: COLUMN report_dashboard.embedding_params; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN report_dashboard.embedding_params IS 'Serialized JSON containing information about required parameters that must be supplied when embedding this Dashboard.';


--
-- Name: COLUMN report_dashboard.archived; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN report_dashboard.archived IS 'Is this Dashboard archived (effectively treated as deleted?)';


--
-- Name: COLUMN report_dashboard."position"; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN report_dashboard."position" IS 'The position this Dashboard should appear in the Dashboards list, lower-numbered positions appearing before higher numbered ones.';


--
-- Name: report_dashboard_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE report_dashboard_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE report_dashboard_id_seq OWNER TO postgres;

--
-- Name: report_dashboard_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE report_dashboard_id_seq OWNED BY report_dashboard.id;


--
-- Name: report_dashboardcard; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE report_dashboardcard (
    id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    "sizeX" integer NOT NULL,
    "sizeY" integer NOT NULL,
    "row" integer DEFAULT 0 NOT NULL,
    col integer DEFAULT 0 NOT NULL,
    card_id integer NOT NULL,
    dashboard_id integer NOT NULL,
    parameter_mappings text NOT NULL,
    visualization_settings text NOT NULL
);


ALTER TABLE report_dashboardcard OWNER TO postgres;

--
-- Name: report_dashboardcard_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE report_dashboardcard_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE report_dashboardcard_id_seq OWNER TO postgres;

--
-- Name: report_dashboardcard_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE report_dashboardcard_id_seq OWNED BY report_dashboardcard.id;


--
-- Name: revision; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE revision (
    id integer NOT NULL,
    model character varying(16) NOT NULL,
    model_id integer NOT NULL,
    user_id integer NOT NULL,
    "timestamp" timestamp with time zone NOT NULL,
    object character varying NOT NULL,
    is_reversion boolean DEFAULT false NOT NULL,
    is_creation boolean DEFAULT false NOT NULL,
    message text
);


ALTER TABLE revision OWNER TO postgres;

--
-- Name: revision_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE revision_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE revision_id_seq OWNER TO postgres;

--
-- Name: revision_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE revision_id_seq OWNED BY revision.id;


--
-- Name: segment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE segment (
    id integer NOT NULL,
    table_id integer NOT NULL,
    creator_id integer NOT NULL,
    name character varying(254) NOT NULL,
    description text,
    is_active boolean DEFAULT true NOT NULL,
    definition text NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    points_of_interest text,
    caveats text,
    show_in_getting_started boolean DEFAULT false NOT NULL
);


ALTER TABLE segment OWNER TO postgres;

--
-- Name: segment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE segment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE segment_id_seq OWNER TO postgres;

--
-- Name: segment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE segment_id_seq OWNED BY segment.id;


--
-- Name: setting; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE setting (
    key character varying(254) NOT NULL,
    value text NOT NULL
);


ALTER TABLE setting OWNER TO postgres;

--
-- Name: view_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE view_log (
    id integer NOT NULL,
    user_id integer,
    model character varying(16) NOT NULL,
    model_id integer NOT NULL,
    "timestamp" timestamp with time zone NOT NULL
);


ALTER TABLE view_log OWNER TO postgres;

--
-- Name: view_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE view_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE view_log_id_seq OWNER TO postgres;

--
-- Name: view_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE view_log_id_seq OWNED BY view_log.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY activity ALTER COLUMN id SET DEFAULT nextval('activity_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY card_label ALTER COLUMN id SET DEFAULT nextval('card_label_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY collection ALTER COLUMN id SET DEFAULT nextval('collection_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY collection_revision ALTER COLUMN id SET DEFAULT nextval('collection_revision_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY computation_job ALTER COLUMN id SET DEFAULT nextval('computation_job_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY computation_job_result ALTER COLUMN id SET DEFAULT nextval('computation_job_result_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY core_user ALTER COLUMN id SET DEFAULT nextval('core_user_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dashboard_favorite ALTER COLUMN id SET DEFAULT nextval('dashboard_favorite_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dashboardcard_series ALTER COLUMN id SET DEFAULT nextval('dashboardcard_series_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dependency ALTER COLUMN id SET DEFAULT nextval('dependency_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dimension ALTER COLUMN id SET DEFAULT nextval('dimension_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY label ALTER COLUMN id SET DEFAULT nextval('label_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY metabase_database ALTER COLUMN id SET DEFAULT nextval('metabase_database_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY metabase_field ALTER COLUMN id SET DEFAULT nextval('metabase_field_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY metabase_fieldvalues ALTER COLUMN id SET DEFAULT nextval('metabase_fieldvalues_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY metabase_table ALTER COLUMN id SET DEFAULT nextval('metabase_table_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY metric ALTER COLUMN id SET DEFAULT nextval('metric_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY metric_important_field ALTER COLUMN id SET DEFAULT nextval('metric_important_field_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY permissions ALTER COLUMN id SET DEFAULT nextval('permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY permissions_group ALTER COLUMN id SET DEFAULT nextval('permissions_group_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY permissions_group_membership ALTER COLUMN id SET DEFAULT nextval('permissions_group_membership_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY permissions_revision ALTER COLUMN id SET DEFAULT nextval('permissions_revision_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pulse ALTER COLUMN id SET DEFAULT nextval('pulse_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pulse_card ALTER COLUMN id SET DEFAULT nextval('pulse_card_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pulse_channel ALTER COLUMN id SET DEFAULT nextval('pulse_channel_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pulse_channel_recipient ALTER COLUMN id SET DEFAULT nextval('pulse_channel_recipient_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY query_execution ALTER COLUMN id SET DEFAULT nextval('query_execution_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY raw_column ALTER COLUMN id SET DEFAULT nextval('raw_column_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY raw_table ALTER COLUMN id SET DEFAULT nextval('raw_table_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY report_card ALTER COLUMN id SET DEFAULT nextval('report_card_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY report_cardfavorite ALTER COLUMN id SET DEFAULT nextval('report_cardfavorite_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY report_dashboard ALTER COLUMN id SET DEFAULT nextval('report_dashboard_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY report_dashboardcard ALTER COLUMN id SET DEFAULT nextval('report_dashboardcard_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY revision ALTER COLUMN id SET DEFAULT nextval('revision_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY segment ALTER COLUMN id SET DEFAULT nextval('segment_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY view_log ALTER COLUMN id SET DEFAULT nextval('view_log_id_seq'::regclass);


--
-- Data for Name: activity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY activity (id, topic, "timestamp", user_id, model, model_id, database_id, table_id, custom_id, details) FROM stdin;
1	install	2018-05-10 09:33:32.333+05	\N	install	\N	\N	\N	\N	{}
2	user-joined	2018-05-10 09:35:46.969+05	1	user	1	\N	\N	\N	{}
3	dashboard-create	2018-05-10 09:36:33.491+05	1	dashboard	1	\N	\N	\N	{"description":"Summary of Program showing main indicators and status of program","name":"Summary Program"}
4	card-create	2018-05-10 09:48:28.838+05	1	card	1	2	\N	\N	{"name":"NNT","description":"Number needed to treat"}
5	card-create	2018-05-10 09:49:40.957+05	1	card	2	2	\N	\N	{"name":"NNS","description":"Number needed to screen"}
6	dashboard-add-cards	2018-05-10 09:50:34.195+05	1	dashboard	1	\N	\N	\N	{"description":"Summary of Program showing main indicators and status of program","name":"Summary Program","dashcards":[{"name":"NNS","description":"Number needed to screen","id":1,"card_id":2}]}
7	dashboard-add-cards	2018-05-10 09:50:34.2+05	1	dashboard	1	\N	\N	\N	{"description":"Summary of Program showing main indicators and status of program","name":"Summary Program","dashcards":[{"name":"NNT","description":"Number needed to treat","id":2,"card_id":1}]}
8	card-update	2018-05-10 18:18:57.452+05	1	card	2	2	\N	\N	{"name":"NNS","description":"Number needed to screen"}
9	dashboard-remove-cards	2018-05-10 18:20:27.031+05	1	dashboard	1	\N	\N	\N	{"description":"Summary of Program showing main indicators and status of program","name":"Summary Program","dashcards":[{"name":"NNS","description":"Number needed to screen","id":1,"card_id":2}]}
10	dashboard-add-cards	2018-05-10 18:20:27.057+05	1	dashboard	1	\N	\N	\N	{"description":"Summary of Program showing main indicators and status of program","name":"Summary Program","dashcards":[{"name":"NNS","description":"Number needed to screen","id":3,"card_id":2}]}
11	card-update	2018-05-10 18:24:25.149+05	1	card	2	2	\N	\N	{"name":"NNS","description":"Number needed to screen"}
12	card-update	2018-05-10 18:26:14.033+05	1	card	2	2	\N	\N	{"name":"NNS","description":"Number needed to screen"}
13	card-create	2018-05-10 18:31:03.519+05	1	card	3	2	\N	\N	{"name":"Total Screenings","description":"Total number of people screened"}
14	dashboard-add-cards	2018-05-10 18:32:55.667+05	1	dashboard	1	\N	\N	\N	{"description":"Summary of Program showing main indicators and status of program","name":"Summary Program","dashcards":[{"name":"Total Screenings","description":"Total number of people screened","id":4,"card_id":3}]}
15	card-update	2018-05-10 18:34:58.266+05	1	card	2	2	\N	\N	{"name":"NNS","description":"Number needed to screen"}
16	dashboard-remove-cards	2018-05-10 18:36:30.026+05	1	dashboard	1	\N	\N	\N	{"description":"Summary of Program showing main indicators and status of program","name":"Summary Program","dashcards":[{"name":"NNS","description":"Number needed to screen","id":3,"card_id":2}]}
17	dashboard-add-cards	2018-05-10 18:36:30.045+05	1	dashboard	1	\N	\N	\N	{"description":"Summary of Program showing main indicators and status of program","name":"Summary Program","dashcards":[{"name":"NNS","description":"Number needed to screen","id":5,"card_id":2}]}
18	card-create	2018-05-11 16:15:46.049+05	1	card	4	2	\N	\N	{"name":"Screening Summary","description":null}
19	card-update	2018-05-11 17:17:08.465+05	1	card	4	2	\N	\N	{"name":"Screening Summary","description":null}
20	card-update	2018-05-11 17:20:48.536+05	1	card	4	2	\N	\N	{"name":"Screening Summary","description":null}
21	dashboard-add-cards	2018-05-11 17:22:33.895+05	1	dashboard	1	\N	\N	\N	{"description":"Summary of Program showing main indicators and status of program","name":"Summary Program","dashcards":[{"name":"Screening Summary","description":null,"id":6,"card_id":4}]}
22	card-update	2018-05-11 17:33:35.274+05	1	card	4	2	\N	\N	{"name":"Screening Summary","description":null}
23	card-create	2018-05-11 17:43:03.742+05	1	card	5	2	\N	\N	{"name":"Screening Summary trend over past 12 months","description":null}
24	card-update	2018-05-11 17:43:35.493+05	1	card	4	2	\N	\N	{"name":"Screening Summary","description":null}
25	dashboard-add-cards	2018-05-11 17:45:44.054+05	1	dashboard	1	\N	\N	\N	{"description":"Summary of Program showing main indicators and status of program","name":"Summary Program","dashcards":[{"name":"Screening Summary trend over past 12 months","description":null,"id":7,"card_id":5}]}
26	card-update	2018-05-11 17:49:20.575+05	1	card	5	2	\N	\N	{"name":"Screening Summary trend over past 12 months","description":null}
27	card-update	2018-05-11 20:32:26.257+05	1	card	4	2	\N	\N	{"name":"Screening Summary","description":null}
28	card-update	2018-05-11 20:34:45.364+05	1	card	5	2	\N	\N	{"name":"Screening Summary trend over past 12 months","description":null}
29	card-update	2018-05-11 20:36:46.576+05	1	card	5	2	\N	\N	{"name":"Screening Summary trend over past 12 months","description":null}
30	card-create	2018-05-12 10:24:17.279+05	1	card	6	2	\N	\N	{"name":"Patient Types by Month","description":null}
31	card-create	2018-05-12 10:30:36.794+05	1	card	7	2	\N	\N	{"name":"Summary Patient Types Enrolled","description":null}
32	dashboard-add-cards	2018-05-12 10:31:52.242+05	1	dashboard	1	\N	\N	\N	{"description":"Summary of Program showing main indicators and status of program","name":"Summary Program","dashcards":[{"name":"Summary Patient Types Enrolled","description":null,"id":8,"card_id":7}]}
33	card-update	2018-05-12 10:32:53.112+05	1	card	6	2	\N	\N	{"name":"Patient Types by Month","description":null}
34	card-update	2018-05-12 10:33:59.468+05	1	card	7	2	\N	\N	{"name":"Summary Patient Types Enrolled","description":null}
35	card-create	2018-05-12 11:37:41.511+05	1	card	8	2	\N	\N	{"name":"Summary TB Diagnosis","description":null}
36	card-update	2018-05-12 11:46:15.141+05	1	card	8	2	\N	\N	{"name":"Summary TB Diagnosis","description":null}
37	card-update	2018-05-12 11:46:53.383+05	1	card	1	2	\N	\N	{"name":"NNT","description":"Number needed to treat"}
38	card-update	2018-05-12 11:48:14.915+05	1	card	1	2	\N	\N	{"name":"NNT","description":"Number needed to treat"}
39	card-update	2018-05-12 12:16:08.773+05	1	card	8	2	\N	\N	{"name":"Summary TB Diagnosis","description":null}
40	card-create	2018-05-12 12:17:28.478+05	1	card	9	2	\N	\N	{"name":"Summary TB Diagnoses Type","description":null}
41	card-update	2018-05-12 12:21:16.683+05	1	card	8	2	\N	\N	{"name":"Summary TB Diagnosis","description":null}
42	dashboard-add-cards	2018-05-12 12:22:04.343+05	1	dashboard	1	\N	\N	\N	{"description":"Summary of Program showing main indicators and status of program","name":"Summary Program","dashcards":[{"name":"Summary TB Diagnoses Type","description":null,"id":9,"card_id":9}]}
43	card-create	2018-05-12 14:03:50.406+05	1	card	10	2	\N	\N	{"name":"Treatment Summary","description":null}
44	card-update	2018-05-12 14:07:49.408+05	1	card	10	2	\N	\N	{"name":"Treatment Summary","description":null}
45	card-update	2018-05-12 14:20:38.937+05	1	card	10	2	\N	\N	{"name":"Treatment Summary","description":null}
46	card-update	2018-05-12 14:22:06.95+05	1	card	7	2	\N	\N	{"name":"Summary Patient Types Enrolled","description":null}
47	card-create	2018-05-12 14:30:28.39+05	1	card	11	2	\N	\N	{"name":"Treatment Summary TB","description":null}
48	dashboard-add-cards	2018-05-12 14:31:27.99+05	1	dashboard	1	\N	\N	\N	{"description":"Summary of Program showing main indicators and status of program","name":"Summary Program","dashcards":[{"name":"Treatment Summary TB","description":null,"id":10,"card_id":11}]}
49	card-create	2018-05-12 15:00:13.554+05	1	card	12	2	\N	\N	{"name":"Treatment Outcome Summary","description":null}
50	card-update	2018-05-12 15:18:02.528+05	1	card	12	2	\N	\N	{"name":"Treatment Outcome Summary","description":null}
51	card-update	2018-05-12 15:20:36.884+05	1	card	12	2	\N	\N	{"name":"Treatment Outcome Summary","description":null}
52	dashboard-add-cards	2018-05-12 15:21:27.624+05	1	dashboard	1	\N	\N	\N	{"description":"Summary of Program showing main indicators and status of program","name":"Summary Program","dashcards":[{"name":"Treatment Outcome Summary","description":null,"id":11,"card_id":12}]}
53	card-update	2018-05-12 15:23:01.719+05	1	card	12	2	\N	\N	{"name":"Treatment Outcome Summary","description":null}
54	dashboard-create	2018-05-12 18:24:52.815+05	1	dashboard	2	\N	\N	\N	{"description":null,"name":"TB Reports"}
55	card-create	2018-05-12 19:31:59.422+05	1	card	13	2	\N	\N	{"name":"TB-01","description":null}
56	card-update	2018-05-12 20:48:56.416+05	1	card	13	2	\N	\N	{"name":"TB-01","description":null}
57	card-update	2018-05-12 21:20:25.126+05	1	card	13	2	\N	\N	{"name":"TB-01","description":null}
\.


--
-- Name: activity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('activity_id_seq', 57, true);


--
-- Data for Name: card_label; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY card_label (id, card_id, label_id) FROM stdin;
\.


--
-- Name: card_label_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('card_label_id_seq', 1, false);


--
-- Data for Name: collection; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY collection (id, name, slug, description, color, archived) FROM stdin;
\.


--
-- Name: collection_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('collection_id_seq', 1, false);


--
-- Data for Name: collection_revision; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY collection_revision (id, before, after, user_id, created_at, remark) FROM stdin;
\.


--
-- Name: collection_revision_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('collection_revision_id_seq', 1, false);


--
-- Data for Name: computation_job; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY computation_job (id, creator_id, created_at, updated_at, type, status, context, ended_at) FROM stdin;
\.


--
-- Name: computation_job_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('computation_job_id_seq', 1, false);


--
-- Data for Name: computation_job_result; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY computation_job_result (id, job_id, created_at, updated_at, permanence, payload) FROM stdin;
\.


--
-- Name: computation_job_result_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('computation_job_result_id_seq', 1, false);


--
-- Data for Name: core_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY core_session (id, user_id, created_at) FROM stdin;
61d4fec5-203d-4195-b411-41439ce709c2	1	2018-05-10 09:35:46.938+05
9b7b3ac8-6061-4f0b-a0b7-4bf1d1121586	1	2018-05-24 17:22:57.767+05
62efa200-8775-4fd5-8750-886f76d5e007	1	2018-05-25 06:53:20.431+05
\.


--
-- Data for Name: core_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY core_user (id, email, first_name, last_name, password, password_salt, date_joined, last_login, is_superuser, is_active, reset_token, reset_triggered, is_qbnewb, google_auth, ldap_auth) FROM stdin;
1	tbreach5.opensrp@gmail.com	TBREACH5	OpenSRP	$2a$10$iIslkVj0qiMLMr23bsArs.pLtAaroPkt7wlzpbwq1RJjTgdrHoHPe	14399a9b-5f3a-43ea-a882-17607db96c9f	2018-05-10 09:35:46.741+05	2018-05-25 06:53:20.447+05	t	t	\N	\N	f	f	f
\.


--
-- Name: core_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('core_user_id_seq', 1, true);


--
-- Data for Name: dashboard_favorite; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY dashboard_favorite (id, user_id, dashboard_id) FROM stdin;
\.


--
-- Name: dashboard_favorite_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('dashboard_favorite_id_seq', 1, false);


--
-- Data for Name: dashboardcard_series; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY dashboardcard_series (id, dashboardcard_id, card_id, "position") FROM stdin;
\.


--
-- Name: dashboardcard_series_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('dashboardcard_series_id_seq', 1, false);


--
-- Data for Name: data_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY data_migrations (id, "timestamp") FROM stdin;
set-card-database-and-table-ids	2018-05-10 09:33:31.722
set-mongodb-databases-ssl-false	2018-05-10 09:33:31.768
set-default-schemas	2018-05-10 09:33:31.776
set-admin-email	2018-05-10 09:33:31.787
remove-database-sync-activity-entries	2018-05-10 09:33:31.797
update-dashboards-to-new-grid	2018-05-10 09:33:31.803
migrate-field-visibility-type	2018-05-10 09:33:31.813
add-users-to-default-permissions-groups	2018-05-10 09:33:31.864
add-admin-group-root-entry	2018-05-10 09:33:31.876
add-databases-to-magic-permissions-groups	2018-05-10 09:33:31.892
migrate-field-types	2018-05-10 09:33:32.077
fix-invalid-field-types	2018-05-10 09:33:32.109
copy-site-url-setting-and-remove-trailing-slashes	2018-05-10 09:33:32.114
migrate-query-executions	2018-05-10 09:33:32.127
drop-old-query-execution-table	2018-05-10 09:33:32.141
ensure-protocol-specified-in-site-url	2018-05-10 09:33:32.148
populate-card-database-id	2018-05-10 09:33:32.151
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
4	cammsaul	migrations/000_migrations.yaml	2018-05-10 09:33:28.77806	3	EXECUTED	7:1ed887e91a846f4d6cbe84d1efd126c4	createTable tableName=setting		\N	3.5.3	\N	\N	5926779892
47	camsaul	migrations/000_migrations.yaml	2018-05-10 09:33:28.77806	46	EXECUTED	7:381e18d5008269e299f12c9726163675	createTable tableName=collection; createIndex indexName=idx_collection_slug, tableName=collection; addColumn tableName=report_card; createIndex indexName=idx_card_collection_id, tableName=report_card		\N	3.5.3	\N	\N	5926779892
48	camsaul	migrations/000_migrations.yaml	2018-05-10 09:33:28.77806	47	EXECUTED	7:b8957fda76bab207f99ced39353df1da	createTable tableName=collection_revision		\N	3.5.3	\N	\N	5926779892
61	camsaul	migrations/000_migrations.yaml	2018-05-10 09:33:28.77806	60	EXECUTED	7:070febe9fb610d73dc7bf69086f50a1d	addColumn tableName=metabase_field	Added 0.26.0	\N	3.5.3	\N	\N	5926779892
7	cammsaul	migrations/000_migrations.yaml	2018-05-10 09:33:28.77806	6	EXECUTED	7:baec0ec600ccc9bdadc176c1c4b29b77	addColumn tableName=metabase_field		\N	3.5.3	\N	\N	5926779892
8	tlrobinson	migrations/000_migrations.yaml	2018-05-10 09:33:28.77806	7	EXECUTED	7:ea2727c7ce666178cff436549f81ddbd	addColumn tableName=metabase_table; addColumn tableName=metabase_field		\N	3.5.3	\N	\N	5926779892
34	tlrobinson	migrations/000_migrations.yaml	2018-05-10 09:33:28.77806	33	EXECUTED	7:e65d70b4c914cfdf5b3ef9927565e899	addColumn tableName=pulse_channel		\N	3.5.3	\N	\N	5926779892
41	camsaul	migrations/000_migrations.yaml	2018-05-10 09:33:28.77806	40	EXECUTED	7:e1aa5b70f61426b29d74d38936e560de	dropColumn columnName=field_type, tableName=metabase_field; addDefaultValue columnName=active, tableName=metabase_field; addDefaultValue columnName=preview_display, tableName=metabase_field; addDefaultValue columnName=position, tableName=metabase_...		\N	3.5.3	\N	\N	5926779892
37	tlrobinson	migrations/000_migrations.yaml	2018-05-10 09:33:28.77806	36	EXECUTED	7:487dd1fa57af0f25edf3265ed9899588	addColumn tableName=query_queryexecution; addNotNullConstraint columnName=query_hash, tableName=query_queryexecution; createIndex indexName=idx_query_queryexecution_query_hash, tableName=query_queryexecution; createIndex indexName=idx_query_querye...		\N	3.5.3	\N	\N	5926779892
38	camsaul	migrations/000_migrations.yaml	2018-05-10 09:33:28.77806	37	EXECUTED	7:5e32fa14a0c34b99027e25901b7e3255	addColumn tableName=metabase_database; addColumn tableName=metabase_table; addColumn tableName=metabase_field; addColumn tableName=report_dashboard; addColumn tableName=metric; addColumn tableName=segment; addColumn tableName=metabase_database; ad...		\N	3.5.3	\N	\N	5926779892
16	agilliland	migrations/000_migrations.yaml	2018-05-10 09:33:28.77806	15	EXECUTED	7:a398a37dd953a0e82633d12658c6ac8f	dropNotNullConstraint columnName=last_login, tableName=core_user		\N	3.5.3	\N	\N	5926779892
17	agilliland	migrations/000_migrations.yaml	2018-05-10 09:33:28.77806	16	EXECUTED	7:5401ec35a5bd1275f93a7cac1ddd7591	addColumn tableName=metabase_database; sql		\N	3.5.3	\N	\N	5926779892
18	camsaul	migrations/000_migrations.yaml	2018-05-10 09:33:28.77806	17	EXECUTED	7:329d897d44ba9893fdafc9ce7e876d73	createTable tableName=data_migrations; createIndex indexName=idx_data_migrations_id, tableName=data_migrations		\N	3.5.3	\N	\N	5926779892
35	agilliland	migrations/000_migrations.yaml	2018-05-10 09:33:28.77806	34	EXECUTED	7:ab80b6b8e6dfc3fa3e8fa5954e3a8ec4	modifyDataType columnName=value, tableName=setting		\N	3.5.3	\N	\N	5926779892
36	agilliland	migrations/000_migrations.yaml	2018-05-10 09:33:28.77806	35	EXECUTED	7:de534c871471b400d70ee29122f23847	addColumn tableName=report_dashboard; addNotNullConstraint columnName=parameters, tableName=report_dashboard; addColumn tableName=report_dashboardcard; addNotNullConstraint columnName=parameter_mappings, tableName=report_dashboardcard		\N	3.5.3	\N	\N	5926779892
40	camsaul	migrations/000_migrations.yaml	2018-05-10 09:33:28.77806	39	EXECUTED	7:0ba56822308957969bf5ad5ea8ee6707	createTable tableName=permissions_group; createIndex indexName=idx_permissions_group_name, tableName=permissions_group; createTable tableName=permissions_group_membership; addUniqueConstraint constraintName=unique_permissions_group_membership_user...		\N	3.5.3	\N	\N	5926779892
2	agilliland	migrations/000_migrations.yaml	2018-05-10 09:33:28.77806	2	EXECUTED	7:816381628d3155232ae439826bfc3992	createTable tableName=core_session		\N	3.5.3	\N	\N	5926779892
45	tlrobinson	migrations/000_migrations.yaml	2018-05-10 09:33:28.77806	44	EXECUTED	7:9198081e3329df7903d9016804ef0cf0	addColumn tableName=report_dashboardcard; addNotNullConstraint columnName=visualization_settings, tableName=report_dashboardcard		\N	3.5.3	\N	\N	5926779892
46	camsaul	migrations/000_migrations.yaml	2018-05-10 09:33:28.77806	45	EXECUTED	7:aab12e940225b458986e15cf53d5d816	addNotNullConstraint columnName=row, tableName=report_dashboardcard; addNotNullConstraint columnName=col, tableName=report_dashboardcard; addDefaultValue columnName=row, tableName=report_dashboardcard; addDefaultValue columnName=col, tableName=rep...		\N	3.5.3	\N	\N	5926779892
62	senior	migrations/000_migrations.yaml	2018-05-10 09:33:28.77806	61	EXECUTED	7:db49b2acae484cf753c67e0858e4b17f	addColumn tableName=metabase_database	Added 0.26.0	\N	3.5.3	\N	\N	5926779892
63	camsaul	migrations/000_migrations.yaml	2018-05-10 09:33:28.77806	62	EXECUTED	7:fd58f763ac416881865080b693ce9aab	addColumn tableName=metabase_database	Added 0.26.0	\N	3.5.3	\N	\N	5926779892
64	senior	migrations/000_migrations.yaml	2018-05-10 09:33:28.77806	63	EXECUTED	7:1da13bf2e4248f9b47587f657c204dc3	dropForeignKeyConstraint baseTableName=raw_table, constraintName=fk_rawtable_ref_database	Added 0.26.0	\N	3.5.3	\N	\N	5926779892
67	attekei	migrations/000_migrations.yaml	2018-05-10 09:33:28.77806	65	EXECUTED	7:3fd33c68aff3798d5aa9777264fba837	createTable tableName=computation_job; createTable tableName=computation_job_result	Added 0.27.0	\N	3.5.3	\N	\N	5926779892
68	sbelak	migrations/000_migrations.yaml	2018-05-10 09:33:28.77806	66	EXECUTED	7:be83b1d77e3c3effde34aecb79e781dc	addColumn tableName=computation_job	Added 0.27.0	\N	3.5.3	\N	\N	5926779892
9	tlrobinson	migrations/000_migrations.yaml	2018-05-10 09:33:28.77806	8	EXECUTED	7:c05cf8a25248b38e281e8e85de4275a2	addColumn tableName=metabase_table		\N	3.5.3	\N	\N	5926779892
10	cammsaul	migrations/000_migrations.yaml	2018-05-10 09:33:28.77806	9	EXECUTED	7:ec4f8eecc37fdc8c22440490de3a13f0	createTable tableName=revision; createIndex indexName=idx_revision_model_model_id, tableName=revision		\N	3.5.3	\N	\N	5926779892
13	agilliland	migrations/000_migrations.yaml	2018-05-10 09:33:28.77806	12	EXECUTED	7:20a2ef1765573854864909ec2e7de766	createTable tableName=activity; createIndex indexName=idx_activity_timestamp, tableName=activity; createIndex indexName=idx_activity_user_id, tableName=activity; createIndex indexName=idx_activity_custom_id, tableName=activity		\N	3.5.3	\N	\N	5926779892
14	agilliland	migrations/000_migrations.yaml	2018-05-10 09:33:28.77806	13	EXECUTED	7:6614fcaca4e41d003ce26de5cbc882f7	createTable tableName=view_log; createIndex indexName=idx_view_log_user_id, tableName=view_log; createIndex indexName=idx_view_log_timestamp, tableName=view_log		\N	3.5.3	\N	\N	5926779892
19	camsaul	migrations/000_migrations.yaml	2018-05-10 09:33:28.77806	18	EXECUTED	7:e8fa976811e4d58d42a45804affa1d07	addColumn tableName=metabase_table		\N	3.5.3	\N	\N	5926779892
20	agilliland	migrations/000_migrations.yaml	2018-05-10 09:33:28.77806	19	EXECUTED	7:9c5fedbd888307edf521a6a547f96f99	createTable tableName=pulse; createIndex indexName=idx_pulse_creator_id, tableName=pulse; createTable tableName=pulse_card; createIndex indexName=idx_pulse_card_pulse_id, tableName=pulse_card; createIndex indexName=idx_pulse_card_card_id, tableNam...		\N	3.5.3	\N	\N	5926779892
26	agilliland	migrations/000_migrations.yaml	2018-05-10 09:33:28.77806	25	EXECUTED	7:ac7f40d2a3fbf3fea7936aa79bb1532b	addColumn tableName=metabase_database; sql		\N	3.5.3	\N	\N	5926779892
27	agilliland	migrations/000_migrations.yaml	2018-05-10 09:33:28.77806	26	EXECUTED	7:e3a52bd649da7940246e4236b204714b	createTable tableName=dashboardcard_series; createIndex indexName=idx_dashboardcard_series_dashboardcard_id, tableName=dashboardcard_series; createIndex indexName=idx_dashboardcard_series_card_id, tableName=dashboardcard_series		\N	3.5.3	\N	\N	5926779892
30	agilliland	migrations/000_migrations.yaml	2018-05-10 09:33:28.77806	29	EXECUTED	7:7b5245de5d964eedb5cd6fdf5afdb6fd	addColumn tableName=metabase_field; addNotNullConstraint columnName=visibility_type, tableName=metabase_field		\N	3.5.3	\N	\N	5926779892
31	agilliland	migrations/000_migrations.yaml	2018-05-10 09:33:28.77806	30	EXECUTED	7:347281cdb65a285b03aeaf77cb28e618	addColumn tableName=metabase_field		\N	3.5.3	\N	\N	5926779892
57	camsaul	migrations/000_migrations.yaml	2018-05-10 09:33:28.77806	56	EXECUTED	7:5d51b16e22be3c81a27d3b5b345a8270	addColumn tableName=report_card	Added 0.25.0	\N	3.5.3	\N	\N	5926779892
42	camsaul	migrations/000_migrations.yaml	2018-05-10 09:33:28.77806	41	EXECUTED	7:779407e2ea3b8d89092fc9f72e29fdaa	dropForeignKeyConstraint baseTableName=query_queryexecution, constraintName=fk_queryexecution_ref_query_id; dropColumn columnName=query_id, tableName=query_queryexecution; dropColumn columnName=is_staff, tableName=core_user; dropColumn columnName=...		\N	3.5.3	\N	\N	5926779892
43	camsaul	migrations/000_migrations.yaml	2018-05-10 09:33:28.77806	42	EXECUTED	7:dbc18c8ca697fc335869f0ed0eb5f4cb	createTable tableName=permissions_revision		\N	3.5.3	\N	\N	5926779892
44	camsaul	migrations/000_migrations.yaml	2018-05-10 09:33:28.77806	43	EXECUTED	7:1d09a61933bbc5a01b0ddef7bd1b1336	dropColumn columnName=public_perms, tableName=report_card; dropColumn columnName=public_perms, tableName=report_dashboard; dropColumn columnName=public_perms, tableName=pulse		\N	3.5.3	\N	\N	5926779892
32	camsaul	migrations/000_migrations.yaml	2018-05-10 09:33:28.77806	31	EXECUTED	7:ff40b5fbe06dc5221d0b9223992ece25	createTable tableName=label; createIndex indexName=idx_label_slug, tableName=label; createTable tableName=card_label; addUniqueConstraint constraintName=unique_card_label_card_id_label_id, tableName=card_label; createIndex indexName=idx_card_label...		\N	3.5.3	\N	\N	5926779892
32	agilliland	migrations/000_migrations.yaml	2018-05-10 09:33:28.77806	32	EXECUTED	7:af1dea42abdc7cd058b5f744602d7a22	createTable tableName=raw_table; createIndex indexName=idx_rawtable_database_id, tableName=raw_table; addUniqueConstraint constraintName=uniq_raw_table_db_schema_name, tableName=raw_table; createTable tableName=raw_column; createIndex indexName=id...		\N	3.5.3	\N	\N	5926779892
69	senior	migrations/000_migrations.yaml	2018-05-10 09:33:28.77806	67	EXECUTED	7:1de67869247405ada4cd35068f11cb5f	addColumn tableName=pulse; dropNotNullConstraint columnName=name, tableName=pulse	Added 0.27.0	\N	3.5.3	\N	\N	5926779892
1	agilliland	migrations/000_migrations.yaml	2018-05-10 09:33:28.77806	1	EXECUTED	7:4760863947b982cf4783d8a8e02dc4ea	createTable tableName=core_organization; createTable tableName=core_user; createTable tableName=core_userorgperm; addUniqueConstraint constraintName=idx_unique_user_id_organization_id, tableName=core_userorgperm; createIndex indexName=idx_userorgp...		\N	3.5.3	\N	\N	5926779892
5	agilliland	migrations/000_migrations.yaml	2018-05-10 09:33:28.77806	4	EXECUTED	7:593149128c8f3a7e1f37a483bc67a924	addColumn tableName=core_organization		\N	3.5.3	\N	\N	5926779892
6	agilliland	migrations/000_migrations.yaml	2018-05-10 09:33:28.77806	5	EXECUTED	7:d24f2f950306f150d87c4208520661d5	dropNotNullConstraint columnName=organization_id, tableName=metabase_database; dropForeignKeyConstraint baseTableName=metabase_database, constraintName=fk_database_ref_organization_id; dropNotNullConstraint columnName=organization_id, tableName=re...		\N	3.5.3	\N	\N	5926779892
21	agilliland	migrations/000_migrations.yaml	2018-05-10 09:33:28.77806	20	EXECUTED	7:c23c71d8a11b3f38aaf5bf98acf51e6f	createTable tableName=segment; createIndex indexName=idx_segment_creator_id, tableName=segment; createIndex indexName=idx_segment_table_id, tableName=segment		\N	3.5.3	\N	\N	5926779892
22	agilliland	migrations/000_migrations.yaml	2018-05-10 09:33:28.77806	21	EXECUTED	7:cb6776ec86ab0ad9e74806a5460b9085	addColumn tableName=revision		\N	3.5.3	\N	\N	5926779892
23	agilliland	migrations/000_migrations.yaml	2018-05-10 09:33:28.77806	22	EXECUTED	7:43b9662bd798db391d4bbb7d4615bf0d	modifyDataType columnName=rows, tableName=metabase_table		\N	3.5.3	\N	\N	5926779892
39	camsaul	migrations/000_migrations.yaml	2018-05-10 09:33:28.77806	38	EXECUTED	7:a63ada256c44684d2649b8f3c28a3023	addColumn tableName=core_user		\N	3.5.3	\N	\N	5926779892
66	senior	migrations/000_migrations.yaml	2018-05-10 09:33:28.77806	64	EXECUTED	7:76d06b44a544105c2a613603b8bdf25f	sql; sql	Added 0.26.0	\N	3.5.3	\N	\N	5926779892
11	agilliland	migrations/000_migrations.yaml	2018-05-10 09:33:28.77806	10	EXECUTED	7:c7ef8b4f4dcb3528f9282b51aea5bb2a	sql		\N	3.5.3	\N	\N	5926779892
12	agilliland	migrations/000_migrations.yaml	2018-05-10 09:33:28.77806	11	EXECUTED	7:f78e18f669d7c9e6d06c63ea9929391f	addColumn tableName=report_card		\N	3.5.3	\N	\N	5926779892
15	agilliland	migrations/000_migrations.yaml	2018-05-10 09:33:28.77806	14	EXECUTED	7:50c72a51651af76928c06f21c9e04f97	addColumn tableName=revision		\N	3.5.3	\N	\N	5926779892
24	agilliland	migrations/000_migrations.yaml	2018-05-10 09:33:28.77806	23	EXECUTED	7:69c2cad167fd7cec9e8c920d9ccab86e	createTable tableName=dependency; createIndex indexName=idx_dependency_model, tableName=dependency; createIndex indexName=idx_dependency_model_id, tableName=dependency; createIndex indexName=idx_dependency_dependent_on_model, tableName=dependency;...		\N	3.5.3	\N	\N	5926779892
25	agilliland	migrations/000_migrations.yaml	2018-05-10 09:33:28.77806	24	EXECUTED	7:327941d9ac9414f493471b746a812fa4	createTable tableName=metric; createIndex indexName=idx_metric_creator_id, tableName=metric; createIndex indexName=idx_metric_table_id, tableName=metric		\N	3.5.3	\N	\N	5926779892
28	agilliland	migrations/000_migrations.yaml	2018-05-10 09:33:28.77806	27	EXECUTED	7:335e7e6b32dcbeb392150b3c3db2d5eb	addColumn tableName=core_user		\N	3.5.3	\N	\N	5926779892
29	agilliland	migrations/000_migrations.yaml	2018-05-10 09:33:28.77806	28	EXECUTED	7:7b0bb8fcb7de2aa29ce57b32baf9ff31	addColumn tableName=pulse_channel		\N	3.5.3	\N	\N	5926779892
49	camsaul	migrations/000_migrations.yaml	2018-05-10 09:33:28.77806	48	EXECUTED	7:bb653dc1919f366bb81f3356a4cbfa6c	addColumn tableName=report_card; createIndex indexName=idx_card_public_uuid, tableName=report_card; addColumn tableName=report_dashboard; createIndex indexName=idx_dashboard_public_uuid, tableName=report_dashboard; dropNotNullConstraint columnName...		\N	3.5.3	\N	\N	5926779892
50	camsaul	migrations/000_migrations.yaml	2018-05-10 09:33:28.77806	49	EXECUTED	7:6a45ed802c2f724731835bfaa97c57c9	addColumn tableName=report_card; addColumn tableName=report_dashboard		\N	3.5.3	\N	\N	5926779892
51	camsaul	migrations/000_migrations.yaml	2018-05-10 09:33:28.77806	50	EXECUTED	7:2b28e18d04212a1cbd82eb7888ae4af3	createTable tableName=query_execution; createIndex indexName=idx_query_execution_started_at, tableName=query_execution; createIndex indexName=idx_query_execution_query_hash_started_at, tableName=query_execution		\N	3.5.3	\N	\N	5926779892
52	camsaul	migrations/000_migrations.yaml	2018-05-10 09:33:28.77806	51	EXECUTED	7:fbe1b7114f1d4f346543e3c22e28bde3	createTable tableName=query_cache; createIndex indexName=idx_query_cache_updated_at, tableName=query_cache; addColumn tableName=report_card		\N	3.5.3	\N	\N	5926779892
53	camsaul	migrations/000_migrations.yaml	2018-05-10 09:33:28.77806	52	EXECUTED	7:cc7ef026c3375d31df5f03036bb7e850	createTable tableName=query		\N	3.5.3	\N	\N	5926779892
54	tlrobinson	migrations/000_migrations.yaml	2018-05-10 09:33:28.77806	53	EXECUTED	7:0857800db71a4757e7202aad4eaed48d	addColumn tableName=pulse		\N	3.5.3	\N	\N	5926779892
55	camsaul	migrations/000_migrations.yaml	2018-05-10 09:33:28.77806	54	EXECUTED	7:e169c9d0a5220127b97630e95717c033	addColumn tableName=report_dashboard; createTable tableName=dashboard_favorite; addUniqueConstraint constraintName=unique_dashboard_favorite_user_id_dashboard_id, tableName=dashboard_favorite; createIndex indexName=idx_dashboard_favorite_user_id, ...		\N	3.5.3	\N	\N	5926779892
56	wwwiiilll	migrations/000_migrations.yaml	2018-05-10 09:33:28.77806	55	EXECUTED	7:d72f90ad1c2911d60b943445a2cb7ee1	addColumn tableName=core_user	Added 0.25.0	\N	3.5.3	\N	\N	5926779892
58	senior	migrations/000_migrations.yaml	2018-05-10 09:33:28.77806	57	EXECUTED	7:a12d6057fa571739e5327316558a117f	createTable tableName=dimension; addUniqueConstraint constraintName=unique_dimension_field_id_name, tableName=dimension; createIndex indexName=idx_dimension_field_id, tableName=dimension	Added 0.25.0	\N	3.5.3	\N	\N	5926779892
59	camsaul	migrations/000_migrations.yaml	2018-05-10 09:33:28.77806	58	EXECUTED	7:583e67af40cae19cab645bbd703558ef	addColumn tableName=metabase_field	Added 0.26.0	\N	3.5.3	\N	\N	5926779892
60	camsaul	migrations/000_migrations.yaml	2018-05-10 09:33:28.77806	59	EXECUTED	7:888069f3cbfb80ac05a734c980ac5885	addColumn tableName=metabase_database	Added 0.26.0	\N	3.5.3	\N	\N	5926779892
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
\.


--
-- Data for Name: dependency; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY dependency (id, model, model_id, dependent_on_model, dependent_on_id, created_at) FROM stdin;
\.


--
-- Name: dependency_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('dependency_id_seq', 1, false);


--
-- Data for Name: dimension; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY dimension (id, field_id, name, type, human_readable_field_id, created_at, updated_at) FROM stdin;
\.


--
-- Name: dimension_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('dimension_id_seq', 1, false);


--
-- Data for Name: label; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY label (id, name, slug, icon) FROM stdin;
\.


--
-- Name: label_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('label_id_seq', 1, false);


--
-- Data for Name: metabase_database; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY metabase_database (id, created_at, updated_at, name, description, details, engine, is_sample, is_full_sync, points_of_interest, caveats, metadata_sync_schedule, cache_field_values_schedule, timezone, is_on_demand) FROM stdin;
2	2018-05-10 09:35:46.926+05	2018-05-10 09:35:46.926+05	TBREACH5	\N	{"host":"localhost","port":5432,"dbname":"tbreach5","user":"postgres","password":"VA1913wm","ssl":false,"tunnel-port":22}	postgres	f	t	\N	\N	0 50 * * * ? *	0 50 0 * * ? *	\N	f
1	2018-05-10 09:33:32.333+05	2018-05-28 16:14:26.331+05	Sample Dataset	\N	{"db":"zip:/C:/apache-tomcat-8.5.20/webapps/tbreach5/WEB-INF/classes/subsys/metabase.jar!/sample-dataset.db;USER=GUEST;PASSWORD=guest"}	h2	t	t	\N	\N	0 50 * * * ? *	0 50 0 * * ? *	\N	f
\.


--
-- Name: metabase_database_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('metabase_database_id_seq', 2, true);


--
-- Data for Name: metabase_field; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY metabase_field (id, created_at, updated_at, name, base_type, special_type, active, description, preview_display, "position", table_id, parent_id, display_name, visibility_type, fk_target_field_id, raw_column_id, last_analyzed, points_of_interest, caveats, fingerprint, fingerprint_version) FROM stdin;
30	2018-05-10 09:33:33.378+05	2018-05-31 11:50:00.376+05	TITLE	type/Text	type/Category	t	The name of the product as it should be displayed to customers.	t	0	1	\N	Title	normal	\N	\N	2018-05-10 09:33:37.178+05	\N	\N	{"global":{"distinct-count":198},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":21.305}}}	1
100	2018-05-10 09:35:47.38+05	2018-05-31 11:50:00.52+05	longitude	type/Text	\N	t	\N	t	0	7	\N	Longitude	normal	\N	\N	\N	\N	\N	\N	0
28	2018-05-10 09:33:33.354+05	2018-05-31 11:50:00.291+05	QUANTITY	type/Integer	type/Category	t	Number of products bought.	t	0	2	\N	Quantity	normal	\N	\N	2018-05-10 09:33:37.027+05	\N	\N	{"global":{"distinct-count":62},"type":{"type/Number":{"min":0,"max":87,"avg":4.0585}}}	1
27	2018-05-10 09:33:33.35+05	2018-05-31 11:50:00.304+05	CREATED_AT	type/DateTime	\N	t	The date and time an order was submitted.	t	0	2	\N	Created At	normal	\N	\N	2018-05-10 09:33:37.027+05	\N	\N	{"global":{"distinct-count":1381}}	1
18	2018-05-10 09:33:33.202+05	2018-05-31 11:50:00.34+05	LONGITUDE	type/Float	type/Longitude	t	This is the longitude of the user on sign-up. It might be updated in the future to the last seen location.	t	0	3	\N	Longitude	normal	\N	\N	2018-05-10 09:33:36.102+05	\N	\N	{"global":{"distinct-count":2500},"type":{"type/Number":{"min":-179.693556788217,"max":179.9427208287961,"avg":0.7039410787134972}}}	1
80	2018-05-10 09:35:47.32+05	2018-05-31 11:50:00.521+05	preferred	type/Boolean	\N	t	\N	t	0	7	\N	Preferred	normal	\N	\N	\N	\N	\N	\N	0
19	2018-05-10 09:33:33.213+05	2018-05-31 11:50:00.343+05	CREATED_AT	type/DateTime	\N	t	The date the user record was created. Also referred to as the user’s "join date"	t	0	3	\N	Created At	normal	\N	\N	2018-05-10 09:33:36.102+05	\N	\N	{"global":{"distinct-count":980}}	1
31	2018-05-10 09:33:33.382+05	2018-05-31 11:50:00.374+05	PRICE	type/Float	type/Category	t	The list price of the product. Note that this is not always the price the product sold for due to discounts, promotions, etc.	t	0	1	\N	Price	normal	\N	\N	2018-05-10 09:33:37.178+05	\N	\N	{"global":{"distinct-count":200},"type":{"type/Number":{"min":31.478481306013133,"max":86.04566142585628,"avg":60.18227577428187}}}	1
97	2018-05-10 09:35:47.374+05	2018-05-31 11:50:00.522+05	country	type/Text	\N	t	\N	t	0	7	\N	Country	normal	\N	\N	\N	\N	\N	\N	0
102	2018-05-10 09:35:47.412+05	2018-05-31 11:50:00.295+05	fielddatatype	type/Text	\N	t	\N	t	0	6	\N	Fielddatatype	normal	\N	\N	\N	\N	\N	\N	0
95	2018-05-10 09:35:47.368+05	2018-05-31 11:50:00.523+05	stateprovince	type/Text	\N	t	\N	t	0	7	\N	Stateprovince	normal	\N	\N	\N	\N	\N	\N	0
104	2018-05-10 09:35:47.417+05	2018-05-31 11:50:00.312+05	effectivedatetime	type/DateTime	\N	t	\N	t	0	6	\N	Effectivedatetime	normal	\N	\N	\N	\N	\N	\N	0
98	2018-05-10 09:35:47.376+05	2018-05-31 11:50:00.524+05	postalcode	type/Text	\N	t	\N	t	0	7	\N	Postalcode	normal	\N	\N	\N	\N	\N	\N	0
106	2018-05-10 09:35:47.423+05	2018-05-31 11:50:00.312+05	parentcode	type/Text	\N	t	\N	t	0	6	\N	Parentcode	normal	\N	\N	\N	\N	\N	\N	0
96	2018-05-10 09:35:47.371+05	2018-05-31 11:50:00.525+05	addressfields	type/Text	\N	t	\N	t	0	7	\N	Addressfields	normal	\N	\N	\N	\N	\N	\N	0
6	2018-05-10 09:33:33.117+05	2018-05-31 11:50:00.396+05	CREATED_AT	type/DateTime	\N	t	The day and time a review was written by a user.	t	0	4	\N	Created At	normal	\N	\N	2018-05-10 09:33:34.522+05	\N	\N	{"global":{"distinct-count":624}}	1
110	2018-05-10 09:35:47.432+05	2018-05-31 11:50:00.313+05	fieldtype	type/Text	\N	t	\N	t	0	6	\N	Fieldtype	normal	\N	\N	\N	\N	\N	\N	0
105	2018-05-10 09:35:47.42+05	2018-05-31 11:50:00.315+05	formsubmissionfield	type/Text	\N	t	\N	t	0	6	\N	Formsubmissionfield	normal	\N	\N	\N	\N	\N	\N	0
108	2018-05-10 09:35:47.428+05	2018-05-31 11:50:00.317+05	_id	type/Text	\N	t	\N	t	0	6	\N	ID	normal	\N	\N	\N	\N	\N	\N	0
101	2018-05-10 09:35:47.41+05	2018-05-31 11:50:00.318+05	comments	type/Text	\N	t	\N	t	0	6	\N	Comments	normal	\N	\N	\N	\N	\N	\N	0
103	2018-05-10 09:35:47.415+05	2018-05-31 11:50:00.319+05	obsid	type/Integer	type/PK	t	\N	t	0	6	\N	Obsid	normal	\N	\N	\N	\N	\N	\N	0
107	2018-05-10 09:35:47.426+05	2018-05-31 11:50:00.321+05	humanreadablevalues	type/Text	\N	t	\N	t	0	6	\N	Humanreadablevalues	normal	\N	\N	\N	\N	\N	\N	0
111	2018-05-10 09:35:47.434+05	2018-05-31 11:50:00.322+05	eventid	type/Integer	type/FK	t	\N	t	0	6	\N	Eventid	normal	134	\N	\N	\N	\N	\N	0
113	2018-05-10 09:35:47.438+05	2018-05-31 11:50:00.324+05	fieldcode	type/Text	\N	t	\N	t	0	6	\N	Fieldcode	normal	\N	\N	\N	\N	\N	\N	0
114	2018-05-10 09:35:47.44+05	2018-05-31 11:50:00.325+05	values	type/Text	\N	t	\N	t	0	6	\N	Values	normal	\N	\N	\N	\N	\N	\N	0
112	2018-05-10 09:35:47.436+05	2018-05-31 11:50:00.33+05	fulldetails	type/Text	\N	t	\N	t	0	6	\N	Fulldetails	normal	\N	\N	\N	\N	\N	\N	0
109	2018-05-10 09:35:47.429+05	2018-05-31 11:50:00.332+05	baseentityid	type/Text	\N	t	\N	t	0	6	\N	Baseentityid	normal	\N	\N	\N	\N	\N	\N	0
2	2018-05-10 09:33:33.077+05	2018-05-31 11:50:00.404+05	BODY	type/Text	type/Description	t	The review the user left. Limited to 2000 characters.	f	0	4	\N	Body	normal	\N	\N	2018-05-10 09:33:34.522+05	\N	\N	{"global":{"distinct-count":984},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":178.3109756097561}}}	1
11	2018-05-10 09:33:33.16+05	2018-05-31 11:50:00.344+05	ADDRESS	type/Text	\N	t	The street address of the account’s billing address	t	0	3	\N	Address	normal	\N	\N	2018-05-10 09:33:36.102+05	\N	\N	{"global":{"distinct-count":2500},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":17.9912}}}	1
13	2018-05-10 09:33:33.175+05	2018-05-31 11:50:00.346+05	EMAIL	type/Text	type/Email	t	The contact email for the account.	t	0	3	\N	Email	normal	\N	\N	2018-05-10 09:33:36.102+05	\N	\N	{"global":{"distinct-count":2500},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":1.0,"average-length":24.1664}}}	1
16	2018-05-10 09:33:33.193+05	2018-05-31 11:50:00.347+05	PASSWORD	type/Text	\N	t	This is the salted password of the user. It should not be visible	t	0	3	\N	Password	normal	\N	\N	2018-05-10 09:33:36.102+05	\N	\N	{"global":{"distinct-count":2500},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":36.0}}}	1
5	2018-05-10 09:33:33.112+05	2018-05-31 11:50:00.397+05	ID	type/BigInteger	type/PK	t	A unique internal identifier for the review. Should not be used externally.	t	0	4	\N	ID	normal	\N	\N	2018-05-10 09:33:34.522+05	\N	\N	{"global":{"distinct-count":984},"type":{"type/Number":{"min":1,"max":984,"avg":492.5}}}	1
4	2018-05-10 09:33:33.105+05	2018-05-31 11:50:00.399+05	PRODUCT_ID	type/Integer	type/FK	t	The product the review was for	t	0	4	\N	Product ID	normal	35	\N	2018-05-10 09:33:34.522+05	\N	\N	{"global":{"distinct-count":195},"type":{"type/Number":{"min":1,"max":200,"avg":100.0670731707317}}}	1
3	2018-05-10 09:33:33.082+05	2018-05-31 11:50:00.4+05	RATING	type/Integer	type/Category	t	The rating (on a scale of 1-5) the user left.	t	0	4	\N	Rating	normal	\N	\N	2018-05-10 09:33:34.522+05	\N	\N	{"global":{"distinct-count":5},"type":{"type/Number":{"min":1,"max":5,"avg":4.0477642276422765}}}	1
1	2018-05-10 09:33:33.069+05	2018-05-31 11:50:00.402+05	REVIEWER	type/Text	\N	t	The user who left the review	t	0	4	\N	Reviewer	normal	\N	\N	2018-05-10 09:33:34.522+05	\N	\N	{"global":{"distinct-count":936},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":9.570121951219512}}}	1
8	2018-05-10 09:33:33.144+05	2018-05-31 11:50:00.349+05	BIRTH_DATE	type/Date	\N	t	The date of birth of the user	t	0	3	\N	Birth Date	normal	\N	\N	2018-05-10 09:33:36.102+05	\N	\N	{"global":{"distinct-count":2293}}	1
12	2018-05-10 09:33:33.168+05	2018-05-31 11:50:00.35+05	ZIP	type/Text	type/ZipCode	t	The postal code of the account’s billing address	t	0	3	\N	Zip	normal	\N	\N	2018-05-10 09:33:36.102+05	\N	\N	{"global":{"distinct-count":2467},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":5.0}}}	1
10	2018-05-10 09:33:33.153+05	2018-05-31 11:50:00.352+05	LATITUDE	type/Float	type/Latitude	t	This is the latitude of the user on sign-up. It might be updated in the future to the last seen location.	t	0	3	\N	Latitude	normal	\N	\N	2018-05-10 09:33:36.102+05	\N	\N	{"global":{"distinct-count":2500},"type":{"type/Number":{"min":-89.62556830684696,"max":89.9420089232147,"avg":0.2000029228840675}}}	1
36	2018-05-10 09:33:33.402+05	2018-05-31 11:50:00.377+05	CREATED_AT	type/DateTime	\N	t	The date the product was added to our catalog.	t	0	1	\N	Created At	normal	\N	\N	2018-05-10 09:33:37.178+05	\N	\N	{"global":{"distinct-count":178}}	1
35	2018-05-10 09:33:33.398+05	2018-05-31 11:50:00.378+05	ID	type/BigInteger	type/PK	t	The numerical product number. Only used internally. All external communication should use the title or EAN.	t	0	1	\N	ID	normal	\N	\N	2018-05-10 09:33:37.178+05	\N	\N	{"global":{"distinct-count":200},"type":{"type/Number":{"min":1,"max":200,"avg":100.5}}}	1
71	2018-05-10 09:35:47.257+05	2018-05-31 11:50:00.459+05	dateVoided	type/Boolean	\N	t	\N	t	0	8	\N	Datevoided	normal	\N	\N	\N	\N	\N	\N	0
79	2018-05-10 09:35:47.284+05	2018-05-31 11:50:00.461+05	firstname	type/Text	\N	t	\N	t	0	8	\N	Firstname	normal	\N	\N	2018-05-10 09:35:49.923+05	\N	\N	{"global":{"distinct-count":2544},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":7.147344013490725}}}	1
85	2018-05-10 09:35:47.337+05	2018-05-31 11:50:00.527+05	town	type/Text	\N	t	\N	t	0	7	\N	Town	normal	\N	\N	\N	\N	\N	\N	0
51	2018-05-10 09:35:47.171+05	2018-05-31 11:50:00.383+05	number	type/Text	\N	t	\N	t	0	10	\N	Number	normal	\N	\N	\N	\N	\N	\N	0
83	2018-05-10 09:35:47.328+05	2018-05-31 11:50:00.529+05	cityvillage	type/Text	\N	t	\N	t	0	7	\N	Cityvillage	normal	\N	\N	\N	\N	\N	\N	0
41	2018-05-10 09:35:47.124+05	2018-05-31 11:50:00.349+05	fulldetails	type/Text	\N	t	\N	t	0	12	\N	Fulldetails	normal	\N	\N	\N	\N	\N	\N	0
52	2018-05-10 09:35:47.173+05	2018-05-31 11:50:00.384+05	preference	type/Integer	\N	t	\N	t	0	10	\N	Preference	normal	\N	\N	\N	\N	\N	\N	0
26	2018-05-10 09:33:33.346+05	2018-05-31 11:50:00.312+05	ID	type/BigInteger	type/PK	t	This is a unique ID for the product. It is also called the “Invoice number” or “Confirmation number” in customer facing emails and screens.	t	0	2	\N	ID	normal	\N	\N	2018-05-10 09:33:37.027+05	\N	\N	{"global":{"distinct-count":10000},"type":{"type/Number":{"min":1,"max":10000,"avg":5000.5}}}	1
37	2018-05-10 09:35:47.112+05	2018-05-31 11:50:00.35+05	datecreated	type/DateTime	\N	t	\N	t	0	12	\N	Datecreated	normal	\N	\N	2018-05-10 09:35:47.706+05	\N	\N	{"global":{"distinct-count":1}}	1
38	2018-05-10 09:35:47.115+05	2018-05-31 11:50:00.351+05	value	type/Text	\N	t	\N	t	0	12	\N	Value	normal	\N	\N	\N	\N	\N	\N	0
48	2018-05-10 09:35:47.164+05	2018-05-31 11:50:00.385+05	fulldetails	type/Text	\N	t	\N	t	0	10	\N	Fulldetails	normal	\N	\N	\N	\N	\N	\N	0
49	2018-05-10 09:35:47.166+05	2018-05-31 11:50:00.387+05	enddate	type/DateTime	\N	t	\N	t	0	10	\N	Enddate	normal	\N	\N	\N	\N	\N	\N	0
43	2018-05-10 09:35:47.147+05	2018-05-31 11:50:00.39+05	use	type/Text	\N	t	\N	t	0	10	\N	Use	normal	\N	\N	\N	\N	\N	\N	0
58	2018-05-10 09:35:47.213+05	2018-05-31 11:50:00.462+05	creator	type/Text	\N	t	\N	t	0	8	\N	Creator	normal	\N	\N	\N	\N	\N	\N	0
20	2018-05-10 09:33:33.303+05	2018-05-31 11:50:00.312+05	DISCOUNT	type/Float	\N	t	Discount amount.	t	0	2	\N	Discount	normal	\N	\N	2018-05-10 09:33:37.027+05	\N	\N	{"global":{"distinct-count":1022},"type":{"type/Number":{"min":0.21249216890034361,"max":70.30699128866013,"avg":5.382008821780497}}}	1
47	2018-05-10 09:35:47.161+05	2018-05-31 11:50:00.391+05	baseentityid	type/Text	\N	t	\N	t	0	10	\N	Baseentityid	normal	\N	\N	\N	\N	\N	\N	0
33	2018-05-10 09:33:33.389+05	2018-05-31 11:50:00.379+05	RATING	type/Float	type/Category	t	The average rating users have given the product. This ranges from 1 - 5	t	0	1	\N	Rating	normal	\N	\N	2018-05-10 09:33:37.178+05	\N	\N	{"global":{"distinct-count":23},"type":{"type/Number":{"min":0.0,"max":5.0,"avg":3.928500000000003}}}	1
91	2018-05-10 09:35:47.358+05	2018-05-31 11:50:00.526+05	fulldetails	type/Text	\N	t	\N	t	0	7	\N	Fulldetails	normal	\N	\N	\N	\N	\N	\N	0
81	2018-05-10 09:35:47.322+05	2018-05-31 11:50:00.53+05	geopoint	type/Text	\N	t	\N	t	0	7	\N	Geopoint	normal	\N	\N	\N	\N	\N	\N	0
89	2018-05-10 09:35:47.352+05	2018-05-31 11:50:00.531+05	baseentityid	type/Text	\N	t	\N	t	0	7	\N	Baseentityid	normal	\N	\N	\N	\N	\N	\N	0
86	2018-05-10 09:35:47.343+05	2018-05-31 11:50:00.532+05	_id	type/Text	\N	t	\N	t	0	7	\N	ID	normal	\N	\N	\N	\N	\N	\N	0
94	2018-05-10 09:35:47.365+05	2018-05-31 11:50:00.533+05	enddate	type/DateTime	\N	t	\N	t	0	7	\N	Enddate	normal	\N	\N	\N	\N	\N	\N	0
88	2018-05-10 09:35:47.348+05	2018-05-31 11:50:00.534+05	subtown	type/Text	\N	t	\N	t	0	7	\N	Subtown	normal	\N	\N	\N	\N	\N	\N	0
44	2018-05-10 09:35:47.15+05	2018-05-31 11:50:00.378+05	startdate	type/DateTime	\N	t	\N	t	0	10	\N	Startdate	normal	\N	\N	\N	\N	\N	\N	0
93	2018-05-10 09:35:47.363+05	2018-05-31 11:50:00.536+05	countydistrict	type/Text	\N	t	\N	t	0	7	\N	Countydistrict	normal	\N	\N	\N	\N	\N	\N	0
45	2018-05-10 09:35:47.153+05	2018-05-31 11:50:00.38+05	type	type/Text	\N	t	\N	t	0	10	\N	Type	normal	\N	\N	\N	\N	\N	\N	0
46	2018-05-10 09:35:47.156+05	2018-05-31 11:50:00.381+05	_id	type/Text	\N	t	\N	t	0	10	\N	ID	normal	\N	\N	\N	\N	\N	\N	0
87	2018-05-10 09:35:47.346+05	2018-05-31 11:50:00.536+05	addresstype	type/Text	\N	t	\N	t	0	7	\N	Addresstype	normal	\N	\N	\N	\N	\N	\N	0
50	2018-05-10 09:35:47.168+05	2018-05-31 11:50:00.393+05	contactpointid	type/Integer	type/PK	t	\N	t	0	10	\N	Contactpointid	normal	\N	\N	\N	\N	\N	\N	0
72	2018-05-10 09:35:47.261+05	2018-05-31 11:50:00.446+05	clienttype	type/Text	\N	t	\N	t	0	8	\N	Clienttype	normal	\N	\N	\N	\N	\N	\N	0
92	2018-05-10 09:35:47.361+05	2018-05-31 11:50:00.538+05	subdistrict	type/Text	\N	t	\N	t	0	7	\N	Subdistrict	normal	\N	\N	\N	\N	\N	\N	0
90	2018-05-10 09:35:47.355+05	2018-05-31 11:50:00.539+05	addressid	type/Integer	type/PK	t	\N	t	0	7	\N	Addressid	normal	\N	\N	\N	\N	\N	\N	0
82	2018-05-10 09:35:47.325+05	2018-05-31 11:50:00.54+05	startdate	type/DateTime	\N	t	\N	t	0	7	\N	Startdate	normal	\N	\N	\N	\N	\N	\N	0
61	2018-05-10 09:35:47.22+05	2018-05-31 11:50:00.447+05	editor	type/Text	\N	t	\N	t	0	8	\N	Editor	normal	\N	\N	\N	\N	\N	\N	0
84	2018-05-10 09:35:47.333+05	2018-05-31 11:50:00.541+05	latitude	type/Text	\N	t	\N	t	0	7	\N	Latitude	normal	\N	\N	\N	\N	\N	\N	0
75	2018-05-10 09:35:47.272+05	2018-05-31 11:50:00.449+05	deathdate	type/DateTime	\N	t	\N	t	0	8	\N	Deathdate	normal	\N	\N	\N	\N	\N	\N	0
62	2018-05-10 09:35:47.222+05	2018-05-31 11:50:00.453+05	voidreason	type/Text	\N	t	\N	t	0	8	\N	Voidreason	normal	\N	\N	\N	\N	\N	\N	0
70	2018-05-10 09:35:47.254+05	2018-05-31 11:50:00.456+05	relationships	type/Text	\N	t	\N	t	0	8	\N	Relationships	normal	\N	\N	\N	\N	\N	\N	0
76	2018-05-10 09:35:47.275+05	2018-05-31 11:50:00.457+05	voider	type/Text	\N	t	\N	t	0	8	\N	Voider	normal	\N	\N	\N	\N	\N	\N	0
67	2018-05-10 09:35:47.238+05	2018-05-31 11:50:00.458+05	voided	type/Boolean	\N	t	\N	t	0	8	\N	Voided	normal	\N	\N	\N	\N	\N	\N	0
139	2018-05-10 09:35:47.511+05	2018-05-31 11:50:00.615+05	category	type/Text	\N	t	\N	t	0	5	\N	Category	normal	\N	\N	\N	\N	\N	\N	0
135	2018-05-10 09:35:47.503+05	2018-05-31 11:50:00.616+05	teamid	type/Text	type/Category	t	\N	t	0	5	\N	Teamid	normal	\N	\N	2018-05-10 15:50:00.913+05	\N	\N	{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":36.0}}}	1
121	2018-05-10 09:35:47.473+05	2018-05-31 11:50:00.617+05	editor	type/Text	\N	t	\N	t	0	5	\N	Editor	normal	\N	\N	\N	\N	\N	\N	0
120	2018-05-10 09:35:47.471+05	2018-05-31 11:50:00.618+05	duration	type/Integer	\N	t	\N	t	0	5	\N	Duration	normal	\N	\N	\N	\N	\N	\N	0
73	2018-05-10 09:35:47.265+05	2018-05-31 11:50:00.467+05	birthdateapprox	type/Boolean	type/Category	t	\N	t	0	8	\N	Birthdateapprox	normal	\N	\N	2018-05-10 09:35:49.923+05	\N	\N	{"global":{"distinct-count":2}}	1
142	2018-05-10 09:35:47.517+05	2018-05-31 11:50:00.62+05	status	type/Text	\N	t	\N	t	0	5	\N	Status	normal	\N	\N	\N	\N	\N	\N	0
74	2018-05-10 09:35:47.268+05	2018-05-31 11:50:00.468+05	fulldetails	type/Text	\N	t	\N	f	0	8	\N	Fulldetails	normal	\N	\N	2018-05-10 09:35:49.923+05	\N	\N	{"global":{"distinct-count":4838},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":639.0739975196362}}}	1
17	2018-05-10 09:33:33.198+05	2018-05-31 11:50:00.353+05	STATE	type/Text	type/State	t	The state or province of the account’s billing address	t	0	3	\N	State	normal	\N	\N	2018-05-10 09:33:36.102+05	\N	\N	{"global":{"distinct-count":62},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":2.0}}}	1
124	2018-05-10 09:35:47.48+05	2018-05-31 11:50:00.622+05	details	type/Text	\N	t	\N	t	0	5	\N	Details	normal	\N	\N	\N	\N	\N	\N	0
118	2018-05-10 09:35:47.467+05	2018-05-31 11:50:00.623+05	creator	type/Text	\N	t	\N	t	0	5	\N	Creator	normal	\N	\N	\N	\N	\N	\N	0
128	2018-05-10 09:35:47.488+05	2018-05-31 11:50:00.624+05	obs	type/Text	\N	t	\N	f	0	5	\N	Obs	normal	\N	\N	2018-05-10 09:35:57.182+05	\N	\N	{"global":{"distinct-count":9998},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":7497.1337}}}	1
29	2018-05-10 09:33:33.374+05	2018-05-31 11:50:00.381+05	VENDOR	type/Text	type/Category	t	The source of the product.	t	0	1	\N	Vendor	normal	\N	\N	2018-05-10 09:33:37.178+05	\N	\N	{"global":{"distinct-count":200},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":19.915}}}	1
133	2018-05-10 09:35:47.499+05	2018-05-31 11:50:00.626+05	dateVoided	type/Boolean	\N	t	\N	t	0	5	\N	Datevoided	normal	\N	\N	\N	\N	\N	\N	0
117	2018-05-10 09:35:47.464+05	2018-05-31 11:50:00.599+05	datecreated	type/DateTime	\N	t	\N	t	0	5	\N	Datecreated	normal	\N	\N	2018-05-10 09:35:57.182+05	\N	\N	{"global":{"distinct-count":20}}	1
136	2018-05-10 09:35:47.505+05	2018-05-31 11:50:00.6+05	fulldetails	type/Text	\N	t	\N	f	0	5	\N	Fulldetails	normal	\N	\N	2018-05-10 09:35:57.182+05	\N	\N	{"global":{"distinct-count":10000},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":7997.6088}}}	1
129	2018-05-10 09:35:47.49+05	2018-05-31 11:50:00.608+05	dateedited	type/DateTime	\N	t	\N	t	0	5	\N	Dateedited	normal	\N	\N	\N	\N	\N	\N	0
137	2018-05-10 09:35:47.507+05	2018-05-31 11:50:00.61+05	reason	type/Text	\N	t	\N	t	0	5	\N	Reason	normal	\N	\N	\N	\N	\N	\N	0
132	2018-05-10 09:35:47.497+05	2018-05-31 11:50:00.627+05	entitytype	type/Text	type/Category	t	\N	t	0	5	\N	Entitytype	normal	\N	\N	2018-05-10 09:35:57.182+05	\N	\N	{"global":{"distinct-count":3},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":7.006}}}	1
24	2018-05-10 09:33:33.334+05	2018-05-31 11:50:00.313+05	PRODUCT_ID	type/Integer	type/FK	t	The product ID. This is an internal identifier for the product, NOT the SKU.	t	0	2	\N	Product ID	normal	35	\N	2018-05-10 09:33:37.027+05	\N	\N	{"global":{"distinct-count":200},"type":{"type/Number":{"min":1,"max":200,"avg":100.0589}}}	1
56	2018-05-10 09:35:47.207+05	2018-05-31 11:50:00.463+05	identifiers	type/Text	\N	t	\N	t	0	8	\N	Identifiers	normal	\N	\N	2018-05-10 09:35:49.923+05	\N	\N	{"global":{"distinct-count":4661},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":37.65026870607689}}}	1
78	2018-05-10 09:35:47.281+05	2018-05-31 11:50:00.464+05	attributes	type/Text	\N	t	\N	t	0	8	\N	Attributes	normal	\N	\N	2018-05-10 09:35:49.923+05	\N	\N	{"global":{"distinct-count":3866},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":29.95163290615957}}}	1
59	2018-05-10 09:35:47.215+05	2018-05-31 11:50:00.465+05	birthdate	type/DateTime	\N	t	\N	t	0	8	\N	Birthdate	normal	\N	\N	2018-05-10 09:35:49.923+05	\N	\N	{"global":{"distinct-count":1271}}	1
57	2018-05-10 09:35:47.21+05	2018-05-31 11:50:00.466+05	datecreated	type/DateTime	\N	t	\N	t	0	8	\N	Datecreated	normal	\N	\N	2018-05-10 09:35:49.923+05	\N	\N	{"global":{"distinct-count":20}}	1
141	2018-05-10 09:35:47.515+05	2018-05-31 11:50:00.611+05	clientid	type/Integer	type/FK	t	\N	t	0	5	\N	Clientid	normal	66	\N	\N	\N	\N	\N	0
127	2018-05-10 09:35:47.486+05	2018-05-31 11:50:00.612+05	voided	type/Boolean	\N	t	\N	t	0	5	\N	Voided	normal	\N	\N	\N	\N	\N	\N	0
122	2018-05-10 09:35:47.476+05	2018-05-31 11:50:00.613+05	voidreason	type/Text	\N	t	\N	t	0	5	\N	Voidreason	normal	\N	\N	\N	\N	\N	\N	0
140	2018-05-10 09:35:47.513+05	2018-05-31 11:50:00.614+05	voider	type/Text	\N	t	\N	t	0	5	\N	Voider	normal	\N	\N	\N	\N	\N	\N	0
55	2018-05-10 09:35:47.205+05	2018-05-31 11:50:00.479+05	serverversion	type/BigInteger	type/Category	t	\N	t	0	8	\N	Serverversion	normal	\N	\N	2018-05-10 09:35:49.923+05	\N	\N	{"global":{"distinct-count":1},"type":{"type/Number":{"min":1525423275616,"max":1525423275616,"avg":1.525423275616E12}}}	1
69	2018-05-10 09:35:47.248+05	2018-05-31 11:50:00.48+05	baseentityid	type/Text	\N	t	\N	t	0	8	\N	Baseentityid	normal	\N	\N	2018-05-10 09:35:49.923+05	\N	\N	{"global":{"distinct-count":4838},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":35.99338569656883}}}	1
54	2018-05-10 09:35:47.202+05	2018-05-31 11:50:00.481+05	lastname	type/Text	\N	t	\N	t	0	8	\N	Lastname	normal	\N	\N	2018-05-10 09:35:49.923+05	\N	\N	{"global":{"distinct-count":621},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":9.808764940239044}}}	1
15	2018-05-10 09:33:33.187+05	2018-05-31 11:50:00.354+05	NAME	type/Text	type/Name	t	The name of the user who owns an account	t	0	3	\N	Name	normal	\N	\N	2018-05-10 09:33:36.102+05	\N	\N	{"global":{"distinct-count":2500},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":13.516}}}	1
65	2018-05-10 09:35:47.232+05	2018-05-31 11:50:00.483+05	deathdateapprox	type/Boolean	type/Category	t	\N	t	0	8	\N	Deathdateapprox	normal	\N	\N	2018-05-10 09:35:49.923+05	\N	\N	{"global":{"distinct-count":1}}	1
42	2018-05-10 09:35:47.128+05	2018-05-31 11:50:00.353+05	statetokenid	type/Integer	type/PK	t	\N	t	0	12	\N	Statetokenid	normal	\N	\N	2018-05-10 09:35:47.706+05	\N	\N	{"global":{"distinct-count":1},"type":{"type/Number":{"min":1,"max":1,"avg":1.0}}}	1
40	2018-05-10 09:35:47.121+05	2018-05-31 11:50:00.354+05	name	type/Text	type/Name	t	\N	t	0	12	\N	Name	normal	\N	\N	2018-05-10 09:35:47.706+05	\N	\N	{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":19.0}}}	1
39	2018-05-10 09:35:47.118+05	2018-05-31 11:50:00.356+05	dateedited	type/DateTime	\N	t	\N	t	0	12	\N	Dateedited	normal	\N	\N	2018-05-10 09:35:47.706+05	\N	\N	{"global":{"distinct-count":1}}	1
53	2018-05-10 09:35:47.178+05	2018-05-31 11:50:00.394+05	clientid	type/Integer	type/FK	t	\N	t	0	10	\N	Clientid	normal	66	\N	\N	\N	\N	\N	0
23	2018-05-10 09:33:33.33+05	2018-05-31 11:50:00.315+05	TAX	type/Float	\N	t	This is the amount of local and federal taxes that are collected on the purchase. Note that other governmental fees on some products are not included here, but instead are accounted for in the subtotal.	t	0	2	\N	Tax	normal	\N	\N	2018-05-10 09:33:37.027+05	\N	\N	{"global":{"distinct-count":761},"type":{"type/Number":{"min":0.0,"max":9.68,"avg":3.263451999999993}}}	1
60	2018-05-10 09:35:47.218+05	2018-05-31 11:50:00.477+05	middlename	type/Text	type/Category	t	\N	t	0	8	\N	Middlename	normal	\N	\N	2018-05-10 09:35:49.923+05	\N	\N	{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":2.0}}}	1
63	2018-05-10 09:35:47.225+05	2018-05-31 11:50:00.484+05	addresses	type/Text	\N	t	\N	f	0	8	\N	Addresses	normal	\N	\N	2018-05-10 09:35:49.923+05	\N	\N	{"global":{"distinct-count":2633},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":162.86792062835883}}}	1
77	2018-05-10 09:35:47.278+05	2018-05-31 11:50:00.485+05	gender	type/Text	type/Category	t	\N	t	0	8	\N	Gender	normal	\N	\N	2018-05-10 09:35:49.923+05	\N	\N	{"global":{"distinct-count":4},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":5.027033436092008}}}	1
9	2018-05-10 09:33:33.148+05	2018-05-31 11:50:00.356+05	SOURCE	type/Text	type/Category	t	The channel through which we acquired this user. Valid values include: Affiliate, Facebook, Google, Organic and Twitter	t	0	3	\N	Source	normal	\N	\N	2018-05-10 09:33:36.102+05	\N	\N	{"global":{"distinct-count":5},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":7.4096}}}	1
14	2018-05-10 09:33:33.18+05	2018-05-31 11:50:00.357+05	ID	type/BigInteger	type/PK	t	A unique identifier given to each user.	t	0	3	\N	ID	normal	\N	\N	2018-05-10 09:33:36.102+05	\N	\N	{"global":{"distinct-count":2500},"type":{"type/Number":{"min":1,"max":2500,"avg":1250.5}}}	1
99	2018-05-10 09:35:47.378+05	2018-05-31 11:50:00.543+05	clientid	type/Integer	type/FK	t	\N	t	0	7	\N	Clientid	normal	66	\N	\N	\N	\N	\N	0
125	2018-05-10 09:35:47.482+05	2018-05-31 11:50:00.628+05	providerid	type/Text	type/Category	t	\N	t	0	5	\N	Providerid	normal	\N	\N	2018-05-10 09:35:57.182+05	\N	\N	{"global":{"distinct-count":7},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":7.002}}}	1
25	2018-05-10 09:33:33.34+05	2018-05-31 11:50:00.317+05	TOTAL	type/Float	\N	t	The total billed amount.	t	0	2	\N	Total	normal	\N	\N	2018-05-10 09:33:37.027+05	\N	\N	{"global":{"distinct-count":10000},"type":{"type/Number":{"min":12.377464066307697,"max":249.05982750877476,"avg":85.6977993498081}}}	1
123	2018-05-10 09:35:47.478+05	2018-05-31 11:50:00.63+05	formsubmissionid	type/Text	\N	t	\N	t	0	5	\N	Formsubmissionid	normal	\N	\N	2018-05-10 09:35:57.182+05	\N	\N	{"global":{"distinct-count":9998},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":35.965}}}	1
138	2018-05-10 09:35:47.509+05	2018-05-31 11:50:00.631+05	eventtype	type/Text	type/Category	t	\N	t	0	5	\N	Eventtype	normal	\N	\N	2018-05-10 09:35:57.182+05	\N	\N	{"global":{"distinct-count":5},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":26.4823}}}	1
21	2018-05-10 09:33:33.316+05	2018-05-31 11:50:00.318+05	USER_ID	type/Integer	type/FK	t	The id of the user who made this order. Note that in some cases where an order was created on behalf of a customer who phoned the order in, this might be the employee who handled the request.	t	0	2	\N	User ID	normal	14	\N	2018-05-10 09:33:37.027+05	\N	\N	{"global":{"distinct-count":1787},"type":{"type/Number":{"min":1,"max":1952,"avg":979.7903}}}	1
7	2018-05-10 09:33:33.139+05	2018-05-31 11:50:00.359+05	CITY	type/Text	type/City	t	The city of the account’s billing address	t	0	3	\N	City	normal	\N	\N	2018-05-10 09:33:36.102+05	\N	\N	{"global":{"distinct-count":2469},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":12.1504}}}	1
64	2018-05-10 09:35:47.229+05	2018-05-31 11:50:00.486+05	_id	type/Text	\N	t	\N	t	0	8	\N	ID	normal	\N	\N	2018-05-10 09:35:49.923+05	\N	\N	{"global":{"distinct-count":4838},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":32.0}}}	1
126	2018-05-10 09:35:47.484+05	2018-05-31 11:50:00.632+05	_id	type/Text	\N	t	\N	t	0	5	\N	ID	normal	\N	\N	2018-05-10 09:35:57.182+05	\N	\N	{"global":{"distinct-count":10000},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":32.0}}}	1
116	2018-05-10 09:35:47.462+05	2018-05-31 11:50:00.633+05	identifiers	type/Text	type/Category	t	\N	t	0	5	\N	Identifiers	normal	\N	\N	2018-05-10 09:35:57.182+05	\N	\N	{"global":{"distinct-count":1},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":2.0}}}	1
134	2018-05-10 09:35:47.501+05	2018-05-31 11:50:00.634+05	eventid	type/Integer	type/PK	t	\N	t	0	5	\N	Eventid	normal	\N	\N	2018-05-10 09:35:57.182+05	\N	\N	{"global":{"distinct-count":10000},"type":{"type/Number":{"min":1,"max":10025,"avg":5000.5025}}}	1
115	2018-05-10 09:35:47.459+05	2018-05-31 11:50:00.636+05	serverversion	type/BigInteger	\N	t	\N	t	0	5	\N	Serverversion	normal	\N	\N	2018-05-10 09:35:57.182+05	\N	\N	{"global":{"distinct-count":10000},"type":{"type/Number":{"min":1464722672189,"max":1525423277963,"avg":1.4711409813331309E12}}}	1
66	2018-05-10 09:35:47.234+05	2018-05-31 11:50:00.487+05	clientid	type/Integer	type/PK	t	\N	t	0	8	\N	Clientid	normal	\N	\N	2018-05-10 09:35:49.923+05	\N	\N	{"global":{"distinct-count":4838},"type":{"type/Number":{"min":1,"max":4838,"avg":2419.5}}}	1
22	2018-05-10 09:33:33.321+05	2018-05-31 11:50:00.319+05	SUBTOTAL	type/Float	\N	t	The raw, pre-tax cost of the order. Note that this might be different in the future from the product price due to promotions, credits, etc.	t	0	2	\N	Subtotal	normal	\N	\N	2018-05-10 09:33:37.027+05	\N	\N	{"global":{"distinct-count":400},"type":{"type/Number":{"min":31.478481306013133,"max":129.06849213878442,"avg":79.59262891828064}}}	1
68	2018-05-10 09:35:47.244+05	2018-05-31 11:50:00.489+05	dateedited	type/DateTime	\N	t	\N	t	0	8	\N	Dateedited	normal	\N	\N	2018-05-10 09:35:49.923+05	\N	\N	{"global":{"distinct-count":19}}	1
32	2018-05-10 09:33:33.385+05	2018-05-31 11:50:00.383+05	CATEGORY	type/Text	type/Category	t	The type of product, valid values include: Doohicky, Gadget, Gizmo and Widget	t	0	1	\N	Category	normal	\N	\N	2018-05-10 09:33:37.178+05	\N	\N	{"global":{"distinct-count":4},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":6.515}}}	1
34	2018-05-10 09:33:33.393+05	2018-05-31 11:50:00.384+05	EAN	type/Text	type/Category	t	The international article number. A 13 digit number uniquely identifying the product.	t	0	1	\N	Ean	normal	\N	\N	2018-05-10 09:33:37.178+05	\N	\N	{"global":{"distinct-count":200},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":13.0}}}	1
131	2018-05-10 09:35:47.495+05	2018-05-31 11:50:00.637+05	eventdate	type/DateTime	\N	t	\N	t	0	5	\N	Eventdate	normal	\N	\N	2018-05-10 09:35:57.182+05	\N	\N	{"global":{"distinct-count":161}}	1
130	2018-05-10 09:35:47.492+05	2018-05-31 11:50:00.638+05	baseentityid	type/Text	\N	t	\N	t	0	5	\N	Baseentityid	normal	\N	\N	2018-05-10 09:35:57.182+05	\N	\N	{"global":{"distinct-count":7338},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":35.947}}}	1
119	2018-05-10 09:35:47.469+05	2018-05-31 11:50:00.639+05	locationid	type/Text	type/Category	t	\N	t	0	5	\N	Locationid	normal	\N	\N	2018-05-10 09:35:57.182+05	\N	\N	{"global":{"distinct-count":21},"type":{"type/Text":{"percent-json":0.0,"percent-url":0.0,"percent-email":0.0,"average-length":4.011001100110011}}}	1
\.


--
-- Name: metabase_field_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('metabase_field_id_seq', 142, true);


--
-- Data for Name: metabase_fieldvalues; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY metabase_fieldvalues (id, created_at, updated_at, "values", human_readable_values, field_id) FROM stdin;
23	2018-05-10 09:35:57.443+05	2018-05-12 00:50:00.412+05	["karim"]	\N	125
20	2018-05-10 09:35:57.378+05	2018-05-12 00:50:00.444+05	[null]	\N	127
22	2018-05-10 09:35:57.416+05	2018-05-12 00:50:00.462+05	[null]	\N	133
21	2018-05-10 09:35:57.399+05	2018-05-12 00:50:00.5+05	["ec_patient"]	\N	132
27	2018-05-12 00:50:00.552+05	2018-05-12 00:50:00.551+05	["5ff304b1-3dd8-4b50-bc04-3b4534e0c2ea"]	\N	135
25	2018-05-10 09:35:57.489+05	2018-05-12 00:50:00.577+05	["Screening"]	\N	138
24	2018-05-10 09:35:57.465+05	2018-05-12 00:50:00.629+05	["{}"]	\N	116
26	2018-05-10 09:35:57.506+05	2018-05-12 00:50:00.643+05	["916eb853-5b7c-4565-a48e-6b0512b7f031"]	\N	119
11	2018-05-10 09:35:57.198+05	2018-05-12 00:50:00.717+05	["CLOUDANT_SYNC_TOKEN"]	\N	40
13	2018-05-10 09:35:57.231+05	2018-05-12 00:50:00.752+05	[null]	\N	71
1	2018-05-10 09:33:37.228+05	2018-05-12 00:50:00.769+05	[1,2,3,4,5]	\N	3
12	2018-05-10 09:35:57.219+05	2018-05-12 00:50:00.77+05	[null]	\N	67
14	2018-05-10 09:35:57.245+05	2018-05-12 00:50:00.816+05	[true]	\N	73
16	2018-05-10 09:35:57.279+05	2018-05-12 00:50:00.839+05	[false]	\N	65
15	2018-05-10 09:35:57.263+05	2018-05-12 00:50:00.852+05	["female","male"]	\N	77
17	2018-05-10 09:35:57.296+05	2018-05-12 00:50:00.864+05	[null]	\N	60
18	2018-05-10 09:35:57.31+05	2018-05-12 00:50:00.877+05	[1525930326698,1525931216758]	\N	55
19	2018-05-10 09:35:57.329+05	2018-05-12 00:50:00.901+05	[]	\N	80
4	2018-05-10 09:33:37.65+05	2018-05-12 00:50:01.543+05	[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,22,24,25,26,27,28,29,30,32,33,34,35,36,37,38,39,40,41,44,46,47,48,49,50,51,52,53,55,56,57,58,59,60,61,63,65,66,68,69,70,72,73,76,80,81,87]	\N	28
2	2018-05-10 09:33:37.34+05	2018-05-12 00:50:02.08+05	["AA","AE","AK","AL","AP","AR","AS","AZ","CA","CO","CT","DC","DE","FL","FM","GA","GU","HI","IA","ID","IL","IN","KS","KY","LA","MA","MD","ME","MH","MI","MN","MO","MP","MS","MT","NC","ND","NE","NH","NJ","NM","NV","NY","OH","OK","OR","PA","PR","PW","RI","SC","SD","TN","TX","UT","VA","VI","VT","WA","WI","WV","WY"]	\N	17
3	2018-05-10 09:33:37.357+05	2018-05-12 00:50:02.118+05	["Affiliate","Facebook","Google","Organic","Twitter"]	\N	9
10	2018-05-10 09:33:37.827+05	2018-05-12 00:50:02.169+05	["Aerodynamic Copper Watch","Aerodynamic Cotton Keyboard","Aerodynamic Cotton Plate","Aerodynamic Granite Coat","Aerodynamic Linen Coat","Aerodynamic Linen Pants","Aerodynamic Paper Computer","Aerodynamic Steel Clock","Awesome Copper Keyboard","Awesome Cotton Bottle","Awesome Cotton Table","Awesome Granite Lamp","Awesome Iron Chair","Awesome Iron Lamp","Awesome Iron Pants","Awesome Iron Table","Awesome Linen Plate","Awesome Marble Shirt","Awesome Wooden Car","Awesome Wooden Pants","Durable Bronze Lamp","Durable Concrete Hat","Durable Concrete Shoes","Durable Cotton Shoes","Durable Iron Clock","Durable Iron Coat","Durable Leather Gloves","Durable Leather Plate","Durable Linen Coat","Durable Rubber Clock","Durable Steel Bag","Durable Wooden Bottle","Durable Wooden Hat","Durable Wool Coat","Enormous Bronze Shoes","Enormous Bronze Toucan","Enormous Copper Bag","Enormous Copper Hat","Enormous Copper Pants","Enormous Granite Car","Enormous Granite Computer","Enormous Granite Shirt","Enormous Iron Coat","Enormous Linen Knife","Enormous Marble Bag","Enormous Marble Clock","Enormous Paper Hat","Enormous Paper Pants","Enormous Paper Toucan","Enormous Wooden Knife","Enormous Wooden Table","Enormous Wool Watch","Ergonomic Concrete Chair","Ergonomic Concrete Shoes","Ergonomic Copper Pants","Ergonomic Copper Plate","Ergonomic Copper Shirt","Ergonomic Cotton Bench","Ergonomic Granite Lamp","Ergonomic Iron Hat","Ergonomic Marble Table","Ergonomic Plastic Gloves","Ergonomic Rubber Bottle","Ergonomic Wooden Bag","Ergonomic Wool Shirt","Ergonomic Wool Table","Fantastic Bronze Hat","Fantastic Concrete Hat","Fantastic Copper Bag","Fantastic Copper Hat","Fantastic Copper Watch","Fantastic Granite Plate","Fantastic Linen Clock","Fantastic Linen Table","Fantastic Marble Gloves","Fantastic Silk Table","Fantastic Silk Watch","Fantastic Wool Bottle","Fantastic Wool Clock","Gorgeous Bronze Wallet","Gorgeous Copper Bag","Gorgeous Cotton Hat","Gorgeous Cotton Shirt","Gorgeous Granite Car","Gorgeous Granite Chair","Gorgeous Iron Clock","Gorgeous Linen Chair","Gorgeous Rubber Pants","Gorgeous Wool Toucan","Heavy-Duty Granite Chair","Heavy-Duty Granite Clock","Heavy-Duty Linen Plate","Heavy-Duty Marble Plate","Heavy-Duty Paper Pants","Heavy-Duty Paper Watch","Heavy-Duty Plastic Coat","Heavy-Duty Steel Car","Heavy-Duty Wool Coat","Heavy-Duty Wool Hat","Incredible Bronze Gloves","Incredible Copper Lamp","Incredible Copper Pants","Incredible Cotton Chair","Incredible Cotton Computer","Incredible Granite Pants","Incredible Linen Hat","Incredible Rubber Keyboard","Incredible Silk Computer","Incredible Steel Coat","Incredible Wool Wallet","Intelligent Aluminum Bench","Intelligent Aluminum Car","Intelligent Bronze Chair","Intelligent Leather Gloves","Intelligent Plastic Chair","Intelligent Plastic Keyboard","Intelligent Rubber Bottle","Intelligent Steel Clock","Lightweight Aluminum Bench","Lightweight Bronze Coat","Lightweight Bronze Shirt","Lightweight Bronze Table","Lightweight Bronze Toucan","Lightweight Concrete Knife","Lightweight Granite Computer","Lightweight Granite Shoes","Lightweight Iron Pants","Lightweight Leather Coat","Lightweight Plastic Wallet","Lightweight Rubber Computer","Lightweight Rubber Shoes","Lightweight Wooden Shoes","Mediocre Bronze Computer","Mediocre Bronze Gloves","Mediocre Concrete Car","Mediocre Concrete Knife","Mediocre Copper Car","Mediocre Cotton Knife","Mediocre Linen Shoes","Mediocre Marble Shoes","Mediocre Silk Plate","Mediocre Wooden Coat","Mediocre Wooden Gloves","Practical Aluminum Computer","Practical Bronze Bottle","Practical Concrete Table","Practical Concrete Wallet","Practical Concrete Watch","Practical Cotton Shoes","Practical Granite Bench","Practical Granite Pants","Practical Iron Car","Practical Leather Bag","Practical Paper Wallet","Practical Plastic Car","Practical Rubber Computer","Practical Steel Shirt","Practical Steel Table","Practical Wooden Gloves","Rustic Aluminum Computer","Rustic Bronze Pants","Rustic Iron Chair","Rustic Leather Chair","Rustic Leather Plate","Rustic Linen Wallet","Rustic Marble Shirt","Rustic Rubber Bottle","Rustic Steel Knife","Sleek Aluminum Toucan","Sleek Copper Bag","Sleek Copper Bench","Sleek Cotton Car","Sleek Iron Bag","Sleek Leather Gloves","Sleek Steel Watch","Small Bronze Bottle","Small Bronze Hat","Small Concrete Shirt","Small Cotton Knife","Small Iron Toucan","Small Leather Clock","Small Linen Keyboard","Small Marble Chair","Small Paper Chair","Small Rubber Bench","Small Rubber Hat","Small Rubber Table","Small Wooden Shirt","Small Wool Chair","Synergistic Aluminum Wallet","Synergistic Bronze Coat","Synergistic Cotton Bench","Synergistic Paper Shirt","Synergistic Rubber Knife","Synergistic Steel Bag","Synergistic Steel Clock","Synergistic Wool Chair","Synergistic Wool Gloves"]	\N	30
6	2018-05-10 09:33:37.714+05	2018-05-12 00:50:02.187+05	["0039085257443","0080913806166","0193622489091","0223463079578","0266395937202","0345353072053","0365814083336","0367211708072","0368413976627","0542301596924","0685731340146","0705767545749","0761352999939","0768866991480","0771359736086","0874083316866","0889005880561","0893866879954","1015531302836","1049066362089","1224623671624","1339793375323","1388680209272","1406042374052","1446345768745","1452839798082","1491752229662","1505574116588","1508850445877","1516020229073","1531651914891","1642168927639","1645391395251","1655144037741","1708125205773","1766476263453","1822816243483","1852124531316","1883906886751","1996911472984","2014138835135","2209870433613","2303521686448","2381000747866","2421804675634","2504641492807","2524683839644","2588209409483","2708977753988","2763391997653","2767465173936","2781272028067","2853743176888","2907442406781","2912871854997","2933938753855","2972612435526","2973334477184","3307417948800","3318870462178","3378896351771","3420284197796","3547213972603","3571460165730","3618315234996","3726665749920","3791564699805","3821120393523","3833568155977","3851134627031","3993080536989","4081328904887","4121133415908","4140372254086","4217164925995","4244169498940","4275475741130","4292136596694","4357503908101","4369580649532","4402403456587","4406397607536","4409896545323","4427367186769","4477284243922","4525981056212","4635505629089","4764828838592","4793726998855","4878153242549","4936845518034","4949351374308","5001299033491","5022101985173","5025373493292","5045842207991","5106999164275","5135432624304","5205582918803","5220731053266","5235839511235","5286281563457","5294833001159","5331769886372","5392970146631","5475451470026","5494860851417","5555933000153","5580300869798","5738100232421","5771515662766","5790831995778","5836607682838","5849738425786","5953453545565","5992571249849","6004321858993","6009595045858","6069592700273","6107216519808","6158779904327","6283077633775","6307260357597","6311805265001","6358563805650","6377993273341","6403448512601","6411836466023","6662556936864","6715866263028","6756086028295","6759465970192","6773200168873","6785768996409","6806962988325","6888636255735","6892017974863","6945241085673","7060763627923","7078803677708","7149275420373","7152242635960","7226803568773","7233267484815","7328496622456","7397630510058","7399080258054","7468836405254","7509342302566","7638160392616","7638187937920","7668295014299","7744759715596","7813135596934","7915145518217","7980400187934","8034622167300","8044360565948","8145725713704","8196059660318","8202158269472","8324001438214","8337714047154","8445467670915","8467810981561","8506092970761","8522169002524","8544803456050","8659959585728","8696829800550","8766792505780","8798832944532","8866752005524","8918828811727","8942633253045","8997654116091","9038416137967","9048944276175","9152915256001","9160659225962","9177560996713","9208431506097","9226368553359","9268782064691","9280806230653","9298563671329","9351022797197","9368714668208","9373361190880","9485432568426","9576606975147","9676838418051","9766308228812","9790510096471","9798212806893","9821258471821","9866709398234","9867512877572","9873669903514","9908718200969"]	\N	34
9	2018-05-10 09:33:37.812+05	2018-05-12 00:50:02.22+05	[31.478481306013133,31.570810009636254,31.652451471595953,31.911059974627456,32.70869907177724,32.898589374893895,33.025676392361675,33.0691911827434,33.819398489965096,34.105364212062945,34.43393775314257,34.436949038695666,34.49232271512591,34.56736283853321,34.880668682414466,35.635592389312286,35.74549478152516,35.75521338106141,35.92769914542002,35.952248064666584,36.113935460814055,36.24941295417628,36.43197524755833,36.576426018011375,36.662566102988634,36.667628590443265,36.8315845033702,37.4916156743209,37.50054912285667,37.51104057352921,37.58694011400149,37.594646461064336,37.60486200773139,37.67719675012089,37.73218428524255,37.791426878082675,37.811220557372984,37.85601333686656,37.94845958813752,37.96298977577792,37.98894313586699,38.0205525319929,38.035528592907845,38.130719028057385,38.31451770105359,38.36261236465027,38.530771412532054,38.632153021191456,38.734016450731,38.787559038256376,38.84841754699762,38.88799647512116,38.944466441884,39.25322706185918,39.32619763276276,39.56265445490145,39.58553358265947,39.80596129296891,39.87054068251135,40.2051093470279,40.31331966092042,40.32041964503478,40.35810004525205,40.66896152589008,41.03090483120909,41.1481376882523,41.17140033287684,41.18667746593478,41.28073406920983,41.42694094244828,41.5210183254109,41.62637911399191,41.72533330055108,41.977197384353474,41.99768273555296,42.10305088938356,42.182090760487554,42.19613680465525,42.33811838875554,42.42927150549158,42.67451373301769,42.707309941184384,43.01529809205257,43.173563567776505,43.2103027382,43.886199108750255,44.27660098813121,45.27950659499382,45.636058560044816,46.39669998721752,70.57172752885909,70.85354088313747,71.49771803710149,71.54905986372474,72.96596482189507,73.19639194666517,73.65401307301552,73.66117403551691,73.78693193241033,73.86901346585773,73.88838559870689,73.89678717043223,74.0138399886752,74.58681052876558,74.65141332152318,74.68622776780649,74.70210866809188,74.74689226628516,74.7964997316208,74.82929026272033,74.88386414053099,75.04592049484627,75.17171353141414,75.39375636423622,75.4342325044977,75.5782958575026,75.88211088644746,75.93086065603255,76.03222871167812,76.11172770427238,76.27011260579093,76.36732260150961,76.37233456963133,76.39738017921495,76.50982131543958,76.75676766286642,76.87563519011165,76.92389684029916,76.92412015015292,76.95459498316461,77.05782495356112,77.10190755218902,77.15030490645287,77.18941333730268,77.28338940628402,77.48761028910431,77.55322688338404,77.56998383601317,77.6659600642541,77.75816139077654,77.87389118856868,77.87659600422019,77.99080121856078,78.0020983595424,78.00649355101187,78.00808522357906,78.0479937898473,78.04882374525098,78.06820055605543,78.07786359395314,78.08888786194562,78.1516484463319,78.27517848484804,78.35732113629447,78.38652808932241,78.54353607418858,78.59287204406947,78.59568620391565,78.70360294051893,78.81795404987895,79.01689858710748,79.0724098818133,79.14646416328823,79.2442446862764,79.25531873456106,79.3130107093201,79.34262029662838,79.40012710936679,79.50137062205391,79.53684798637575,79.55169756930505,79.59561366773278,79.61734293982114,79.71099776706703,79.82183989845656,80.04228684378334,80.06978661922757,80.08487588471849,80.23650200456913,80.392555805425,80.73348397034569,80.76530495656675,80.8113290846362,81.08314048886325,81.09828122135757,81.13091321632862,81.17813780639051,81.24207889711256,81.39731133780502,81.51127185581468,81.70338010030035,81.81966926973539,82.31933304702872,82.4778426224166,82.5660847281631,83.00775268524082,83.15002372588783,83.57855921489288,85.57515960004623,86.04566142585628]	\N	31
8	2018-05-10 09:33:37.794+05	2018-05-12 00:50:02.232+05	["Doohickey","Gadget","Gizmo","Widget"]	\N	32
7	2018-05-10 09:33:37.759+05	2018-05-12 00:50:02.239+05	[0.0,2.0,2.5,2.7,3.0,3.1,3.2,3.3,3.4,3.5,3.6,3.7,3.8,4.0,4.1,4.2,4.3,4.4,4.5,4.6,4.7,4.8,5.0]	\N	33
5	2018-05-10 09:33:37.691+05	2018-05-12 00:50:02.248+05	["Akeem Raynor Inc","America Brakus Inc","Angie Kautzer and Sons","Armstrong-Abbott","Arthur Stanton Jr. Group","Ashton Abshire LLC","Barton, Effertz and Weissnat","Bayer, Bernier and Ebert","Becker, Daniel and Swift","Bednar, Boyle and Powlowski","Bednar, Mayer and Bailey","Bednar-Metz","Beer-Treutel","Benjamin West and Sons","Bergstrom-Hudson","Bessie Zemlak Group","Blanda-Huel","Caleb Considine LLC","Chadd Brekke and Sons","Chadd Champlin Inc","Champlin-Wisoky","Clair Carroll DDS LLC","Cole, Hagenes and Stoltenberg","Collins-Vandervort","Connelly-Quigley","Conroy, Muller and Swaniawski","Conroy-Deckow","Considine, Collier and Bergstrom","Corine Roberts Group","Cornelius Price Group","Crist-Quitzon","Cummings-Schroeder","D'Amore-Conn","Darryl Krajcik Inc","Declan Jenkins MD LLC","Delaney Russel Inc","Desiree White Group","Devante Kilback Group","Dibbert-Christiansen","Dickinson, O'Connell and Flatley","Dietrich, Block and Block","Dietrich-Crooks","Dr. Joesph Schiller and Sons","Dr. Kristoffer Kling and Sons","Dr. Virgil Abbott LLC","DuBuque-Farrell","Emile Pacocha LLC","Emmitt Barton LLC","Erdman-Homenick","Erna King Inc","Ernestine Rau DDS Inc","Eusebio Stehr Group","Fadel, Kertzmann and Wehner","Feest-Kreiger","Felicita Legros Inc","Flatley-McCullough","Funk-Nolan","Gaetano Macejkovic Group","Genevieve Grimes LLC","Gerhold-Hessel","Gorczany, Haag and Hansen","Graham, Feest and Russel","Grant-Beer","Grimes, Ziemann and Jenkins","Gulgowski, Harris and Ortiz","Gutkowski, Mante and Prosacco","Gutmann, Hintz and Olson","Gutmann, Nicolas and Donnelly","Haag-Stroman","Haley, Jast and Quitzon","Hallie Mayert and Sons","Hane, Murphy and Schaden","Harber-Greenfelder","Hartmann, Sawayn and Zboncak","Hauck-Orn","Hellen Langworth and Sons","Herman Grant Group","Hettinger-Ruecker","Hills-Morar","Hirthe-Donnelly","Hoppe, Bogan and Strosin","Hoppe-Abbott","Irwin Jones and Sons","Jacobi, VonRueden and Schoen","Jenkins, Bins and Cormier","Jenkins, Hahn and Daugherty","Jerel Larkin Inc","Jermey Smitham Group","Jewell Kiehn LLC","Jimmy Hirthe Group","Joseph Reynolds and Sons","Jovan Fay I and Sons","Judd Turner Sr. Group","Julian Gutkowski and Sons","Junius Harris and Sons","Juvenal Koch and Sons","Kenneth Huels and Sons","King-Stark","Kody Windler Group","Koepp-Conn","Koss-Runte","Kulas, Witting and Thiel","Kylee Prosacco and Sons","Lehner-Fadel","Leonardo Ziemann and Sons","Lind, Dicki and Hartmann","Lindgren-Wuckert","Lockman, Anderson and Ernser","Lockman-Raynor","Lonny Rice Group","Lorena Mayer LLC","Lorenzo Schneider LLC","Lowe-Heaney","Lueilwitz-Kuhn","Lueilwitz-Runolfsson","Lueilwitz-Witting","Luettgen, Kilback and Satterfield","Luettgen, Lindgren and Rau","Lynch, Schultz and Bashirian","Madisyn Kulas Inc","Maggio-Gerlach","Marcel Moore Inc","Marguerite Klocko LLC","Marlene Bergstrom Group","Maxime Ryan LLC","Mazie Anderson Jr. Group","McCullough-VonRueden","McGlynn-Gorczany","McGlynn-Orn","Miller, Marvin and Sauer","Miss Sherwood Rice LLC","Moen, Oberbrunner and Shields","Mortimer Jakubowski LLC","Mosciski-Glover","Mrs. Ervin Nader LLC","Mrs. Warren Metz Inc","Mueller, Bartoletti and Lind","Mueller, Littel and Hilll","Murphy-Crooks","Nitzsche-Wolff","Nolan-Raynor","O'Connell, Schaden and Rogahn","O'Kon, Dooley and Mante","Oberbrunner-Stiedemann","Okuneva, Watsica and Weber","Osinski-Fay","Osinski-Streich","Parisian-Borer","Percival Kautzer Group","Pfeffer-VonRueden","Pouros, Morissette and Lowe","Predovic-Bergnaum","Reichel, Jast and O'Hara","Robel-Ledner","Roberts, Dicki and Upton","Roob, Smith and Hettinger","Rosina Senger II LLC","Russel, Jacobi and Keeling","Rutherford, Carter and Muller","Ryan Streich Sr. Group","Samara Boyer and Sons","Sanford Feil Inc","Schaden-Muller","Schamberger-Bins","Schiller, Hyatt and Beahan","Schmeler-Brown","Schneider, Glover and Zieme","Schoen-Franecki","Schulist, Hackett and Bartell","Schumm, Hegmann and White","Schumm-Parisian","Schuster, Kunde and Swaniawski","Schuster-Crooks","Shanahan-Kertzmann","Sipes-Koch","Smitham-Feil","Sporer, Weber and Brown","Stamm-Volkman","Stanton-Emmerich","Stroman, Vandervort and Schneider","Sydnie Toy Inc","Treutel, Kuhlman and Ernser","Ursula Rohan and Sons","Vada Predovic and Sons","Veronica Hettinger and Sons","Veum, Schultz and Kub","Waelchi, Schuppe and McKenzie","Walker-Stoltenberg","Walter-White","Watsica-Kertzmann","Weissnat-Christiansen","Welch-Bernhard","White, Fisher and Walker","White-Lesch","Wilkinson, Walsh and Quigley","Willms, Wolff and Heathcote","Wolf-Wisozk","Wyman-Torphy","Zboncak-Tremblay","Ziemann, Yundt and Murazik"]	\N	29
\.


--
-- Name: metabase_fieldvalues_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('metabase_fieldvalues_id_seq', 27, true);


--
-- Data for Name: metabase_table; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY metabase_table (id, created_at, updated_at, name, rows, description, entity_name, entity_type, active, db_id, display_name, visibility_type, schema, raw_table_id, points_of_interest, caveats, show_in_getting_started) FROM stdin;
9	2018-05-10 09:35:47.044+05	2018-05-10 18:43:15.586+05	databasechangeloglock	\N	\N	\N	\N	t	2	Databasechangeloglock	cruft	public	\N	\N	\N	f
11	2018-05-10 09:35:47.05+05	2018-05-10 18:43:15.586+05	databasechangelog	\N	\N	\N	\N	t	2	Databasechangelog	cruft	public	\N	\N	\N	f
2	2018-05-10 09:33:33.004+05	2018-05-31 11:50:00.587+05	ORDERS	12805	This is a confirmed order for a product from a user.	\N	\N	t	1	Orders	\N	PUBLIC	\N	\N	\N	f
3	2018-05-10 09:33:33.01+05	2018-05-31 11:50:00.62+05	PEOPLE	2500	This is a user account. Note that employees and customer support staff will have accounts.	\N	\N	t	1	People	\N	PUBLIC	\N	\N	\N	f
1	2018-05-10 09:33:32.997+05	2018-05-31 11:50:00.639+05	PRODUCTS	200	This is our product catalog. It includes all products ever sold by the Sample Company.	\N	\N	t	1	Products	\N	PUBLIC	\N	\N	\N	f
4	2018-05-10 09:33:33.038+05	2018-05-31 11:50:00.655+05	REVIEWS	984	These are reviews our customers have left on products. Note that these are not tied to orders so it is possible people have reviewed products they did not purchase from us.	\N	\N	t	1	Reviews	\N	PUBLIC	\N	\N	\N	f
6	2018-05-10 09:35:47.035+05	2018-05-31 11:50:00.718+05	obs	0	\N	\N	\N	t	2	Obs	\N	public	\N	\N	\N	f
12	2018-05-10 09:35:47.053+05	2018-05-31 11:50:00.758+05	statetoken	1	\N	\N	\N	t	2	Statetoken	\N	public	\N	\N	\N	f
10	2018-05-10 09:35:47.047+05	2018-05-31 11:50:00.79+05	contactpoint	0	\N	\N	\N	t	2	Contactpoint	\N	public	\N	\N	\N	f
8	2018-05-10 09:35:47.041+05	2018-05-31 11:50:00.827+05	client	2501	\N	\N	\N	t	2	Client	\N	public	\N	\N	\N	f
7	2018-05-10 09:35:47.038+05	2018-05-31 11:50:00.976+05	address	0	\N	\N	\N	t	2	Address	\N	public	\N	\N	\N	f
5	2018-05-10 09:35:47.032+05	2018-05-31 11:50:01.058+05	event	14500	\N	\N	\N	t	2	Event	\N	public	\N	\N	\N	f
\.


--
-- Name: metabase_table_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('metabase_table_id_seq', 12, true);


--
-- Data for Name: metric; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY metric (id, table_id, creator_id, name, description, is_active, definition, created_at, updated_at, points_of_interest, caveats, how_is_this_calculated, show_in_getting_started) FROM stdin;
\.


--
-- Name: metric_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('metric_id_seq', 1, false);


--
-- Data for Name: metric_important_field; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY metric_important_field (id, metric_id, field_id) FROM stdin;
\.


--
-- Name: metric_important_field_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('metric_important_field_id_seq', 1, false);


--
-- Data for Name: permissions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY permissions (id, object, group_id) FROM stdin;
1	/	2
2	/db/1/	1
3	/db/1/	3
4	/db/2/	1
5	/db/2/	3
\.


--
-- Data for Name: permissions_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY permissions_group (id, name) FROM stdin;
1	All Users
2	Administrators
3	MetaBot
\.


--
-- Name: permissions_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('permissions_group_id_seq', 3, true);


--
-- Data for Name: permissions_group_membership; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY permissions_group_membership (id, user_id, group_id) FROM stdin;
1	1	1
2	1	2
\.


--
-- Name: permissions_group_membership_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('permissions_group_membership_id_seq', 2, true);


--
-- Name: permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('permissions_id_seq', 5, true);


--
-- Data for Name: permissions_revision; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY permissions_revision (id, before, after, user_id, created_at, remark) FROM stdin;
\.


--
-- Name: permissions_revision_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('permissions_revision_id_seq', 1, false);


--
-- Data for Name: pulse; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY pulse (id, creator_id, name, created_at, updated_at, skip_if_empty, alert_condition, alert_first_only, alert_above_goal) FROM stdin;
\.


--
-- Data for Name: pulse_card; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY pulse_card (id, pulse_id, card_id, "position") FROM stdin;
\.


--
-- Name: pulse_card_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('pulse_card_id_seq', 1, false);


--
-- Data for Name: pulse_channel; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY pulse_channel (id, pulse_id, channel_type, details, schedule_type, schedule_hour, schedule_day, created_at, updated_at, schedule_frame, enabled) FROM stdin;
\.


--
-- Name: pulse_channel_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('pulse_channel_id_seq', 1, false);


--
-- Data for Name: pulse_channel_recipient; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY pulse_channel_recipient (id, pulse_channel_id, user_id) FROM stdin;
\.


--
-- Name: pulse_channel_recipient_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('pulse_channel_recipient_id_seq', 1, false);


--
-- Name: pulse_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('pulse_id_seq', 1, false);


--
-- Data for Name: query; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY query (query_hash, average_execution_time) FROM stdin;
\\xeaa787f70882b4674a30e11f8dc837a9904e4c86fcf6c6066f7d1d3dee9bbaa0	111
\\xd3c7421dc27e7dd57ea2fc4eb3796392c957d0c6574364d885c64955a41bc36b	365
\\xc675b8049d324074d9dd0b21b44d1f9d3959f945f594385b710f0ed6ec6f59d7	27
\\x8ab8621be10b1d2e8982b0481d73b152256f18f473b7dbe77e52d8593cf70598	6
\\xd9fe0a5345765d74f11aea4dda41bc86661dae83f7bcdf14df5a3ea8617d65be	38
\\x27c77fd3c2412b9e60a5ab11102282ed1acf7b102c153ef7d39604c6aaf8af49	38
\\xdb7a424767893c7a4d8260a61da6a2e5499fa158b49cd69b299107a274ec5a02	231
\\x2cd6883f978896a993c094f3a4140f3fca257b23ac6f64f8034f632bed6b3df1	1507
\\xdaf8c43e03ce8882eb61f9d7c93f664a54c929621861aa991f904f66ab8b4960	56
\\x59eda70f18ed3e5ae31e1ccf3c9eeb47469c8f3d31e382e106d99db0139d02c2	8
\\x0f2d83e15795f8fd3f9d71848f5d9314a9b5b73e119082d597a95a9255d8c2b8	8
\\x103f38bcb650c6a03b016541d67f2e48dcb24178b04ed911f5ff968050dc102d	624
\\xd7c7c72c7fdb79b993920bce97afc9f850f12d507da7832606333ffc1bf7a60e	19
\\x9c3ae202149b4b75a865cff22b825ef7fb381ff284ce867dde43a5ba8d4b3f73	10
\\x5d976b549a46ff94a37092e6fba6aa10ba00c226ff45980782a15d27401c7bec	38
\\x53368572079769e5fc5ee82865b51882a899774fa71a2cbe065e6573289825bf	31
\\xd34714c08a4f1d4212a42ce7c853c540497f8ffbda59355e0783aa1d7dbcf3b6	29
\\x1352bb5c1a9db373c26daed48e5053ddd782e2494e9a0d83b300bbdf0a61a884	25
\\x0c971541808c2059d82050872449fa654e4d06717b4db8801590244095e19122	64
\\x58e8974cefcba6d23524f4cf84179abf56c0c6cab68acdbf2708eee57e0fa5c6	329
\\xaa5969abda2dba231eebd8116cfa1a363cd9856e63d7d41566a3e66bc7a034cc	44
\\x530d5dd0bbc96b26f97d58a169b522b4dfd75c12d079ecebc341f713227867a7	43
\\x5386d26cdba27f26b9bc550ba820e0100c8d99c01a3f603ff143e6d82628e69a	449
\\x3c7fbf09be1285e52375b7ad68aaad506025e2b8c74cf8c0c9c03b6271bc4e85	32
\\x2679168d411ad805b9515e0857d60d6370066358c25cca71c2c516c73cad3048	286
\\x9b9dbce0a3828abcb3ea0fc83d8c3131d0f074f273cc099a1e3b2d519916d2e5	47
\\x640285d6a3097377e75e3125ead1b591738757fcce144618da400fe0dc5b0025	49
\\x3d5f4c09759fc5d0bec9690bd61fd57249362cf229c0ee8085764adf87f6c563	30
\\xfeae41237b0e89c37d04c032c70274ab68179dd26e27d4bb8ceb9e0bc1bf1b3f	24
\\x2b87c165d553f54bc6471cc04b4401f1175fb11fc309278cee2496558394aa04	25
\\xf70a745313efcf56ce321b5fd3151282608199d65030a810ba827854fae89783	311
\\x169bbf0fe3b5b222623b51b18d4c4636d223d62a33c37152254a6b93ee73b55c	220
\\x1030637b0c9b28d6f3fb9113dce98354595d4a8f2a135cba0f4b5294a4c0a890	233
\\x893b140310649376a75aaceed2221a99b981cf290e1177aedd8c7ab05957cc41	220
\\x8cabea0c035fd65894813377b5ab7abb3509af4eb5c8202c64c5f962478ab096	248
\\xf6c77a9342f4691477c7f5d514a4cd760a7b19eb917156de634e07a2fc7650c0	372
\\x5b9802e7aabdfc852c5164d7ac171082d57b3bf48da8a1832f8fef3ac99c0c46	32
\\x6a0e0cf3726ab8907759fd354fa2abe9ecca120bbc2d1b0913d628360ee627b7	315
\\xd22d1b931f78335a4476f94158ed8ce579dfab27c723716b2b4edcff535e58c1	186
\\x27e288d9ed41ce655b7b6df9f9bb875e771d98f863deecd1b2542885aba2e4be	388
\\x9bff52c7c1ef10501fb8d395309468dd15292786edce3557f0547a44f3db605f	334
\\xc1ce618898628643645280c58fdfeefc42c7e956c00b07311f3424002229371e	160
\\xf98177a9fb71fab785e29aaf3f0fe7a7131961672b511de80a151d54a6289edb	56
\\x0fb6e7ad71f2b0aa0c4751b7b2b596636baf40711060916b532e64d20c94d7fe	168
\\xfc3c845e3cb40b2d749e06eb54fc8b87a6126eb91a8d42985dd533f356c453cc	210
\\x69f700c316037dc2790535556173520f4c90f6a3f1431e1ff08e91188c950c39	150
\\x3e6b30fcc693fe679c5e4fc735c5daba4c640c2720b78fe0b94c1c2ef53c684c	164
\\x74a8ca4653974e67855e6aa074384e73662a111ae88f70e0f07d5d26966eac75	29
\\x03a34660b3e9424523725f8d8aa70c9f0ba046e64f0d384488aa6a8b69015771	162
\\x7cbf702e527b9bd21c0772c30ffa395556a1c907fda7abdc8546cc80ccf7e4cd	24
\\x7db2942aeb628397e51c18023ab18de79d767c8a061b0587fa9daee42beecbb8	25
\\x349760d01e6d78708796b74435698ef8da58d5fee3d5cce30ee37eced24892ee	172
\\x3fbc92380ce7a4e70328c53b14ee7e8aee5400192c6dbfde8f2e4a50f7ed01a3	29
\\xa185685494fb0b0db2d17ffbecc970c7cdd0be709a8681cc218d0afd6027ef9d	218
\\xcc8e152254f009b94147aa665741c7c388a13bc0e7813f98085084f88a5f3067	188
\\x2766c88c42b2f536b65564bbe4f81a3612918671bcf479501793a3ea119d53da	674
\\xc1402a6327738a9efb05a14da9f6e0eb7a78e1ea4863471934f3a7975f7265b4	210
\\x2b1278942a0e8d4150fadc4d904522f0ce5edf4690115ec54b10bdcf1c7c803a	27
\\x0b8e131e308a16abfaf257f041cffef2c7259fdfaa34baf3dbc9645273eed1b6	169
\\x4a75167640637e7c4773d3a6d5110f5692e465241c7502d617cf262c5a117a74	171
\\xf50d4217ddf32ec899cd9a230f98c41480aba86997ba3298593ddb58c0e0e24b	170
\\x2779224ba015ca94f4d0c4e2d049b4d72b32fe95c027e4c7f4214353f361b49c	176
\\xd77aa3a5b754bdb259b7dc5a3638328d2a47c131846d2bcfd6210163cc380254	182
\\x60930c9a0d610fc15a2453f21ed61e3e67ac45beb66f3e300187848666e8a73e	53
\\x8c2796adb6934e57515e2977fdc3b5a56331b1853e21e57537f8a538d973199d	41
\\xd6c03f7939cd07addb4b60bb94a5765ae27d8aca2f6007b00806782f9508207a	33
\\xc07f3f69812016baee2a0b982bc1f3661c56677dce69b38a7100386aed5fef1c	27
\\x88bb4d3915aa30d98b6aa14d05efb92a152ee88d84d22e9025922ba126436305	232
\\xd4fd9f0c2902c805eb1c948e90cafe89b7447fd05f0a1bcff774832d5573c8de	110
\\x651b1d729dae19b10a2d5b3081338c18717af67a973cc71e7fbcdb087993c095	217
\\xefc93672e4f896a1bf5c2abb3dffe3f41c43672f92e0f338a6ad0623e829125c	112
\\x61c4d93817b39e501bdab36845fad7a42db9309783a5d751af7270e08ba8d83a	228
\\x2e8740586b3bcb41f7e172109e6af68d6f6a96e9a5af90a9bacfec40b9bc1bd7	56
\\xf41079c3fe29629465b4baf7e60fa87cb96394a46b8b1634b8f50c3bd7db18b8	44
\\xba07a7b0c2c067cf2a7d7437b9d47de73d5e5cf125d7a45a13ffb8178a88148e	25
\\xe99f2f0a0b9ba63dd59a556aef33ae200bc7aadaa168709a433081520c91d7d2	178
\\x1ba2e4498d6ddd2b42aa5701f8b1d0cf71d191e2bd23206b384c17ea9e30728d	37
\\x8338a066d5fcb3024c0f8dc7507ab731e68989d46566fb63071b0485d7f302c8	32
\\x6ca638d801a339c965f60d8f33875099d0e69c50dae50ccf3c125b253823ecbf	31
\\x71a7edb69d00442dbcbd8d7dc88a8e9fe4b8dfc3474c0d30f5a4ed54fab9f503	30
\\x61b224a4391817e421402129aeaeac1eb9d507437031a7b9d90cecdfcfd3e42b	31
\\xa105a2e51a83351044c0ec02a9a179513f0ceff38d499d16f2a1f92d5b42851e	31
\\x79e1cf4f31ec1a21a4608ab1908f3ba57b61a3200e720abbb9a490ace430533c	166
\\x08ca3dc773041d78d64d6d1056c532e0b524ac4c61ca80b4912499d20156db9f	212
\\x35c347c183a740c22228c135075abdaffee4bd5683592f0abf9ef78b4553a58a	39
\\xeb894eaf1196ebad6e94d103e96b37bfffbcdc866c7be808a3c70e83b8cd94c1	239
\\x73b4680be1becafe399ca396957b30b31d71c8e3fd1f97d1814c92953549b9da	43
\\xc8cbfa8c365920e3080ef5c94929f4fd360828b5db4920147f2162e71a454671	222
\\x4ae76f93d695ef43774c688e69d2b9fb30978ac8a6d43420b2843359e52cfceb	231
\\xcd35a910a8087c45c67d71f49c9f5b94292df85fe37374511015a99fbc44d2c4	69
\\xf5e8506f6b21a3d954cfac8b91f83f6b2bbf2cfc64febe66a78580bc253e43c5	222
\\x93be832054e4148f03590d9d533569f4c6534544f68f90c2400f4a7334be91d0	37
\\x041f58a8ae7e63b7c4657f152be1a46027f0f21b6822d0a3e2e7896a415d7190	243
\\xc666f5bb7860fb6c740994d2f061ea0b029c2e17ee219ca904617e7091d94f46	34
\\x8e69efb574f545b1df57342ed497015a6d061e120d4ade9543fb43476f61d8dd	50
\\x1053f70cf7652378c8ca012af57e7b337c5902c3971f24e32e0549e5bd84d366	226
\\x4370cf36abec25622c706a313bbd6dc341b318c9e22b0ce7779b070dc0ed0831	71
\\xea969158c73e108e70b1ff8cb633f40a43007a3652ab010d374512cff8cff40d	22
\\xaadd57bf9fc124691383feddac6530bfd1dffc4587321b8b1613534ae77d0ae0	25
\\xfd1ee7f4c349633dddd8e1bbde3d888df03b2ff409003ef07d56d37d5c5d075b	23
\\x62ba14fbc419e6f3cd42c9a37aea9490fcc4154fb3ac60ae9e0487325bd1fe64	46
\\xaa293bb5525e033401fa24dbe5c7e005dbabb24890c3facd33986647ab8ec365	24
\\xe84449f614d63fee56e40341cd1115a033647f4ba18175b4348a4be8e59c226a	30
\\x77e76584be663323492d3053250b833f2e63a61a0ac95bb0151e92130e07cccf	32
\\x40c6de68ca08793c5a1e2e3fd8e0d7c7574cf44e778a9911c476b1d655b8df25	35
\\x8ea935a129c81087c2a00c673e16dfa4854c1ec03b2594b034041786321a2568	224
\\xbaf1b6778a4c60bcdbbd959deb8e4123d813c9e65fc697d3723fb2397f048acb	41
\\x6da4dc32f253e376d6e70b1ed0108ab6cc47fc76a0c320b12f2c1f3d0ddf4f7f	40
\\x737ae63e4a04c65fb3c9bb7dcd9e9270f7b708b77cd5bdc62e9a1e07843dafec	33
\\x995afa9769717634e01bbb5d556cb8ea8fc819346221cb6c08d85d8e2b906df8	26
\\x38da1376297ec92d5f596b1a8c3f0c81441a2a1e0e237ffada5f9ea60867dc50	109
\\x94aac15a2de1732171ab287b64df839ab9a09c4e2761446918077c384fd80a01	164
\\x73cdf619236c552536e0a1f4655fa621475379f543d808f75de298e65e8d1f3d	319
\\xf7817c13d6fbbe2fdb6c5150d8ce8cfcff2f8f946d0bb3f47655f1bf5c17fbec	121
\\x274db8b61a1f30f2414088211ba778015a0c756a1135d59948894a6001c810fc	216
\\x70ced9002696332c773ba1f81fdca6bf6f0bd9c35a8f83db09d9c3a0f053d29a	43
\\xd474bb9b25381c1ac39f2b4556d34f10ab33c4672d23f4bc08a7491749af997f	29
\\x4f44976960f078230ea99da0cb379cbce70da0ac8f531ab1de8c35c7880fb947	1338
\\xc907b7c22788d23329858a5bac5cd9dc6064716b5c5c86f98beec6c871ac0566	164
\\xb839012e30d1225b3dabfa5b14338218ef960414f2b13e6696b9208daf4c1105	159
\\x4eee9ecb63e8713f3c8e86e0cec0d52402f04aa4c77474de4db75db834154a06	143
\\x283085239783aed0644a7d4a31317b045cdde1e1342ab92160f3919b6b04ff67	31
\\x30a1fc503bc20af266151b5d9afc14606d461fd1bdaec706b9e4f6812b68f7f7	32
\\x7a764f64b3ccbb423482a30ed8197aa49dac6ec31b7a8210e5d764e09b9a064e	219
\\xc4732ca06f7545d625e3232fac6afc5e14f37b26a3ee54592b51c6bf73929b12	202
\\x9399377c164aa3ec6ab3b3a2196cfead80b9593af9f398655c15ca2ca7c4dac3	41
\\xc3a61077f40aab7677b167d4cced02011847c5493a08406d141836eaaa9674dc	36
\\xfddec19e8a6bc844a89e31bb7beb7dd26a37d34fe737ed3fa8af6e10e6191065	234
\\x46017f95a73343a2d7d0e68fdcb54a8dc34ed109d663ba96c37ad4904ab7ac5e	223
\\xd9254da326c08809513b02ed5ced851e9571ac0126cd58187b1bbcc3b58c3008	43
\\x340e85ef6f6f21c5812b50cdb4ff8d28da3d3707878cadbf10e519d6ba3e8a75	223
\\x2c2e509a058169cbc445bd158f6f51f332172c527ec340d450cdfd4ba4a86fa5	217
\\x3242c7f04b88b1459faffceb7f298d3467116b0351209d38b41b43c08ef5db09	51
\\xd0328fbcc55cf76ef3c606b793e2c12f55e5ca0a1451943277e5a4c9d6cd85fa	226
\\xddb00ae6485ebfd73c507ce6462c4b9dc59021189a441030a4a8a95941d70906	201
\\xa2781e52d951d3efc5628aaa0e231fe45ffd0ecc6ee2f339158a6dfc27f7b533	70
\\x699af6b3f206499bd7c7475dc2efb310d2442bdaa9a6cd7571ae21112e4d2b90	210
\\xeb16ea6c3a4aa5ff08b5cf8c9140a3a395137b75a343a8b132f3bf43c9904218	213
\\x9403059f2dfca3ef7d257a001559a45af92904c003076f337842e327d1f0ee4f	40
\\xf7f73fb6a8441abeb8dbc42e47eed75dbbd40776d5e28e76193c722218d622ce	199
\\x0517aece015da3e180723d5684c1801f7e2b6a2383358c2a68708ac48a376683	210
\\x1aa866552a5900e9f1f4d86607eff6898d34430fffa2b531f9dfe43ae61dfddf	180
\\x73acb2f20d9d019692dfd0f275f23e01ab36fad99739d307b10cfecc78cf113b	217
\\xc6e07df307e4fc37b0f849bc01980d96b60ef234072b96124ec7617ad782e001	22
\\xfe50919ead1c6f5f9c0758c0156ca7453f86b861a4534524b2cdfb7e7966f34e	16
\\xd7de40df83bbb6cdf19ec4367210f5c6e4864322417c09d08be3a0db7189f156	201
\\xc071cc4eb19080fd31f84c16a20d09ea1f1a50a6e52925f2c574a15bd949f9d0	193
\\x0d9d797d1235b54210aee4705c5d458b5424d969bcf796eda5efb3ecaed89161	15
\\xcab565eb4efbcf631b831c3a761343a5b3ca1bfd595113e4a73a9ef20c8752d6	171
\\x202782c9488e8ac856d7868e8b56f7f1db4e84d30385fdd71181c4f398dc8783	20
\\x30e46ccea214065adcc1130acbdd0342d0ab23bbfd3658d839ffb30fe3cf34c9	15
\\x9738339eab623ed2fb2093249a41892ec873bea85cea267f1c4615788dcfa0c1	19
\\x4172c33b122f2baac361983b535a36d71cb963ff731eee35f5bcc9138bb99f83	14
\\x598542b095292c51ea5b015d21f61312a5495f1ffd20155155badef973cbfdcf	162
\\x3e096ba1940bf598a9eeb61b8766bec8735529c51783b78086ed713ed5781f31	15
\\x3d61a4a398e503975d9b9d96d820b39abd063c97d4acd22ff5a11fbfe292fc2f	173
\\x299081802049172247ca7b329d1b524681b98fe3d088b925bdf7bf17c9dba62c	195
\\x9ed47806b250ce1fc230d59ebef644cae6c8f36ef44066ad75b91baf0d6040a3	184
\\x6692f8795711a2a8d147aee5c557e4df9a49afaef7d1f8c3d01acfa7bab62aaa	203
\\x664cf609d3c5d644c7586479a5b4ceb76de59f9d4c0136c1a148f452671915b2	194
\\xae8eda9397963ebde0ac52dd286a81f2a0c10ff233e0ddf76ef36209370a8969	174
\\xe2a492eeb475912b3b89b8d44872f27cbd63a812ae5df2f29738931788d64db7	25
\\x8b5ac8f0ef0c306ceda2710bbd6f9e13f7c782c0fc6ad1a74be1348dd36e1c17	189
\\x7e66535098e69e7586b8a36915eee1388014fcd26b61962a8bc60f3696bd35f8	190
\\x638892564f882f80908de5d45f9a56592d06206316889eb8a4eafbb969dcd293	21
\\x4d05a2a2b7b125d5235ba2e6eaf5b9f9f468fddb3eec3de857c0f56225b73cc5	187
\\x232aee263646badd2f6d5acbc2fbd4ea2e5b2adf0d863d205e953bcf0ffd7358	9
\\x0d824504635264c0d617e297ae335fc24b0ad3be1c18e465ceccd9d07007ac57	15
\\x9544477cb157dd235451292b0b6f77d5d08f0a121afc1b6e8851ce1fcf993cfd	71
\\xcaf933070e41b4c651fba2be9e3e4dafe16d13bb2b1fb203902fad3af3f88e0a	7142
\\x75db6a8c4562742785671911886f5a719b152945423f5f278e04eaf4e5991017	197
\\xd76aef6252c39e1791e863afeebd67da9ea1e296dea142a35966a88171390099	297
\\xa8984d04aa0831499adf952aa23923b1a76b51482650f1044f6916dcb316dd6f	286
\\xee5239d4925e3a2dae3734003ed1e4dc85d74fa6b07c1729d0ade059f6b10c26	288
\\x28f8c0d2a5ca33ba2b8f836520f3f17c048f46a0920d24b9487638b1e8325463	305
\\xe6556c2f0d6f1ad4b415d0a4ed6465ed3ac172835963bdaca2c9323fc360e68a	20
\\x753adfc95a052fa5e9a249ee8bc4442e988444954949ac5d76872e8b7675ba66	18
\\xa8ba8b6fe4698eee286eb80c184edc2e0f94d43014cb3440a3a241b874081ce4	27
\\xa33be5de317284f52a58c23ececd67fd22e5dfaa2031e54d937351e9ef9b3536	10
\\xc8c932438a7408bfe0c0e8d1767d3e5b68ccbefe54359e4f839695a4d65baf5d	13
\\xe5c0d8d37650c87ca07ec861cab7300e4b4797633735d999073767360d6b6b47	13
\\x891fd042f48eaa65eb03a971119dc13649a76c411e549641a8eca1e24d3ccb0e	164
\\x524b8a6f3f98552f3ead229882ee19b4948464ab0f29eedb4df77b4d752fcb59	174
\\xd76a3dc0ba4d607d3a7bb6c927d4496e17831029d80f06253a07c1ece003553f	12
\\xab680b9a199c68d76cb1126d710b3682d0fc7219d1b44ac502894268bd5cb4ee	193
\\xc495cb30ce642ba6c75323b8f242bf2e7a007801865f7315176ec47d6d01b28a	294
\\xa495ed6a71b7697b05eb19c257ff2e5928ad35a943c5c77d28352daa2065efa8	295
\\x91da5bbddb7abf7979a119322e7b3d924443bd4c5495f9cba7c5343887055b43	169
\\x324171589606fada61afb09af731628e4d58cb591e10879d2e57ac48abe7dd6c	59
\\x837de1fbaf3b620b6a236a1a540c8c3d0f1d6543341f10566c67fcf0f046adc6	63
\\x6e970e87142e74a9ed5b0bb7b717fc67be3772caf3109096ed8be44ae51ad063	31
\\xe3aaebba69d2c390903cc5596f67dc7aac163388eec4a3ab168c37fa85cea721	1126
\\x4532d70b0a38ac917b105b19241aa30303898aef9ac9702ae44ada8241f80b84	322
\\x8ae80493353081dfbd8d55b348833826cc1a1f13165ed62df29973c3d8daae75	299
\\xb5beba004be4cee68cdb49fffce6ddc07353675056b4acb13d9ce235e0998efd	35
\\xf8d81e4ab11a36005c8fdf5614846b1fe725f94143e38ad8134236570b2c5311	33
\\xfa2a29ee538969e8a42b8b65121d8612cd4d22febfef4d8bd01d60ba5f95c50b	8837
\\x479c76b9485e3dbb77990915f2e9043712f580f21878c0fafd1a4a079abb0da3	166
\\xf5bb35262b14839953ef7fd9e95f6ed9b9756817e0fe3c85edd042da73a69b7e	171
\\xde126e2ad09610414386c9e8e517c899ed8ca75e70ce62d9516bc41bcbdc83fa	329
\\x2805a292160f8183baf17d032441b24340a6a930a9e414736106df6b80501de7	304
\\x6e05847cfe924d7651adb3e3b50be5a08d91bc676611be4c37d418fbc310dcfb	164
\\x87acd77e9abf37797873583f0225c1f6a715728a0a04237e19e29cb0ef5a2e18	297
\\x46cf17d1a63c95bc4929ffe3cbac6405dfdfbc68ab48714850bd227baaf43926	172
\\x1ec8543e542479ce09deab374ce4832f2234cee4705fe2e9ba7110f1894ec90b	306
\\x877e71cdfa4663cf6d2fe1233b3df009b7aa357915cca8a9f71b793bc5d7b07a	302
\\x0651eb95dac29bd2d4dcb5740c5282180db865266a7fcf6a379ef6374a4065ce	317
\\xde526cf2199a8fbb557a5ec2e6988de5043d07ddbb25ee7035f53570f298b2c6	332
\\xa09a6367872457a766e3af5766d846cda4a7d316a7d9e9cb174a5faa2de20e4a	311
\\xbb56aeaa1ac4c0b350f87332ab09a7788467c3c22dcc5160e473b9d8cb819959	3731
\\x12e9b6a3286b4aa1cf0f816bd5ad90931b4018486745db72cb651f4431116b6e	1947
\\x6dcb470f09e67056cf6da38724e14714faa763329664807379d07da8e52c2f11	162
\\x226d8cf1175a49783be6334aa4dbea953c7b9d5d0f0a2018fc8a2820f5fffef3	1656
\\x4bfa8637452831e87c66f0668642ff57dea623a13ccc5d004ecdc92ad356fa6a	198
\\x889aad2d75fa64146c8db540febb2a9e83699e58194a86354a0e883c2072ec0e	1494
\\xf0dead72489245e6977db4e30d505892b2be8d20539ed56e0411d97668a51ee4	318
\\x3f85482ad1eca68de0403f2fd7b92616359e1133d3065928d975f281f8ba5f4f	314
\\x6261a8007a957539d06884b9865e6e77b0e565c39350a362a71ca3bf3b43cb1b	325
\\x3faeae7c8b976618951577d0d6b2f099a89f8b501c7392dc10fb54770ec36075	306
\\x816b99d5a3681e0809ccb472ddbc90e262ec0b52d59d304ee8b00dd03c99107a	182
\\x1f8bd090ee46eab83681a93b1e5d693c4a6e7db448c4d781fcdc44e18e544859	317
\\x0a227d6979fba4f04b0ead91b56213d5cfcae415cf572ded8f3d8a3f380316a8	371
\\xac38987462a91d484767ab363161ccc73065ae4374a83ef187e2b3bd68dbd563	396
\\x56bf3a9080c0368de17184edcbbb9dfad712cd5696316efdafa4b8133ade8d27	267
\\xc7c09217b39d9b238a4162f85df7a0f6f3f2dc2e4c64cf2588f3127ace87d44c	224
\\x7e001f2fa3467276c15e399a89014281fcf1f5c0d6730627439b9ffeee79d465	199
\\x4cb00a09440c5f372192c09d9b7f2e9ced627bd3792eb2670b40381a1be5396b	224
\\xa798ac87bcec471969b7c7125ae3ee97ce20c6febfb8f87f941ce47d66817daa	363
\\xa9dd4995bc62e082c4342c65c7d89d79c492de4114e00d89ca5f86795994c372	439
\\xdec74db9194353a9bfd039b0fdbf20dbf999ab7a9c228dd83dc7c400b6e7e59a	241
\\x1f35aea575b6a2d7bd7b4d189ebabf2e8d51d01abcbfa9e226b907a0836ac2af	359
\\x50d08631629d3213fdb4c77bc152d05682a0fb7634a11fc2797f594018b8b70a	363
\\x1f2393eaeb439e71d6dfd3cea2192fd60299c49bf620020c2b14f10fcb4d51cb	159
\\x5799e5ee5c0a531ebdeb28bb3587d69494d9f0e7b7d2822f3f2ada5513f02d8d	124
\\x21dccf365b0376a984813d599b75849647c35891784be9c8fb26c510eb3da78b	104
\\x026e7c41b9faf92803ff46f732bbadaa12b2e4667c40e5d6064ee95cb298f687	989
\\x853e6e4dc9986952f2986b24dadf3a065f75c9edff70f7fdd280aad27c021979	1095
\\x54862d22bcb68901eb371b8e9e536647dadd30c3796f0a9872c28815a6c19edc	634
\.


--
-- Data for Name: query_cache; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY query_cache (query_hash, updated_at, results) FROM stdin;
\.


--
-- Data for Name: query_execution; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY query_execution (id, hash, started_at, running_time, result_rows, native, context, error, executor_id, card_id, dashboard_id, pulse_id) FROM stdin;
1	\\xeaa787f70882b4674a30e11f8dc837a9904e4c86fcf6c6066f7d1d3dee9bbaa0	2018-05-10 09:38:34.423	111	2000	f	ad-hoc	\N	1	\N	\N	\N
2	\\xd3c7421dc27e7dd57ea2fc4eb3796392c957d0c6574364d885c64955a41bc36b	2018-05-10 09:40:07.309	365	5	f	ad-hoc	\N	1	\N	\N	\N
3	\\xc675b8049d324074d9dd0b21b44d1f9d3959f945f594385b710f0ed6ec6f59d7	2018-05-10 09:45:40.093	27	1	t	ad-hoc	\N	1	\N	\N	\N
4	\\x8ab8621be10b1d2e8982b0481d73b152256f18f473b7dbe77e52d8593cf70598	2018-05-10 09:47:22.457	6	1	t	ad-hoc	\N	1	\N	\N	\N
5	\\x38da1376297ec92d5f596b1a8c3f0c81441a2a1e0e237ffada5f9ea60867dc50	2018-05-10 09:48:11.096	8	1	t	ad-hoc	\N	1	\N	\N	\N
6	\\x38da1376297ec92d5f596b1a8c3f0c81441a2a1e0e237ffada5f9ea60867dc50	2018-05-10 09:48:35.47	10	1	t	question	\N	1	1	\N	\N
7	\\x59eda70f18ed3e5ae31e1ccf3c9eeb47469c8f3d31e382e106d99db0139d02c2	2018-05-10 09:49:24.748	7	1	t	ad-hoc	\N	1	\N	\N	\N
8	\\x59eda70f18ed3e5ae31e1ccf3c9eeb47469c8f3d31e382e106d99db0139d02c2	2018-05-10 09:49:44.126	11	1	t	question	\N	1	2	\N	\N
9	\\x38da1376297ec92d5f596b1a8c3f0c81441a2a1e0e237ffada5f9ea60867dc50	2018-05-10 09:49:59.312	11	1	t	question	\N	1	1	\N	\N
10	\\x2cd6883f978896a993c094f3a4140f3fca257b23ac6f64f8034f632bed6b3df1	2018-05-10 10:15:44.841	1507	6448	t	ad-hoc	\N	1	\N	\N	\N
11	\\x59eda70f18ed3e5ae31e1ccf3c9eeb47469c8f3d31e382e106d99db0139d02c2	2018-05-10 16:01:31.024	13	1	t	question	\N	1	2	\N	\N
12	\\x38da1376297ec92d5f596b1a8c3f0c81441a2a1e0e237ffada5f9ea60867dc50	2018-05-10 16:01:31.024	15	1	t	question	\N	1	1	\N	\N
13	\\x59eda70f18ed3e5ae31e1ccf3c9eeb47469c8f3d31e382e106d99db0139d02c2	2018-05-10 16:14:12.143	10	1	t	question	\N	1	2	\N	\N
14	\\x0f2d83e15795f8fd3f9d71848f5d9314a9b5b73e119082d597a95a9255d8c2b8	2018-05-10 16:14:53.523	8	1	t	ad-hoc	\N	1	\N	\N	\N
15	\\x103f38bcb650c6a03b016541d67f2e48dcb24178b04ed911f5ff968050dc102d	2018-05-10 17:24:32.575	624	0	t	ad-hoc	ERROR: column "event.obs" must appear in the GROUP BY clause or be used in an aggregate function\n  Position: 162	1	\N	\N	\N
16	\\xd7c7c72c7fdb79b993920bce97afc9f850f12d507da7832606333ffc1bf7a60e	2018-05-10 17:25:00.407	19	1	t	ad-hoc	\N	1	\N	\N	\N
17	\\x9c3ae202149b4b75a865cff22b825ef7fb381ff284ce867dde43a5ba8d4b3f73	2018-05-10 17:31:41.307	10	1	t	ad-hoc	\N	1	\N	\N	\N
18	\\x9c3ae202149b4b75a865cff22b825ef7fb381ff284ce867dde43a5ba8d4b3f73	2018-05-10 17:31:43.844	9	1	t	ad-hoc	\N	1	\N	\N	\N
19	\\x9c3ae202149b4b75a865cff22b825ef7fb381ff284ce867dde43a5ba8d4b3f73	2018-05-10 17:32:07.666	7	1	t	ad-hoc	\N	1	\N	\N	\N
20	\\x5b9802e7aabdfc852c5164d7ac171082d57b3bf48da8a1832f8fef3ac99c0c46	2018-05-10 18:18:48.635	31	1	t	ad-hoc	\N	1	\N	\N	\N
21	\\x5b9802e7aabdfc852c5164d7ac171082d57b3bf48da8a1832f8fef3ac99c0c46	2018-05-10 18:19:00.985	31	1	t	question	\N	1	2	\N	\N
22	\\x38da1376297ec92d5f596b1a8c3f0c81441a2a1e0e237ffada5f9ea60867dc50	2018-05-10 18:19:01.005	62	1	t	question	\N	1	1	\N	\N
23	\\x5b9802e7aabdfc852c5164d7ac171082d57b3bf48da8a1832f8fef3ac99c0c46	2018-05-10 18:19:01.232	33	1	t	question	\N	1	2	\N	\N
24	\\x5b9802e7aabdfc852c5164d7ac171082d57b3bf48da8a1832f8fef3ac99c0c46	2018-05-10 18:20:36.235	21	1	t	question	\N	1	2	\N	\N
25	\\x53368572079769e5fc5ee82865b51882a899774fa71a2cbe065e6573289825bf	2018-05-10 18:23:16.577	31	1	t	ad-hoc	\N	1	\N	\N	\N
26	\\xd34714c08a4f1d4212a42ce7c853c540497f8ffbda59355e0783aa1d7dbcf3b6	2018-05-10 18:24:00.11	29	1	t	ad-hoc	\N	1	\N	\N	\N
27	\\x1352bb5c1a9db373c26daed48e5053ddd782e2494e9a0d83b300bbdf0a61a884	2018-05-10 18:24:12.151	25	1	t	ad-hoc	\N	1	\N	\N	\N
28	\\x3d5f4c09759fc5d0bec9690bd61fd57249362cf229c0ee8085764adf87f6c563	2018-05-10 18:24:20.031	28	1	t	ad-hoc	\N	1	\N	\N	\N
29	\\x38da1376297ec92d5f596b1a8c3f0c81441a2a1e0e237ffada5f9ea60867dc50	2018-05-10 18:24:30.817	10	1	t	question	\N	1	1	\N	\N
30	\\x3d5f4c09759fc5d0bec9690bd61fd57249362cf229c0ee8085764adf87f6c563	2018-05-10 18:24:30.824	60	1	t	question	\N	1	2	\N	\N
31	\\x3d5f4c09759fc5d0bec9690bd61fd57249362cf229c0ee8085764adf87f6c563	2018-05-10 18:24:59.817	21	1	t	question	\N	1	2	\N	\N
32	\\x38da1376297ec92d5f596b1a8c3f0c81441a2a1e0e237ffada5f9ea60867dc50	2018-05-10 18:25:06.496	13	1	t	question	\N	1	1	\N	\N
33	\\x3d5f4c09759fc5d0bec9690bd61fd57249362cf229c0ee8085764adf87f6c563	2018-05-10 18:25:06.499	26	1	t	question	\N	1	2	\N	\N
34	\\x3d5f4c09759fc5d0bec9690bd61fd57249362cf229c0ee8085764adf87f6c563	2018-05-10 18:25:49.778	24	1	t	question	\N	1	2	\N	\N
35	\\x38da1376297ec92d5f596b1a8c3f0c81441a2a1e0e237ffada5f9ea60867dc50	2018-05-10 18:26:17.975	8	1	t	question	\N	1	1	\N	\N
36	\\x3d5f4c09759fc5d0bec9690bd61fd57249362cf229c0ee8085764adf87f6c563	2018-05-10 18:26:17.983	28	1	t	question	\N	1	2	\N	\N
37	\\x3d5f4c09759fc5d0bec9690bd61fd57249362cf229c0ee8085764adf87f6c563	2018-05-10 18:26:18.1	25	1	t	question	\N	1	2	\N	\N
38	\\x3d5f4c09759fc5d0bec9690bd61fd57249362cf229c0ee8085764adf87f6c563	2018-05-10 18:26:27.758	26	1	t	question	\N	1	2	\N	\N
39	\\x3c7fbf09be1285e52375b7ad68aaad506025e2b8c74cf8c0c9c03b6271bc4e85	2018-05-10 18:28:15.285	32	1	t	ad-hoc	\N	1	\N	\N	\N
40	\\x2679168d411ad805b9515e0857d60d6370066358c25cca71c2c516c73cad3048	2018-05-10 18:28:30.449	286	0	t	ad-hoc	ERROR: syntax error at or near "FROM"\n  Position: 174	1	\N	\N	\N
41	\\x94aac15a2de1732171ab287b64df839ab9a09c4e2761446918077c384fd80a01	2018-05-10 18:28:41.614	9	1	t	ad-hoc	\N	1	\N	\N	\N
42	\\x38da1376297ec92d5f596b1a8c3f0c81441a2a1e0e237ffada5f9ea60867dc50	2018-05-10 18:31:50.811	7	1	t	question	\N	1	1	\N	\N
43	\\x3d5f4c09759fc5d0bec9690bd61fd57249362cf229c0ee8085764adf87f6c563	2018-05-10 18:31:50.811	46	1	t	question	\N	1	2	\N	\N
44	\\x94aac15a2de1732171ab287b64df839ab9a09c4e2761446918077c384fd80a01	2018-05-10 18:31:50.965	10	1	t	question	\N	1	3	\N	\N
45	\\x3d5f4c09759fc5d0bec9690bd61fd57249362cf229c0ee8085764adf87f6c563	2018-05-10 18:33:01.884	23	1	t	question	\N	1	2	\N	\N
46	\\xfeae41237b0e89c37d04c032c70274ab68179dd26e27d4bb8ceb9e0bc1bf1b3f	2018-05-10 18:34:36.091	24	1	t	ad-hoc	\N	1	\N	\N	\N
47	\\x2b87c165d553f54bc6471cc04b4401f1175fb11fc309278cee2496558394aa04	2018-05-10 18:34:43.361	25	1	t	ad-hoc	\N	1	\N	\N	\N
48	\\x026e7c41b9faf92803ff46f732bbadaa12b2e4667c40e5d6064ee95cb298f687	2018-05-10 18:34:49.46	24	1	t	ad-hoc	\N	1	\N	\N	\N
49	\\x38da1376297ec92d5f596b1a8c3f0c81441a2a1e0e237ffada5f9ea60867dc50	2018-05-10 18:35:03.56	7	1	t	question	\N	1	1	\N	\N
50	\\x94aac15a2de1732171ab287b64df839ab9a09c4e2761446918077c384fd80a01	2018-05-10 18:35:03.572	6	1	t	question	\N	1	3	\N	\N
51	\\x026e7c41b9faf92803ff46f732bbadaa12b2e4667c40e5d6064ee95cb298f687	2018-05-10 18:35:03.564	27	1	t	question	\N	1	2	\N	\N
52	\\x026e7c41b9faf92803ff46f732bbadaa12b2e4667c40e5d6064ee95cb298f687	2018-05-10 18:35:03.701	22	1	t	question	\N	1	2	\N	\N
53	\\x38da1376297ec92d5f596b1a8c3f0c81441a2a1e0e237ffada5f9ea60867dc50	2018-05-10 18:36:33.893	5	1	t	question	\N	1	1	\N	\N
54	\\x5b9802e7aabdfc852c5164d7ac171082d57b3bf48da8a1832f8fef3ac99c0c46	2018-05-10 18:44:50.163	24	1	t	ad-hoc	\N	1	\N	\N	\N
55	\\x5b9802e7aabdfc852c5164d7ac171082d57b3bf48da8a1832f8fef3ac99c0c46	2018-05-11 09:34:35.47	55	1	t	ad-hoc	\N	1	\N	\N	\N
56	\\x6a0e0cf3726ab8907759fd354fa2abe9ecca120bbc2d1b0913d628360ee627b7	2018-05-11 10:49:33.267	315	0	t	ad-hoc	ERROR: syntax error at or near "month"\n  Position: 146	1	\N	\N	\N
57	\\xd22d1b931f78335a4476f94158ed8ce579dfab27c723716b2b4edcff535e58c1	2018-05-11 10:49:48.952	186	0	t	ad-hoc	ERROR: function month(timestamp without time zone) does not exist\n  Hint: No function matches the given name and argument types. You might need to add explicit type casts.\n  Position: 127	1	\N	\N	\N
58	\\x27e288d9ed41ce655b7b6df9f9bb875e771d98f863deecd1b2542885aba2e4be	2018-05-11 15:42:48.728	388	0	t	ad-hoc	ERROR: syntax error at or near "e"\n  Position: 156	1	\N	\N	\N
59	\\x9bff52c7c1ef10501fb8d395309468dd15292786edce3557f0547a44f3db605f	2018-05-11 15:43:45.988	334	0	t	ad-hoc	ERROR: syntax error at or near "e"\n  Position: 156	1	\N	\N	\N
60	\\xc1ce618898628643645280c58fdfeefc42c7e956c00b07311f3424002229371e	2018-05-11 15:44:51.328	160	0	t	ad-hoc	ERROR: column "e.eventdate" must appear in the GROUP BY clause or be used in an aggregate function\n  Position: 126	1	\N	\N	\N
61	\\xf98177a9fb71fab785e29aaf3f0fe7a7131961672b511de80a151d54a6289edb	2018-05-11 15:45:05.329	56	4800	t	ad-hoc	\N	1	\N	\N	\N
62	\\x0fb6e7ad71f2b0aa0c4751b7b2b596636baf40711060916b532e64d20c94d7fe	2018-05-11 15:47:04.171	168	0	t	ad-hoc	ERROR: syntax error at or near "month"\n  Position: 160	1	\N	\N	\N
63	\\xfc3c845e3cb40b2d749e06eb54fc8b87a6126eb91a8d42985dd533f356c453cc	2018-05-11 15:47:22.752	210	0	t	ad-hoc	ERROR: syntax error at or near "month"\n  Position: 160	1	\N	\N	\N
64	\\x69f700c316037dc2790535556173520f4c90f6a3f1431e1ff08e91188c950c39	2018-05-11 15:47:36.649	150	0	t	ad-hoc	ERROR: syntax error at or near "month"\n  Position: 165	1	\N	\N	\N
65	\\x3e6b30fcc693fe679c5e4fc735c5daba4c640c2720b78fe0b94c1c2ef53c684c	2018-05-11 15:47:45.963	164	0	t	ad-hoc	ERROR: aggregate functions are not allowed in GROUP BY\n  Position: 128	1	\N	\N	\N
66	\\x74a8ca4653974e67855e6aa074384e73662a111ae88f70e0f07d5d26966eac75	2018-05-11 15:47:57.263	29	12	t	ad-hoc	\N	1	\N	\N	\N
67	\\x03a34660b3e9424523725f8d8aa70c9f0ba046e64f0d384488aa6a8b69015771	2018-05-11 15:48:35.988	161	0	t	ad-hoc	ERROR: type "date_part" does not exist\n  Position: 128	1	\N	\N	\N
68	\\x03a34660b3e9424523725f8d8aa70c9f0ba046e64f0d384488aa6a8b69015771	2018-05-11 15:48:40.337	169	0	t	ad-hoc	ERROR: type "date_part" does not exist\n  Position: 128	1	\N	\N	\N
78	\\x2b1278942a0e8d4150fadc4d904522f0ce5edf4690115ec54b10bdcf1c7c803a	2018-05-11 16:15:49.758	21	15	t	question	\N	1	4	\N	\N
79	\\x2b1278942a0e8d4150fadc4d904522f0ce5edf4690115ec54b10bdcf1c7c803a	2018-05-11 16:18:01.535	27	15	t	question	\N	1	4	\N	\N
80	\\x0b8e131e308a16abfaf257f041cffef2c7259fdfaa34baf3dbc9645273eed1b6	2018-05-11 16:20:30.96	169	0	t	ad-hoc	ERROR: syntax error at or near "'Month'"\n  Position: 144	1	\N	\N	\N
81	\\x4a75167640637e7c4773d3a6d5110f5692e465241c7502d617cf262c5a117a74	2018-05-11 16:20:40.538	171	0	t	ad-hoc	ERROR: syntax error at or near "'Year'"\n  Position: 167	1	\N	\N	\N
83	\\x2779224ba015ca94f4d0c4e2d049b4d72b32fe95c027e4c7f4214353f361b49c	2018-05-11 16:21:42.787	176	0	t	ad-hoc	ERROR: schema "tin" does not exist\n  Position: 126	1	\N	\N	\N
69	\\x7cbf702e527b9bd21c0772c30ffa395556a1c907fda7abdc8546cc80ccf7e4cd	2018-05-11 15:50:17.915	25	12	t	ad-hoc	\N	1	\N	\N	\N
70	\\x7cbf702e527b9bd21c0772c30ffa395556a1c907fda7abdc8546cc80ccf7e4cd	2018-05-11 15:50:44.733	19	12	t	ad-hoc	\N	1	\N	\N	\N
71	\\x7db2942aeb628397e51c18023ab18de79d767c8a061b0587fa9daee42beecbb8	2018-05-11 16:08:25.534	25	15	t	ad-hoc	\N	1	\N	\N	\N
76	\\x94aac15a2de1732171ab287b64df839ab9a09c4e2761446918077c384fd80a01	2018-05-11 16:15:49.612	6	1	t	question	\N	1	3	\N	\N
77	\\x026e7c41b9faf92803ff46f732bbadaa12b2e4667c40e5d6064ee95cb298f687	2018-05-11 16:15:49.618	26	1	t	question	\N	1	2	\N	\N
72	\\x349760d01e6d78708796b74435698ef8da58d5fee3d5cce30ee37eced24892ee	2018-05-11 16:10:10.605	172	0	t	ad-hoc	ERROR: syntax error at or near "SUM"\n  Position: 434	1	\N	\N	\N
73	\\x3fbc92380ce7a4e70328c53b14ee7e8aee5400192c6dbfde8f2e4a50f7ed01a3	2018-05-11 16:10:16.066	29	15	t	ad-hoc	\N	1	\N	\N	\N
75	\\x38da1376297ec92d5f596b1a8c3f0c81441a2a1e0e237ffada5f9ea60867dc50	2018-05-11 16:15:49.608	6	1	t	question	\N	1	1	\N	\N
74	\\x2b1278942a0e8d4150fadc4d904522f0ce5edf4690115ec54b10bdcf1c7c803a	2018-05-11 16:11:05.302	28	15	t	ad-hoc	\N	1	\N	\N	\N
82	\\xf50d4217ddf32ec899cd9a230f98c41480aba86997ba3298593ddb58c0e0e24b	2018-05-11 16:21:02.03	170	0	t	ad-hoc	ERROR: type "screeningmonth" does not exist\n  Position: 126	1	\N	\N	\N
84	\\xd77aa3a5b754bdb259b7dc5a3638328d2a47c131846d2bcfd6210163cc380254	2018-05-11 16:21:49.011	183	0	t	ad-hoc	ERROR: schema "tin" does not exist\n  Position: 126	1	\N	\N	\N
85	\\xd77aa3a5b754bdb259b7dc5a3638328d2a47c131846d2bcfd6210163cc380254	2018-05-11 16:47:12.314	172	0	t	ad-hoc	ERROR: schema "tin" does not exist\n  Position: 126	1	\N	\N	\N
86	\\xd77aa3a5b754bdb259b7dc5a3638328d2a47c131846d2bcfd6210163cc380254	2018-05-11 17:16:23.997	180	0	t	ad-hoc	ERROR: schema "tin" does not exist\n  Position: 126	1	\N	\N	\N
87	\\x60930c9a0d610fc15a2453f21ed61e3e67ac45beb66f3e300187848666e8a73e	2018-05-11 17:16:34.106	53	15	t	ad-hoc	\N	1	\N	\N	\N
88	\\x8c2796adb6934e57515e2977fdc3b5a56331b1853e21e57537f8a538d973199d	2018-05-11 17:17:11.455	41	15	t	question	\N	1	4	\N	\N
89	\\xd6c03f7939cd07addb4b60bb94a5765ae27d8aca2f6007b00806782f9508207a	2018-05-11 17:20:25.206	33	15	t	ad-hoc	\N	1	\N	\N	\N
90	\\xc07f3f69812016baee2a0b982bc1f3661c56677dce69b38a7100386aed5fef1c	2018-05-11 17:20:35.998	27	15	t	ad-hoc	\N	1	\N	\N	\N
91	\\xba07a7b0c2c067cf2a7d7437b9d47de73d5e5cf125d7a45a13ffb8178a88148e	2018-05-11 17:20:43.69	25	15	t	ad-hoc	\N	1	\N	\N	\N
92	\\x38da1376297ec92d5f596b1a8c3f0c81441a2a1e0e237ffada5f9ea60867dc50	2018-05-11 17:20:53.802	8	1	t	question	\N	1	1	\N	\N
93	\\x94aac15a2de1732171ab287b64df839ab9a09c4e2761446918077c384fd80a01	2018-05-11 17:20:53.811	18	1	t	question	\N	1	3	\N	\N
94	\\x026e7c41b9faf92803ff46f732bbadaa12b2e4667c40e5d6064ee95cb298f687	2018-05-11 17:20:53.814	29	1	t	question	\N	1	2	\N	\N
95	\\x94aac15a2de1732171ab287b64df839ab9a09c4e2761446918077c384fd80a01	2018-05-11 17:20:59.837	6	1	t	question	\N	1	3	\N	\N
96	\\x38da1376297ec92d5f596b1a8c3f0c81441a2a1e0e237ffada5f9ea60867dc50	2018-05-11 17:21:23.977	5	1	t	question	\N	1	1	\N	\N
97	\\x94aac15a2de1732171ab287b64df839ab9a09c4e2761446918077c384fd80a01	2018-05-11 17:21:23.983	35	1	t	question	\N	1	3	\N	\N
98	\\x026e7c41b9faf92803ff46f732bbadaa12b2e4667c40e5d6064ee95cb298f687	2018-05-11 17:21:24.011	66	1	t	question	\N	1	2	\N	\N
99	\\xba07a7b0c2c067cf2a7d7437b9d47de73d5e5cf125d7a45a13ffb8178a88148e	2018-05-11 17:21:31.41	31	15	t	question	\N	1	4	\N	\N
100	\\xba07a7b0c2c067cf2a7d7437b9d47de73d5e5cf125d7a45a13ffb8178a88148e	2018-05-11 17:22:42.78	20	15	t	question	\N	1	4	\N	\N
101	\\xe99f2f0a0b9ba63dd59a556aef33ae200bc7aadaa168709a433081520c91d7d2	2018-05-11 17:26:52.322	178	0	t	ad-hoc	ERROR: column "e.eventdate" must appear in the GROUP BY clause or be used in an aggregate function\n  Position: 144	1	\N	\N	\N
102	\\x1ba2e4498d6ddd2b42aa5701f8b1d0cf71d191e2bd23206b384c17ea9e30728d	2018-05-11 17:27:27.445	37	2	t	ad-hoc	\N	1	\N	\N	\N
103	\\x8338a066d5fcb3024c0f8dc7507ab731e68989d46566fb63071b0485d7f302c8	2018-05-11 17:27:44.854	32	19	t	ad-hoc	\N	1	\N	\N	\N
104	\\x6ca638d801a339c965f60d8f33875099d0e69c50dae50ccf3c125b253823ecbf	2018-05-11 17:27:52.727	31	19	t	ad-hoc	\N	1	\N	\N	\N
105	\\xa105a2e51a83351044c0ec02a9a179513f0ceff38d499d16f2a1f92d5b42851e	2018-05-11 17:28:00.136	31	15	t	ad-hoc	\N	1	\N	\N	\N
106	\\x71a7edb69d00442dbcbd8d7dc88a8e9fe4b8dfc3474c0d30f5a4ed54fab9f503	2018-05-11 17:28:23.752	30	15	t	ad-hoc	\N	1	\N	\N	\N
107	\\x61b224a4391817e421402129aeaeac1eb9d507437031a7b9d90cecdfcfd3e42b	2018-05-11 17:28:33.362	31	15	t	ad-hoc	\N	1	\N	\N	\N
108	\\xa105a2e51a83351044c0ec02a9a179513f0ceff38d499d16f2a1f92d5b42851e	2018-05-11 17:31:44.843	33	15	t	ad-hoc	\N	1	\N	\N	\N
109	\\x79e1cf4f31ec1a21a4608ab1908f3ba57b61a3200e720abbb9a490ace430533c	2018-05-11 17:32:29.756	166	0	t	ad-hoc	ERROR: column "e.eventdate" must appear in the GROUP BY clause or be used in an aggregate function\n  Position: 201	1	\N	\N	\N
110	\\xd9fe0a5345765d74f11aea4dda41bc86661dae83f7bcdf14df5a3ea8617d65be	2018-05-11 17:32:46.232	38	15	t	ad-hoc	\N	1	\N	\N	\N
111	\\x27c77fd3c2412b9e60a5ab11102282ed1acf7b102c153ef7d39604c6aaf8af49	2018-05-11 17:33:21.916	38	15	t	ad-hoc	\N	1	\N	\N	\N
112	\\x38da1376297ec92d5f596b1a8c3f0c81441a2a1e0e237ffada5f9ea60867dc50	2018-05-11 17:33:45.282	16	1	t	question	\N	1	1	\N	\N
113	\\x94aac15a2de1732171ab287b64df839ab9a09c4e2761446918077c384fd80a01	2018-05-11 17:33:45.282	18	1	t	question	\N	1	3	\N	\N
114	\\x026e7c41b9faf92803ff46f732bbadaa12b2e4667c40e5d6064ee95cb298f687	2018-05-11 17:33:45.283	28	1	t	question	\N	1	2	\N	\N
115	\\x4370cf36abec25622c706a313bbd6dc341b318c9e22b0ce7779b070dc0ed0831	2018-05-11 17:33:45.31	33	15	t	question	\N	1	4	\N	\N
116	\\x94aac15a2de1732171ab287b64df839ab9a09c4e2761446918077c384fd80a01	2018-05-11 17:36:04.237	7	1	t	question	\N	1	3	\N	\N
117	\\x4370cf36abec25622c706a313bbd6dc341b318c9e22b0ce7779b070dc0ed0831	2018-05-11 17:36:14.296	33	15	t	question	\N	1	4	\N	\N
118	\\x4370cf36abec25622c706a313bbd6dc341b318c9e22b0ce7779b070dc0ed0831	2018-05-11 17:37:42.631	29	15	t	question	\N	1	4	\N	\N
119	\\xe3aaebba69d2c390903cc5596f67dc7aac163388eec4a3ab168c37fa85cea721	2018-05-11 17:38:15.975	65	15	f	ad-hoc	\N	1	4	\N	\N
120	\\x94aac15a2de1732171ab287b64df839ab9a09c4e2761446918077c384fd80a01	2018-05-11 17:43:06.984	15	1	t	question	\N	1	3	\N	\N
121	\\x38da1376297ec92d5f596b1a8c3f0c81441a2a1e0e237ffada5f9ea60867dc50	2018-05-11 17:43:07.002	18	1	t	question	\N	1	1	\N	\N
122	\\x4370cf36abec25622c706a313bbd6dc341b318c9e22b0ce7779b070dc0ed0831	2018-05-11 17:43:06.981	40	15	t	question	\N	1	4	\N	\N
123	\\x026e7c41b9faf92803ff46f732bbadaa12b2e4667c40e5d6064ee95cb298f687	2018-05-11 17:43:07.003	28	1	t	question	\N	1	2	\N	\N
124	\\xe3aaebba69d2c390903cc5596f67dc7aac163388eec4a3ab168c37fa85cea721	2018-05-11 17:43:07.191	43	15	f	question	\N	1	5	\N	\N
125	\\x4370cf36abec25622c706a313bbd6dc341b318c9e22b0ce7779b070dc0ed0831	2018-05-11 17:43:16.439	29	15	t	question	\N	1	4	\N	\N
126	\\x38da1376297ec92d5f596b1a8c3f0c81441a2a1e0e237ffada5f9ea60867dc50	2018-05-11 17:43:40.435	26	1	t	question	\N	1	1	\N	\N
127	\\x94aac15a2de1732171ab287b64df839ab9a09c4e2761446918077c384fd80a01	2018-05-11 17:43:40.442	20	1	t	question	\N	1	3	\N	\N
128	\\x026e7c41b9faf92803ff46f732bbadaa12b2e4667c40e5d6064ee95cb298f687	2018-05-11 17:43:40.449	34	1	t	question	\N	1	2	\N	\N
129	\\x853e6e4dc9986952f2986b24dadf3a065f75c9edff70f7fdd280aad27c021979	2018-05-11 17:43:40.451	38	12	t	question	\N	1	4	\N	\N
130	\\xe3aaebba69d2c390903cc5596f67dc7aac163388eec4a3ab168c37fa85cea721	2018-05-11 17:43:56.425	52	12	f	question	\N	1	5	\N	\N
131	\\xe3aaebba69d2c390903cc5596f67dc7aac163388eec4a3ab168c37fa85cea721	2018-05-11 17:46:59.372	47	12	f	question	\N	1	5	\N	\N
132	\\x94aac15a2de1732171ab287b64df839ab9a09c4e2761446918077c384fd80a01	2018-05-11 17:49:26.275	11	1	t	question	\N	1	3	\N	\N
133	\\x38da1376297ec92d5f596b1a8c3f0c81441a2a1e0e237ffada5f9ea60867dc50	2018-05-11 17:49:26.272	24	1	t	question	\N	1	1	\N	\N
134	\\x026e7c41b9faf92803ff46f732bbadaa12b2e4667c40e5d6064ee95cb298f687	2018-05-11 17:49:26.288	31	1	t	question	\N	1	2	\N	\N
135	\\x853e6e4dc9986952f2986b24dadf3a065f75c9edff70f7fdd280aad27c021979	2018-05-11 17:49:26.316	39	12	t	question	\N	1	4	\N	\N
136	\\xe3aaebba69d2c390903cc5596f67dc7aac163388eec4a3ab168c37fa85cea721	2018-05-11 17:49:26.285	77	12	f	question	\N	1	5	\N	\N
139	\\x026e7c41b9faf92803ff46f732bbadaa12b2e4667c40e5d6064ee95cb298f687	2018-05-11 20:30:02.425	419	1	t	question	\N	1	2	\N	\N
138	\\x94aac15a2de1732171ab287b64df839ab9a09c4e2761446918077c384fd80a01	2018-05-11 20:30:02.512	314	1	t	question	\N	1	3	\N	\N
140	\\xe3aaebba69d2c390903cc5596f67dc7aac163388eec4a3ab168c37fa85cea721	2018-05-11 20:30:02.521	355	12	f	question	\N	1	5	\N	\N
141	\\x853e6e4dc9986952f2986b24dadf3a065f75c9edff70f7fdd280aad27c021979	2018-05-11 20:30:02.418	438	12	t	question	\N	1	4	\N	\N
137	\\x38da1376297ec92d5f596b1a8c3f0c81441a2a1e0e237ffada5f9ea60867dc50	2018-05-11 20:30:02.333	445	1	t	question	\N	1	1	\N	\N
142	\\x853e6e4dc9986952f2986b24dadf3a065f75c9edff70f7fdd280aad27c021979	2018-05-11 20:32:04.553	37	12	t	question	\N	1	4	\N	\N
143	\\x853e6e4dc9986952f2986b24dadf3a065f75c9edff70f7fdd280aad27c021979	2018-05-11 20:32:37.538	43	12	t	question	\N	1	4	\N	\N
144	\\xe3aaebba69d2c390903cc5596f67dc7aac163388eec4a3ab168c37fa85cea721	2018-05-11 20:32:45.86	77	12	f	question	\N	1	5	\N	\N
145	\\xd4fd9f0c2902c805eb1c948e90cafe89b7447fd05f0a1bcff774832d5573c8de	2018-05-11 20:34:05.615	110	0	f	ad-hoc	\N	1	4	\N	\N
146	\\xe3aaebba69d2c390903cc5596f67dc7aac163388eec4a3ab168c37fa85cea721	2018-05-11 20:34:12.649	81	12	f	ad-hoc	\N	1	4	\N	\N
147	\\xe3aaebba69d2c390903cc5596f67dc7aac163388eec4a3ab168c37fa85cea721	2018-05-11 20:34:52.823	65	12	f	question	\N	1	5	\N	\N
148	\\x38da1376297ec92d5f596b1a8c3f0c81441a2a1e0e237ffada5f9ea60867dc50	2018-05-11 20:36:50.815	82	1	t	question	\N	1	1	\N	\N
149	\\x853e6e4dc9986952f2986b24dadf3a065f75c9edff70f7fdd280aad27c021979	2018-05-11 20:36:50.893	77	12	t	question	\N	1	4	\N	\N
150	\\xe3aaebba69d2c390903cc5596f67dc7aac163388eec4a3ab168c37fa85cea721	2018-05-11 20:36:50.857	114	12	f	question	\N	1	5	\N	\N
152	\\x026e7c41b9faf92803ff46f732bbadaa12b2e4667c40e5d6064ee95cb298f687	2018-05-11 20:36:50.865	33	1	t	question	\N	1	2	\N	\N
151	\\x94aac15a2de1732171ab287b64df839ab9a09c4e2761446918077c384fd80a01	2018-05-11 20:36:50.836	61	1	t	question	\N	1	3	\N	\N
155	\\x853e6e4dc9986952f2986b24dadf3a065f75c9edff70f7fdd280aad27c021979	2018-05-11 20:38:53.291	51	12	t	question	\N	1	4	\N	\N
153	\\x94aac15a2de1732171ab287b64df839ab9a09c4e2761446918077c384fd80a01	2018-05-11 20:38:53.286	16	1	t	question	\N	1	3	\N	\N
156	\\x38da1376297ec92d5f596b1a8c3f0c81441a2a1e0e237ffada5f9ea60867dc50	2018-05-11 20:38:53.319	29	1	t	question	\N	1	1	\N	\N
154	\\x026e7c41b9faf92803ff46f732bbadaa12b2e4667c40e5d6064ee95cb298f687	2018-05-11 20:38:53.28	30	1	t	question	\N	1	2	\N	\N
157	\\xe3aaebba69d2c390903cc5596f67dc7aac163388eec4a3ab168c37fa85cea721	2018-05-11 20:38:53.317	81	12	f	question	\N	1	5	\N	\N
158	\\x026e7c41b9faf92803ff46f732bbadaa12b2e4667c40e5d6064ee95cb298f687	2018-05-12 02:35:01.927	367	1	t	question	\N	1	2	\N	\N
159	\\x38da1376297ec92d5f596b1a8c3f0c81441a2a1e0e237ffada5f9ea60867dc50	2018-05-12 02:35:01.745	643	1	t	question	\N	1	1	\N	\N
160	\\x853e6e4dc9986952f2986b24dadf3a065f75c9edff70f7fdd280aad27c021979	2018-05-12 02:35:01.75	637	12	t	question	\N	1	4	\N	\N
161	\\x94aac15a2de1732171ab287b64df839ab9a09c4e2761446918077c384fd80a01	2018-05-12 02:35:01.805	641	1	t	question	\N	1	3	\N	\N
162	\\xe3aaebba69d2c390903cc5596f67dc7aac163388eec4a3ab168c37fa85cea721	2018-05-12 02:35:02.034	427	12	f	question	\N	1	5	\N	\N
163	\\x94aac15a2de1732171ab287b64df839ab9a09c4e2761446918077c384fd80a01	2018-05-12 09:22:04.702	411	1	t	question	\N	1	3	\N	\N
164	\\x38da1376297ec92d5f596b1a8c3f0c81441a2a1e0e237ffada5f9ea60867dc50	2018-05-12 09:22:04.763	457	1	t	question	\N	1	1	\N	\N
165	\\x026e7c41b9faf92803ff46f732bbadaa12b2e4667c40e5d6064ee95cb298f687	2018-05-12 09:22:04.782	526	1	t	question	\N	1	2	\N	\N
166	\\xe3aaebba69d2c390903cc5596f67dc7aac163388eec4a3ab168c37fa85cea721	2018-05-12 09:22:04.823	804	12	f	question	\N	1	5	\N	\N
167	\\x853e6e4dc9986952f2986b24dadf3a065f75c9edff70f7fdd280aad27c021979	2018-05-12 09:22:04.81	825	12	t	question	\N	1	4	\N	\N
168	\\x853e6e4dc9986952f2986b24dadf3a065f75c9edff70f7fdd280aad27c021979	2018-05-12 09:24:22.57	263	12	t	question	\N	1	4	\N	\N
169	\\x58e8974cefcba6d23524f4cf84179abf56c0c6cab68acdbf2708eee57e0fa5c6	2018-05-12 09:32:13.275	329	210	t	ad-hoc	\N	1	\N	\N	\N
170	\\xaa5969abda2dba231eebd8116cfa1a363cd9856e63d7d41566a3e66bc7a034cc	2018-05-12 09:32:42.52	44	48	t	ad-hoc	\N	1	\N	\N	\N
171	\\x640285d6a3097377e75e3125ead1b591738757fcce144618da400fe0dc5b0025	2018-05-12 09:39:31.039	49	48	t	ad-hoc	\N	1	\N	\N	\N
172	\\x530d5dd0bbc96b26f97d58a169b522b4dfd75c12d079ecebc341f713227867a7	2018-05-12 09:40:12.495	43	48	t	ad-hoc	\N	1	\N	\N	\N
173	\\x9b9dbce0a3828abcb3ea0fc83d8c3131d0f074f273cc099a1e3b2d519916d2e5	2018-05-12 09:42:58.198	46	48	t	ad-hoc	\N	1	\N	\N	\N
174	\\x5386d26cdba27f26b9bc550ba820e0100c8d99c01a3f603ff143e6d82628e69a	2018-05-12 09:43:50.027	449	0	t	ad-hoc	ERROR: function max(jsonb) does not exist\n  Hint: No function matches the given name and argument types. You might need to add explicit type casts.\n  Position: 253	1	\N	\N	\N
175	\\x9b9dbce0a3828abcb3ea0fc83d8c3131d0f074f273cc099a1e3b2d519916d2e5	2018-05-12 09:43:54.277	57	48	t	ad-hoc	\N	1	\N	\N	\N
176	\\xf6c77a9342f4691477c7f5d514a4cd760a7b19eb917156de634e07a2fc7650c0	2018-05-12 09:45:30.069	389	0	t	ad-hoc	ERROR: malformed array literal: "humanReadableValues"\n  Detail: Array value must start with "{" or dimension information.\n  Position: 323	1	\N	\N	\N
177	\\x640285d6a3097377e75e3125ead1b591738757fcce144618da400fe0dc5b0025	2018-05-12 09:45:46.478	51	48	t	ad-hoc	\N	1	\N	\N	\N
178	\\xf70a745313efcf56ce321b5fd3151282608199d65030a810ba827854fae89783	2018-05-12 09:46:20.096	311	0	t	ad-hoc	ERROR: malformed array literal: "humanReadableValues"\n  Detail: Array value must start with "{" or dimension information.\n  Position: 323	1	\N	\N	\N
179	\\x169bbf0fe3b5b222623b51b18d4c4636d223d62a33c37152254a6b93ee73b55c	2018-05-12 09:46:26.047	220	0	t	ad-hoc	ERROR: malformed array literal: "humanReadableValues"\n  Detail: Array value must start with "{" or dimension information.\n  Position: 323	1	\N	\N	\N
180	\\x1030637b0c9b28d6f3fb9113dce98354595d4a8f2a135cba0f4b5294a4c0a890	2018-05-12 09:46:35.72	233	0	t	ad-hoc	ERROR: malformed array literal: "humanReadableValues"\n  Detail: Array value must start with "{" or dimension information.\n  Position: 323	1	\N	\N	\N
181	\\x893b140310649376a75aaceed2221a99b981cf290e1177aedd8c7ab05957cc41	2018-05-12 09:46:45.638	220	0	t	ad-hoc	ERROR: operator does not exist: text -> integer\n  Hint: No operator matches the given name and argument type(s). You might need to add explicit type casts.\n  Position: 345	1	\N	\N	\N
182	\\x8cabea0c035fd65894813377b5ab7abb3509af4eb5c8202c64c5f962478ab096	2018-05-12 09:48:21.715	248	0	t	ad-hoc	ERROR: malformed array literal: "humanReadableValues"\n  Detail: Array value must start with "{" or dimension information.\n  Position: 322	1	\N	\N	\N
183	\\xf6c77a9342f4691477c7f5d514a4cd760a7b19eb917156de634e07a2fc7650c0	2018-05-12 09:48:59.554	219	0	t	ad-hoc	ERROR: malformed array literal: "humanReadableValues"\n  Detail: Array value must start with "{" or dimension information.\n  Position: 323	1	\N	\N	\N
184	\\xa185685494fb0b0db2d17ffbecc970c7cdd0be709a8681cc218d0afd6027ef9d	2018-05-12 09:49:27.308	218	0	t	ad-hoc	ERROR: function max(jsonb) does not exist\n  Hint: No function matches the given name and argument types. You might need to add explicit type casts.\n  Position: 252	1	\N	\N	\N
185	\\xcc8e152254f009b94147aa665741c7c388a13bc0e7813f98085084f88a5f3067	2018-05-12 09:49:51.834	188	0	t	ad-hoc	ERROR: syntax error at or near "GROUP"\n  Position: 252	1	\N	\N	\N
186	\\x2766c88c42b2f536b65564bbe4f81a3612918671bcf479501793a3ea119d53da	2018-05-12 09:50:01.031	674	0	t	ad-hoc	ERROR: operator does not exist: text -> integer\n  Hint: No operator matches the given name and argument type(s). You might need to add explicit type casts.\n  Position: 356	1	\N	\N	\N
187	\\xc1402a6327738a9efb05a14da9f6e0eb7a78e1ea4863471934f3a7975f7265b4	2018-05-12 09:50:11.909	210	0	t	ad-hoc	ERROR: column "o.value" must appear in the GROUP BY clause or be used in an aggregate function\n  Position: 252	1	\N	\N	\N
188	\\xefc93672e4f896a1bf5c2abb3dffe3f41c43672f92e0f338a6ad0623e829125c	2018-05-12 09:50:20.8	113	1023	t	ad-hoc	\N	1	\N	\N	\N
189	\\x88bb4d3915aa30d98b6aa14d05efb92a152ee88d84d22e9025922ba126436305	2018-05-12 09:51:07.488	232	0	t	ad-hoc	ERROR: operator does not exist: text -> integer\n  Hint: No operator matches the given name and argument type(s). You might need to add explicit type casts.\n  Position: 356	1	\N	\N	\N
190	\\x651b1d729dae19b10a2d5b3081338c18717af67a973cc71e7fbcdb087993c095	2018-05-12 09:51:14.189	217	0	t	ad-hoc	ERROR: operator does not exist: text ->>\n  Hint: No operator matches the given name and argument type(s). You might need to add explicit type casts.\n  Position: 356	1	\N	\N	\N
191	\\xefc93672e4f896a1bf5c2abb3dffe3f41c43672f92e0f338a6ad0623e829125c	2018-05-12 09:51:54.165	102	1023	t	ad-hoc	\N	1	\N	\N	\N
192	\\x61c4d93817b39e501bdab36845fad7a42db9309783a5d751af7270e08ba8d83a	2018-05-12 09:52:02.548	228	0	t	ad-hoc	ERROR: column "oo" does not exist\n  Position: 903	1	\N	\N	\N
193	\\x2e8740586b3bcb41f7e172109e6af68d6f6a96e9a5af90a9bacfec40b9bc1bd7	2018-05-12 09:52:09.188	56	48	t	ad-hoc	\N	1	\N	\N	\N
194	\\xf41079c3fe29629465b4baf7e60fa87cb96394a46b8b1634b8f50c3bd7db18b8	2018-05-12 09:52:22.263	44	48	t	ad-hoc	\N	1	\N	\N	\N
195	\\x35c347c183a740c22228c135075abdaffee4bd5683592f0abf9ef78b4553a58a	2018-05-12 09:52:33.244	41	48	t	ad-hoc	\N	1	\N	\N	\N
196	\\x35c347c183a740c22228c135075abdaffee4bd5683592f0abf9ef78b4553a58a	2018-05-12 10:02:33.693	35	20	t	ad-hoc	\N	1	\N	\N	\N
197	\\x35c347c183a740c22228c135075abdaffee4bd5683592f0abf9ef78b4553a58a	2018-05-12 10:07:12.108	33	14	t	ad-hoc	\N	1	\N	\N	\N
198	\\xeb894eaf1196ebad6e94d103e96b37bfffbcdc866c7be808a3c70e83b8cd94c1	2018-05-12 10:08:12.719	239	0	t	ad-hoc	ERROR: column "screening_month_fmt" does not exist\n  Position: 904	1	\N	\N	\N
199	\\x73b4680be1becafe399ca396957b30b31d71c8e3fd1f97d1814c92953549b9da	2018-05-12 10:08:22.774	43	14	t	ad-hoc	\N	1	\N	\N	\N
200	\\x4ae76f93d695ef43774c688e69d2b9fb30978ac8a6d43420b2843359e52cfceb	2018-05-12 10:09:33.328	231	0	t	ad-hoc	ERROR: aggregate functions are not allowed in GROUP BY\n  Position: 180	1	\N	\N	\N
201	\\x8e69efb574f545b1df57342ed497015a6d061e120d4ade9543fb43476f61d8dd	2018-05-12 10:09:44.674	50	14	t	ad-hoc	\N	1	\N	\N	\N
202	\\x1053f70cf7652378c8ca012af57e7b337c5902c3971f24e32e0549e5bd84d366	2018-05-12 10:11:01.844	226	0	t	ad-hoc	ERROR: aggregate functions are not allowed in GROUP BY\n  Position: 249	1	\N	\N	\N
203	\\x0c971541808c2059d82050872449fa654e4d06717b4db8801590244095e19122	2018-05-12 10:11:22.854	67	59	t	ad-hoc	\N	1	\N	\N	\N
204	\\xdb7a424767893c7a4d8260a61da6a2e5499fa158b49cd69b299107a274ec5a02	2018-05-12 10:12:21.455	231	0	t	ad-hoc	ERROR: invalid input syntax for type json\n  Detail: Token "other" is invalid.\n  Where: JSON data, line 1: other	1	\N	\N	\N
205	\\x0c971541808c2059d82050872449fa654e4d06717b4db8801590244095e19122	2018-05-12 10:12:42.314	52	59	t	ad-hoc	\N	1	\N	\N	\N
206	\\x0c971541808c2059d82050872449fa654e4d06717b4db8801590244095e19122	2018-05-12 10:12:55.789	50	59	t	ad-hoc	\N	1	\N	\N	\N
207	\\x08ca3dc773041d78d64d6d1056c532e0b524ac4c61ca80b4912499d20156db9f	2018-05-12 10:18:07.923	212	0	t	ad-hoc	ERROR: column "o.value" must appear in the GROUP BY clause or be used in an aggregate function\n  Position: 234	1	\N	\N	\N
212	\\x041f58a8ae7e63b7c4657f152be1a46027f0f21b6822d0a3e2e7896a415d7190	2018-05-12 10:20:13.354	243	0	t	ad-hoc	ERROR: column "formsubmissionfield" does not exist\n  Hint: Perhaps you meant to reference the column "e.formsubmissionid".\n  Position: 915	1	\N	\N	\N
213	\\xc666f5bb7860fb6c740994d2f061ea0b029c2e17ee219ca904617e7091d94f46	2018-05-12 10:20:20.732	34	45	t	ad-hoc	\N	1	\N	\N	\N
208	\\xc8cbfa8c365920e3080ef5c94929f4fd360828b5db4920147f2162e71a454671	2018-05-12 10:18:45.6	222	0	t	ad-hoc	ERROR: column "o.value" must appear in the GROUP BY clause or be used in an aggregate function\n  Position: 350	1	\N	\N	\N
245	\\xe3aaebba69d2c390903cc5596f67dc7aac163388eec4a3ab168c37fa85cea721	2018-05-12 10:32:57.26	377	12	f	question	\N	1	5	\N	\N
246	\\x853e6e4dc9986952f2986b24dadf3a065f75c9edff70f7fdd280aad27c021979	2018-05-12 10:32:57.272	371	12	t	question	\N	1	4	\N	\N
209	\\xcd35a910a8087c45c67d71f49c9f5b94292df85fe37374511015a99fbc44d2c4	2018-05-12 10:19:03.471	69	311	t	ad-hoc	\N	1	\N	\N	\N
210	\\xf5e8506f6b21a3d954cfac8b91f83f6b2bbf2cfc64febe66a78580bc253e43c5	2018-05-12 10:19:33.308	222	0	t	ad-hoc	ERROR: column "formsubmissionfield" does not exist\n  Hint: Perhaps you meant to reference the column "e.formsubmissionid".\n  Position: 909	1	\N	\N	\N
211	\\x93be832054e4148f03590d9d533569f4c6534544f68f90c2400f4a7334be91d0	2018-05-12 10:19:50.725	37	45	t	ad-hoc	\N	1	\N	\N	\N
217	\\xaadd57bf9fc124691383feddac6530bfd1dffc4587321b8b1613534ae77d0ae0	2018-05-12 10:23:43.213	25	53	t	ad-hoc	\N	1	\N	\N	\N
241	\\xdaf8c43e03ce8882eb61f9d7c93f664a54c929621861aa991f904f66ab8b4960	2018-05-12 10:32:57.283	87	5	f	question	\N	1	7	\N	\N
214	\\xea969158c73e108e70b1ff8cb633f40a43007a3652ab010d374512cff8cff40d	2018-05-12 10:20:50.716	21	45	t	ad-hoc	\N	1	\N	\N	\N
215	\\xea969158c73e108e70b1ff8cb633f40a43007a3652ab010d374512cff8cff40d	2018-05-12 10:20:51.766	16	45	t	ad-hoc	\N	1	\N	\N	\N
216	\\xea969158c73e108e70b1ff8cb633f40a43007a3652ab010d374512cff8cff40d	2018-05-12 10:22:58.937	28	53	t	ad-hoc	\N	1	\N	\N	\N
218	\\x38da1376297ec92d5f596b1a8c3f0c81441a2a1e0e237ffada5f9ea60867dc50	2018-05-12 10:24:24.742	100	1	t	question	\N	1	1	\N	\N
219	\\x94aac15a2de1732171ab287b64df839ab9a09c4e2761446918077c384fd80a01	2018-05-12 10:24:24.795	366	1	t	question	\N	1	3	\N	\N
220	\\x026e7c41b9faf92803ff46f732bbadaa12b2e4667c40e5d6064ee95cb298f687	2018-05-12 10:24:24.787	486	1	t	question	\N	1	2	\N	\N
221	\\xe3aaebba69d2c390903cc5596f67dc7aac163388eec4a3ab168c37fa85cea721	2018-05-12 10:24:24.854	719	12	f	question	\N	1	5	\N	\N
222	\\x853e6e4dc9986952f2986b24dadf3a065f75c9edff70f7fdd280aad27c021979	2018-05-12 10:24:24.858	720	12	t	question	\N	1	4	\N	\N
223	\\xbaf1b6778a4c60bcdbbd959deb8e4123d813c9e65fc697d3723fb2397f048acb	2018-05-12 10:25:24.007	41	53	f	ad-hoc	\N	1	6	\N	\N
224	\\xbaf1b6778a4c60bcdbbd959deb8e4123d813c9e65fc697d3723fb2397f048acb	2018-05-12 10:25:48.045	34	53	f	ad-hoc	\N	1	6	\N	\N
225	\\x62ba14fbc419e6f3cd42c9a37aea9490fcc4154fb3ac60ae9e0487325bd1fe64	2018-05-12 10:26:34.603	48	5	f	ad-hoc	\N	1	6	\N	\N
226	\\x5d976b549a46ff94a37092e6fba6aa10ba00c226ff45980782a15d27401c7bec	2018-05-12 10:26:53.43	38	18	f	ad-hoc	\N	1	6	\N	\N
227	\\x62ba14fbc419e6f3cd42c9a37aea9490fcc4154fb3ac60ae9e0487325bd1fe64	2018-05-12 10:27:06.426	34	5	f	ad-hoc	\N	1	6	\N	\N
228	\\xbaf1b6778a4c60bcdbbd959deb8e4123d813c9e65fc697d3723fb2397f048acb	2018-05-12 10:27:38.497	31	53	f	ad-hoc	\N	1	6	\N	\N
229	\\x62ba14fbc419e6f3cd42c9a37aea9490fcc4154fb3ac60ae9e0487325bd1fe64	2018-05-12 10:28:02.066	33	5	f	ad-hoc	\N	1	6	\N	\N
230	\\xbaf1b6778a4c60bcdbbd959deb8e4123d813c9e65fc697d3723fb2397f048acb	2018-05-12 10:28:09.982	30	53	f	ad-hoc	\N	1	6	\N	\N
231	\\xdaf8c43e03ce8882eb61f9d7c93f664a54c929621861aa991f904f66ab8b4960	2018-05-12 10:29:25.926	57	5	f	ad-hoc	\N	1	6	\N	\N
232	\\x94aac15a2de1732171ab287b64df839ab9a09c4e2761446918077c384fd80a01	2018-05-12 10:30:40.255	25	1	t	question	\N	1	3	\N	\N
233	\\x38da1376297ec92d5f596b1a8c3f0c81441a2a1e0e237ffada5f9ea60867dc50	2018-05-12 10:30:40.233	49	1	t	question	\N	1	1	\N	\N
234	\\x026e7c41b9faf92803ff46f732bbadaa12b2e4667c40e5d6064ee95cb298f687	2018-05-12 10:30:40.262	206	1	t	question	\N	1	2	\N	\N
235	\\xdaf8c43e03ce8882eb61f9d7c93f664a54c929621861aa991f904f66ab8b4960	2018-05-12 10:30:40.566	40	5	f	question	\N	1	7	\N	\N
236	\\x853e6e4dc9986952f2986b24dadf3a065f75c9edff70f7fdd280aad27c021979	2018-05-12 10:30:40.241	561	12	t	question	\N	1	4	\N	\N
237	\\xe3aaebba69d2c390903cc5596f67dc7aac163388eec4a3ab168c37fa85cea721	2018-05-12 10:30:40.277	558	12	f	question	\N	1	5	\N	\N
238	\\xaadd57bf9fc124691383feddac6530bfd1dffc4587321b8b1613534ae77d0ae0	2018-05-12 10:32:01.824	20	53	t	question	\N	1	6	\N	\N
239	\\xfd1ee7f4c349633dddd8e1bbde3d888df03b2ff409003ef07d56d37d5c5d075b	2018-05-12 10:32:46.018	23	53	t	ad-hoc	\N	1	\N	\N	\N
240	\\xaa293bb5525e033401fa24dbe5c7e005dbabb24890c3facd33986647ab8ec365	2018-05-12 10:32:50.761	24	53	t	ad-hoc	\N	1	\N	\N	\N
242	\\x94aac15a2de1732171ab287b64df839ab9a09c4e2761446918077c384fd80a01	2018-05-12 10:32:57.231	139	1	t	question	\N	1	3	\N	\N
243	\\x38da1376297ec92d5f596b1a8c3f0c81441a2a1e0e237ffada5f9ea60867dc50	2018-05-12 10:32:57.241	129	1	t	question	\N	1	1	\N	\N
244	\\x026e7c41b9faf92803ff46f732bbadaa12b2e4667c40e5d6064ee95cb298f687	2018-05-12 10:32:57.261	216	1	t	question	\N	1	2	\N	\N
247	\\xdaf8c43e03ce8882eb61f9d7c93f664a54c929621861aa991f904f66ab8b4960	2018-05-12 10:33:12.084	41	5	f	question	\N	1	7	\N	\N
248	\\x324171589606fada61afb09af731628e4d58cb591e10879d2e57ac48abe7dd6c	2018-05-12 10:33:55.056	60	5	f	ad-hoc	\N	1	6	\N	\N
250	\\x38da1376297ec92d5f596b1a8c3f0c81441a2a1e0e237ffada5f9ea60867dc50	2018-05-12 10:34:03.296	116	1	t	question	\N	1	1	\N	\N
249	\\x94aac15a2de1732171ab287b64df839ab9a09c4e2761446918077c384fd80a01	2018-05-12 10:34:03.306	106	1	t	question	\N	1	3	\N	\N
251	\\x324171589606fada61afb09af731628e4d58cb591e10879d2e57ac48abe7dd6c	2018-05-12 10:34:03.368	44	5	f	question	\N	1	7	\N	\N
252	\\x026e7c41b9faf92803ff46f732bbadaa12b2e4667c40e5d6064ee95cb298f687	2018-05-12 10:34:03.313	186	1	t	question	\N	1	2	\N	\N
253	\\xe3aaebba69d2c390903cc5596f67dc7aac163388eec4a3ab168c37fa85cea721	2018-05-12 10:34:03.312	379	12	f	question	\N	1	5	\N	\N
254	\\x853e6e4dc9986952f2986b24dadf3a065f75c9edff70f7fdd280aad27c021979	2018-05-12 10:34:03.326	383	12	t	question	\N	1	4	\N	\N
255	\\x026e7c41b9faf92803ff46f732bbadaa12b2e4667c40e5d6064ee95cb298f687	2018-05-12 11:21:49.501	104	1	t	question	\N	1	2	\N	\N
256	\\x77e76584be663323492d3053250b833f2e63a61a0ac95bb0151e92130e07cccf	2018-05-12 11:29:03.84	33	1	t	ad-hoc	\N	1	\N	\N	\N
257	\\x77e76584be663323492d3053250b833f2e63a61a0ac95bb0151e92130e07cccf	2018-05-12 11:29:09.461	24	1	t	ad-hoc	\N	1	\N	\N	\N
258	\\x40c6de68ca08793c5a1e2e3fd8e0d7c7574cf44e778a9911c476b1d655b8df25	2018-05-12 11:29:23.295	35	1	t	ad-hoc	\N	1	\N	\N	\N
259	\\x8ea935a129c81087c2a00c673e16dfa4854c1ec03b2594b034041786321a2568	2018-05-12 11:30:07.968	224	0	t	ad-hoc	ERROR: function max(jsonb) does not exist\n  Hint: No function matches the given name and argument types. You might need to add explicit type casts.\n  Position: 219	1	\N	\N	\N
260	\\x6da4dc32f253e376d6e70b1ed0108ab6cc47fc76a0c320b12f2c1f3d0ddf4f7f	2018-05-12 11:31:56.255	40	1	t	ad-hoc	\N	1	\N	\N	\N
261	\\x737ae63e4a04c65fb3c9bb7dcd9e9270f7b708b77cd5bdc62e9a1e07843dafec	2018-05-12 11:32:18.262	33	1	t	ad-hoc	\N	1	\N	\N	\N
262	\\x995afa9769717634e01bbb5d556cb8ea8fc819346221cb6c08d85d8e2b906df8	2018-05-12 11:32:27.9	26	1	t	ad-hoc	\N	1	\N	\N	\N
263	\\xd474bb9b25381c1ac39f2b4556d34f10ab33c4672d23f4bc08a7491749af997f	2018-05-12 11:33:37.458	29	1	t	ad-hoc	\N	1	\N	\N	\N
264	\\xd474bb9b25381c1ac39f2b4556d34f10ab33c4672d23f4bc08a7491749af997f	2018-05-12 11:33:37.953	26	1	t	ad-hoc	\N	1	\N	\N	\N
265	\\xd474bb9b25381c1ac39f2b4556d34f10ab33c4672d23f4bc08a7491749af997f	2018-05-12 11:36:38.776	28	1	t	ad-hoc	\N	1	\N	\N	\N
266	\\xf7817c13d6fbbe2fdb6c5150d8ce8cfcff2f8f946d0bb3f47655f1bf5c17fbec	2018-05-12 11:38:07.332	43	1	f	ad-hoc	\N	1	8	\N	\N
267	\\x38da1376297ec92d5f596b1a8c3f0c81441a2a1e0e237ffada5f9ea60867dc50	2018-05-12 11:38:49.281	9	1	t	question	\N	1	1	\N	\N
268	\\xd474bb9b25381c1ac39f2b4556d34f10ab33c4672d23f4bc08a7491749af997f	2018-05-12 11:39:02.498	26	1	t	question	\N	1	8	\N	\N
269	\\xd474bb9b25381c1ac39f2b4556d34f10ab33c4672d23f4bc08a7491749af997f	2018-05-12 11:40:28.759	27	1	t	question	\N	1	8	\N	\N
270	\\xe84449f614d63fee56e40341cd1115a033647f4ba18175b4348a4be8e59c226a	2018-05-12 11:44:37.242	30	1	t	ad-hoc	\N	1	\N	\N	\N
271	\\x274db8b61a1f30f2414088211ba778015a0c756a1135d59948894a6001c810fc	2018-05-12 11:45:44.602	216	0	t	ad-hoc	ERROR: syntax error at or near "100"\n  Position: 169	1	\N	\N	\N
272	\\x70ced9002696332c773ba1f81fdca6bf6f0bd9c35a8f83db09d9c3a0f053d29a	2018-05-12 11:45:54.596	43	1	t	ad-hoc	\N	1	\N	\N	\N
273	\\x283085239783aed0644a7d4a31317b045cdde1e1342ab92160f3919b6b04ff67	2018-05-12 11:46:03.103	30	1	t	ad-hoc	\N	1	\N	\N	\N
274	\\xd474bb9b25381c1ac39f2b4556d34f10ab33c4672d23f4bc08a7491749af997f	2018-05-12 11:46:08.329	29	1	t	question	\N	1	8	\N	\N
275	\\x283085239783aed0644a7d4a31317b045cdde1e1342ab92160f3919b6b04ff67	2018-05-12 11:46:11.693	28	1	t	ad-hoc	\N	1	\N	\N	\N
276	\\x38da1376297ec92d5f596b1a8c3f0c81441a2a1e0e237ffada5f9ea60867dc50	2018-05-12 11:46:41.051	9	1	t	question	\N	1	1	\N	\N
277	\\x283085239783aed0644a7d4a31317b045cdde1e1342ab92160f3919b6b04ff67	2018-05-12 11:46:46.958	35	1	t	ad-hoc	\N	1	\N	\N	\N
278	\\x283085239783aed0644a7d4a31317b045cdde1e1342ab92160f3919b6b04ff67	2018-05-12 11:46:56.853	38	1	t	question	\N	1	1	\N	\N
279	\\x94aac15a2de1732171ab287b64df839ab9a09c4e2761446918077c384fd80a01	2018-05-12 11:46:56.854	85	1	t	question	\N	1	3	\N	\N
280	\\x324171589606fada61afb09af731628e4d58cb591e10879d2e57ac48abe7dd6c	2018-05-12 11:46:56.927	89	5	f	question	\N	1	7	\N	\N
281	\\x026e7c41b9faf92803ff46f732bbadaa12b2e4667c40e5d6064ee95cb298f687	2018-05-12 11:46:56.855	312	1	t	question	\N	1	2	\N	\N
282	\\xe3aaebba69d2c390903cc5596f67dc7aac163388eec4a3ab168c37fa85cea721	2018-05-12 11:46:56.891	429	12	f	question	\N	1	5	\N	\N
283	\\x853e6e4dc9986952f2986b24dadf3a065f75c9edff70f7fdd280aad27c021979	2018-05-12 11:46:56.884	440	12	t	question	\N	1	4	\N	\N
284	\\x283085239783aed0644a7d4a31317b045cdde1e1342ab92160f3919b6b04ff67	2018-05-12 11:47:44.171	23	1	t	question	\N	1	1	\N	\N
285	\\x73cdf619236c552536e0a1f4655fa621475379f543d808f75de298e65e8d1f3d	2018-05-12 11:48:07.994	36	1	t	ad-hoc	\N	1	\N	\N	\N
286	\\x73cdf619236c552536e0a1f4655fa621475379f543d808f75de298e65e8d1f3d	2018-05-12 11:48:18.59	150	1	t	question	\N	1	1	\N	\N
287	\\x324171589606fada61afb09af731628e4d58cb591e10879d2e57ac48abe7dd6c	2018-05-12 11:48:18.694	46	5	f	question	\N	1	7	\N	\N
288	\\x94aac15a2de1732171ab287b64df839ab9a09c4e2761446918077c384fd80a01	2018-05-12 11:48:18.608	133	1	t	question	\N	1	3	\N	\N
289	\\x026e7c41b9faf92803ff46f732bbadaa12b2e4667c40e5d6064ee95cb298f687	2018-05-12 11:48:18.609	229	1	t	question	\N	1	2	\N	\N
290	\\x853e6e4dc9986952f2986b24dadf3a065f75c9edff70f7fdd280aad27c021979	2018-05-12 11:48:18.678	384	12	t	question	\N	1	4	\N	\N
291	\\xe3aaebba69d2c390903cc5596f67dc7aac163388eec4a3ab168c37fa85cea721	2018-05-12 11:48:18.681	393	12	f	question	\N	1	5	\N	\N
302	\\x2c2e509a058169cbc445bd158f6f51f332172c527ec340d450cdfd4ba4a86fa5	2018-05-12 12:05:05.413	217	0	t	ad-hoc	ERROR: column "o.value" must appear in the GROUP BY clause or be used in an aggregate function\n  Position: 164	1	\N	\N	\N
304	\\xd0328fbcc55cf76ef3c606b793e2c12f55e5ca0a1451943277e5a4c9d6cd85fa	2018-05-12 12:05:53.731	226	0	t	ad-hoc	ERROR: column "form" does not exist\n  Position: 573	1	\N	\N	\N
292	\\x283085239783aed0644a7d4a31317b045cdde1e1342ab92160f3919b6b04ff67	2018-05-12 11:58:43.046	28	1	t	question	\N	1	8	\N	\N
293	\\x30a1fc503bc20af266151b5d9afc14606d461fd1bdaec706b9e4f6812b68f7f7	2018-05-12 11:59:07.795	32	1	t	ad-hoc	\N	1	\N	\N	\N
306	\\xa2781e52d951d3efc5628aaa0e231fe45ffd0ecc6ee2f339158a6dfc27f7b533	2018-05-12 12:06:07.444	70	4500	t	ad-hoc	\N	1	\N	\N	\N
294	\\x7a764f64b3ccbb423482a30ed8197aa49dac6ec31b7a8210e5d764e09b9a064e	2018-05-12 12:02:18.067	219	0	t	ad-hoc	ERROR: syntax error at or near ")"\n  Position: 431	1	\N	\N	\N
295	\\xc4732ca06f7545d625e3232fac6afc5e14f37b26a3ee54592b51c6bf73929b12	2018-05-12 12:02:26.41	202	0	t	ad-hoc	ERROR: column "o.value" must appear in the GROUP BY clause or be used in an aggregate function\n  Position: 351	1	\N	\N	\N
296	\\x9399377c164aa3ec6ab3b3a2196cfead80b9593af9f398655c15ca2ca7c4dac3	2018-05-12 12:02:31.826	41	1	t	ad-hoc	\N	1	\N	\N	\N
299	\\x46017f95a73343a2d7d0e68fdcb54a8dc34ed109d663ba96c37ad4904ab7ac5e	2018-05-12 12:03:14.576	223	0	t	ad-hoc	ERROR: aggregate functions are not allowed in GROUP BY\n  Position: 340	1	\N	\N	\N
297	\\xc3a61077f40aab7677b167d4cced02011847c5493a08406d141836eaaa9674dc	2018-05-12 12:02:40.537	36	1	t	ad-hoc	\N	1	\N	\N	\N
298	\\xfddec19e8a6bc844a89e31bb7beb7dd26a37d34fe737ed3fa8af6e10e6191065	2018-05-12 12:03:07.606	234	0	t	ad-hoc	ERROR: syntax error at or near "WHERE"\n  Position: 544	1	\N	\N	\N
301	\\x340e85ef6f6f21c5812b50cdb4ff8d28da3d3707878cadbf10e519d6ba3e8a75	2018-05-12 12:04:01.473	223	0	t	ad-hoc	ERROR: aggregate functions are not allowed in GROUP BY\n  Position: 164	1	\N	\N	\N
309	\\x9403059f2dfca3ef7d257a001559a45af92904c003076f337842e327d1f0ee4f	2018-05-12 12:10:11.656	40	500	t	ad-hoc	\N	1	\N	\N	\N
311	\\x0517aece015da3e180723d5684c1801f7e2b6a2383358c2a68708ac48a376683	2018-05-12 12:10:47.936	210	0	t	ad-hoc	ERROR: column "o.value" must appear in the GROUP BY clause or be used in an aggregate function\n  Position: 174	1	\N	\N	\N
312	\\x1aa866552a5900e9f1f4d86607eff6898d34430fffa2b531f9dfe43ae61dfddf	2018-05-12 12:11:23.598	180	0	t	ad-hoc	ERROR: column "o.value" must appear in the GROUP BY clause or be used in an aggregate function\n  Position: 175	1	\N	\N	\N
316	\\xd7de40df83bbb6cdf19ec4367210f5c6e4864322417c09d08be3a0db7189f156	2018-05-12 12:13:56.085	201	0	t	ad-hoc	ERROR: syntax error at or near "CASE"\n  Position: 254	1	\N	\N	\N
318	\\x0d9d797d1235b54210aee4705c5d458b5424d969bcf796eda5efb3ecaed89161	2018-05-12 12:14:22.138	15	1	t	ad-hoc	\N	1	\N	\N	\N
321	\\x30e46ccea214065adcc1130acbdd0342d0ab23bbfd3658d839ffb30fe3cf34c9	2018-05-12 12:15:35.461	15	3	t	ad-hoc	\N	1	\N	\N	\N
300	\\xd9254da326c08809513b02ed5ced851e9571ac0126cd58187b1bbcc3b58c3008	2018-05-12 12:03:30.891	43	4	t	ad-hoc	\N	1	\N	\N	\N
303	\\x3242c7f04b88b1459faffceb7f298d3467116b0351209d38b41b43c08ef5db09	2018-05-12 12:05:22.095	51	4500	t	ad-hoc	\N	1	\N	\N	\N
305	\\xddb00ae6485ebfd73c507ce6462c4b9dc59021189a441030a4a8a95941d70906	2018-05-12 12:05:59.31	201	0	t	ad-hoc	ERROR: column "form" does not exist\n  Position: 572	1	\N	\N	\N
307	\\x699af6b3f206499bd7c7475dc2efb310d2442bdaa9a6cd7571ae21112e4d2b90	2018-05-12 12:09:40.311	210	0	t	ad-hoc	ERROR: column "formsubmissionfield" does not exist\n  Hint: Perhaps you meant to reference the column "e.formsubmissionid".\n  Position: 572	1	\N	\N	\N
310	\\xf7f73fb6a8441abeb8dbc42e47eed75dbbd40776d5e28e76193c722218d622ce	2018-05-12 12:10:38.412	199	0	t	ad-hoc	ERROR: column "o.value" must appear in the GROUP BY clause or be used in an aggregate function\n  Position: 164	1	\N	\N	\N
320	\\x202782c9488e8ac856d7868e8b56f7f1db4e84d30385fdd71181c4f398dc8783	2018-05-12 12:15:10.75	20	3	t	ad-hoc	\N	1	\N	\N	\N
308	\\xeb16ea6c3a4aa5ff08b5cf8c9140a3a395137b75a343a8b132f3bf43c9904218	2018-05-12 12:09:58.904	213	0	t	ad-hoc	ERROR: column "confirmed_tb" does not exist\n  Position: 598	1	\N	\N	\N
313	\\x73acb2f20d9d019692dfd0f275f23e01ab36fad99739d307b10cfecc78cf113b	2018-05-12 12:11:46.785	217	0	t	ad-hoc	ERROR: column "o.value" must appear in the GROUP BY clause or be used in an aggregate function\n  Position: 303	1	\N	\N	\N
315	\\xfe50919ead1c6f5f9c0758c0156ca7453f86b861a4534524b2cdfb7e7966f34e	2018-05-12 12:12:23.267	16	1	t	ad-hoc	\N	1	\N	\N	\N
317	\\xc071cc4eb19080fd31f84c16a20d09ea1f1a50a6e52925f2c574a15bd949f9d0	2018-05-12 12:14:01.148	193	0	t	ad-hoc	ERROR: syntax error at or near "CASE"\n  Position: 254	1	\N	\N	\N
319	\\xcab565eb4efbcf631b831c3a761343a5b3ca1bfd595113e4a73a9ef20c8752d6	2018-05-12 12:15:05.592	171	0	t	ad-hoc	ERROR: syntax error at or near "o"\n  Position: 255	1	\N	\N	\N
314	\\xc6e07df307e4fc37b0f849bc01980d96b60ef234072b96124ec7617ad782e001	2018-05-12 12:11:57.37	22	1	t	ad-hoc	\N	1	\N	\N	\N
322	\\x0d824504635264c0d617e297ae335fc24b0ad3be1c18e465ceccd9d07007ac57	2018-05-12 12:15:53.826	15	3	t	ad-hoc	\N	1	\N	\N	\N
323	\\x73cdf619236c552536e0a1f4655fa621475379f543d808f75de298e65e8d1f3d	2018-05-12 12:16:13.695	30	1	t	question	\N	1	1	\N	\N
324	\\x324171589606fada61afb09af731628e4d58cb591e10879d2e57ac48abe7dd6c	2018-05-12 12:16:13.734	63	5	f	question	\N	1	7	\N	\N
325	\\x94aac15a2de1732171ab287b64df839ab9a09c4e2761446918077c384fd80a01	2018-05-12 12:16:13.695	150	1	t	question	\N	1	3	\N	\N
326	\\x026e7c41b9faf92803ff46f732bbadaa12b2e4667c40e5d6064ee95cb298f687	2018-05-12 12:16:13.723	222	1	t	question	\N	1	2	\N	\N
327	\\x853e6e4dc9986952f2986b24dadf3a065f75c9edff70f7fdd280aad27c021979	2018-05-12 12:16:13.711	425	12	t	question	\N	1	4	\N	\N
328	\\xe3aaebba69d2c390903cc5596f67dc7aac163388eec4a3ab168c37fa85cea721	2018-05-12 12:16:13.729	420	12	f	question	\N	1	5	\N	\N
329	\\x0d824504635264c0d617e297ae335fc24b0ad3be1c18e465ceccd9d07007ac57	2018-05-12 12:16:22.474	12	3	t	question	\N	1	8	\N	\N
330	\\xf7817c13d6fbbe2fdb6c5150d8ce8cfcff2f8f946d0bb3f47655f1bf5c17fbec	2018-05-12 12:16:44.998	23	3	f	ad-hoc	\N	1	8	\N	\N
331	\\x0d824504635264c0d617e297ae335fc24b0ad3be1c18e465ceccd9d07007ac57	2018-05-12 12:17:36.73	13	3	t	question	\N	1	8	\N	\N
332	\\x3d61a4a398e503975d9b9d96d820b39abd063c97d4acd22ff5a11fbfe292fc2f	2018-05-12 12:18:07.672	173	0	t	ad-hoc	ERROR: syntax error at or near ":"\n  Position: 207	1	\N	\N	\N
333	\\x299081802049172247ca7b329d1b524681b98fe3d088b925bdf7bf17c9dba62c	2018-05-12 12:18:16.417	195	0	t	ad-hoc	ERROR: syntax error at or near ":"\n  Position: 207	1	\N	\N	\N
334	\\x9ed47806b250ce1fc230d59ebef644cae6c8f36ef44066ad75b91baf0d6040a3	2018-05-12 12:18:34.28	184	0	t	ad-hoc	ERROR: operator does not exist: text #> integer\n  Hint: No operator matches the given name and argument type(s). You might need to add explicit type casts.\n  Position: 207	1	\N	\N	\N
335	\\x6692f8795711a2a8d147aee5c557e4df9a49afaef7d1f8c3d01acfa7bab62aaa	2018-05-12 12:18:53.502	203	0	t	ad-hoc	ERROR: operator does not exist: text #>> integer\n  Hint: No operator matches the given name and argument type(s). You might need to add explicit type casts.\n  Position: 207	1	\N	\N	\N
336	\\x664cf609d3c5d644c7586479a5b4ceb76de59f9d4c0136c1a148f452671915b2	2018-05-12 12:19:13.775	194	0	t	ad-hoc	ERROR: operator does not exist: text ->> integer\n  Hint: No operator matches the given name and argument type(s). You might need to add explicit type casts.\n  Position: 207	1	\N	\N	\N
337	\\xae8eda9397963ebde0ac52dd286a81f2a0c10ff233e0ddf76ef36209370a8969	2018-05-12 12:19:22.263	174	0	t	ad-hoc	ERROR: syntax error at or near ":"\n  Position: 207	1	\N	\N	\N
338	\\xe2a492eeb475912b3b89b8d44872f27cbd63a812ae5df2f29738931788d64db7	2018-05-12 12:19:31.433	25	1	t	ad-hoc	\N	1	\N	\N	\N
339	\\x8b5ac8f0ef0c306ceda2710bbd6f9e13f7c782c0fc6ad1a74be1348dd36e1c17	2018-05-12 12:19:40.618	189	0	t	ad-hoc	ERROR: operator does not exist: json #>> integer\n  Hint: No operator matches the given name and argument type(s). You might need to add explicit type casts.\n  Position: 213	1	\N	\N	\N
340	\\x7e66535098e69e7586b8a36915eee1388014fcd26b61962a8bc60f3696bd35f8	2018-05-12 12:20:05.509	190	0	t	ad-hoc	ERROR: could not identify an equality operator for type json\n  Position: 372	1	\N	\N	\N
341	\\x638892564f882f80908de5d45f9a56592d06206316889eb8a4eafbb969dcd293	2018-05-12 12:20:08.944	21	3	t	ad-hoc	\N	1	\N	\N	\N
342	\\x4d05a2a2b7b125d5235ba2e6eaf5b9f9f468fddb3eec3de857c0f56225b73cc5	2018-05-12 12:20:20.455	187	0	t	ad-hoc	ERROR: malformed array literal: "humanReadableValues"\n  Detail: Array value must start with "{" or dimension information.\n  Position: 185	1	\N	\N	\N
343	\\x324171589606fada61afb09af731628e4d58cb591e10879d2e57ac48abe7dd6c	2018-05-12 12:20:39.028	41	5	f	question	\N	1	7	\N	\N
344	\\xaa293bb5525e033401fa24dbe5c7e005dbabb24890c3facd33986647ab8ec365	2018-05-12 12:20:44.315	20	53	t	question	\N	1	6	\N	\N
345	\\x0d824504635264c0d617e297ae335fc24b0ad3be1c18e465ceccd9d07007ac57	2018-05-12 12:21:02.026	14	3	t	question	\N	1	8	\N	\N
346	\\xc8c932438a7408bfe0c0e8d1767d3e5b68ccbefe54359e4f839695a4d65baf5d	2018-05-12 12:21:12.366	12	3	t	ad-hoc	\N	1	\N	\N	\N
347	\\x94aac15a2de1732171ab287b64df839ab9a09c4e2761446918077c384fd80a01	2018-05-12 12:21:22.206	39	1	t	question	\N	1	3	\N	\N
348	\\x73cdf619236c552536e0a1f4655fa621475379f543d808f75de298e65e8d1f3d	2018-05-12 12:21:22.206	51	1	t	question	\N	1	1	\N	\N
349	\\x324171589606fada61afb09af731628e4d58cb591e10879d2e57ac48abe7dd6c	2018-05-12 12:21:22.337	35	5	f	question	\N	1	7	\N	\N
350	\\x026e7c41b9faf92803ff46f732bbadaa12b2e4667c40e5d6064ee95cb298f687	2018-05-12 12:21:22.253	212	1	t	question	\N	1	2	\N	\N
351	\\x853e6e4dc9986952f2986b24dadf3a065f75c9edff70f7fdd280aad27c021979	2018-05-12 12:21:22.226	389	12	t	question	\N	1	4	\N	\N
352	\\xe3aaebba69d2c390903cc5596f67dc7aac163388eec4a3ab168c37fa85cea721	2018-05-12 12:21:22.267	391	12	f	question	\N	1	5	\N	\N
353	\\xf7817c13d6fbbe2fdb6c5150d8ce8cfcff2f8f946d0bb3f47655f1bf5c17fbec	2018-05-12 12:21:31.264	21	3	f	question	\N	1	9	\N	\N
354	\\x94aac15a2de1732171ab287b64df839ab9a09c4e2761446918077c384fd80a01	2018-05-12 12:21:45.153	21	1	t	question	\N	1	3	\N	\N
355	\\x73cdf619236c552536e0a1f4655fa621475379f543d808f75de298e65e8d1f3d	2018-05-12 12:21:45.149	36	1	t	question	\N	1	1	\N	\N
356	\\x324171589606fada61afb09af731628e4d58cb591e10879d2e57ac48abe7dd6c	2018-05-12 12:21:45.192	40	5	f	question	\N	1	7	\N	\N
357	\\x026e7c41b9faf92803ff46f732bbadaa12b2e4667c40e5d6064ee95cb298f687	2018-05-12 12:21:45.153	226	1	t	question	\N	1	2	\N	\N
358	\\xf7817c13d6fbbe2fdb6c5150d8ce8cfcff2f8f946d0bb3f47655f1bf5c17fbec	2018-05-12 12:21:45.442	29	3	f	question	\N	1	9	\N	\N
359	\\x853e6e4dc9986952f2986b24dadf3a065f75c9edff70f7fdd280aad27c021979	2018-05-12 12:21:45.156	391	12	t	question	\N	1	4	\N	\N
360	\\xe3aaebba69d2c390903cc5596f67dc7aac163388eec4a3ab168c37fa85cea721	2018-05-12 12:21:45.182	407	12	f	question	\N	1	5	\N	\N
361	\\x73cdf619236c552536e0a1f4655fa621475379f543d808f75de298e65e8d1f3d	2018-05-12 12:57:03.14	53	1	t	question	\N	1	1	\N	\N
362	\\x94aac15a2de1732171ab287b64df839ab9a09c4e2761446918077c384fd80a01	2018-05-12 12:57:03.147	97	1	t	question	\N	1	3	\N	\N
363	\\x324171589606fada61afb09af731628e4d58cb591e10879d2e57ac48abe7dd6c	2018-05-12 12:57:03.194	168	5	f	question	\N	1	7	\N	\N
364	\\xf7817c13d6fbbe2fdb6c5150d8ce8cfcff2f8f946d0bb3f47655f1bf5c17fbec	2018-05-12 12:57:03.392	45	3	f	question	\N	1	9	\N	\N
365	\\x026e7c41b9faf92803ff46f732bbadaa12b2e4667c40e5d6064ee95cb298f687	2018-05-12 12:57:03.216	291	1	t	question	\N	1	2	\N	\N
366	\\x853e6e4dc9986952f2986b24dadf3a065f75c9edff70f7fdd280aad27c021979	2018-05-12 12:57:03.195	492	12	t	question	\N	1	4	\N	\N
367	\\xe3aaebba69d2c390903cc5596f67dc7aac163388eec4a3ab168c37fa85cea721	2018-05-12 12:57:03.201	496	12	f	question	\N	1	5	\N	\N
368	\\xf7817c13d6fbbe2fdb6c5150d8ce8cfcff2f8f946d0bb3f47655f1bf5c17fbec	2018-05-12 13:09:45.563	34	3	f	question	\N	1	9	\N	\N
369	\\xc8c932438a7408bfe0c0e8d1767d3e5b68ccbefe54359e4f839695a4d65baf5d	2018-05-12 13:09:50.92	13	3	t	question	\N	1	8	\N	\N
370	\\xe6556c2f0d6f1ad4b415d0a4ed6465ed3ac172835963bdaca2c9323fc360e68a	2018-05-12 13:58:21.5	20	3	t	ad-hoc	\N	1	\N	\N	\N
371	\\xe5c0d8d37650c87ca07ec861cab7300e4b4797633735d999073767360d6b6b47	2018-05-12 14:01:33.991	13	4	t	ad-hoc	\N	1	\N	\N	\N
372	\\x73cdf619236c552536e0a1f4655fa621475379f543d808f75de298e65e8d1f3d	2018-05-12 14:03:54.867	69	1	t	question	\N	1	1	\N	\N
373	\\x94aac15a2de1732171ab287b64df839ab9a09c4e2761446918077c384fd80a01	2018-05-12 14:03:54.884	116	1	t	question	\N	1	3	\N	\N
374	\\x324171589606fada61afb09af731628e4d58cb591e10879d2e57ac48abe7dd6c	2018-05-12 14:03:54.949	110	5	f	question	\N	1	7	\N	\N
375	\\xf7817c13d6fbbe2fdb6c5150d8ce8cfcff2f8f946d0bb3f47655f1bf5c17fbec	2018-05-12 14:03:54.975	93	3	f	question	\N	1	9	\N	\N
376	\\x026e7c41b9faf92803ff46f732bbadaa12b2e4667c40e5d6064ee95cb298f687	2018-05-12 14:03:54.891	261	1	t	question	\N	1	2	\N	\N
377	\\xe3aaebba69d2c390903cc5596f67dc7aac163388eec4a3ab168c37fa85cea721	2018-05-12 14:03:54.913	429	12	f	question	\N	1	5	\N	\N
378	\\x853e6e4dc9986952f2986b24dadf3a065f75c9edff70f7fdd280aad27c021979	2018-05-12 14:03:54.899	457	12	t	question	\N	1	4	\N	\N
379	\\xb5beba004be4cee68cdb49fffce6ddc07353675056b4acb13d9ce235e0998efd	2018-05-12 14:04:02.53	35	4	f	ad-hoc	\N	1	10	\N	\N
380	\\xc8c932438a7408bfe0c0e8d1767d3e5b68ccbefe54359e4f839695a4d65baf5d	2018-05-12 14:04:41.938	17	3	t	question	\N	1	8	\N	\N
381	\\x324171589606fada61afb09af731628e4d58cb591e10879d2e57ac48abe7dd6c	2018-05-12 14:05:07.11	32	5	f	question	\N	1	7	\N	\N
382	\\xaa293bb5525e033401fa24dbe5c7e005dbabb24890c3facd33986647ab8ec365	2018-05-12 14:05:16.799	19	53	t	question	\N	1	6	\N	\N
383	\\xe5c0d8d37650c87ca07ec861cab7300e4b4797633735d999073767360d6b6b47	2018-05-12 14:06:11.897	14	4	t	question	\N	1	10	\N	\N
413	\\x1f2393eaeb439e71d6dfd3cea2192fd60299c49bf620020c2b14f10fcb4d51cb	2018-05-12 14:23:01.381	42	5	f	question	\N	1	7	\N	\N
384	\\xd76a3dc0ba4d607d3a7bb6c927d4496e17831029d80f06253a07c1ece003553f	2018-05-12 14:06:42.097	12	9	t	ad-hoc	\N	1	\N	\N	\N
385	\\x324171589606fada61afb09af731628e4d58cb591e10879d2e57ac48abe7dd6c	2018-05-12 14:08:08.319	35	5	f	question	\N	1	7	\N	\N
386	\\xb5beba004be4cee68cdb49fffce6ddc07353675056b4acb13d9ce235e0998efd	2018-05-12 14:08:37.831	35	9	f	ad-hoc	\N	1	10	\N	\N
387	\\xd76a3dc0ba4d607d3a7bb6c927d4496e17831029d80f06253a07c1ece003553f	2018-05-12 14:09:42.009	16	9	t	question	\N	1	10	\N	\N
388	\\xab680b9a199c68d76cb1126d710b3682d0fc7219d1b44ac502894268bd5cb4ee	2018-05-12 14:20:16.822	193	0	t	ad-hoc	ERROR: column "o.value" must appear in the GROUP BY clause or be used in an aggregate function\n  Position: 173	1	\N	\N	\N
389	\\x753adfc95a052fa5e9a249ee8bc4442e988444954949ac5d76872e8b7675ba66	2018-05-12 14:20:30.995	18	9	t	ad-hoc	\N	1	\N	\N	\N
390	\\x73cdf619236c552536e0a1f4655fa621475379f543d808f75de298e65e8d1f3d	2018-05-12 14:20:47.925	46	1	t	question	\N	1	1	\N	\N
391	\\x324171589606fada61afb09af731628e4d58cb591e10879d2e57ac48abe7dd6c	2018-05-12 14:20:47.949	65	5	f	question	\N	1	7	\N	\N
393	\\xf7817c13d6fbbe2fdb6c5150d8ce8cfcff2f8f946d0bb3f47655f1bf5c17fbec	2018-05-12 14:20:48.012	55	3	f	question	\N	1	9	\N	\N
394	\\x026e7c41b9faf92803ff46f732bbadaa12b2e4667c40e5d6064ee95cb298f687	2018-05-12 14:20:47.931	344	1	t	question	\N	1	2	\N	\N
395	\\xe3aaebba69d2c390903cc5596f67dc7aac163388eec4a3ab168c37fa85cea721	2018-05-12 14:20:47.946	521	12	f	question	\N	1	5	\N	\N
396	\\x853e6e4dc9986952f2986b24dadf3a065f75c9edff70f7fdd280aad27c021979	2018-05-12 14:20:47.938	579	12	t	question	\N	1	4	\N	\N
397	\\x324171589606fada61afb09af731628e4d58cb591e10879d2e57ac48abe7dd6c	2018-05-12 14:20:53.106	26	5	f	question	\N	1	7	\N	\N
398	\\x837de1fbaf3b620b6a236a1a540c8c3d0f1d6543341f10566c67fcf0f046adc6	2018-05-12 14:21:23.124	66	5	f	ad-hoc	\N	1	10	\N	\N
399	\\x837de1fbaf3b620b6a236a1a540c8c3d0f1d6543341f10566c67fcf0f046adc6	2018-05-12 14:21:37.913	33	5	f	ad-hoc	\N	1	10	\N	\N
400	\\x6e970e87142e74a9ed5b0bb7b717fc67be3772caf3109096ed8be44ae51ad063	2018-05-12 14:22:02.896	31	5	f	ad-hoc	\N	1	10	\N	\N
392	\\x94aac15a2de1732171ab287b64df839ab9a09c4e2761446918077c384fd80a01	2018-05-12 14:20:47.925	116	1	t	question	\N	1	3	\N	\N
401	\\x73cdf619236c552536e0a1f4655fa621475379f543d808f75de298e65e8d1f3d	2018-05-12 14:22:17.548	201	1	t	question	\N	1	1	\N	\N
402	\\x94aac15a2de1732171ab287b64df839ab9a09c4e2761446918077c384fd80a01	2018-05-12 14:22:17.573	82	1	t	question	\N	1	3	\N	\N
403	\\x1f2393eaeb439e71d6dfd3cea2192fd60299c49bf620020c2b14f10fcb4d51cb	2018-05-12 14:22:17.701	54	5	f	question	\N	1	7	\N	\N
404	\\xf7817c13d6fbbe2fdb6c5150d8ce8cfcff2f8f946d0bb3f47655f1bf5c17fbec	2018-05-12 14:22:17.797	29	3	f	question	\N	1	9	\N	\N
405	\\x026e7c41b9faf92803ff46f732bbadaa12b2e4667c40e5d6064ee95cb298f687	2018-05-12 14:22:17.573	297	1	t	question	\N	1	2	\N	\N
406	\\x853e6e4dc9986952f2986b24dadf3a065f75c9edff70f7fdd280aad27c021979	2018-05-12 14:22:17.613	440	12	t	question	\N	1	4	\N	\N
407	\\xe3aaebba69d2c390903cc5596f67dc7aac163388eec4a3ab168c37fa85cea721	2018-05-12 14:22:17.615	458	12	f	question	\N	1	5	\N	\N
408	\\x1f2393eaeb439e71d6dfd3cea2192fd60299c49bf620020c2b14f10fcb4d51cb	2018-05-12 14:22:43.537	29	5	f	question	\N	1	7	\N	\N
409	\\x1f2393eaeb439e71d6dfd3cea2192fd60299c49bf620020c2b14f10fcb4d51cb	2018-05-12 14:22:54.022	30	5	f	question	\N	1	7	\N	\N
410	\\x1f2393eaeb439e71d6dfd3cea2192fd60299c49bf620020c2b14f10fcb4d51cb	2018-05-12 14:22:55.239	34	5	f	question	\N	1	7	\N	\N
411	\\x94aac15a2de1732171ab287b64df839ab9a09c4e2761446918077c384fd80a01	2018-05-12 14:23:01.377	16	1	t	question	\N	1	3	\N	\N
412	\\x73cdf619236c552536e0a1f4655fa621475379f543d808f75de298e65e8d1f3d	2018-05-12 14:23:01.373	37	1	t	question	\N	1	1	\N	\N
414	\\xf7817c13d6fbbe2fdb6c5150d8ce8cfcff2f8f946d0bb3f47655f1bf5c17fbec	2018-05-12 14:23:01.429	35	3	f	question	\N	1	9	\N	\N
415	\\x026e7c41b9faf92803ff46f732bbadaa12b2e4667c40e5d6064ee95cb298f687	2018-05-12 14:23:01.36	258	1	t	question	\N	1	2	\N	\N
416	\\x853e6e4dc9986952f2986b24dadf3a065f75c9edff70f7fdd280aad27c021979	2018-05-12 14:23:01.409	358	12	t	question	\N	1	4	\N	\N
417	\\xe3aaebba69d2c390903cc5596f67dc7aac163388eec4a3ab168c37fa85cea721	2018-05-12 14:23:01.414	362	12	f	question	\N	1	5	\N	\N
418	\\xb5beba004be4cee68cdb49fffce6ddc07353675056b4acb13d9ce235e0998efd	2018-05-12 14:24:16.343	36	9	f	ad-hoc	\N	1	10	\N	\N
419	\\xf8d81e4ab11a36005c8fdf5614846b1fe725f94143e38ad8134236570b2c5311	2018-05-12 14:25:04.951	33	4	f	ad-hoc	\N	1	10	\N	\N
420	\\x94aac15a2de1732171ab287b64df839ab9a09c4e2761446918077c384fd80a01	2018-05-12 14:30:32.665	26	1	t	question	\N	1	3	\N	\N
421	\\x73cdf619236c552536e0a1f4655fa621475379f543d808f75de298e65e8d1f3d	2018-05-12 14:30:32.661	33	1	t	question	\N	1	1	\N	\N
422	\\xf7817c13d6fbbe2fdb6c5150d8ce8cfcff2f8f946d0bb3f47655f1bf5c17fbec	2018-05-12 14:30:32.755	29	3	f	question	\N	1	9	\N	\N
423	\\x1f2393eaeb439e71d6dfd3cea2192fd60299c49bf620020c2b14f10fcb4d51cb	2018-05-12 14:30:32.736	53	5	f	question	\N	1	7	\N	\N
424	\\x026e7c41b9faf92803ff46f732bbadaa12b2e4667c40e5d6064ee95cb298f687	2018-05-12 14:30:32.666	249	1	t	question	\N	1	2	\N	\N
425	\\x853e6e4dc9986952f2986b24dadf3a065f75c9edff70f7fdd280aad27c021979	2018-05-12 14:30:32.69	461	12	t	question	\N	1	4	\N	\N
426	\\xe3aaebba69d2c390903cc5596f67dc7aac163388eec4a3ab168c37fa85cea721	2018-05-12 14:30:32.71	442	12	f	question	\N	1	5	\N	\N
427	\\x5799e5ee5c0a531ebdeb28bb3587d69494d9f0e7b7d2822f3f2ada5513f02d8d	2018-05-12 14:30:33.118	41	4	f	question	\N	1	11	\N	\N
428	\\x753adfc95a052fa5e9a249ee8bc4442e988444954949ac5d76872e8b7675ba66	2018-05-12 14:51:19.447	12	9	t	question	\N	1	10	\N	\N
429	\\xc907b7c22788d23329858a5bac5cd9dc6064716b5c5c86f98beec6c871ac0566	2018-05-12 14:52:50.698	164	0	t	ad-hoc	ERROR: schema "e" does not exist\n  Position: 328	1	\N	\N	\N
430	\\x4172c33b122f2baac361983b535a36d71cb963ff731eee35f5bcc9138bb99f83	2018-05-12 14:53:08.023	15	2	t	ad-hoc	\N	1	\N	\N	\N
431	\\xb839012e30d1225b3dabfa5b14338218ef960414f2b13e6696b9208daf4c1105	2018-05-12 14:53:38.018	159	0	t	ad-hoc	ERROR: syntax error at or near "("\n  Position: 184	1	\N	\N	\N
432	\\x4eee9ecb63e8713f3c8e86e0cec0d52402f04aa4c77474de4db75db834154a06	2018-05-12 14:53:41.847	143	0	t	ad-hoc	ERROR: function max(jsonb) does not exist\n  Hint: No function matches the given name and argument types. You might need to add explicit type casts.\n  Position: 171	1	\N	\N	\N
433	\\x9738339eab623ed2fb2093249a41892ec873bea85cea267f1c4615788dcfa0c1	2018-05-12 14:53:56.499	19	2	t	ad-hoc	\N	1	\N	\N	\N
434	\\x9738339eab623ed2fb2093249a41892ec873bea85cea267f1c4615788dcfa0c1	2018-05-12 14:56:02.842	23	7	t	ad-hoc	\N	1	\N	\N	\N
435	\\x4172c33b122f2baac361983b535a36d71cb963ff731eee35f5bcc9138bb99f83	2018-05-12 14:56:10.915	8	7	t	ad-hoc	\N	1	\N	\N	\N
436	\\x598542b095292c51ea5b015d21f61312a5495f1ffd20155155badef973cbfdcf	2018-05-12 14:58:57.405	162	0	t	ad-hoc	ERROR: column reference "baseentityid" is ambiguous\n  Position: 188	1	\N	\N	\N
437	\\x3e096ba1940bf598a9eeb61b8766bec8735529c51783b78086ed713ed5781f31	2018-05-12 14:59:05.449	15	7	t	ad-hoc	\N	1	\N	\N	\N
438	\\x232aee263646badd2f6d5acbc2fbd4ea2e5b2adf0d863d205e953bcf0ffd7358	2018-05-12 14:59:26.706	9	7	t	ad-hoc	\N	1	\N	\N	\N
439	\\xa33be5de317284f52a58c23ececd67fd22e5dfaa2031e54d937351e9ef9b3536	2018-05-12 14:59:55.593	10	7	t	ad-hoc	\N	1	\N	\N	\N
440	\\x73cdf619236c552536e0a1f4655fa621475379f543d808f75de298e65e8d1f3d	2018-05-12 15:00:30.971	72	1	t	question	\N	1	1	\N	\N
441	\\x94aac15a2de1732171ab287b64df839ab9a09c4e2761446918077c384fd80a01	2018-05-12 15:00:30.976	109	1	t	question	\N	1	3	\N	\N
442	\\x1f2393eaeb439e71d6dfd3cea2192fd60299c49bf620020c2b14f10fcb4d51cb	2018-05-12 15:00:31.007	78	5	f	question	\N	1	7	\N	\N
443	\\xf7817c13d6fbbe2fdb6c5150d8ce8cfcff2f8f946d0bb3f47655f1bf5c17fbec	2018-05-12 15:00:31.149	36	3	f	question	\N	1	9	\N	\N
444	\\x5799e5ee5c0a531ebdeb28bb3587d69494d9f0e7b7d2822f3f2ada5513f02d8d	2018-05-12 15:00:31.149	44	4	f	question	\N	1	11	\N	\N
445	\\x026e7c41b9faf92803ff46f732bbadaa12b2e4667c40e5d6064ee95cb298f687	2018-05-12 15:00:30.974	307	1	t	question	\N	1	2	\N	\N
446	\\xe3aaebba69d2c390903cc5596f67dc7aac163388eec4a3ab168c37fa85cea721	2018-05-12 15:00:31.002	489	12	f	question	\N	1	5	\N	\N
447	\\x853e6e4dc9986952f2986b24dadf3a065f75c9edff70f7fdd280aad27c021979	2018-05-12 15:00:31.004	501	12	t	question	\N	1	4	\N	\N
448	\\x94aac15a2de1732171ab287b64df839ab9a09c4e2761446918077c384fd80a01	2018-05-12 15:00:41.956	19	1	t	question	\N	1	3	\N	\N
449	\\x73cdf619236c552536e0a1f4655fa621475379f543d808f75de298e65e8d1f3d	2018-05-12 15:00:41.954	33	1	t	question	\N	1	1	\N	\N
450	\\x1f2393eaeb439e71d6dfd3cea2192fd60299c49bf620020c2b14f10fcb4d51cb	2018-05-12 15:00:41.967	102	5	f	question	\N	1	7	\N	\N
451	\\xf7817c13d6fbbe2fdb6c5150d8ce8cfcff2f8f946d0bb3f47655f1bf5c17fbec	2018-05-12 15:00:42.004	65	3	f	question	\N	1	9	\N	\N
452	\\x5799e5ee5c0a531ebdeb28bb3587d69494d9f0e7b7d2822f3f2ada5513f02d8d	2018-05-12 15:00:42.078	52	4	f	question	\N	1	11	\N	\N
453	\\x026e7c41b9faf92803ff46f732bbadaa12b2e4667c40e5d6064ee95cb298f687	2018-05-12 15:00:41.971	293	1	t	question	\N	1	2	\N	\N
454	\\xe3aaebba69d2c390903cc5596f67dc7aac163388eec4a3ab168c37fa85cea721	2018-05-12 15:00:42.007	443	12	f	question	\N	1	5	\N	\N
455	\\x853e6e4dc9986952f2986b24dadf3a065f75c9edff70f7fdd280aad27c021979	2018-05-12 15:00:41.996	467	12	t	question	\N	1	4	\N	\N
456	\\xa8ba8b6fe4698eee286eb80c184edc2e0f94d43014cb3440a3a241b874081ce4	2018-05-12 15:00:53.438	27	7	f	ad-hoc	\N	1	12	\N	\N
457	\\xa33be5de317284f52a58c23ececd67fd22e5dfaa2031e54d937351e9ef9b3536	2018-05-12 15:06:05.155	12	7	t	question	\N	1	12	\N	\N
458	\\x21dccf365b0376a984813d599b75849647c35891784be9c8fb26c510eb3da78b	2018-05-12 15:06:19.63	13	7	t	ad-hoc	\N	1	\N	\N	\N
459	\\x891fd042f48eaa65eb03a971119dc13649a76c411e549641a8eca1e24d3ccb0e	2018-05-12 15:10:54.713	164	0	t	ad-hoc	ERROR: column "c.gender" must appear in the GROUP BY clause or be used in an aggregate function\n  Position: 173	1	\N	\N	\N
460	\\x524b8a6f3f98552f3ead229882ee19b4948464ab0f29eedb4df77b4d752fcb59	2018-05-12 15:11:09.881	174	0	t	ad-hoc	ERROR: column "o.value" must appear in the GROUP BY clause or be used in an aggregate function\n  Position: 185	1	\N	\N	\N
461	\\x21dccf365b0376a984813d599b75849647c35891784be9c8fb26c510eb3da78b	2018-05-12 15:11:14.036	18	7	t	ad-hoc	\N	1	\N	\N	\N
462	\\x21dccf365b0376a984813d599b75849647c35891784be9c8fb26c510eb3da78b	2018-05-12 15:17:52.278	13	11	t	ad-hoc	\N	1	\N	\N	\N
463	\\x94aac15a2de1732171ab287b64df839ab9a09c4e2761446918077c384fd80a01	2018-05-12 15:18:06.72	74	1	t	question	\N	1	3	\N	\N
464	\\x1f2393eaeb439e71d6dfd3cea2192fd60299c49bf620020c2b14f10fcb4d51cb	2018-05-12 15:18:06.711	141	4	f	question	\N	1	7	\N	\N
465	\\x73cdf619236c552536e0a1f4655fa621475379f543d808f75de298e65e8d1f3d	2018-05-12 15:18:06.702	150	1	t	question	\N	1	1	\N	\N
466	\\xf7817c13d6fbbe2fdb6c5150d8ce8cfcff2f8f946d0bb3f47655f1bf5c17fbec	2018-05-12 15:18:06.858	29	2	f	question	\N	1	9	\N	\N
467	\\x5799e5ee5c0a531ebdeb28bb3587d69494d9f0e7b7d2822f3f2ada5513f02d8d	2018-05-12 15:18:06.895	35	4	f	question	\N	1	11	\N	\N
468	\\x026e7c41b9faf92803ff46f732bbadaa12b2e4667c40e5d6064ee95cb298f687	2018-05-12 15:18:06.761	299	1	t	question	\N	1	2	\N	\N
469	\\x853e6e4dc9986952f2986b24dadf3a065f75c9edff70f7fdd280aad27c021979	2018-05-12 15:18:06.7	479	12	t	question	\N	1	4	\N	\N
470	\\xe3aaebba69d2c390903cc5596f67dc7aac163388eec4a3ab168c37fa85cea721	2018-05-12 15:18:06.72	516	12	f	question	\N	1	5	\N	\N
471	\\x21dccf365b0376a984813d599b75849647c35891784be9c8fb26c510eb3da78b	2018-05-12 15:18:14.47	8	11	t	question	\N	1	12	\N	\N
472	\\x21dccf365b0376a984813d599b75849647c35891784be9c8fb26c510eb3da78b	2018-05-12 15:20:31.728	10	11	t	ad-hoc	\N	1	\N	\N	\N
475	\\x1f2393eaeb439e71d6dfd3cea2192fd60299c49bf620020c2b14f10fcb4d51cb	2018-05-12 15:20:40.135	42	4	f	question	\N	1	7	\N	\N
473	\\x94aac15a2de1732171ab287b64df839ab9a09c4e2761446918077c384fd80a01	2018-05-12 15:20:40.074	15	1	t	question	\N	1	3	\N	\N
477	\\x5799e5ee5c0a531ebdeb28bb3587d69494d9f0e7b7d2822f3f2ada5513f02d8d	2018-05-12 15:20:40.154	39	4	f	question	\N	1	11	\N	\N
479	\\xe3aaebba69d2c390903cc5596f67dc7aac163388eec4a3ab168c37fa85cea721	2018-05-12 15:20:40.103	478	12	f	question	\N	1	5	\N	\N
480	\\x853e6e4dc9986952f2986b24dadf3a065f75c9edff70f7fdd280aad27c021979	2018-05-12 15:20:40.102	508	12	t	question	\N	1	4	\N	\N
492	\\x94aac15a2de1732171ab287b64df839ab9a09c4e2761446918077c384fd80a01	2018-05-12 15:35:10.636	123	1	t	question	\N	1	3	\N	\N
494	\\xf7817c13d6fbbe2fdb6c5150d8ce8cfcff2f8f946d0bb3f47655f1bf5c17fbec	2018-05-12 15:35:10.767	100	3	f	question	\N	1	9	\N	\N
495	\\x73cdf619236c552536e0a1f4655fa621475379f543d808f75de298e65e8d1f3d	2018-05-12 15:35:10.633	251	1	t	question	\N	1	1	\N	\N
496	\\x5799e5ee5c0a531ebdeb28bb3587d69494d9f0e7b7d2822f3f2ada5513f02d8d	2018-05-12 15:35:10.844	57	4	f	question	\N	1	11	\N	\N
497	\\x21dccf365b0376a984813d599b75849647c35891784be9c8fb26c510eb3da78b	2018-05-12 15:35:10.873	105	7	t	question	\N	1	12	\N	\N
498	\\x026e7c41b9faf92803ff46f732bbadaa12b2e4667c40e5d6064ee95cb298f687	2018-05-12 15:35:10.663	840	1	t	question	\N	1	2	\N	\N
499	\\x853e6e4dc9986952f2986b24dadf3a065f75c9edff70f7fdd280aad27c021979	2018-05-12 15:35:10.657	1016	12	t	question	\N	1	4	\N	\N
500	\\xe3aaebba69d2c390903cc5596f67dc7aac163388eec4a3ab168c37fa85cea721	2018-05-12 15:35:10.663	1065	12	f	question	\N	1	5	\N	\N
501	\\x753adfc95a052fa5e9a249ee8bc4442e988444954949ac5d76872e8b7675ba66	2018-05-12 15:35:45.148	28	9	t	question	\N	1	10	\N	\N
474	\\x73cdf619236c552536e0a1f4655fa621475379f543d808f75de298e65e8d1f3d	2018-05-12 15:20:40.075	71	1	t	question	\N	1	1	\N	\N
502	\\x21dccf365b0376a984813d599b75849647c35891784be9c8fb26c510eb3da78b	2018-05-12 15:35:50.815	24	7	t	question	\N	1	12	\N	\N
476	\\xf7817c13d6fbbe2fdb6c5150d8ce8cfcff2f8f946d0bb3f47655f1bf5c17fbec	2018-05-12 15:20:40.153	35	2	f	question	\N	1	9	\N	\N
478	\\x026e7c41b9faf92803ff46f732bbadaa12b2e4667c40e5d6064ee95cb298f687	2018-05-12 15:20:40.089	284	1	t	question	\N	1	2	\N	\N
481	\\x21dccf365b0376a984813d599b75849647c35891784be9c8fb26c510eb3da78b	2018-05-12 15:20:40.6	10	11	t	question	\N	1	12	\N	\N
485	\\x1f2393eaeb439e71d6dfd3cea2192fd60299c49bf620020c2b14f10fcb4d51cb	2018-05-12 15:23:06.188	88	4	f	question	\N	1	7	\N	\N
482	\\x21dccf365b0376a984813d599b75849647c35891784be9c8fb26c510eb3da78b	2018-05-12 15:22:30.868	11	11	t	question	\N	1	12	\N	\N
483	\\x94aac15a2de1732171ab287b64df839ab9a09c4e2761446918077c384fd80a01	2018-05-12 15:23:06.162	14	1	t	question	\N	1	3	\N	\N
484	\\x73cdf619236c552536e0a1f4655fa621475379f543d808f75de298e65e8d1f3d	2018-05-12 15:23:06.159	32	1	t	question	\N	1	1	\N	\N
486	\\xf7817c13d6fbbe2fdb6c5150d8ce8cfcff2f8f946d0bb3f47655f1bf5c17fbec	2018-05-12 15:23:06.24	36	2	f	question	\N	1	9	\N	\N
493	\\x1f2393eaeb439e71d6dfd3cea2192fd60299c49bf620020c2b14f10fcb4d51cb	2018-05-12 15:35:10.73	107	5	f	question	\N	1	7	\N	\N
503	\\x21dccf365b0376a984813d599b75849647c35891784be9c8fb26c510eb3da78b	2018-05-12 15:36:27.089	21	7	t	question	\N	1	12	\N	\N
504	\\x21dccf365b0376a984813d599b75849647c35891784be9c8fb26c510eb3da78b	2018-05-12 15:36:32.672	20	7	t	question	\N	1	12	\N	\N
487	\\x21dccf365b0376a984813d599b75849647c35891784be9c8fb26c510eb3da78b	2018-05-12 15:23:06.284	10	11	t	question	\N	1	12	\N	\N
488	\\x5799e5ee5c0a531ebdeb28bb3587d69494d9f0e7b7d2822f3f2ada5513f02d8d	2018-05-12 15:23:06.283	33	4	f	question	\N	1	11	\N	\N
489	\\x026e7c41b9faf92803ff46f732bbadaa12b2e4667c40e5d6064ee95cb298f687	2018-05-12 15:23:06.175	281	1	t	question	\N	1	2	\N	\N
490	\\x853e6e4dc9986952f2986b24dadf3a065f75c9edff70f7fdd280aad27c021979	2018-05-12 15:23:06.151	433	12	t	question	\N	1	4	\N	\N
491	\\xe3aaebba69d2c390903cc5596f67dc7aac163388eec4a3ab168c37fa85cea721	2018-05-12 15:23:06.188	445	12	f	question	\N	1	5	\N	\N
505	\\x94aac15a2de1732171ab287b64df839ab9a09c4e2761446918077c384fd80a01	2018-05-12 15:39:00.162	79	1	t	question	\N	1	3	\N	\N
506	\\x73cdf619236c552536e0a1f4655fa621475379f543d808f75de298e65e8d1f3d	2018-05-12 15:39:00.115	189	1	t	question	\N	1	1	\N	\N
507	\\x1f2393eaeb439e71d6dfd3cea2192fd60299c49bf620020c2b14f10fcb4d51cb	2018-05-12 15:39:00.242	123	5	f	question	\N	1	7	\N	\N
508	\\xf7817c13d6fbbe2fdb6c5150d8ce8cfcff2f8f946d0bb3f47655f1bf5c17fbec	2018-05-12 15:39:00.257	106	3	f	question	\N	1	9	\N	\N
509	\\x5799e5ee5c0a531ebdeb28bb3587d69494d9f0e7b7d2822f3f2ada5513f02d8d	2018-05-12 15:39:00.371	73	4	f	question	\N	1	11	\N	\N
510	\\x21dccf365b0376a984813d599b75849647c35891784be9c8fb26c510eb3da78b	2018-05-12 15:39:00.505	28	12	t	question	\N	1	12	\N	\N
511	\\x026e7c41b9faf92803ff46f732bbadaa12b2e4667c40e5d6064ee95cb298f687	2018-05-12 15:39:00.173	757	1	t	question	\N	1	2	\N	\N
512	\\x853e6e4dc9986952f2986b24dadf3a065f75c9edff70f7fdd280aad27c021979	2018-05-12 15:39:00.166	900	12	t	question	\N	1	4	\N	\N
513	\\xe3aaebba69d2c390903cc5596f67dc7aac163388eec4a3ab168c37fa85cea721	2018-05-12 15:39:00.242	883	12	f	question	\N	1	5	\N	\N
514	\\x853e6e4dc9986952f2986b24dadf3a065f75c9edff70f7fdd280aad27c021979	2018-05-12 18:28:45.861	419	12	t	question	\N	1	4	\N	\N
515	\\x4370cf36abec25622c706a313bbd6dc341b318c9e22b0ce7779b070dc0ed0831	2018-05-12 18:30:17.92	404	162	t	ad-hoc	\N	1	\N	\N	\N
516	\\xfa2a29ee538969e8a42b8b65121d8612cd4d22febfef4d8bd01d60ba5f95c50b	2018-05-12 18:31:53.498	8837	10000	t	ad-hoc	\N	1	\N	\N	\N
517	\\x479c76b9485e3dbb77990915f2e9043712f580f21878c0fafd1a4a079abb0da3	2018-05-12 18:33:25.965	166	0	t	ad-hoc	ERROR: argument of WHERE must be type boolean, not type integer\n  Position: 476	1	\N	\N	\N
518	\\xf5bb35262b14839953ef7fd9e95f6ed9b9756817e0fe3c85edd042da73a69b7e	2018-05-12 18:33:34.581	171	0	t	ad-hoc	ERROR: operator does not exist: integer = boolean\n  Hint: No operator matches the given name and argument type(s). You might need to add explicit type casts.\n  Position: 490	1	\N	\N	\N
519	\\x87acd77e9abf37797873583f0225c1f6a715728a0a04237e19e29cb0ef5a2e18	2018-05-12 18:33:46.732	297	1500	t	ad-hoc	\N	1	\N	\N	\N
520	\\xbb56aeaa1ac4c0b350f87332ab09a7788467c3c22dcc5160e473b9d8cb819959	2018-05-12 18:35:53.627	3731	10000	t	ad-hoc	\N	1	\N	\N	\N
521	\\x12e9b6a3286b4aa1cf0f816bd5ad90931b4018486745db72cb651f4431116b6e	2018-05-12 18:36:29.537	1947	10000	t	ad-hoc	\N	1	\N	\N	\N
522	\\x6dcb470f09e67056cf6da38724e14714faa763329664807379d07da8e52c2f11	2018-05-12 18:37:20.745	162	0	t	ad-hoc	ERROR: column pr.presumptive does not exist\n  Position: 535	1	\N	\N	\N
523	\\x226d8cf1175a49783be6334aa4dbea953c7b9d5d0f0a2018fc8a2820f5fffef3	2018-05-12 18:37:28.568	1656	10000	t	ad-hoc	\N	1	\N	\N	\N
524	\\x4bfa8637452831e87c66f0668642ff57dea623a13ccc5d004ecdc92ad356fa6a	2018-05-12 18:38:16.14	198	0	t	ad-hoc	ERROR: syntax error at or near "CASE"\n  Position: 365	1	\N	\N	\N
525	\\x889aad2d75fa64146c8db540febb2a9e83699e58194a86354a0e883c2072ec0e	2018-05-12 18:38:49	1494	10000	t	ad-hoc	\N	1	\N	\N	\N
526	\\x4f44976960f078230ea99da0cb379cbce70da0ac8f531ab1de8c35c7880fb947	2018-05-12 18:39:04.443	1338	10000	t	ad-hoc	\N	1	\N	\N	\N
527	\\x9544477cb157dd235451292b0b6f77d5d08f0a121afc1b6e8851ce1fcf993cfd	2018-05-12 18:39:41.144	71	1500	t	ad-hoc	\N	1	\N	\N	\N
528	\\xcaf933070e41b4c651fba2be9e3e4dafe16d13bb2b1fb203902fad3af3f88e0a	2018-05-12 18:40:44.86	7142	10000	t	ad-hoc	\N	1	\N	\N	\N
529	\\x75db6a8c4562742785671911886f5a719b152945423f5f278e04eaf4e5991017	2018-05-12 18:41:27.604	197	0	t	ad-hoc	ERROR: argument of AND must be type boolean, not type integer\n  Position: 440	1	\N	\N	\N
530	\\xd76aef6252c39e1791e863afeebd67da9ea1e296dea142a35966a88171390099	2018-05-12 18:41:45.316	300	1500	t	ad-hoc	\N	1	\N	\N	\N
531	\\xd76aef6252c39e1791e863afeebd67da9ea1e296dea142a35966a88171390099	2018-05-12 18:41:51.764	274	1500	t	ad-hoc	\N	1	\N	\N	\N
532	\\xa8984d04aa0831499adf952aa23923b1a76b51482650f1044f6916dcb316dd6f	2018-05-12 18:42:10.714	286	1500	t	ad-hoc	\N	1	\N	\N	\N
533	\\xee5239d4925e3a2dae3734003ed1e4dc85d74fa6b07c1729d0ade059f6b10c26	2018-05-12 18:45:04.531	288	1500	t	ad-hoc	\N	1	\N	\N	\N
534	\\x28f8c0d2a5ca33ba2b8f836520f3f17c048f46a0920d24b9487638b1e8325463	2018-05-12 18:45:48.308	305	1500	t	ad-hoc	\N	1	\N	\N	\N
535	\\xc495cb30ce642ba6c75323b8f242bf2e7a007801865f7315176ec47d6d01b28a	2018-05-12 18:46:50.441	294	1500	t	ad-hoc	\N	1	\N	\N	\N
536	\\xa495ed6a71b7697b05eb19c257ff2e5928ad35a943c5c77d28352daa2065efa8	2018-05-12 18:50:00.797	295	1500	t	ad-hoc	\N	1	\N	\N	\N
537	\\x91da5bbddb7abf7979a119322e7b3d924443bd4c5495f9cba7c5343887055b43	2018-05-12 18:51:39.994	169	0	t	ad-hoc	ERROR: syntax error at or near "addresses"\n  Position: 355	1	\N	\N	\N
538	\\x4532d70b0a38ac917b105b19241aa30303898aef9ac9702ae44ada8241f80b84	2018-05-12 18:52:00.231	322	1500	t	ad-hoc	\N	1	\N	\N	\N
539	\\x8ae80493353081dfbd8d55b348833826cc1a1f13165ed62df29973c3d8daae75	2018-05-12 18:52:14.577	299	1500	t	ad-hoc	\N	1	\N	\N	\N
540	\\xde126e2ad09610414386c9e8e517c899ed8ca75e70ce62d9516bc41bcbdc83fa	2018-05-12 18:53:12.348	329	1500	t	ad-hoc	\N	1	\N	\N	\N
541	\\x2805a292160f8183baf17d032441b24340a6a930a9e414736106df6b80501de7	2018-05-12 18:53:47.341	304	1500	t	ad-hoc	\N	1	\N	\N	\N
542	\\x6e05847cfe924d7651adb3e3b50be5a08d91bc676611be4c37d418fbc310dcfb	2018-05-12 18:54:03.787	164	0	t	ad-hoc	ERROR: operator does not exist: text ->> unknown\n  Hint: No operator matches the given name and argument type(s). You might need to add explicit type casts.\n  Position: 244	1	\N	\N	\N
543	\\x46cf17d1a63c95bc4929ffe3cbac6405dfdfbc68ab48714850bd227baaf43926	2018-05-12 18:54:11.21	172	0	t	ad-hoc	ERROR: malformed array literal: "addressFields"\n  Detail: Array value must start with "{" or dimension information.\n  Position: 229	1	\N	\N	\N
544	\\x1ec8543e542479ce09deab374ce4832f2234cee4705fe2e9ba7110f1894ec90b	2018-05-12 18:54:27.601	306	1500	t	ad-hoc	\N	1	\N	\N	\N
545	\\x877e71cdfa4663cf6d2fe1233b3df009b7aa357915cca8a9f71b793bc5d7b07a	2018-05-12 18:56:06.82	302	1500	t	ad-hoc	\N	1	\N	\N	\N
546	\\x0651eb95dac29bd2d4dcb5740c5282180db865266a7fcf6a379ef6374a4065ce	2018-05-12 18:56:14.652	317	1500	t	ad-hoc	\N	1	\N	\N	\N
547	\\xde526cf2199a8fbb557a5ec2e6988de5043d07ddbb25ee7035f53570f298b2c6	2018-05-12 19:28:41.059	332	1500	t	ad-hoc	\N	1	\N	\N	\N
548	\\xa09a6367872457a766e3af5766d846cda4a7d316a7d9e9cb174a5faa2de20e4a	2018-05-12 19:29:06.776	311	1500	t	ad-hoc	\N	1	\N	\N	\N
549	\\xf0dead72489245e6977db4e30d505892b2be8d20539ed56e0411d97668a51ee4	2018-05-12 19:30:00.024	318	1500	t	ad-hoc	\N	1	\N	\N	\N
550	\\x3f85482ad1eca68de0403f2fd7b92616359e1133d3065928d975f281f8ba5f4f	2018-05-12 19:30:23.513	314	1500	t	ad-hoc	\N	1	\N	\N	\N
551	\\x6261a8007a957539d06884b9865e6e77b0e565c39350a362a71ca3bf3b43cb1b	2018-05-12 19:30:33.286	325	1500	t	ad-hoc	\N	1	\N	\N	\N
552	\\x3faeae7c8b976618951577d0d6b2f099a89f8b501c7392dc10fb54770ec36075	2018-05-12 19:30:52.133	306	1500	t	ad-hoc	\N	1	\N	\N	\N
553	\\x816b99d5a3681e0809ccb472ddbc90e262ec0b52d59d304ee8b00dd03c99107a	2018-05-12 19:31:32.288	182	0	t	ad-hoc	ERROR: syntax error at or near "name"\n  Position: 189	1	\N	\N	\N
554	\\x1f8bd090ee46eab83681a93b1e5d693c4a6e7db448c4d781fcdc44e18e544859	2018-05-12 19:31:38.784	317	1500	t	ad-hoc	\N	1	\N	\N	\N
555	\\x0a227d6979fba4f04b0ead91b56213d5cfcae415cf572ded8f3d8a3f380316a8	2018-05-12 20:29:55.749	371	1500	t	ad-hoc	\N	1	\N	\N	\N
556	\\xac38987462a91d484767ab363161ccc73065ae4374a83ef187e2b3bd68dbd563	2018-05-12 20:30:31.828	396	1500	t	ad-hoc	\N	1	\N	\N	\N
557	\\x56bf3a9080c0368de17184edcbbb9dfad712cd5696316efdafa4b8133ade8d27	2018-05-12 21:15:21.159	267	0	t	ad-hoc	ERROR: syntax error at or near "e"\n  Position: 502	1	\N	\N	\N
558	\\xc7c09217b39d9b238a4162f85df7a0f6f3f2dc2e4c64cf2588f3127ace87d44c	2018-05-12 21:15:27.206	224	0	t	ad-hoc	ERROR: column "year" does not exist\n  Position: 458	1	\N	\N	\N
559	\\x7e001f2fa3467276c15e399a89014281fcf1f5c0d6730627439b9ffeee79d465	2018-05-12 21:15:39.461	199	0	t	ad-hoc	ERROR: function datediff(unknown, timestamp without time zone, timestamp without time zone) does not exist\n  Hint: No function matches the given name and argument types. You might need to add explicit type casts.\n  Position: 449	1	\N	\N	\N
560	\\xa9dd4995bc62e082c4342c65c7d89d79c492de4114e00d89ca5f86795994c372	2018-05-12 21:17:32.795	443	1500	t	ad-hoc	\N	1	\N	\N	\N
561	\\x4cb00a09440c5f372192c09d9b7f2e9ced627bd3792eb2670b40381a1be5396b	2018-05-12 21:17:55.299	224	0	t	ad-hoc	ERROR: column e.birthdate does not exist\n  Hint: Perhaps you meant to reference the column "c.birthdate".\n  Position: 467	1	\N	\N	\N
562	\\xa798ac87bcec471969b7c7125ae3ee97ce20c6febfb8f87f941ce47d66817daa	2018-05-12 21:18:07.455	363	1500	t	ad-hoc	\N	1	\N	\N	\N
563	\\xa9dd4995bc62e082c4342c65c7d89d79c492de4114e00d89ca5f86795994c372	2018-05-12 21:18:21.281	399	1500	t	ad-hoc	\N	1	\N	\N	\N
564	\\xdec74db9194353a9bfd039b0fdbf20dbf999ab7a9c228dd83dc7c400b6e7e59a	2018-05-12 21:18:57.173	241	0	t	ad-hoc	ERROR: syntax error at or near "dob_age"\n  Position: 539	1	\N	\N	\N
565	\\x1f35aea575b6a2d7bd7b4d189ebabf2e8d51d01abcbfa9e226b907a0836ac2af	2018-05-12 21:19:03.361	359	1500	t	ad-hoc	\N	1	\N	\N	\N
566	\\x50d08631629d3213fdb4c77bc152d05682a0fb7634a11fc2797f594018b8b70a	2018-05-12 21:19:49.955	363	1500	t	ad-hoc	\N	1	\N	\N	\N
567	\\x54862d22bcb68901eb371b8e9e536647dadd30c3796f0a9872c28815a6c19edc	2018-05-12 21:20:07.464	391	1500	t	ad-hoc	\N	1	\N	\N	\N
568	\\x94aac15a2de1732171ab287b64df839ab9a09c4e2761446918077c384fd80a01	2018-05-22 09:41:11.966	678	1	t	question	\N	1	3	\N	\N
569	\\x1f2393eaeb439e71d6dfd3cea2192fd60299c49bf620020c2b14f10fcb4d51cb	2018-05-22 09:41:12.218	459	5	f	question	\N	1	7	\N	\N
570	\\xf7817c13d6fbbe2fdb6c5150d8ce8cfcff2f8f946d0bb3f47655f1bf5c17fbec	2018-05-22 09:41:12.74	69	3	f	question	\N	1	9	\N	\N
571	\\x5799e5ee5c0a531ebdeb28bb3587d69494d9f0e7b7d2822f3f2ada5513f02d8d	2018-05-22 09:41:12.736	105	4	f	question	\N	1	11	\N	\N
572	\\x73cdf619236c552536e0a1f4655fa621475379f543d808f75de298e65e8d1f3d	2018-05-22 09:41:11.964	913	1	t	question	\N	1	1	\N	\N
573	\\x21dccf365b0376a984813d599b75849647c35891784be9c8fb26c510eb3da78b	2018-05-22 09:41:12.825	83	12	t	question	\N	1	12	\N	\N
574	\\x026e7c41b9faf92803ff46f732bbadaa12b2e4667c40e5d6064ee95cb298f687	2018-05-22 09:41:11.972	1812	1	t	question	\N	1	2	\N	\N
575	\\x853e6e4dc9986952f2986b24dadf3a065f75c9edff70f7fdd280aad27c021979	2018-05-22 09:41:11.976	1942	12	t	question	\N	1	4	\N	\N
576	\\xe3aaebba69d2c390903cc5596f67dc7aac163388eec4a3ab168c37fa85cea721	2018-05-22 09:41:11.973	1974	12	f	question	\N	1	5	\N	\N
577	\\xbaf1b6778a4c60bcdbbd959deb8e4123d813c9e65fc697d3723fb2397f048acb	2018-05-22 09:42:39.053	64	70	f	ad-hoc	\N	1	6	\N	\N
578	\\x94aac15a2de1732171ab287b64df839ab9a09c4e2761446918077c384fd80a01	2018-05-22 09:43:26.374	154	1	t	question	\N	1	3	\N	\N
579	\\x1f2393eaeb439e71d6dfd3cea2192fd60299c49bf620020c2b14f10fcb4d51cb	2018-05-22 09:43:26.393	141	5	f	question	\N	1	7	\N	\N
580	\\x5799e5ee5c0a531ebdeb28bb3587d69494d9f0e7b7d2822f3f2ada5513f02d8d	2018-05-22 09:43:26.552	92	4	f	question	\N	1	11	\N	\N
581	\\xf7817c13d6fbbe2fdb6c5150d8ce8cfcff2f8f946d0bb3f47655f1bf5c17fbec	2018-05-22 09:43:26.601	74	3	f	question	\N	1	9	\N	\N
582	\\x21dccf365b0376a984813d599b75849647c35891784be9c8fb26c510eb3da78b	2018-05-22 09:43:26.659	34	12	t	question	\N	1	12	\N	\N
583	\\x73cdf619236c552536e0a1f4655fa621475379f543d808f75de298e65e8d1f3d	2018-05-22 09:43:26.383	350	1	t	question	\N	1	1	\N	\N
584	\\x026e7c41b9faf92803ff46f732bbadaa12b2e4667c40e5d6064ee95cb298f687	2018-05-22 09:43:26.442	844	1	t	question	\N	1	2	\N	\N
585	\\x853e6e4dc9986952f2986b24dadf3a065f75c9edff70f7fdd280aad27c021979	2018-05-22 09:43:26.4	1019	12	t	question	\N	1	4	\N	\N
586	\\xe3aaebba69d2c390903cc5596f67dc7aac163388eec4a3ab168c37fa85cea721	2018-05-22 09:43:26.479	944	12	f	question	\N	1	5	\N	\N
587	\\x94aac15a2de1732171ab287b64df839ab9a09c4e2761446918077c384fd80a01	2018-05-22 09:52:31.338	35	1	t	question	\N	1	3	\N	\N
588	\\x73cdf619236c552536e0a1f4655fa621475379f543d808f75de298e65e8d1f3d	2018-05-22 09:52:31.335	188	1	t	question	\N	1	1	\N	\N
589	\\xf7817c13d6fbbe2fdb6c5150d8ce8cfcff2f8f946d0bb3f47655f1bf5c17fbec	2018-05-22 09:52:31.524	89	3	f	question	\N	1	9	\N	\N
590	\\x1f2393eaeb439e71d6dfd3cea2192fd60299c49bf620020c2b14f10fcb4d51cb	2018-05-22 09:52:31.472	150	5	f	question	\N	1	7	\N	\N
591	\\x5799e5ee5c0a531ebdeb28bb3587d69494d9f0e7b7d2822f3f2ada5513f02d8d	2018-05-22 09:52:31.562	85	4	f	question	\N	1	11	\N	\N
592	\\x21dccf365b0376a984813d599b75849647c35891784be9c8fb26c510eb3da78b	2018-05-22 09:52:31.64	33	12	t	question	\N	1	12	\N	\N
593	\\x026e7c41b9faf92803ff46f732bbadaa12b2e4667c40e5d6064ee95cb298f687	2018-05-22 09:52:31.353	993	1	t	question	\N	1	2	\N	\N
594	\\x853e6e4dc9986952f2986b24dadf3a065f75c9edff70f7fdd280aad27c021979	2018-05-22 09:52:31.356	1131	12	t	question	\N	1	4	\N	\N
595	\\xe3aaebba69d2c390903cc5596f67dc7aac163388eec4a3ab168c37fa85cea721	2018-05-22 09:52:31.392	1102	12	f	question	\N	1	5	\N	\N
596	\\x54862d22bcb68901eb371b8e9e536647dadd30c3796f0a9872c28815a6c19edc	2018-05-22 11:49:15.276	705	1500	t	question	\N	1	13	\N	\N
597	\\x54862d22bcb68901eb371b8e9e536647dadd30c3796f0a9872c28815a6c19edc	2018-05-22 11:50:18.322	337	1500	t	question	\N	1	13	\N	\N
599	\\x1f2393eaeb439e71d6dfd3cea2192fd60299c49bf620020c2b14f10fcb4d51cb	2018-05-24 18:53:25.989	462	5	f	question	\N	1	7	\N	\N
598	\\x94aac15a2de1732171ab287b64df839ab9a09c4e2761446918077c384fd80a01	2018-05-24 18:53:25.689	762	1	t	question	\N	1	3	\N	\N
600	\\x73cdf619236c552536e0a1f4655fa621475379f543d808f75de298e65e8d1f3d	2018-05-24 18:53:25.7	832	1	t	question	\N	1	1	\N	\N
601	\\xf7817c13d6fbbe2fdb6c5150d8ce8cfcff2f8f946d0bb3f47655f1bf5c17fbec	2018-05-24 18:53:26.639	101	3	f	question	\N	1	9	\N	\N
602	\\x5799e5ee5c0a531ebdeb28bb3587d69494d9f0e7b7d2822f3f2ada5513f02d8d	2018-05-24 18:53:26.721	93	4	f	question	\N	1	11	\N	\N
603	\\x21dccf365b0376a984813d599b75849647c35891784be9c8fb26c510eb3da78b	2018-05-24 18:53:26.715	181	12	t	question	\N	1	12	\N	\N
604	\\x026e7c41b9faf92803ff46f732bbadaa12b2e4667c40e5d6064ee95cb298f687	2018-05-24 18:53:25.694	2017	1	t	question	\N	1	2	\N	\N
605	\\xe3aaebba69d2c390903cc5596f67dc7aac163388eec4a3ab168c37fa85cea721	2018-05-24 18:53:25.737	2190	12	f	question	\N	1	5	\N	\N
606	\\x853e6e4dc9986952f2986b24dadf3a065f75c9edff70f7fdd280aad27c021979	2018-05-24 18:53:25.73	2233	12	t	question	\N	1	4	\N	\N
607	\\x94aac15a2de1732171ab287b64df839ab9a09c4e2761446918077c384fd80a01	2018-05-24 18:58:14.871	106	1	t	question	\N	1	3	\N	\N
608	\\x73cdf619236c552536e0a1f4655fa621475379f543d808f75de298e65e8d1f3d	2018-05-24 18:58:14.881	165	1	t	question	\N	1	1	\N	\N
609	\\x1f2393eaeb439e71d6dfd3cea2192fd60299c49bf620020c2b14f10fcb4d51cb	2018-05-24 18:58:15.049	135	5	f	question	\N	1	7	\N	\N
610	\\xf7817c13d6fbbe2fdb6c5150d8ce8cfcff2f8f946d0bb3f47655f1bf5c17fbec	2018-05-24 18:58:15.05	134	3	f	question	\N	1	9	\N	\N
611	\\x21dccf365b0376a984813d599b75849647c35891784be9c8fb26c510eb3da78b	2018-05-24 18:58:15.214	83	12	t	question	\N	1	12	\N	\N
612	\\x5799e5ee5c0a531ebdeb28bb3587d69494d9f0e7b7d2822f3f2ada5513f02d8d	2018-05-24 18:58:15.2	105	4	f	question	\N	1	11	\N	\N
613	\\x026e7c41b9faf92803ff46f732bbadaa12b2e4667c40e5d6064ee95cb298f687	2018-05-24 18:58:14.907	930	1	t	question	\N	1	2	\N	\N
614	\\x853e6e4dc9986952f2986b24dadf3a065f75c9edff70f7fdd280aad27c021979	2018-05-24 18:58:14.886	1093	12	t	question	\N	1	4	\N	\N
615	\\xe3aaebba69d2c390903cc5596f67dc7aac163388eec4a3ab168c37fa85cea721	2018-05-24 18:58:14.883	1147	12	f	question	\N	1	5	\N	\N
616	\\x94aac15a2de1732171ab287b64df839ab9a09c4e2761446918077c384fd80a01	2018-05-25 06:54:01.538	118	1	t	question	\N	1	3	\N	\N
617	\\x1f2393eaeb439e71d6dfd3cea2192fd60299c49bf620020c2b14f10fcb4d51cb	2018-05-25 06:54:01.549	117	5	f	question	\N	1	7	\N	\N
618	\\x73cdf619236c552536e0a1f4655fa621475379f543d808f75de298e65e8d1f3d	2018-05-25 06:54:01.391	275	1	t	question	\N	1	1	\N	\N
619	\\xf7817c13d6fbbe2fdb6c5150d8ce8cfcff2f8f946d0bb3f47655f1bf5c17fbec	2018-05-25 06:54:01.93	65	3	f	question	\N	1	9	\N	\N
620	\\x5799e5ee5c0a531ebdeb28bb3587d69494d9f0e7b7d2822f3f2ada5513f02d8d	2018-05-25 06:54:01.933	145	4	f	question	\N	1	11	\N	\N
621	\\x21dccf365b0376a984813d599b75849647c35891784be9c8fb26c510eb3da78b	2018-05-25 06:54:02.008	99	12	t	question	\N	1	12	\N	\N
622	\\x026e7c41b9faf92803ff46f732bbadaa12b2e4667c40e5d6064ee95cb298f687	2018-05-25 06:54:01.426	1213	1	t	question	\N	1	2	\N	\N
623	\\x853e6e4dc9986952f2986b24dadf3a065f75c9edff70f7fdd280aad27c021979	2018-05-25 06:54:01.538	1296	12	t	question	\N	1	4	\N	\N
624	\\xe3aaebba69d2c390903cc5596f67dc7aac163388eec4a3ab168c37fa85cea721	2018-05-25 06:54:01.429	1408	12	f	question	\N	1	5	\N	\N
625	\\x94aac15a2de1732171ab287b64df839ab9a09c4e2761446918077c384fd80a01	2018-05-25 06:55:25.659	26	1	t	public-dashboard	\N	\N	3	1	\N
626	\\xf7817c13d6fbbe2fdb6c5150d8ce8cfcff2f8f946d0bb3f47655f1bf5c17fbec	2018-05-25 06:55:25.77	67	3	f	public-dashboard	\N	\N	9	1	\N
627	\\x1f2393eaeb439e71d6dfd3cea2192fd60299c49bf620020c2b14f10fcb4d51cb	2018-05-25 06:55:25.818	65	5	f	public-dashboard	\N	\N	7	1	\N
628	\\x21dccf365b0376a984813d599b75849647c35891784be9c8fb26c510eb3da78b	2018-05-25 06:55:25.894	39	12	t	public-dashboard	\N	\N	12	1	\N
629	\\x5799e5ee5c0a531ebdeb28bb3587d69494d9f0e7b7d2822f3f2ada5513f02d8d	2018-05-25 06:55:25.863	74	4	f	public-dashboard	\N	\N	11	1	\N
630	\\x73cdf619236c552536e0a1f4655fa621475379f543d808f75de298e65e8d1f3d	2018-05-25 06:55:25.703	270	1	t	public-dashboard	\N	\N	1	1	\N
631	\\x026e7c41b9faf92803ff46f732bbadaa12b2e4667c40e5d6064ee95cb298f687	2018-05-25 06:55:25.667	821	1	t	public-dashboard	\N	\N	2	1	\N
632	\\xe3aaebba69d2c390903cc5596f67dc7aac163388eec4a3ab168c37fa85cea721	2018-05-25 06:55:25.75	904	12	f	public-dashboard	\N	\N	5	1	\N
633	\\x853e6e4dc9986952f2986b24dadf3a065f75c9edff70f7fdd280aad27c021979	2018-05-25 06:55:25.731	935	12	t	public-dashboard	\N	\N	4	1	\N
634	\\x94aac15a2de1732171ab287b64df839ab9a09c4e2761446918077c384fd80a01	2018-05-25 06:57:36.488	30	1	t	question	\N	1	3	\N	\N
635	\\x1f2393eaeb439e71d6dfd3cea2192fd60299c49bf620020c2b14f10fcb4d51cb	2018-05-25 06:57:36.541	60	5	f	question	\N	1	7	\N	\N
636	\\xf7817c13d6fbbe2fdb6c5150d8ce8cfcff2f8f946d0bb3f47655f1bf5c17fbec	2018-05-25 06:57:36.598	56	3	f	question	\N	1	9	\N	\N
637	\\x5799e5ee5c0a531ebdeb28bb3587d69494d9f0e7b7d2822f3f2ada5513f02d8d	2018-05-25 06:57:36.614	78	4	f	question	\N	1	11	\N	\N
647	\\x1f2393eaeb439e71d6dfd3cea2192fd60299c49bf620020c2b14f10fcb4d51cb	2018-05-25 07:00:52.453	77	5	f	public-dashboard	\N	\N	7	1	\N
638	\\x21dccf365b0376a984813d599b75849647c35891784be9c8fb26c510eb3da78b	2018-05-25 06:57:36.665	29	12	t	question	\N	1	12	\N	\N
639	\\x73cdf619236c552536e0a1f4655fa621475379f543d808f75de298e65e8d1f3d	2018-05-25 06:57:36.463	253	1	t	question	\N	1	1	\N	\N
640	\\x026e7c41b9faf92803ff46f732bbadaa12b2e4667c40e5d6064ee95cb298f687	2018-05-25 06:57:36.487	799	1	t	question	\N	1	2	\N	\N
641	\\x853e6e4dc9986952f2986b24dadf3a065f75c9edff70f7fdd280aad27c021979	2018-05-25 06:57:36.484	893	12	t	question	\N	1	4	\N	\N
642	\\xe3aaebba69d2c390903cc5596f67dc7aac163388eec4a3ab168c37fa85cea721	2018-05-25 06:57:36.487	972	12	f	question	\N	1	5	\N	\N
643	\\x94aac15a2de1732171ab287b64df839ab9a09c4e2761446918077c384fd80a01	2018-05-25 07:00:52.006	83	1	t	public-dashboard	\N	\N	3	1	\N
644	\\x73cdf619236c552536e0a1f4655fa621475379f543d808f75de298e65e8d1f3d	2018-05-25 07:00:52.043	225	1	t	public-dashboard	\N	\N	1	1	\N
645	\\xf7817c13d6fbbe2fdb6c5150d8ce8cfcff2f8f946d0bb3f47655f1bf5c17fbec	2018-05-25 07:00:52.27	230	3	f	public-dashboard	\N	\N	9	1	\N
649	\\x026e7c41b9faf92803ff46f732bbadaa12b2e4667c40e5d6064ee95cb298f687	2018-05-25 07:00:52.029	1013	1	t	public-dashboard	\N	\N	2	1	\N
650	\\xe3aaebba69d2c390903cc5596f67dc7aac163388eec4a3ab168c37fa85cea721	2018-05-25 07:00:52.078	1139	12	f	public-dashboard	\N	\N	5	1	\N
651	\\x853e6e4dc9986952f2986b24dadf3a065f75c9edff70f7fdd280aad27c021979	2018-05-25 07:00:52.109	1114	12	t	public-dashboard	\N	\N	4	1	\N
667	\\x026e7c41b9faf92803ff46f732bbadaa12b2e4667c40e5d6064ee95cb298f687	2018-05-25 07:08:17.815	807	1	t	public-dashboard	\N	\N	2	1	\N
668	\\x853e6e4dc9986952f2986b24dadf3a065f75c9edff70f7fdd280aad27c021979	2018-05-25 07:08:17.902	879	12	t	public-dashboard	\N	\N	4	1	\N
669	\\xe3aaebba69d2c390903cc5596f67dc7aac163388eec4a3ab168c37fa85cea721	2018-05-25 07:08:17.882	909	12	f	public-dashboard	\N	\N	5	1	\N
646	\\x5799e5ee5c0a531ebdeb28bb3587d69494d9f0e7b7d2822f3f2ada5513f02d8d	2018-05-25 07:00:52.45	77	4	f	public-dashboard	\N	\N	11	1	\N
648	\\x21dccf365b0376a984813d599b75849647c35891784be9c8fb26c510eb3da78b	2018-05-25 07:00:52.512	26	12	t	public-dashboard	\N	\N	12	1	\N
652	\\x94aac15a2de1732171ab287b64df839ab9a09c4e2761446918077c384fd80a01	2018-05-25 07:05:25.209	24	1	t	public-dashboard	\N	\N	3	1	\N
653	\\x73cdf619236c552536e0a1f4655fa621475379f543d808f75de298e65e8d1f3d	2018-05-25 07:05:25.235	197	1	t	public-dashboard	\N	\N	1	1	\N
654	\\x21dccf365b0376a984813d599b75849647c35891784be9c8fb26c510eb3da78b	2018-05-25 07:05:25.53	37	12	t	public-dashboard	\N	\N	12	1	\N
655	\\x1f2393eaeb439e71d6dfd3cea2192fd60299c49bf620020c2b14f10fcb4d51cb	2018-05-25 07:05:25.433	155	5	f	public-dashboard	\N	\N	7	1	\N
657	\\xf7817c13d6fbbe2fdb6c5150d8ce8cfcff2f8f946d0bb3f47655f1bf5c17fbec	2018-05-25 07:05:25.58	49	3	f	public-dashboard	\N	\N	9	1	\N
658	\\x026e7c41b9faf92803ff46f732bbadaa12b2e4667c40e5d6064ee95cb298f687	2018-05-25 07:05:25.218	787	1	t	public-dashboard	\N	\N	2	1	\N
659	\\x853e6e4dc9986952f2986b24dadf3a065f75c9edff70f7fdd280aad27c021979	2018-05-25 07:05:25.307	847	12	t	public-dashboard	\N	\N	4	1	\N
660	\\xe3aaebba69d2c390903cc5596f67dc7aac163388eec4a3ab168c37fa85cea721	2018-05-25 07:05:25.295	896	12	f	public-dashboard	\N	\N	5	1	\N
661	\\x94aac15a2de1732171ab287b64df839ab9a09c4e2761446918077c384fd80a01	2018-05-25 07:08:17.79	27	1	t	public-dashboard	\N	\N	3	1	\N
663	\\x21dccf365b0376a984813d599b75849647c35891784be9c8fb26c510eb3da78b	2018-05-25 07:08:18.067	29	12	t	public-dashboard	\N	\N	12	1	\N
664	\\xf7817c13d6fbbe2fdb6c5150d8ce8cfcff2f8f946d0bb3f47655f1bf5c17fbec	2018-05-25 07:08:18.03	84	3	f	public-dashboard	\N	\N	9	1	\N
665	\\x1f2393eaeb439e71d6dfd3cea2192fd60299c49bf620020c2b14f10fcb4d51cb	2018-05-25 07:08:18.027	94	5	f	public-dashboard	\N	\N	7	1	\N
666	\\x5799e5ee5c0a531ebdeb28bb3587d69494d9f0e7b7d2822f3f2ada5513f02d8d	2018-05-25 07:08:18.104	96	4	f	public-dashboard	\N	\N	11	1	\N
670	\\x94aac15a2de1732171ab287b64df839ab9a09c4e2761446918077c384fd80a01	2018-05-25 07:09:11.072	24	1	t	public-dashboard	\N	\N	3	1	\N
671	\\x73cdf619236c552536e0a1f4655fa621475379f543d808f75de298e65e8d1f3d	2018-05-25 07:09:11.099	349	1	t	public-dashboard	\N	\N	1	1	\N
672	\\x1f2393eaeb439e71d6dfd3cea2192fd60299c49bf620020c2b14f10fcb4d51cb	2018-05-25 07:09:11.181	300	5	f	public-dashboard	\N	\N	7	1	\N
673	\\xf7817c13d6fbbe2fdb6c5150d8ce8cfcff2f8f946d0bb3f47655f1bf5c17fbec	2018-05-25 07:09:11.197	295	3	f	public-dashboard	\N	\N	9	1	\N
674	\\x21dccf365b0376a984813d599b75849647c35891784be9c8fb26c510eb3da78b	2018-05-25 07:09:11.458	57	12	t	public-dashboard	\N	\N	12	1	\N
680	\\x1f2393eaeb439e71d6dfd3cea2192fd60299c49bf620020c2b14f10fcb4d51cb	2018-05-25 07:09:51.122	57	5	f	public-dashboard	\N	\N	7	1	\N
681	\\xf7817c13d6fbbe2fdb6c5150d8ce8cfcff2f8f946d0bb3f47655f1bf5c17fbec	2018-05-25 07:09:51.14	51	3	f	public-dashboard	\N	\N	9	1	\N
682	\\x21dccf365b0376a984813d599b75849647c35891784be9c8fb26c510eb3da78b	2018-05-25 07:09:51.221	28	12	t	public-dashboard	\N	\N	12	1	\N
683	\\x73cdf619236c552536e0a1f4655fa621475379f543d808f75de298e65e8d1f3d	2018-05-25 07:09:51.054	229	1	t	public-dashboard	\N	\N	1	1	\N
684	\\x5799e5ee5c0a531ebdeb28bb3587d69494d9f0e7b7d2822f3f2ada5513f02d8d	2018-05-25 07:09:51.234	99	4	f	public-dashboard	\N	\N	11	1	\N
685	\\x026e7c41b9faf92803ff46f732bbadaa12b2e4667c40e5d6064ee95cb298f687	2018-05-25 07:09:51.037	829	1	t	public-dashboard	\N	\N	2	1	\N
686	\\xe3aaebba69d2c390903cc5596f67dc7aac163388eec4a3ab168c37fa85cea721	2018-05-25 07:09:51.072	940	12	f	public-dashboard	\N	\N	5	1	\N
687	\\x853e6e4dc9986952f2986b24dadf3a065f75c9edff70f7fdd280aad27c021979	2018-05-25 07:09:51.09	942	12	t	public-dashboard	\N	\N	4	1	\N
688	\\x94aac15a2de1732171ab287b64df839ab9a09c4e2761446918077c384fd80a01	2018-05-25 07:10:19.973	21	1	t	public-dashboard	\N	\N	3	1	\N
689	\\x1f2393eaeb439e71d6dfd3cea2192fd60299c49bf620020c2b14f10fcb4d51cb	2018-05-25 07:10:20.062	55	5	f	public-dashboard	\N	\N	7	1	\N
690	\\x73cdf619236c552536e0a1f4655fa621475379f543d808f75de298e65e8d1f3d	2018-05-25 07:10:19.989	176	1	t	public-dashboard	\N	\N	1	1	\N
691	\\x21dccf365b0376a984813d599b75849647c35891784be9c8fb26c510eb3da78b	2018-05-25 07:10:20.168	28	12	t	public-dashboard	\N	\N	12	1	\N
692	\\xf7817c13d6fbbe2fdb6c5150d8ce8cfcff2f8f946d0bb3f47655f1bf5c17fbec	2018-05-25 07:10:20.118	99	3	f	public-dashboard	\N	\N	9	1	\N
693	\\x5799e5ee5c0a531ebdeb28bb3587d69494d9f0e7b7d2822f3f2ada5513f02d8d	2018-05-25 07:10:20.173	91	4	f	public-dashboard	\N	\N	11	1	\N
694	\\x026e7c41b9faf92803ff46f732bbadaa12b2e4667c40e5d6064ee95cb298f687	2018-05-25 07:10:19.981	809	1	t	public-dashboard	\N	\N	2	1	\N
695	\\xe3aaebba69d2c390903cc5596f67dc7aac163388eec4a3ab168c37fa85cea721	2018-05-25 07:10:20.015	881	12	f	public-dashboard	\N	\N	5	1	\N
696	\\x853e6e4dc9986952f2986b24dadf3a065f75c9edff70f7fdd280aad27c021979	2018-05-25 07:10:20.038	887	12	t	public-dashboard	\N	\N	4	1	\N
656	\\x5799e5ee5c0a531ebdeb28bb3587d69494d9f0e7b7d2822f3f2ada5513f02d8d	2018-05-25 07:05:25.53	82	4	f	public-dashboard	\N	\N	11	1	\N
662	\\x73cdf619236c552536e0a1f4655fa621475379f543d808f75de298e65e8d1f3d	2018-05-25 07:08:17.849	178	1	t	public-dashboard	\N	\N	1	1	\N
675	\\x5799e5ee5c0a531ebdeb28bb3587d69494d9f0e7b7d2822f3f2ada5513f02d8d	2018-05-25 07:09:11.497	71	4	f	public-dashboard	\N	\N	11	1	\N
676	\\x026e7c41b9faf92803ff46f732bbadaa12b2e4667c40e5d6064ee95cb298f687	2018-05-25 07:09:11.083	925	1	t	public-dashboard	\N	\N	2	1	\N
677	\\x853e6e4dc9986952f2986b24dadf3a065f75c9edff70f7fdd280aad27c021979	2018-05-25 07:09:11.146	997	12	t	public-dashboard	\N	\N	4	1	\N
678	\\xe3aaebba69d2c390903cc5596f67dc7aac163388eec4a3ab168c37fa85cea721	2018-05-25 07:09:11.126	1048	12	f	public-dashboard	\N	\N	5	1	\N
679	\\x94aac15a2de1732171ab287b64df839ab9a09c4e2761446918077c384fd80a01	2018-05-25 07:09:51.024	24	1	t	public-dashboard	\N	\N	3	1	\N
697	\\x94aac15a2de1732171ab287b64df839ab9a09c4e2761446918077c384fd80a01	2018-05-25 18:19:10.025	1235	1	t	question	\N	1	3	\N	\N
698	\\x1f2393eaeb439e71d6dfd3cea2192fd60299c49bf620020c2b14f10fcb4d51cb	2018-05-25 18:19:10.515	745	5	f	question	\N	1	7	\N	\N
699	\\x5799e5ee5c0a531ebdeb28bb3587d69494d9f0e7b7d2822f3f2ada5513f02d8d	2018-05-25 18:19:11.374	139	4	f	question	\N	1	11	\N	\N
700	\\xf7817c13d6fbbe2fdb6c5150d8ce8cfcff2f8f946d0bb3f47655f1bf5c17fbec	2018-05-25 18:19:11.364	149	3	f	question	\N	1	9	\N	\N
701	\\x73cdf619236c552536e0a1f4655fa621475379f543d808f75de298e65e8d1f3d	2018-05-25 18:19:10.03	1558	1	t	question	\N	1	1	\N	\N
702	\\x21dccf365b0376a984813d599b75849647c35891784be9c8fb26c510eb3da78b	2018-05-25 18:19:11.542	65	12	t	question	\N	1	12	\N	\N
703	\\x026e7c41b9faf92803ff46f732bbadaa12b2e4667c40e5d6064ee95cb298f687	2018-05-25 18:19:10.01	2082	1	t	question	\N	1	2	\N	\N
704	\\x853e6e4dc9986952f2986b24dadf3a065f75c9edff70f7fdd280aad27c021979	2018-05-25 18:19:10.056	2218	12	t	question	\N	1	4	\N	\N
705	\\xe3aaebba69d2c390903cc5596f67dc7aac163388eec4a3ab168c37fa85cea721	2018-05-25 18:19:10.057	2223	12	f	question	\N	1	5	\N	\N
706	\\x54862d22bcb68901eb371b8e9e536647dadd30c3796f0a9872c28815a6c19edc	2018-05-25 18:19:20.603	695	1500	t	question	\N	1	13	\N	\N
707	\\x94aac15a2de1732171ab287b64df839ab9a09c4e2761446918077c384fd80a01	2018-05-25 18:32:52.364	70	1	t	public-dashboard	\N	1	3	1	\N
708	\\x73cdf619236c552536e0a1f4655fa621475379f543d808f75de298e65e8d1f3d	2018-05-25 18:32:52.416	185	1	t	public-dashboard	\N	1	1	1	\N
709	\\xf7817c13d6fbbe2fdb6c5150d8ce8cfcff2f8f946d0bb3f47655f1bf5c17fbec	2018-05-25 18:32:52.716	136	3	f	public-dashboard	\N	1	9	1	\N
710	\\x1f2393eaeb439e71d6dfd3cea2192fd60299c49bf620020c2b14f10fcb4d51cb	2018-05-25 18:32:52.666	192	5	f	public-dashboard	\N	1	7	1	\N
711	\\x21dccf365b0376a984813d599b75849647c35891784be9c8fb26c510eb3da78b	2018-05-25 18:32:52.836	34	12	t	public-dashboard	\N	1	12	1	\N
712	\\x5799e5ee5c0a531ebdeb28bb3587d69494d9f0e7b7d2822f3f2ada5513f02d8d	2018-05-25 18:32:52.893	82	4	f	public-dashboard	\N	1	11	1	\N
713	\\x026e7c41b9faf92803ff46f732bbadaa12b2e4667c40e5d6064ee95cb298f687	2018-05-25 18:32:52.371	1086	1	t	public-dashboard	\N	1	2	1	\N
714	\\xe3aaebba69d2c390903cc5596f67dc7aac163388eec4a3ab168c37fa85cea721	2018-05-25 18:32:52.453	1162	12	f	public-dashboard	\N	1	5	1	\N
715	\\x853e6e4dc9986952f2986b24dadf3a065f75c9edff70f7fdd280aad27c021979	2018-05-25 18:32:52.516	1217	12	t	public-dashboard	\N	1	4	1	\N
716	\\x94aac15a2de1732171ab287b64df839ab9a09c4e2761446918077c384fd80a01	2018-05-25 18:34:03.278	28	1	t	question	\N	1	3	\N	\N
717	\\x73cdf619236c552536e0a1f4655fa621475379f543d808f75de298e65e8d1f3d	2018-05-25 18:34:03.249	230	1	t	question	\N	1	1	\N	\N
718	\\x1f2393eaeb439e71d6dfd3cea2192fd60299c49bf620020c2b14f10fcb4d51cb	2018-05-25 18:34:03.307	175	5	f	question	\N	1	7	\N	\N
719	\\x21dccf365b0376a984813d599b75849647c35891784be9c8fb26c510eb3da78b	2018-05-25 18:34:03.53	36	12	t	question	\N	1	12	\N	\N
720	\\xf7817c13d6fbbe2fdb6c5150d8ce8cfcff2f8f946d0bb3f47655f1bf5c17fbec	2018-05-25 18:34:03.519	79	3	f	question	\N	1	9	\N	\N
721	\\x5799e5ee5c0a531ebdeb28bb3587d69494d9f0e7b7d2822f3f2ada5513f02d8d	2018-05-25 18:34:03.53	125	4	f	question	\N	1	11	\N	\N
722	\\x026e7c41b9faf92803ff46f732bbadaa12b2e4667c40e5d6064ee95cb298f687	2018-05-25 18:34:03.262	902	1	t	question	\N	1	2	\N	\N
723	\\xe3aaebba69d2c390903cc5596f67dc7aac163388eec4a3ab168c37fa85cea721	2018-05-25 18:34:03.343	949	12	f	question	\N	1	5	\N	\N
724	\\x853e6e4dc9986952f2986b24dadf3a065f75c9edff70f7fdd280aad27c021979	2018-05-25 18:34:03.342	966	12	t	question	\N	1	4	\N	\N
725	\\x94aac15a2de1732171ab287b64df839ab9a09c4e2761446918077c384fd80a01	2018-05-25 18:34:08.448	30	1	t	question	\N	1	3	\N	\N
726	\\x73cdf619236c552536e0a1f4655fa621475379f543d808f75de298e65e8d1f3d	2018-05-25 18:34:08.431	183	1	t	question	\N	1	1	\N	\N
727	\\x1f2393eaeb439e71d6dfd3cea2192fd60299c49bf620020c2b14f10fcb4d51cb	2018-05-25 18:34:08.615	70	5	f	question	\N	1	7	\N	\N
728	\\xf7817c13d6fbbe2fdb6c5150d8ce8cfcff2f8f946d0bb3f47655f1bf5c17fbec	2018-05-25 18:34:08.617	87	3	f	question	\N	1	9	\N	\N
729	\\x21dccf365b0376a984813d599b75849647c35891784be9c8fb26c510eb3da78b	2018-05-25 18:34:08.734	32	12	t	question	\N	1	12	\N	\N
730	\\x5799e5ee5c0a531ebdeb28bb3587d69494d9f0e7b7d2822f3f2ada5513f02d8d	2018-05-25 18:34:08.704	82	4	f	question	\N	1	11	\N	\N
731	\\x026e7c41b9faf92803ff46f732bbadaa12b2e4667c40e5d6064ee95cb298f687	2018-05-25 18:34:08.495	983	1	t	question	\N	1	2	\N	\N
732	\\x853e6e4dc9986952f2986b24dadf3a065f75c9edff70f7fdd280aad27c021979	2018-05-25 18:34:08.444	1165	12	t	question	\N	1	4	\N	\N
733	\\xe3aaebba69d2c390903cc5596f67dc7aac163388eec4a3ab168c37fa85cea721	2018-05-25 18:34:08.497	1197	12	f	question	\N	1	5	\N	\N
734	\\x94aac15a2de1732171ab287b64df839ab9a09c4e2761446918077c384fd80a01	2018-05-25 18:36:03.265	28	1	t	question	\N	1	3	\N	\N
735	\\x73cdf619236c552536e0a1f4655fa621475379f543d808f75de298e65e8d1f3d	2018-05-25 18:36:03.264	159	1	t	question	\N	1	1	\N	\N
736	\\x1f2393eaeb439e71d6dfd3cea2192fd60299c49bf620020c2b14f10fcb4d51cb	2018-05-25 18:36:03.338	139	5	f	question	\N	1	7	\N	\N
737	\\xf7817c13d6fbbe2fdb6c5150d8ce8cfcff2f8f946d0bb3f47655f1bf5c17fbec	2018-05-25 18:36:03.35	129	3	f	question	\N	1	9	\N	\N
738	\\x21dccf365b0376a984813d599b75849647c35891784be9c8fb26c510eb3da78b	2018-05-25 18:36:03.542	146	12	t	question	\N	1	12	\N	\N
739	\\x5799e5ee5c0a531ebdeb28bb3587d69494d9f0e7b7d2822f3f2ada5513f02d8d	2018-05-25 18:36:03.489	261	4	f	question	\N	1	11	\N	\N
740	\\x026e7c41b9faf92803ff46f732bbadaa12b2e4667c40e5d6064ee95cb298f687	2018-05-25 18:36:03.291	898	1	t	question	\N	1	2	\N	\N
741	\\x853e6e4dc9986952f2986b24dadf3a065f75c9edff70f7fdd280aad27c021979	2018-05-25 18:36:03.309	1012	12	t	question	\N	1	4	\N	\N
742	\\xe3aaebba69d2c390903cc5596f67dc7aac163388eec4a3ab168c37fa85cea721	2018-05-25 18:36:03.421	955	12	f	question	\N	1	5	\N	\N
743	\\x94aac15a2de1732171ab287b64df839ab9a09c4e2761446918077c384fd80a01	2018-05-25 18:36:07.338	25	1	t	embedded-dashboard	\N	1	3	1	\N
744	\\x1f2393eaeb439e71d6dfd3cea2192fd60299c49bf620020c2b14f10fcb4d51cb	2018-05-25 18:36:07.467	73	5	f	embedded-dashboard	\N	1	7	1	\N
745	\\xf7817c13d6fbbe2fdb6c5150d8ce8cfcff2f8f946d0bb3f47655f1bf5c17fbec	2018-05-25 18:36:07.49	74	3	f	embedded-dashboard	\N	1	9	1	\N
746	\\x73cdf619236c552536e0a1f4655fa621475379f543d808f75de298e65e8d1f3d	2018-05-25 18:36:07.357	223	1	t	embedded-dashboard	\N	1	1	1	\N
747	\\x21dccf365b0376a984813d599b75849647c35891784be9c8fb26c510eb3da78b	2018-05-25 18:36:07.595	29	12	t	embedded-dashboard	\N	1	12	1	\N
748	\\x5799e5ee5c0a531ebdeb28bb3587d69494d9f0e7b7d2822f3f2ada5513f02d8d	2018-05-25 18:36:07.643	78	4	f	embedded-dashboard	\N	1	11	1	\N
749	\\x026e7c41b9faf92803ff46f732bbadaa12b2e4667c40e5d6064ee95cb298f687	2018-05-25 18:36:07.339	859	1	t	embedded-dashboard	\N	1	2	1	\N
750	\\x853e6e4dc9986952f2986b24dadf3a065f75c9edff70f7fdd280aad27c021979	2018-05-25 18:36:07.422	884	12	t	embedded-dashboard	\N	1	4	1	\N
751	\\xe3aaebba69d2c390903cc5596f67dc7aac163388eec4a3ab168c37fa85cea721	2018-05-25 18:36:07.395	931	12	f	embedded-dashboard	\N	1	5	1	\N
752	\\x94aac15a2de1732171ab287b64df839ab9a09c4e2761446918077c384fd80a01	2018-05-25 18:39:32.45	29	1	t	embedded-dashboard	\N	1	3	1	\N
753	\\x73cdf619236c552536e0a1f4655fa621475379f543d808f75de298e65e8d1f3d	2018-05-25 18:39:32.491	255	1	t	embedded-dashboard	\N	1	1	1	\N
754	\\x21dccf365b0376a984813d599b75849647c35891784be9c8fb26c510eb3da78b	2018-05-25 18:39:32.764	34	12	t	embedded-dashboard	\N	1	12	1	\N
755	\\xf7817c13d6fbbe2fdb6c5150d8ce8cfcff2f8f946d0bb3f47655f1bf5c17fbec	2018-05-25 18:39:32.753	66	3	f	embedded-dashboard	\N	1	9	1	\N
756	\\x1f2393eaeb439e71d6dfd3cea2192fd60299c49bf620020c2b14f10fcb4d51cb	2018-05-25 18:39:32.751	79	5	f	embedded-dashboard	\N	1	7	1	\N
757	\\x5799e5ee5c0a531ebdeb28bb3587d69494d9f0e7b7d2822f3f2ada5513f02d8d	2018-05-25 18:39:32.815	113	4	f	embedded-dashboard	\N	1	11	1	\N
758	\\x026e7c41b9faf92803ff46f732bbadaa12b2e4667c40e5d6064ee95cb298f687	2018-05-25 18:39:32.465	885	1	t	embedded-dashboard	\N	1	2	1	\N
759	\\xe3aaebba69d2c390903cc5596f67dc7aac163388eec4a3ab168c37fa85cea721	2018-05-25 18:39:32.523	1020	12	f	embedded-dashboard	\N	1	5	1	\N
760	\\x853e6e4dc9986952f2986b24dadf3a065f75c9edff70f7fdd280aad27c021979	2018-05-25 18:39:32.548	1023	12	t	embedded-dashboard	\N	1	4	1	\N
761	\\x54862d22bcb68901eb371b8e9e536647dadd30c3796f0a9872c28815a6c19edc	2018-05-28 17:07:26.956	1516	1500	t	question	\N	1	13	\N	\N
762	\\x94aac15a2de1732171ab287b64df839ab9a09c4e2761446918077c384fd80a01	2018-05-29 02:00:29.225	507	1	t	question	\N	1	3	\N	\N
763	\\x73cdf619236c552536e0a1f4655fa621475379f543d808f75de298e65e8d1f3d	2018-05-29 02:00:29.207	527	1	t	question	\N	1	1	\N	\N
764	\\x1f2393eaeb439e71d6dfd3cea2192fd60299c49bf620020c2b14f10fcb4d51cb	2018-05-29 02:00:29.81	209	5	f	question	\N	1	7	\N	\N
765	\\x5799e5ee5c0a531ebdeb28bb3587d69494d9f0e7b7d2822f3f2ada5513f02d8d	2018-05-29 02:00:29.904	312	4	f	question	\N	1	11	\N	\N
766	\\xf7817c13d6fbbe2fdb6c5150d8ce8cfcff2f8f946d0bb3f47655f1bf5c17fbec	2018-05-29 02:00:29.891	326	3	f	question	\N	1	9	\N	\N
767	\\x21dccf365b0376a984813d599b75849647c35891784be9c8fb26c510eb3da78b	2018-05-29 02:00:30.059	604	12	t	question	\N	1	12	\N	\N
768	\\x026e7c41b9faf92803ff46f732bbadaa12b2e4667c40e5d6064ee95cb298f687	2018-05-29 02:00:29.241	1434	1	t	question	\N	1	2	\N	\N
769	\\x853e6e4dc9986952f2986b24dadf3a065f75c9edff70f7fdd280aad27c021979	2018-05-29 02:00:29.334	1477	12	t	question	\N	1	4	\N	\N
770	\\xe3aaebba69d2c390903cc5596f67dc7aac163388eec4a3ab168c37fa85cea721	2018-05-29 02:00:29.338	1733	12	f	question	\N	1	5	\N	\N
771	\\x54862d22bcb68901eb371b8e9e536647dadd30c3796f0a9872c28815a6c19edc	2018-05-29 09:16:07.828	806	1500	t	question	\N	1	13	\N	\N
772	\\x54862d22bcb68901eb371b8e9e536647dadd30c3796f0a9872c28815a6c19edc	2018-05-30 10:11:35.598	1161	1500	t	question	\N	1	13	\N	\N
\.


--
-- Name: query_execution_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('query_execution_id_seq', 772, true);


--
-- Data for Name: raw_column; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY raw_column (id, raw_table_id, active, name, column_type, is_pk, fk_target_column_id, details, created_at, updated_at) FROM stdin;
\.


--
-- Name: raw_column_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('raw_column_id_seq', 1, false);


--
-- Data for Name: raw_table; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY raw_table (id, database_id, active, schema, name, details, created_at, updated_at) FROM stdin;
\.


--
-- Name: raw_table_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('raw_table_id_seq', 1, false);


--
-- Data for Name: report_card; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY report_card (id, created_at, updated_at, name, description, display, dataset_query, visualization_settings, creator_id, database_id, table_id, query_type, archived, collection_id, public_uuid, made_public_by_id, enable_embedding, embedding_params, cache_ttl, result_metadata) FROM stdin;
3	2018-05-10 18:31:03.514+05	2018-05-29 02:00:29.667+05	Total Screenings	Total number of people screened	scalar	{"database":2,"type":"native","native":{"query":"SELECT COUNT(DISTINCT baseentityid) total FROM event e WHERE e.eventtype='Screening' ","collection":"address","template_tags":{}}}	{}	1	2	\N	native	f	\N	\N	\N	f	\N	\N	[{"base_type":"type/Integer","display_name":"Total","name":"total"}]
1	2018-05-10 09:48:28.818+05	2018-05-29 02:00:29.732+05	NNT	Number needed to treat	scalar	{"database":2,"type":"native","native":{"query":"SELECT CONCAT(confirmed_tb_cases, ' (', 100*confirmed_tb_cases/o.total, '%)') as nnt FROM (\\r\\n    SELECT COUNT(DISTINCT baseentityid) total, \\r\\n    SUM(CASE WHEN o ->> 'formSubmissionField' = 'confirmed_tb' AND (o ->> 'values' = '[\\"yes\\"]' OR o ->> 'humanReadableValues' = '[\\"yes\\"]') THEN 1 ELSE 0 END) confirmed_tb_cases \\r\\n    FROM event e, jsonb_array_elements(e.obs) as o \\r\\n    WHERE e.eventtype='TB Diagnosis' ) o\\r\\n","collection":"address","template_tags":{}}}	{}	1	2	\N	native	f	\N	\N	\N	f	\N	\N	[{"base_type":"type/Text","display_name":"Nnt","name":"nnt"}]
2	2018-05-10 09:49:40.953+05	2018-05-29 02:00:30.673+05	NNS	Number needed to screen	scalar	{"database":2,"type":"native","native":{"query":"SELECT CONCAT(ot.presumptives, ' (', 100*ot.presumptives/ot.total,'%)') nns FROM (\\r\\n    SELECT \\r\\n    COUNT(DISTINCT baseentityid) total, \\r\\n    SUM(CASE WHEN o ->> 'formSubmissionField' = 'presumptive' AND (o ->> 'values' = '[\\"no\\"]' OR o ->> 'humanReadableValues' = '[\\"no\\"]') THEN 1 ELSE 0 END) presumptives\\r\\n    FROM event e, jsonb_array_elements(e.obs) as o WHERE e.eventtype='Screening' \\r\\n) ot","collection":"address","template_tags":{}}}	{}	1	2	\N	native	f	\N	\N	\N	f	\N	\N	[{"base_type":"type/Text","display_name":"Nns","name":"nns"}]
5	2018-05-11 17:43:03.719+05	2018-05-29 02:00:31.068+05	Screening Summary trend over past 12 months	\N	bar	{"database":-1337,"type":"query","query":{"source_table":"card__4"}}	{"graph.dimensions":["screening_month"],"graph.metrics":["non_presumptives","presumptives"],"stackable.stack_type":null,"graph.y_axis.labels_enabled":false,"graph.y_axis.auto_split":false,"graph.y_axis.axis_enabled":true}	1	2	\N	query	f	\N	\N	\N	f	\N	\N	[{"base_type":"type/Text","display_name":"Screening Month","name":"screening_month"},{"base_type":"type/Text","display_name":"Screening Month Fmt","name":"screening_month_fmt"},{"base_type":"type/Integer","display_name":"Total","name":"total"},{"base_type":"type/Integer","display_name":"Non Presumptives","name":"non_presumptives"},{"base_type":"type/Integer","display_name":"Presumptives","name":"presumptives"}]
10	2018-05-12 14:03:50.402+05	2018-05-12 15:35:45.175+05	Treatment Summary	\N	table	{"database":2,"type":"native","native":{"query":" -- (o ->> 'humanReadableValues')::json->>0\\r\\nSELECT \\r\\no->>'formSubmissionField' formSubmissionField, \\r\\nCOUNT(DISTINCT baseentityid) confirmed_tb_cases,  (o ->> 'humanReadableValues')::json->>0 diagnosis_method \\r\\nFROM event e, jsonb_array_elements(e.obs) as o \\r\\nWHERE e.eventtype LIKE 'Treatment Initiation%' AND (o->>'formSubmissionField'='site_of_disease' OR o->>'formSubmissionField'='treatment_phase' OR o->>'formSubmissionField'='patient_type')\\r\\nGROUP BY formSubmissionField, diagnosis_method\\r\\n","collection":"address","template_tags":{}}}	{}	1	2	\N	native	f	\N	\N	\N	f	\N	\N	[{"base_type":"type/Text","display_name":"Formsubmissionfield","name":"formsubmissionfield"},{"base_type":"type/Integer","display_name":"Confirmed Tb Cases","name":"confirmed_tb_cases"},{"base_type":"type/Text","display_name":"Diagnosis Method","name":"diagnosis_method"}]
7	2018-05-12 10:30:36.769+05	2018-05-29 02:00:30.016+05	Summary Patient Types Enrolled	\N	pie	{"database":-1337,"type":"query","query":{"source_table":"card__10","filter":["AND",["=",["field-id",["field-literal","formsubmissionfield","type/Text"]],"patient_type"]],"order_by":[[["field-id",["field-literal","confirmed_tb_cases","type/Integer"]],"descending"]]}}	{"pie.dimension":"diagnosis_method"}	1	2	\N	query	f	\N	\N	\N	f	\N	\N	[{"base_type":"type/Text","display_name":"Formsubmissionfield","name":"formsubmissionfield"},{"base_type":"type/Integer","display_name":"Confirmed Tb Cases","name":"confirmed_tb_cases"},{"base_type":"type/Text","display_name":"Diagnosis Method","name":"diagnosis_method"}]
12	2018-05-12 15:00:13.55+05	2018-05-29 02:00:30.66+05	Treatment Outcome Summary	\N	line	{"database":2,"type":"native","native":{"query":" -- (o ->> 'humanReadableValues')::json->>0\\r\\nSELECT \\r\\nc.gender,  (o ->> 'humanReadableValues')::json->>0 outcome, COUNT(DISTINCT e.baseentityid) confirmed_tb_cases \\r\\nFROM event e join client c on e.baseentityid=c.baseentityid, jsonb_array_elements(e.obs) as o \\r\\nWHERE e.eventtype = 'Treatment Outcome' AND (o->>'formSubmissionField'='treatment_outcome')\\r\\nGROUP BY outcome, gender\\r\\n","collection":"address","template_tags":{}}}	{"line.marker_enabled":true,"graph.show_goal":false,"graph.y_axis.auto_split":true,"graph.x_axis.title_text":"Treatment Outcome","graph.dimensions":["outcome","gender"],"graph.metrics":["confirmed_tb_cases"]}	1	2	\N	native	f	\N	\N	\N	f	\N	\N	[{"base_type":"type/Text","display_name":"Gender","name":"gender"},{"base_type":"type/Text","display_name":"Outcome","name":"outcome"},{"base_type":"type/Integer","display_name":"Confirmed Tb Cases","name":"confirmed_tb_cases"}]
6	2018-05-12 10:24:17.246+05	2018-05-12 14:05:16.817+05	Patient Types by Month	\N	table	{"database":2,"type":"native","native":{"query":"SELECT \\r\\n    to_char(e.eventdate, 'Mon, YYYY') _month, \\r\\n    MAX(to_char(e.eventdate, 'YYYY-MM')) _month_fmt,\\r\\n    (o ->> 'humanReadableValues')::json->>0 patient_type, \\r\\n    COUNT(DISTINCT baseentityid) total\\r\\nFROM event e, jsonb_array_elements(e.obs) as o\\r\\nWHERE e.eventtype LIKE 'Treatment Initiation%' AND o ->> 'formSubmissionField'='patient_type'\\r\\nGROUP BY _Month, patient_type\\r\\nORDER BY _Month_fmt DESC, total DESC\\r\\n","collection":"address","template_tags":{}}}	{}	1	2	\N	native	f	\N	\N	\N	f	\N	\N	[{"base_type":"type/Text","display_name":"Month","name":"_month"},{"base_type":"type/Text","display_name":"Month Fmt","name":"_month_fmt"},{"base_type":"type/Text","display_name":"Patient Type","name":"patient_type"},{"base_type":"type/Integer","display_name":"Total","name":"total"}]
8	2018-05-12 11:37:41.506+05	2018-05-12 14:04:41.952+05	Summary TB Diagnosis	\N	table	{"database":2,"type":"native","native":{"query":"SELECT \\r\\nCOUNT(DISTINCT baseentityid) confirmed_tb_cases,  (o ->> 'humanReadableValues')::json->>0 diagnosis_method \\r\\nFROM event e, jsonb_array_elements(e.obs) as o \\r\\nWHERE e.eventtype='TB Diagnosis' AND o->>'formSubmissionField'='diagnosis_type'\\r\\nGROUP BY diagnosis_method\\r\\n","collection":"address","template_tags":{}}}	{}	1	2	\N	native	f	\N	\N	\N	f	\N	\N	[{"base_type":"type/Integer","display_name":"Confirmed Tb Cases","name":"confirmed_tb_cases"},{"base_type":"type/Text","display_name":"Diagnosis Method","name":"diagnosis_method"}]
9	2018-05-12 12:17:28.465+05	2018-05-29 02:00:30.145+05	Summary TB Diagnoses Type	\N	pie	{"database":-1337,"type":"query","query":{"source_table":"card__8"}}	{"pie.dimension":"diagnosis_method","pie.metric":"confirmed_tb_cases"}	1	2	\N	query	f	\N	\N	\N	f	\N	\N	[{"base_type":"type/Integer","display_name":"Confirmed Tb Cases","name":"confirmed_tb_cases"},{"base_type":"type/Text","display_name":"Diagnosis Method","name":"diagnosis_method"}]
11	2018-05-12 14:30:28.366+05	2018-05-29 02:00:30.11+05	Treatment Summary TB	\N	bar	{"database":-1337,"type":"query","query":{"source_table":"card__10","filter":["AND",["!=",["field-id",["field-literal","formsubmissionfield","type/Text"]],"patient_type"]]}}	{"graph.dimensions":["formsubmissionfield","diagnosis_method"],"graph.metrics":["confirmed_tb_cases"],"stackable.stack_type":"stacked","graph.x_axis.labels_enabled":false,"graph.y_axis.labels_enabled":true}	1	2	\N	query	f	\N	\N	\N	f	\N	\N	[{"base_type":"type/Text","display_name":"Formsubmissionfield","name":"formsubmissionfield"},{"base_type":"type/Integer","display_name":"Confirmed Tb Cases","name":"confirmed_tb_cases"},{"base_type":"type/Text","display_name":"Diagnosis Method","name":"diagnosis_method"}]
13	2018-05-12 19:31:59.405+05	2018-05-30 10:11:36.752+05	TB-01	\N	table	{"database":2,"type":"native","native":{"query":"SELECT c.identifiers->>'TBREACH ID' identifier, to_char(e.eventdate, 'dd-MM-yyyy') screening_date, c.firstname _name, c.lastname last_name, \\r\\nCONCAT(coalesce(a->'addressFields'->>'address1', ''), ', ', a->>'subTown', ', town: ', a->>'town', ', ', a->>'cityVillage') address,\\r\\nc.attributes->>'Primary Contact Number' phone_number, CONCAT(to_char(c.birthdate, 'dd-MM-yyyy'), ' (', DATE_PART('year', e.eventdate) - DATE_PART('year', c.birthdate), ')') dob_age,\\r\\n\\r\\n e.*,\\r\\n    -- to_char(e.eventdate, 'Mon, YYYY') screening_Month, \\r\\n    CASE WHEN o ->> 'formSubmissionField' = 'presumptive' AND (o ->> 'values' = '[\\"yes\\"]' OR o ->> 'humanReadableValues' = '[\\"yes\\"]') THEN 1 ELSE 0 END presumptive\\r\\nFROM event e JOIN client c ON e.baseentityid=c.baseentityid, jsonb_array_elements(c.addresses) as a, jsonb_array_elements(e.obs) as o \\r\\nWHERE e.eventtype='Screening' AND a ->> 'addressType' = 'usual_residence'\\r\\nAND (CASE WHEN o ->> 'formSubmissionField' = 'presumptive' AND (o ->> 'values' = '[\\"yes\\"]' OR o ->> 'humanReadableValues' = '[\\"yes\\"]') THEN TRUE ELSE FALSE END) \\r\\n","collection":"address","template_tags":{}}}	{}	1	2	\N	native	f	\N	\N	\N	f	\N	\N	[{"base_type":"type/Text","display_name":"Identifier","name":"identifier"},{"base_type":"type/Text","display_name":"Screening Date","name":"screening_date"},{"base_type":"type/Text","display_name":"Name","name":"_name"},{"base_type":"type/Text","display_name":"Last Name","name":"last_name"},{"base_type":"type/Text","display_name":"Address","name":"address"},{"base_type":"type/Text","display_name":"Phone Number","name":"phone_number"},{"base_type":"type/Text","display_name":"Dob Age","name":"dob_age"},{"base_type":"type/Integer","display_name":"Eventid","name":"eventid"},{"base_type":"type/*","display_name":"Identifiers","name":"identifiers"},{"base_type":"type/*","display_name":"Duration","name":"duration"},{"base_type":"type/Text","display_name":"Entitytype","name":"entitytype"},{"base_type":"type/DateTime","display_name":"Eventdate","name":"eventdate"},{"base_type":"type/Text","display_name":"Eventtype","name":"eventtype"},{"base_type":"type/Text","display_name":"Formsubmissionid","name":"formsubmissionid"},{"base_type":"type/Text","display_name":"Locationid","name":"locationid"},{"base_type":"type/Text","display_name":"Providerid","name":"providerid"},{"base_type":"type/Text","display_name":"Teamid","name":"teamid"},{"base_type":"type/*","display_name":"Status","name":"status"},{"base_type":"type/*","display_name":"Category","name":"category"},{"base_type":"type/*","display_name":"Reason","name":"reason"},{"base_type":"type/*","display_name":"Details","name":"details"},{"base_type":"type/*","display_name":"Obs","name":"obs"},{"base_type":"type/DateTime","display_name":"Datecreated","name":"datecreated"},{"base_type":"type/*","display_name":"Dateedited","name":"dateedited"},{"base_type":"type/*","display_name":"Voided","name":"voided"},{"base_type":"type/*","display_name":"Datevoided","name":"dateVoided"},{"base_type":"type/*","display_name":"Voidreason","name":"voidreason"},{"base_type":"type/*","display_name":"Creator","name":"creator"},{"base_type":"type/*","display_name":"Editor","name":"editor"},{"base_type":"type/*","display_name":"Voider","name":"voider"},{"base_type":"type/Integer","display_name":"Serverversion","name":"serverversion"},{"base_type":"type/Text","display_name":"ID","name":"_id"},{"base_type":"type/Text","display_name":"Baseentityid","name":"baseentityid"},{"base_type":"type/*","display_name":"Clientid","name":"clientid"},{"base_type":"type/*","display_name":"Fulldetails","name":"fulldetails"},{"base_type":"type/Integer","display_name":"Presumptive","name":"presumptive"}]
4	2018-05-11 16:15:46.041+05	2018-05-29 02:00:30.807+05	Screening Summary	\N	table	{"database":2,"type":"native","native":{"query":"SELECT \\r\\n    to_char(e.eventdate, 'Mon, YYYY') screening_Month, \\r\\n    MAX(to_char(e.eventdate, 'YYYY-MM')) screening_Month_fmt, \\r\\n    COUNT(DISTINCT baseentityid) total, \\r\\n    SUM(CASE WHEN o ->> 'formSubmissionField' = 'presumptive' AND (o ->> 'values' = '[\\"no\\"]' OR o ->> 'humanReadableValues' = '[\\"no\\"]') THEN 1 ELSE 0 END) non_Presumptives,\\r\\n    SUM(CASE WHEN o ->> 'formSubmissionField' = 'presumptive' AND (o ->> 'values' = '[\\"yes\\"]' OR o ->> 'humanReadableValues' = '[\\"yes\\"]') THEN 1 ELSE 0 END) presumptives\\r\\n    FROM event e, jsonb_array_elements(e.obs) as o WHERE e.eventtype='Screening' \\r\\nGROUP BY screening_Month\\r\\nORDER BY screening_Month_fmt DESC\\r\\nLIMIT 12","collection":"address","template_tags":{}}}	{"table.columns":[{"name":"screening_month","enabled":true},{"name":"screening_month_fmt","enabled":false},{"name":"total","enabled":true},{"name":"non_presumptives","enabled":true},{"name":"presumptives","enabled":true}]}	1	2	\N	native	f	\N	\N	\N	f	\N	\N	[{"base_type":"type/Text","display_name":"Screening Month","name":"screening_month"},{"base_type":"type/Text","display_name":"Screening Month Fmt","name":"screening_month_fmt"},{"base_type":"type/Integer","display_name":"Total","name":"total"},{"base_type":"type/Integer","display_name":"Non Presumptives","name":"non_presumptives"},{"base_type":"type/Integer","display_name":"Presumptives","name":"presumptives"}]
\.


--
-- Name: report_card_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('report_card_id_seq', 13, true);


--
-- Data for Name: report_cardfavorite; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY report_cardfavorite (id, created_at, updated_at, card_id, owner_id) FROM stdin;
\.


--
-- Name: report_cardfavorite_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('report_cardfavorite_id_seq', 1, false);


--
-- Data for Name: report_dashboard; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY report_dashboard (id, created_at, updated_at, name, description, creator_id, parameters, points_of_interest, caveats, show_in_getting_started, public_uuid, made_public_by_id, enable_embedding, embedding_params, archived, "position") FROM stdin;
2	2018-05-12 18:24:52.805+05	2018-05-12 18:24:52.805+05	TB Reports	\N	1	[]	\N	\N	f	\N	\N	f	\N	f	\N
1	2018-05-10 09:36:33.485+05	2018-05-25 07:09:04.852+05	Summary Program	Summary of Program showing main indicators and status of program	1	[]	\N	\N	f	476b679b-072f-4167-80a2-ded8e1d302c8	1	f	\N	f	\N
\.


--
-- Name: report_dashboard_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('report_dashboard_id_seq', 2, true);


--
-- Data for Name: report_dashboardcard; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY report_dashboardcard (id, created_at, updated_at, "sizeX", "sizeY", "row", col, card_id, dashboard_id, parameter_mappings, visualization_settings) FROM stdin;
9	2018-05-12 12:22:04.335+05	2018-05-25 07:09:04.829+05	9	6	14	9	9	1	[]	{}
2	2018-05-10 09:50:34.175+05	2018-05-25 07:09:04.811+05	7	3	0	11	1	1	[]	{}
4	2018-05-10 18:32:55.658+05	2018-05-25 07:09:04.814+05	5	3	0	0	3	1	[]	{"scalar.locale":null}
5	2018-05-10 18:36:30.038+05	2018-05-25 07:09:04.816+05	6	3	0	5	2	1	[]	{}
6	2018-05-11 17:22:33.887+05	2018-05-25 07:09:04.82+05	9	11	3	9	4	1	[]	{}
7	2018-05-11 17:45:44.046+05	2018-05-25 07:09:04.823+05	9	11	3	0	5	1	[]	{}
8	2018-05-12 10:31:52.22+05	2018-05-25 07:09:04.826+05	9	6	14	0	7	1	[]	{"pie.dimension":"diagnosis_method","pie.metric":"total"}
10	2018-05-12 14:31:27.976+05	2018-05-25 07:09:04.832+05	6	6	20	12	11	1	[]	{}
11	2018-05-12 15:21:27.618+05	2018-05-25 07:09:04.834+05	12	6	20	0	12	1	[]	{}
\.


--
-- Name: report_dashboardcard_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('report_dashboardcard_id_seq', 11, true);


--
-- Data for Name: revision; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY revision (id, model, model_id, user_id, "timestamp", object, is_reversion, is_creation, message) FROM stdin;
2	Card	1	1	2018-05-10 09:48:28.834+05	{"description":"Number needed to treat","archived":false,"table_id":null,"result_metadata":[{"base_type":"type/Integer","display_name":"Count","name":"count"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"native","name":"NNT","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"native","native":{"query":"SELECT COUNT(*) FROM event WHERE eventtype='Child Vaccination Enrollment'","collection":"address","template_tags":{}}},"id":1,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	t	\N
3	Card	2	1	2018-05-10 09:49:40.958+05	{"description":"Number needed to screen","archived":false,"table_id":null,"result_metadata":[{"base_type":"type/Integer","display_name":"Count","name":"count"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"native","name":"NNS","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"native","native":{"query":"SELECT COUNT(*) FROM event WHERE eventtype='Woman TT enrollment'","collection":"address","template_tags":{}}},"id":2,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	t	\N
8	Card	2	1	2018-05-10 18:18:57.454+05	{"description":"Number needed to screen","archived":false,"table_id":null,"result_metadata":[{"base_type":"type/Integer","display_name":"Total","name":"total"},{"base_type":"type/Integer","display_name":"Pre Sum Pt Ives","name":"presumptives"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"native","name":"NNS","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"native","native":{"query":"SELECT \\r\\nCOUNT(DISTINCT baseentityid) total, \\r\\nSUM(CASE WHEN o ->> 'formSubmissionField' = 'presumptive' AND (o ->> 'values' = '[\\"no\\"]' OR o ->> 'humanReadableValues' = '[\\"no\\"]') THEN 1 ELSE 0 END) presumptives\\r\\nFROM event e, jsonb_array_elements(e.obs) as o WHERE e.eventtype='Screening' \\r\\n","collection":"address","template_tags":{}}},"id":2,"display":"table","visualization_settings":{},"public_uuid":null}	f	f	\N
13	Card	2	1	2018-05-10 18:24:25.151+05	{"description":"Number needed to screen","archived":false,"table_id":null,"result_metadata":[{"base_type":"type/Text","display_name":"Nns","name":"nns"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"native","name":"NNS","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"native","native":{"query":"SELECT CONCAT(ot.presumptives, '/', ot.total, ' (', 100*ot.presumptives/ot.total,' %)') nns FROM (\\r\\n    SELECT \\r\\n    COUNT(DISTINCT baseentityid) total, \\r\\n    SUM(CASE WHEN o ->> 'formSubmissionField' = 'presumptive' AND (o ->> 'values' = '[\\"no\\"]' OR o ->> 'humanReadableValues' = '[\\"no\\"]') THEN 1 ELSE 0 END) presumptives\\r\\n    FROM event e, jsonb_array_elements(e.obs) as o WHERE e.eventtype='Screening' \\r\\n) ot","collection":"address","template_tags":{}}},"id":2,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	f	\N
14	Card	2	1	2018-05-10 18:26:14.035+05	{"description":"Number needed to screen","archived":false,"table_id":null,"result_metadata":[{"base_type":"type/Text","display_name":"Nns","name":"nns"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"native","name":"NNS","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"native","native":{"query":"SELECT CONCAT(ot.presumptives, '/', ot.total, ' (', 100*ot.presumptives/ot.total,' %)') nns FROM (\\r\\n    SELECT \\r\\n    COUNT(DISTINCT baseentityid) total, \\r\\n    SUM(CASE WHEN o ->> 'formSubmissionField' = 'presumptive' AND (o ->> 'values' = '[\\"no\\"]' OR o ->> 'humanReadableValues' = '[\\"no\\"]') THEN 1 ELSE 0 END) presumptives\\r\\n    FROM event e, jsonb_array_elements(e.obs) as o WHERE e.eventtype='Screening' \\r\\n) ot","collection":"address","template_tags":{}}},"id":2,"display":"table","visualization_settings":{},"public_uuid":null}	f	f	\N
15	Card	3	1	2018-05-10 18:31:03.523+05	{"description":"Total number of people screened","archived":false,"table_id":null,"result_metadata":[{"base_type":"type/Integer","display_name":"Total","name":"total"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"native","name":"Total Screenings","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"native","native":{"query":"SELECT COUNT(DISTINCT baseentityid) total FROM event e WHERE e.eventtype='Screening' ","collection":"address","template_tags":{}}},"id":3,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	t	\N
19	Card	2	1	2018-05-10 18:34:58.269+05	{"description":"Number needed to screen","archived":false,"table_id":null,"result_metadata":[{"base_type":"type/Text","display_name":"Nns","name":"nns"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"native","name":"NNS","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"native","native":{"query":"SELECT CONCAT(ot.presumptives, ' (', 100*ot.presumptives/ot.total,'%)') nns FROM (\\r\\n    SELECT \\r\\n    COUNT(DISTINCT baseentityid) total, \\r\\n    SUM(CASE WHEN o ->> 'formSubmissionField' = 'presumptive' AND (o ->> 'values' = '[\\"no\\"]' OR o ->> 'humanReadableValues' = '[\\"no\\"]') THEN 1 ELSE 0 END) presumptives\\r\\n    FROM event e, jsonb_array_elements(e.obs) as o WHERE e.eventtype='Screening' \\r\\n) ot","collection":"address","template_tags":{}}},"id":2,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	f	\N
24	Card	4	1	2018-05-11 16:15:46.051+05	{"description":null,"archived":false,"table_id":null,"result_metadata":[{"base_type":"type/Float","display_name":"Screeningmonth","name":"screeningmonth"},{"base_type":"type/Float","display_name":"Screeningyear","name":"screeningyear"},{"base_type":"type/Integer","display_name":"Total","name":"total"},{"base_type":"type/Integer","display_name":"Presumptives","name":"presumptives"},{"base_type":"type/Integer","display_name":"Nonpresumptives","name":"nonpresumptives"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"native","name":"Screening Summary","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"native","native":{"query":"SELECT \\r\\ndate_part('month', e.eventdate) screeningMonth, \\r\\ndate_part('year', e.eventdate) screeningYear, \\r\\nCOUNT(DISTINCT baseentityid) total, \\r\\nSUM(CASE WHEN o ->> 'formSubmissionField' = 'presumptive' AND (o ->> 'values' = '[\\"yes\\"]' OR o ->> 'humanReadableValues' = '[\\"yes\\"]') THEN 1 ELSE 0 END) presumptives,\\r\\nSUM(CASE WHEN o ->> 'formSubmissionField' = 'presumptive' AND (o ->> 'values' = '[\\"no\\"]' OR o ->> 'humanReadableValues' = '[\\"no\\"]') THEN 1 ELSE 0 END) nonPresumptives\\r\\nFROM event e, jsonb_array_elements(e.obs) as o WHERE e.eventtype='Screening' \\r\\nGROUP BY screeningYear,screeningMonth","collection":"address","template_tags":{}}},"id":4,"display":"table","visualization_settings":{},"public_uuid":null}	f	t	\N
25	Card	4	1	2018-05-11 17:17:08.466+05	{"description":null,"archived":false,"table_id":null,"result_metadata":[{"base_type":"type/Float","display_name":"Screeningmonth","name":"screeningmonth"},{"base_type":"type/Float","display_name":"Screeningyear","name":"screeningyear"},{"base_type":"type/Integer","display_name":"Total","name":"total"},{"base_type":"type/Integer","display_name":"Presumptives","name":"presumptives"},{"base_type":"type/Integer","display_name":"Nonpresumptives","name":"nonpresumptives"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"native","name":"Screening Summary","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"native","native":{"query":"    SELECT \\r\\n    date_part('month', e.eventdate) screeningMonth, \\r\\n    date_part('year', e.eventdate) screeningYear, \\r\\n    COUNT(DISTINCT baseentityid) total, \\r\\n    SUM(CASE WHEN o ->> 'formSubmissionField' = 'presumptive' AND (o ->> 'values' = '[\\"no\\"]' OR o ->> 'humanReadableValues' = '[\\"no\\"]') THEN 1 ELSE 0 END) nonPresumptives,\\r\\n    SUM(CASE WHEN o ->> 'formSubmissionField' = 'presumptive' AND (o ->> 'values' = '[\\"yes\\"]' OR o ->> 'humanReadableValues' = '[\\"yes\\"]') THEN 1 ELSE 0 END) presumptives\\r\\n    FROM event e, jsonb_array_elements(e.obs) as o WHERE e.eventtype='Screening' \\r\\n    GROUP BY screeningYear,screeningMonth","collection":"address","template_tags":{}}},"id":4,"display":"table","visualization_settings":{},"public_uuid":null}	f	f	\N
31	Card	5	1	2018-05-11 17:43:03.726+05	{"description":null,"archived":false,"table_id":null,"result_metadata":[{"base_type":"type/Text","display_name":"Screening Month","name":"screening_month"},{"base_type":"type/Text","display_name":"Screening Month Fmt","name":"screening_month_fmt"},{"base_type":"type/Integer","display_name":"Total","name":"total"},{"base_type":"type/Integer","display_name":"Non Presumptives","name":"non_presumptives"},{"base_type":"type/Integer","display_name":"Presumptives","name":"presumptives"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Screening Summary trend over past 12 months","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":-1337,"type":"query","query":{"source_table":"card__4"}},"id":5,"display":"bar","visualization_settings":{"graph.dimensions":["screening_month"],"graph.metrics":["total","non_presumptives","presumptives"],"stackable.stack_type":null,"graph.y_axis.labels_enabled":false},"public_uuid":null}	f	t	\N
26	Card	4	1	2018-05-11 17:20:48.538+05	{"description":null,"archived":false,"table_id":null,"result_metadata":[{"base_type":"type/Float","display_name":"Screening Month","name":"screening_month"},{"base_type":"type/Float","display_name":"Screening Year","name":"screening_year"},{"base_type":"type/Integer","display_name":"Total","name":"total"},{"base_type":"type/Integer","display_name":"Non Presumptives","name":"non_presumptives"},{"base_type":"type/Integer","display_name":"Presumptives","name":"presumptives"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"native","name":"Screening Summary","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"native","native":{"query":"    SELECT \\r\\n    date_part('month', e.eventdate) screening_Month, \\r\\n    date_part('year', e.eventdate) screening_Year, \\r\\n    COUNT(DISTINCT baseentityid) total, \\r\\n    SUM(CASE WHEN o ->> 'formSubmissionField' = 'presumptive' AND (o ->> 'values' = '[\\"no\\"]' OR o ->> 'humanReadableValues' = '[\\"no\\"]') THEN 1 ELSE 0 END) non_Presumptives,\\r\\n    SUM(CASE WHEN o ->> 'formSubmissionField' = 'presumptive' AND (o ->> 'values' = '[\\"yes\\"]' OR o ->> 'humanReadableValues' = '[\\"yes\\"]') THEN 1 ELSE 0 END) presumptives\\r\\n    FROM event e, jsonb_array_elements(e.obs) as o WHERE e.eventtype='Screening' \\r\\n    GROUP BY screening_Year,screening_Month","collection":"address","template_tags":{}}},"id":4,"display":"table","visualization_settings":{},"public_uuid":null}	f	f	\N
30	Card	4	1	2018-05-11 17:33:35.277+05	{"description":null,"archived":false,"table_id":null,"result_metadata":[{"base_type":"type/Text","display_name":"Screening Month","name":"screening_month"},{"base_type":"type/Text","display_name":"Screening Month Fmt","name":"screening_month_fmt"},{"base_type":"type/Integer","display_name":"Total","name":"total"},{"base_type":"type/Integer","display_name":"Non Presumptives","name":"non_presumptives"},{"base_type":"type/Integer","display_name":"Presumptives","name":"presumptives"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"native","name":"Screening Summary","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"native","native":{"query":"SELECT \\r\\n    to_char(e.eventdate, 'Mon, YYYY') screening_Month, \\r\\n    MAX(to_char(e.eventdate, 'YYYY-MM')) screening_Month_fmt, \\r\\n    COUNT(DISTINCT baseentityid) total, \\r\\n    SUM(CASE WHEN o ->> 'formSubmissionField' = 'presumptive' AND (o ->> 'values' = '[\\"no\\"]' OR o ->> 'humanReadableValues' = '[\\"no\\"]') THEN 1 ELSE 0 END) non_Presumptives,\\r\\n    SUM(CASE WHEN o ->> 'formSubmissionField' = 'presumptive' AND (o ->> 'values' = '[\\"yes\\"]' OR o ->> 'humanReadableValues' = '[\\"yes\\"]') THEN 1 ELSE 0 END) presumptives\\r\\n    FROM event e, jsonb_array_elements(e.obs) as o WHERE e.eventtype='Screening' \\r\\nGROUP BY screening_Month\\r\\nORDER BY screening_Month_fmt DESC","collection":"address","template_tags":{}}},"id":4,"display":"table","visualization_settings":{},"public_uuid":null}	f	f	\N
32	Card	4	1	2018-05-11 17:43:35.496+05	{"description":null,"archived":false,"table_id":null,"result_metadata":[{"base_type":"type/Text","display_name":"Screening Month","name":"screening_month"},{"base_type":"type/Text","display_name":"Screening Month Fmt","name":"screening_month_fmt"},{"base_type":"type/Integer","display_name":"Total","name":"total"},{"base_type":"type/Integer","display_name":"Non Presumptives","name":"non_presumptives"},{"base_type":"type/Integer","display_name":"Presumptives","name":"presumptives"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"native","name":"Screening Summary","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"native","native":{"query":"SELECT \\r\\n    to_char(e.eventdate, 'Mon, YYYY') screening_Month, \\r\\n    MAX(to_char(e.eventdate, 'YYYY-MM')) screening_Month_fmt, \\r\\n    COUNT(DISTINCT baseentityid) total, \\r\\n    SUM(CASE WHEN o ->> 'formSubmissionField' = 'presumptive' AND (o ->> 'values' = '[\\"no\\"]' OR o ->> 'humanReadableValues' = '[\\"no\\"]') THEN 1 ELSE 0 END) non_Presumptives,\\r\\n    SUM(CASE WHEN o ->> 'formSubmissionField' = 'presumptive' AND (o ->> 'values' = '[\\"yes\\"]' OR o ->> 'humanReadableValues' = '[\\"yes\\"]') THEN 1 ELSE 0 END) presumptives\\r\\n    FROM event e, jsonb_array_elements(e.obs) as o WHERE e.eventtype='Screening' \\r\\nGROUP BY screening_Month\\r\\nORDER BY screening_Month_fmt DESC\\r\\nLIMIT 12","collection":"address","template_tags":{}}},"id":4,"display":"table","visualization_settings":{},"public_uuid":null}	f	f	\N
38	Card	5	1	2018-05-11 17:49:20.565+05	{"description":null,"archived":false,"table_id":null,"result_metadata":[{"base_type":"type/Text","display_name":"Screening Month","name":"screening_month"},{"base_type":"type/Text","display_name":"Screening Month Fmt","name":"screening_month_fmt"},{"base_type":"type/Integer","display_name":"Total","name":"total"},{"base_type":"type/Integer","display_name":"Non Presumptives","name":"non_presumptives"},{"base_type":"type/Integer","display_name":"Presumptives","name":"presumptives"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Screening Summary trend over past 12 months","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":-1337,"type":"query","query":{"source_table":"card__4"}},"id":5,"display":"bar","visualization_settings":{"graph.dimensions":["screening_month"],"graph.metrics":["non_presumptives","presumptives"],"stackable.stack_type":null,"graph.y_axis.labels_enabled":false},"public_uuid":null}	f	f	\N
39	Card	4	1	2018-05-11 20:32:26.257+05	{"description":null,"archived":false,"table_id":null,"result_metadata":[{"base_type":"type/Text","display_name":"Screening Month","name":"screening_month"},{"base_type":"type/Text","display_name":"Screening Month Fmt","name":"screening_month_fmt"},{"base_type":"type/Integer","display_name":"Total","name":"total"},{"base_type":"type/Integer","display_name":"Non Presumptives","name":"non_presumptives"},{"base_type":"type/Integer","display_name":"Presumptives","name":"presumptives"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"native","name":"Screening Summary","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"native","native":{"query":"SELECT \\r\\n    to_char(e.eventdate, 'Mon, YYYY') screening_Month, \\r\\n    MAX(to_char(e.eventdate, 'YYYY-MM')) screening_Month_fmt, \\r\\n    COUNT(DISTINCT baseentityid) total, \\r\\n    SUM(CASE WHEN o ->> 'formSubmissionField' = 'presumptive' AND (o ->> 'values' = '[\\"no\\"]' OR o ->> 'humanReadableValues' = '[\\"no\\"]') THEN 1 ELSE 0 END) non_Presumptives,\\r\\n    SUM(CASE WHEN o ->> 'formSubmissionField' = 'presumptive' AND (o ->> 'values' = '[\\"yes\\"]' OR o ->> 'humanReadableValues' = '[\\"yes\\"]') THEN 1 ELSE 0 END) presumptives\\r\\n    FROM event e, jsonb_array_elements(e.obs) as o WHERE e.eventtype='Screening' \\r\\nGROUP BY screening_Month\\r\\nORDER BY screening_Month_fmt DESC\\r\\nLIMIT 12","collection":"address","template_tags":{}}},"id":4,"display":"table","visualization_settings":{"table.columns":[{"name":"screening_month","enabled":true},{"name":"screening_month_fmt","enabled":false},{"name":"total","enabled":true},{"name":"non_presumptives","enabled":true},{"name":"presumptives","enabled":true}]},"public_uuid":null}	f	f	\N
40	Card	5	1	2018-05-11 20:34:45.34+05	{"description":null,"archived":false,"table_id":null,"result_metadata":[{"base_type":"type/Text","display_name":"Screening Month","name":"screening_month"},{"base_type":"type/Text","display_name":"Screening Month Fmt","name":"screening_month_fmt"},{"base_type":"type/Integer","display_name":"Total","name":"total"},{"base_type":"type/Integer","display_name":"Non Presumptives","name":"non_presumptives"},{"base_type":"type/Integer","display_name":"Presumptives","name":"presumptives"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Screening Summary trend over past 12 months","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":-1337,"type":"query","query":{"source_table":"card__4"}},"id":5,"display":"bar","visualization_settings":{"graph.dimensions":["screening_month"],"graph.metrics":["non_presumptives","presumptives"],"stackable.stack_type":null,"graph.y_axis.labels_enabled":false,"graph.y_axis.auto_split":false,"graph.y_axis.axis_enabled":true},"public_uuid":null}	f	f	\N
41	Card	5	1	2018-05-11 20:36:46.55+05	{"description":null,"archived":false,"table_id":null,"result_metadata":[{"base_type":"type/Text","display_name":"Screening Month","name":"screening_month"},{"base_type":"type/Text","display_name":"Screening Month Fmt","name":"screening_month_fmt"},{"base_type":"type/Integer","display_name":"Total","name":"total"},{"base_type":"type/Integer","display_name":"Non Presumptives","name":"non_presumptives"},{"base_type":"type/Integer","display_name":"Presumptives","name":"presumptives"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Screening Summary trend over past 12 months","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":-1337,"type":"query","query":{"source_table":"card__4"}},"id":5,"display":"bar","visualization_settings":{"graph.dimensions":["screening_month"],"graph.metrics":["non_presumptives","presumptives"],"stackable.stack_type":null,"graph.y_axis.labels_enabled":false,"graph.y_axis.auto_split":false,"graph.y_axis.axis_enabled":true},"public_uuid":null}	f	f	\N
46	Card	6	1	2018-05-12 10:24:17.276+05	{"description":null,"archived":false,"table_id":null,"result_metadata":[{"base_type":"type/Text","display_name":"Month","name":"_month"},{"base_type":"type/Text","display_name":"Month Fmt","name":"_month_fmt"},{"base_type":"type/Text","display_name":"Patient Type","name":"patient_type"},{"base_type":"type/Integer","display_name":"Total","name":"total"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"native","name":"Patient Types by Month","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"native","native":{"query":"SELECT \\r\\n    to_char(e.eventdate, 'Mon, YYYY') _month, \\r\\n    MAX(to_char(e.eventdate, 'YYYY-MM')) _month_fmt,\\r\\n    (o ->> 'humanReadableValues')::json->>0 patient_type, \\r\\n    COUNT(DISTINCT baseentityid) total\\r\\nFROM event e, jsonb_array_elements(e.obs) as o\\r\\nWHERE e.eventtype LIKE 'Treatment Initiation%' AND o ->> 'formSubmissionField'='patient_type'\\r\\nGROUP BY _Month, patient_type\\r\\nORDER BY _Month_fmt DESC\\r\\n","collection":"address","template_tags":{}}},"id":6,"display":"table","visualization_settings":{},"public_uuid":null}	f	t	\N
49	Card	7	1	2018-05-12 10:30:36.784+05	{"description":null,"archived":false,"table_id":null,"result_metadata":[{"base_type":"type/Text","display_name":"Patient Type","name":"patient_type"},{"base_type":"type/Integer","display_name":"sum","name":"sum"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Summary Patient Types Enrolled","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":-1337,"type":"query","query":{"source_table":"card__6","aggregation":[["sum",["field-id",["field-literal","total","type/Integer"]]]],"breakout":[["field-id",["field-literal","patient_type","type/Text"]]]}},"id":7,"display":"pie","visualization_settings":{"pie.dimension":"patient_type","pie.metric":"total"},"public_uuid":null}	f	t	\N
53	Card	6	1	2018-05-12 10:32:53.134+05	{"description":null,"archived":false,"table_id":null,"result_metadata":[{"base_type":"type/Text","display_name":"Month","name":"_month"},{"base_type":"type/Text","display_name":"Month Fmt","name":"_month_fmt"},{"base_type":"type/Text","display_name":"Patient Type","name":"patient_type"},{"base_type":"type/Integer","display_name":"Total","name":"total"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"native","name":"Patient Types by Month","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"native","native":{"query":"SELECT \\r\\n    to_char(e.eventdate, 'Mon, YYYY') _month, \\r\\n    MAX(to_char(e.eventdate, 'YYYY-MM')) _month_fmt,\\r\\n    (o ->> 'humanReadableValues')::json->>0 patient_type, \\r\\n    COUNT(DISTINCT baseentityid) total\\r\\nFROM event e, jsonb_array_elements(e.obs) as o\\r\\nWHERE e.eventtype LIKE 'Treatment Initiation%' AND o ->> 'formSubmissionField'='patient_type'\\r\\nGROUP BY _Month, patient_type\\r\\nORDER BY _Month_fmt DESC, total DESC\\r\\n","collection":"address","template_tags":{}}},"id":6,"display":"table","visualization_settings":{},"public_uuid":null}	f	f	\N
54	Card	7	1	2018-05-12 10:33:59.449+05	{"description":null,"archived":false,"table_id":null,"result_metadata":[{"base_type":"type/Text","display_name":"Patient Type","name":"patient_type"},{"base_type":"type/Integer","display_name":"sum","name":"sum"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Summary Patient Types Enrolled","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":-1337,"type":"query","query":{"source_table":"card__6","aggregation":[["sum",["field-id",["field-literal","total","type/Integer"]]]],"breakout":[["field-id",["field-literal","patient_type","type/Text"]]],"order_by":[[["aggregation",0],"descending"]]}},"id":7,"display":"pie","visualization_settings":{"pie.dimension":"patient_type","pie.metric":"total"},"public_uuid":null}	f	f	\N
57	Card	8	1	2018-05-12 11:37:41.513+05	{"description":null,"archived":false,"table_id":null,"result_metadata":[{"base_type":"type/Integer","display_name":"Total","name":"total"},{"base_type":"type/Integer","display_name":"Confirmed Tb Cases","name":"confirmed_tb_cases"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"native","name":"Summary TB Diagnosis","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"native","native":{"query":"SELECT COUNT(DISTINCT baseentityid) total, \\r\\nSUM(CASE WHEN o ->> 'formSubmissionField' = 'confirmed_tb' AND (o ->> 'values' = '[\\"yes\\"]' OR o ->> 'humanReadableValues' = '[\\"yes\\"]') THEN 1 ELSE 0 END) confirmed_tb_cases \\r\\nFROM event e, jsonb_array_elements(e.obs) as o WHERE e.eventtype='TB Diagnosis' \\r\\n","collection":"address","template_tags":{}}},"id":8,"display":"table","visualization_settings":{},"public_uuid":null}	f	t	\N
58	Card	8	1	2018-05-12 11:46:15.147+05	{"description":null,"archived":false,"table_id":null,"result_metadata":[{"base_type":"type/Text","display_name":"Nnt","name":"nnt"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"native","name":"Summary TB Diagnosis","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"native","native":{"query":"SELECT CONCAT(confirmed_tb_cases, '/', total, ' (', 100*confirmed_tb_cases/o.total, '%)') as nnt FROM (\\r\\n    SELECT COUNT(DISTINCT baseentityid) total, \\r\\n    SUM(CASE WHEN o ->> 'formSubmissionField' = 'confirmed_tb' AND (o ->> 'values' = '[\\"yes\\"]' OR o ->> 'humanReadableValues' = '[\\"yes\\"]') THEN 1 ELSE 0 END) confirmed_tb_cases \\r\\n    FROM event e, jsonb_array_elements(e.obs) as o \\r\\n    WHERE e.eventtype='TB Diagnosis' ) o\\r\\n","collection":"address","template_tags":{}}},"id":8,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	f	\N
59	Card	1	1	2018-05-12 11:46:53.386+05	{"description":"Number needed to treat","archived":false,"table_id":null,"result_metadata":[{"base_type":"type/Text","display_name":"Nnt","name":"nnt"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"native","name":"NNT","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"native","native":{"query":"SELECT CONCAT(confirmed_tb_cases, '/', total, ' (', 100*confirmed_tb_cases/o.total, '%)') as nnt FROM (\\r\\n    SELECT COUNT(DISTINCT baseentityid) total, \\r\\n    SUM(CASE WHEN o ->> 'formSubmissionField' = 'confirmed_tb' AND (o ->> 'values' = '[\\"yes\\"]' OR o ->> 'humanReadableValues' = '[\\"yes\\"]') THEN 1 ELSE 0 END) confirmed_tb_cases \\r\\n    FROM event e, jsonb_array_elements(e.obs) as o \\r\\n    WHERE e.eventtype='TB Diagnosis' ) o\\r\\n","collection":"address","template_tags":{}}},"id":1,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	f	\N
60	Card	1	1	2018-05-12 11:48:14.92+05	{"description":"Number needed to treat","archived":false,"table_id":null,"result_metadata":[{"base_type":"type/Text","display_name":"Nnt","name":"nnt"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"native","name":"NNT","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"native","native":{"query":"SELECT CONCAT(confirmed_tb_cases, ' (', 100*confirmed_tb_cases/o.total, '%)') as nnt FROM (\\r\\n    SELECT COUNT(DISTINCT baseentityid) total, \\r\\n    SUM(CASE WHEN o ->> 'formSubmissionField' = 'confirmed_tb' AND (o ->> 'values' = '[\\"yes\\"]' OR o ->> 'humanReadableValues' = '[\\"yes\\"]') THEN 1 ELSE 0 END) confirmed_tb_cases \\r\\n    FROM event e, jsonb_array_elements(e.obs) as o \\r\\n    WHERE e.eventtype='TB Diagnosis' ) o\\r\\n","collection":"address","template_tags":{}}},"id":1,"display":"scalar","visualization_settings":{},"public_uuid":null}	f	f	\N
61	Card	8	1	2018-05-12 12:16:08.778+05	{"description":null,"archived":false,"table_id":null,"result_metadata":[{"base_type":"type/Integer","display_name":"Confirmed Tb Cases","name":"confirmed_tb_cases"},{"base_type":"type/Text","display_name":"Diagnosis Method","name":"diagnosis_method"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"native","name":"Summary TB Diagnosis","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"native","native":{"query":"SELECT \\r\\nCOUNT(DISTINCT baseentityid) confirmed_tb_cases,  o ->> 'humanReadableValues' diagnosis_method \\r\\nFROM event e, jsonb_array_elements(e.obs) as o \\r\\nWHERE e.eventtype='TB Diagnosis' AND o->>'formSubmissionField'='diagnosis_type'\\r\\nGROUP BY diagnosis_method\\r\\n","collection":"address","template_tags":{}}},"id":8,"display":"table","visualization_settings":{},"public_uuid":null}	f	f	\N
62	Card	9	1	2018-05-12 12:17:28.47+05	{"description":null,"archived":false,"table_id":null,"result_metadata":[{"base_type":"type/Integer","display_name":"Confirmed Tb Cases","name":"confirmed_tb_cases"},{"base_type":"type/Text","display_name":"Diagnosis Method","name":"diagnosis_method"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Summary TB Diagnoses Type","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":-1337,"type":"query","query":{"source_table":"card__8"}},"id":9,"display":"pie","visualization_settings":{"pie.dimension":"diagnosis_method","pie.metric":"confirmed_tb_cases"},"public_uuid":null}	f	t	\N
63	Card	8	1	2018-05-12 12:21:16.687+05	{"description":null,"archived":false,"table_id":null,"result_metadata":[{"base_type":"type/Integer","display_name":"Confirmed Tb Cases","name":"confirmed_tb_cases"},{"base_type":"type/Text","display_name":"Diagnosis Method","name":"diagnosis_method"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"native","name":"Summary TB Diagnosis","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"native","native":{"query":"SELECT \\r\\nCOUNT(DISTINCT baseentityid) confirmed_tb_cases,  (o ->> 'humanReadableValues')::json->>0 diagnosis_method \\r\\nFROM event e, jsonb_array_elements(e.obs) as o \\r\\nWHERE e.eventtype='TB Diagnosis' AND o->>'formSubmissionField'='diagnosis_type'\\r\\nGROUP BY diagnosis_method\\r\\n","collection":"address","template_tags":{}}},"id":8,"display":"table","visualization_settings":{},"public_uuid":null}	f	f	\N
71	Card	10	1	2018-05-12 14:03:50.408+05	{"description":null,"archived":false,"table_id":null,"result_metadata":[{"base_type":"type/Integer","display_name":"Confirmed Tb Cases","name":"confirmed_tb_cases"},{"base_type":"type/Text","display_name":"Diagnosis Method","name":"diagnosis_method"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"native","name":"Treatment Summary","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"native","native":{"query":" -- (o ->> 'humanReadableValues')::json->>0\\r\\nSELECT \\r\\nCOUNT(DISTINCT baseentityid) confirmed_tb_cases,  (o ->> 'humanReadableValues')::json->>0 diagnosis_method \\r\\nFROM event e, jsonb_array_elements(e.obs) as o \\r\\nWHERE e.eventtype LIKE 'Treatment Initiation%' AND (o->>'formSubmissionField'='site_of_disease' OR o->>'formSubmissionField'='treatment_phase')\\r\\nGROUP BY diagnosis_method\\r\\n","collection":"address","template_tags":{}}},"id":10,"display":"table","visualization_settings":{},"public_uuid":null}	f	t	\N
72	Card	10	1	2018-05-12 14:07:49.413+05	{"description":null,"archived":false,"table_id":null,"result_metadata":[{"base_type":"type/Integer","display_name":"Confirmed Tb Cases","name":"confirmed_tb_cases"},{"base_type":"type/Text","display_name":"Diagnosis Method","name":"diagnosis_method"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"native","name":"Treatment Summary","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"native","native":{"query":" -- (o ->> 'humanReadableValues')::json->>0\\r\\nSELECT \\r\\nCOUNT(DISTINCT baseentityid) confirmed_tb_cases,  (o ->> 'humanReadableValues')::json->>0 diagnosis_method \\r\\nFROM event e, jsonb_array_elements(e.obs) as o \\r\\nWHERE e.eventtype LIKE 'Treatment Initiation%' AND (o->>'formSubmissionField'='site_of_disease' OR o->>'formSubmissionField'='treatment_phase' OR o->>'formSubmissionField'='patient_type')\\r\\nGROUP BY diagnosis_method\\r\\n","collection":"address","template_tags":{}}},"id":10,"display":"table","visualization_settings":{},"public_uuid":null}	f	f	\N
73	Card	10	1	2018-05-12 14:20:38.938+05	{"description":null,"archived":false,"table_id":null,"result_metadata":[{"base_type":"type/Text","display_name":"Formsubmissionfield","name":"formsubmissionfield"},{"base_type":"type/Integer","display_name":"Confirmed Tb Cases","name":"confirmed_tb_cases"},{"base_type":"type/Text","display_name":"Diagnosis Method","name":"diagnosis_method"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"native","name":"Treatment Summary","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"native","native":{"query":" -- (o ->> 'humanReadableValues')::json->>0\\r\\nSELECT \\r\\no->>'formSubmissionField' formSubmissionField, \\r\\nCOUNT(DISTINCT baseentityid) confirmed_tb_cases,  (o ->> 'humanReadableValues')::json->>0 diagnosis_method \\r\\nFROM event e, jsonb_array_elements(e.obs) as o \\r\\nWHERE e.eventtype LIKE 'Treatment Initiation%' AND (o->>'formSubmissionField'='site_of_disease' OR o->>'formSubmissionField'='treatment_phase' OR o->>'formSubmissionField'='patient_type')\\r\\nGROUP BY formSubmissionField, diagnosis_method\\r\\n","collection":"address","template_tags":{}}},"id":10,"display":"table","visualization_settings":{},"public_uuid":null}	f	f	\N
74	Card	7	1	2018-05-12 14:22:06.94+05	{"description":null,"archived":false,"table_id":null,"result_metadata":[{"base_type":"type/Text","display_name":"Formsubmissionfield","name":"formsubmissionfield"},{"base_type":"type/Integer","display_name":"Confirmed Tb Cases","name":"confirmed_tb_cases"},{"base_type":"type/Text","display_name":"Diagnosis Method","name":"diagnosis_method"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Summary Patient Types Enrolled","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":-1337,"type":"query","query":{"source_table":"card__10","filter":["AND",["=",["field-id",["field-literal","formsubmissionfield","type/Text"]],"patient_type"]],"order_by":[[["field-id",["field-literal","confirmed_tb_cases","type/Integer"]],"descending"]]}},"id":7,"display":"pie","visualization_settings":{"pie.dimension":"diagnosis_method"},"public_uuid":null}	f	f	\N
77	Card	11	1	2018-05-12 14:30:28.379+05	{"description":null,"archived":false,"table_id":null,"result_metadata":[{"base_type":"type/Text","display_name":"Formsubmissionfield","name":"formsubmissionfield"},{"base_type":"type/Integer","display_name":"Confirmed Tb Cases","name":"confirmed_tb_cases"},{"base_type":"type/Text","display_name":"Diagnosis Method","name":"diagnosis_method"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"query","name":"Treatment Summary TB","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":-1337,"type":"query","query":{"source_table":"card__10","filter":["AND",["!=",["field-id",["field-literal","formsubmissionfield","type/Text"]],"patient_type"]]}},"id":11,"display":"bar","visualization_settings":{"graph.dimensions":["formsubmissionfield","diagnosis_method"],"graph.metrics":["confirmed_tb_cases"],"stackable.stack_type":"stacked","graph.x_axis.labels_enabled":false,"graph.y_axis.labels_enabled":true},"public_uuid":null}	f	t	\N
79	Dashboard	1	1	2018-05-12 14:31:28.077+05	{"description":"Summary of Program showing main indicators and status of program","name":"Summary Program","cards":[{"sizeX":4,"sizeY":3,"row":0,"col":8,"id":2,"card_id":1,"series":[]},{"sizeX":4,"sizeY":3,"row":0,"col":0,"id":4,"card_id":3,"series":[]},{"sizeX":4,"sizeY":3,"row":0,"col":4,"id":5,"card_id":2,"series":[]},{"sizeX":6,"sizeY":11,"row":0,"col":12,"id":6,"card_id":4,"series":[]},{"sizeX":12,"sizeY":7,"row":4,"col":0,"id":7,"card_id":5,"series":[]},{"sizeX":6,"sizeY":4,"row":11,"col":6,"id":8,"card_id":7,"series":[]},{"sizeX":6,"sizeY":4,"row":11,"col":0,"id":9,"card_id":9,"series":[]},{"sizeX":6,"sizeY":4,"row":11,"col":12,"id":10,"card_id":11,"series":[]}]}	f	f	\N
80	Dashboard	1	1	2018-05-12 14:31:28.09+05	{"description":"Summary of Program showing main indicators and status of program","name":"Summary Program","cards":[{"sizeX":4,"sizeY":3,"row":0,"col":8,"id":2,"card_id":1,"series":[]},{"sizeX":4,"sizeY":3,"row":0,"col":0,"id":4,"card_id":3,"series":[]},{"sizeX":4,"sizeY":3,"row":0,"col":4,"id":5,"card_id":2,"series":[]},{"sizeX":6,"sizeY":11,"row":0,"col":12,"id":6,"card_id":4,"series":[]},{"sizeX":12,"sizeY":7,"row":4,"col":0,"id":7,"card_id":5,"series":[]},{"sizeX":6,"sizeY":4,"row":11,"col":6,"id":8,"card_id":7,"series":[]},{"sizeX":6,"sizeY":4,"row":11,"col":0,"id":9,"card_id":9,"series":[]},{"sizeX":6,"sizeY":4,"row":11,"col":12,"id":10,"card_id":11,"series":[]}]}	f	f	\N
81	Card	12	1	2018-05-12 15:00:13.555+05	{"description":null,"archived":false,"table_id":null,"result_metadata":[{"base_type":"type/Text","display_name":"Gender","name":"gender"},{"base_type":"type/Text","display_name":"Outcome","name":"outcome"},{"base_type":"type/Integer","display_name":"Confirmed Tb Cases","name":"confirmed_tb_cases"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"native","name":"Treatment Outcome Summary","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"native","native":{"query":" -- (o ->> 'humanReadableValues')::json->>0\\r\\nSELECT \\r\\nc.gender,  (o ->> 'humanReadableValues')::json->>0 outcome, COUNT(DISTINCT e.baseentityid) confirmed_tb_cases \\r\\nFROM event e join client c on e.baseentityid=c.baseentityid, jsonb_array_elements(e.obs) as o \\r\\nWHERE e.eventtype = 'Treatment Outcome' AND (o->>'formSubmissionField'='treatment_outcome')\\r\\nGROUP BY gender,outcome\\r\\n","collection":"address","template_tags":{}}},"id":12,"display":"table","visualization_settings":{},"public_uuid":null}	f	t	\N
82	Card	12	1	2018-05-12 15:18:02.529+05	{"description":null,"archived":false,"table_id":null,"result_metadata":[{"base_type":"type/Text","display_name":"Gender","name":"gender"},{"base_type":"type/Text","display_name":"Outcome","name":"outcome"},{"base_type":"type/Integer","display_name":"Confirmed Tb Cases","name":"confirmed_tb_cases"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"native","name":"Treatment Outcome Summary","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"native","native":{"query":" -- (o ->> 'humanReadableValues')::json->>0\\r\\nSELECT \\r\\nc.gender,  (o ->> 'humanReadableValues')::json->>0 outcome, COUNT(DISTINCT e.baseentityid) confirmed_tb_cases \\r\\nFROM event e join client c on e.baseentityid=c.baseentityid, jsonb_array_elements(e.obs) as o \\r\\nWHERE e.eventtype = 'Treatment Outcome' AND (o->>'formSubmissionField'='treatment_outcome')\\r\\nGROUP BY outcome, gender\\r\\n","collection":"address","template_tags":{}}},"id":12,"display":"table","visualization_settings":{},"public_uuid":null}	f	f	\N
83	Card	12	1	2018-05-12 15:20:36.886+05	{"description":null,"archived":false,"table_id":null,"result_metadata":[{"base_type":"type/Text","display_name":"Gender","name":"gender"},{"base_type":"type/Text","display_name":"Outcome","name":"outcome"},{"base_type":"type/Integer","display_name":"Confirmed Tb Cases","name":"confirmed_tb_cases"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"native","name":"Treatment Outcome Summary","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"native","native":{"query":" -- (o ->> 'humanReadableValues')::json->>0\\r\\nSELECT \\r\\nc.gender,  (o ->> 'humanReadableValues')::json->>0 outcome, COUNT(DISTINCT e.baseentityid) confirmed_tb_cases \\r\\nFROM event e join client c on e.baseentityid=c.baseentityid, jsonb_array_elements(e.obs) as o \\r\\nWHERE e.eventtype = 'Treatment Outcome' AND (o->>'formSubmissionField'='treatment_outcome')\\r\\nGROUP BY outcome, gender\\r\\n","collection":"address","template_tags":{}}},"id":12,"display":"line","visualization_settings":{"line.marker_enabled":true,"graph.show_goal":false,"graph.y_axis.auto_split":true,"graph.x_axis.title_text":"Treatment Outcome"},"public_uuid":null}	f	f	\N
88	Dashboard	2	1	2018-05-12 18:24:52.893+05	{"description":null,"name":"TB Reports","cards":[]}	f	t	\N
84	Dashboard	1	1	2018-05-12 15:21:27.633+05	{"description":"Summary of Program showing main indicators and status of program","name":"Summary Program","cards":[{"sizeX":4,"sizeY":3,"row":0,"col":8,"id":2,"card_id":1,"series":[]},{"sizeX":4,"sizeY":3,"row":0,"col":0,"id":4,"card_id":3,"series":[]},{"sizeX":4,"sizeY":3,"row":0,"col":4,"id":5,"card_id":2,"series":[]},{"sizeX":6,"sizeY":11,"row":0,"col":12,"id":6,"card_id":4,"series":[]},{"sizeX":12,"sizeY":7,"row":4,"col":0,"id":7,"card_id":5,"series":[]},{"sizeX":6,"sizeY":4,"row":11,"col":6,"id":8,"card_id":7,"series":[]},{"sizeX":6,"sizeY":4,"row":11,"col":0,"id":9,"card_id":9,"series":[]},{"sizeX":6,"sizeY":4,"row":11,"col":12,"id":10,"card_id":11,"series":[]},{"sizeX":2,"sizeY":2,"row":0,"col":0,"id":11,"card_id":12,"series":[]}]}	f	f	\N
85	Dashboard	1	1	2018-05-12 15:21:27.701+05	{"description":"Summary of Program showing main indicators and status of program","name":"Summary Program","cards":[{"sizeX":4,"sizeY":3,"row":0,"col":8,"id":2,"card_id":1,"series":[]},{"sizeX":4,"sizeY":3,"row":0,"col":0,"id":4,"card_id":3,"series":[]},{"sizeX":4,"sizeY":3,"row":0,"col":4,"id":5,"card_id":2,"series":[]},{"sizeX":6,"sizeY":11,"row":0,"col":12,"id":6,"card_id":4,"series":[]},{"sizeX":12,"sizeY":7,"row":4,"col":0,"id":7,"card_id":5,"series":[]},{"sizeX":6,"sizeY":4,"row":11,"col":6,"id":8,"card_id":7,"series":[]},{"sizeX":6,"sizeY":4,"row":11,"col":0,"id":9,"card_id":9,"series":[]},{"sizeX":6,"sizeY":4,"row":11,"col":12,"id":10,"card_id":11,"series":[]},{"sizeX":18,"sizeY":6,"row":15,"col":0,"id":11,"card_id":12,"series":[]}]}	f	f	\N
86	Dashboard	1	1	2018-05-12 15:21:27.734+05	{"description":"Summary of Program showing main indicators and status of program","name":"Summary Program","cards":[{"sizeX":4,"sizeY":3,"row":0,"col":8,"id":2,"card_id":1,"series":[]},{"sizeX":4,"sizeY":3,"row":0,"col":0,"id":4,"card_id":3,"series":[]},{"sizeX":4,"sizeY":3,"row":0,"col":4,"id":5,"card_id":2,"series":[]},{"sizeX":6,"sizeY":11,"row":0,"col":12,"id":6,"card_id":4,"series":[]},{"sizeX":12,"sizeY":7,"row":4,"col":0,"id":7,"card_id":5,"series":[]},{"sizeX":6,"sizeY":4,"row":11,"col":6,"id":8,"card_id":7,"series":[]},{"sizeX":6,"sizeY":4,"row":11,"col":0,"id":9,"card_id":9,"series":[]},{"sizeX":6,"sizeY":4,"row":11,"col":12,"id":10,"card_id":11,"series":[]},{"sizeX":18,"sizeY":6,"row":15,"col":0,"id":11,"card_id":12,"series":[]}]}	f	f	\N
87	Card	12	1	2018-05-12 15:23:01.72+05	{"description":null,"archived":false,"table_id":null,"result_metadata":[{"base_type":"type/Text","display_name":"Gender","name":"gender"},{"base_type":"type/Text","display_name":"Outcome","name":"outcome"},{"base_type":"type/Integer","display_name":"Confirmed Tb Cases","name":"confirmed_tb_cases"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"native","name":"Treatment Outcome Summary","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"native","native":{"query":" -- (o ->> 'humanReadableValues')::json->>0\\r\\nSELECT \\r\\nc.gender,  (o ->> 'humanReadableValues')::json->>0 outcome, COUNT(DISTINCT e.baseentityid) confirmed_tb_cases \\r\\nFROM event e join client c on e.baseentityid=c.baseentityid, jsonb_array_elements(e.obs) as o \\r\\nWHERE e.eventtype = 'Treatment Outcome' AND (o->>'formSubmissionField'='treatment_outcome')\\r\\nGROUP BY outcome, gender\\r\\n","collection":"address","template_tags":{}}},"id":12,"display":"line","visualization_settings":{"line.marker_enabled":true,"graph.show_goal":false,"graph.y_axis.auto_split":true,"graph.x_axis.title_text":"Treatment Outcome","graph.dimensions":["outcome","gender"],"graph.metrics":["confirmed_tb_cases"]},"public_uuid":null}	f	f	\N
89	Card	13	1	2018-05-12 19:31:59.423+05	{"description":null,"archived":false,"table_id":null,"result_metadata":[{"base_type":"type/Text","display_name":"Screening Date","name":"screening_date"},{"base_type":"type/Text","display_name":"Name","name":"_name"},{"base_type":"type/Text","display_name":"Last Name","name":"last_name"},{"base_type":"type/Text","display_name":"Address","name":"address"},{"base_type":"type/Text","display_name":"Phone Number","name":"phone_number"},{"base_type":"type/Integer","display_name":"Eventid","name":"eventid"},{"base_type":"type/*","display_name":"Identifiers","name":"identifiers"},{"base_type":"type/*","display_name":"Duration","name":"duration"},{"base_type":"type/Text","display_name":"Entitytype","name":"entitytype"},{"base_type":"type/DateTime","display_name":"Eventdate","name":"eventdate"},{"base_type":"type/Text","display_name":"Eventtype","name":"eventtype"},{"base_type":"type/Text","display_name":"Formsubmissionid","name":"formsubmissionid"},{"base_type":"type/Text","display_name":"Locationid","name":"locationid"},{"base_type":"type/Text","display_name":"Providerid","name":"providerid"},{"base_type":"type/Text","display_name":"Teamid","name":"teamid"},{"base_type":"type/*","display_name":"Status","name":"status"},{"base_type":"type/*","display_name":"Category","name":"category"},{"base_type":"type/*","display_name":"Reason","name":"reason"},{"base_type":"type/*","display_name":"Details","name":"details"},{"base_type":"type/*","display_name":"Obs","name":"obs"},{"base_type":"type/DateTime","display_name":"Datecreated","name":"datecreated"},{"base_type":"type/*","display_name":"Dateedited","name":"dateedited"},{"base_type":"type/*","display_name":"Voided","name":"voided"},{"base_type":"type/*","display_name":"Datevoided","name":"dateVoided"},{"base_type":"type/*","display_name":"Voidreason","name":"voidreason"},{"base_type":"type/*","display_name":"Creator","name":"creator"},{"base_type":"type/*","display_name":"Editor","name":"editor"},{"base_type":"type/*","display_name":"Voider","name":"voider"},{"base_type":"type/Integer","display_name":"Serverversion","name":"serverversion"},{"base_type":"type/Text","display_name":"ID","name":"_id"},{"base_type":"type/Text","display_name":"Baseentityid","name":"baseentityid"},{"base_type":"type/*","display_name":"Clientid","name":"clientid"},{"base_type":"type/*","display_name":"Fulldetails","name":"fulldetails"},{"base_type":"type/Integer","display_name":"Presumptive","name":"presumptive"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"native","name":"TB-01","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"native","native":{"query":"SELECT to_char(e.eventdate, 'dd-MM-yyyy') screening_date, c.firstname _name, c.lastname last_name, \\r\\nCONCAT(coalesce(a->'addressFields'->>'address1', ''), ', ', a->>'subTown', ', town: ', a->>'town', ', ', a->>'cityVillage') address,\\r\\nc.attributes->>'Primary Contact Number' phone_number,\\r\\n\\r\\n e.*,\\r\\n    -- to_char(e.eventdate, 'Mon, YYYY') screening_Month, \\r\\n    CASE WHEN o ->> 'formSubmissionField' = 'presumptive' AND (o ->> 'values' = '[\\"yes\\"]' OR o ->> 'humanReadableValues' = '[\\"yes\\"]') THEN 1 ELSE 0 END presumptive\\r\\nFROM event e JOIN client c ON e.baseentityid=c.baseentityid, jsonb_array_elements(c.addresses) as a, jsonb_array_elements(e.obs) as o \\r\\nWHERE e.eventtype='Screening' AND a ->> 'addressType' = 'usual_residence'\\r\\nAND (CASE WHEN o ->> 'formSubmissionField' = 'presumptive' AND (o ->> 'values' = '[\\"yes\\"]' OR o ->> 'humanReadableValues' = '[\\"yes\\"]') THEN TRUE ELSE FALSE END) \\r\\n","collection":"address","template_tags":{}}},"id":13,"display":"table","visualization_settings":{},"public_uuid":null}	f	t	\N
90	Card	13	1	2018-05-12 20:48:56.419+05	{"description":null,"archived":false,"table_id":null,"result_metadata":[{"base_type":"type/Text","display_name":"Identifier","name":"identifier"},{"base_type":"type/Text","display_name":"Screening Date","name":"screening_date"},{"base_type":"type/Text","display_name":"Name","name":"_name"},{"base_type":"type/Text","display_name":"Last Name","name":"last_name"},{"base_type":"type/Text","display_name":"Address","name":"address"},{"base_type":"type/Text","display_name":"Phone Number","name":"phone_number"},{"base_type":"type/Integer","display_name":"Eventid","name":"eventid"},{"base_type":"type/*","display_name":"Identifiers","name":"identifiers"},{"base_type":"type/*","display_name":"Duration","name":"duration"},{"base_type":"type/Text","display_name":"Entitytype","name":"entitytype"},{"base_type":"type/DateTime","display_name":"Eventdate","name":"eventdate"},{"base_type":"type/Text","display_name":"Eventtype","name":"eventtype"},{"base_type":"type/Text","display_name":"Formsubmissionid","name":"formsubmissionid"},{"base_type":"type/Text","display_name":"Locationid","name":"locationid"},{"base_type":"type/Text","display_name":"Providerid","name":"providerid"},{"base_type":"type/Text","display_name":"Teamid","name":"teamid"},{"base_type":"type/*","display_name":"Status","name":"status"},{"base_type":"type/*","display_name":"Category","name":"category"},{"base_type":"type/*","display_name":"Reason","name":"reason"},{"base_type":"type/*","display_name":"Details","name":"details"},{"base_type":"type/*","display_name":"Obs","name":"obs"},{"base_type":"type/DateTime","display_name":"Datecreated","name":"datecreated"},{"base_type":"type/*","display_name":"Dateedited","name":"dateedited"},{"base_type":"type/*","display_name":"Voided","name":"voided"},{"base_type":"type/*","display_name":"Datevoided","name":"dateVoided"},{"base_type":"type/*","display_name":"Voidreason","name":"voidreason"},{"base_type":"type/*","display_name":"Creator","name":"creator"},{"base_type":"type/*","display_name":"Editor","name":"editor"},{"base_type":"type/*","display_name":"Voider","name":"voider"},{"base_type":"type/Integer","display_name":"Serverversion","name":"serverversion"},{"base_type":"type/Text","display_name":"ID","name":"_id"},{"base_type":"type/Text","display_name":"Baseentityid","name":"baseentityid"},{"base_type":"type/*","display_name":"Clientid","name":"clientid"},{"base_type":"type/*","display_name":"Fulldetails","name":"fulldetails"},{"base_type":"type/Integer","display_name":"Presumptive","name":"presumptive"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"native","name":"TB-01","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"native","native":{"query":"SELECT c.identifiers->>'TBREACH ID' identifier, to_char(e.eventdate, 'dd-MM-yyyy') screening_date, c.firstname _name, c.lastname last_name, \\r\\nCONCAT(coalesce(a->'addressFields'->>'address1', ''), ', ', a->>'subTown', ', town: ', a->>'town', ', ', a->>'cityVillage') address,\\r\\nc.attributes->>'Primary Contact Number' phone_number,\\r\\n\\r\\n e.*,\\r\\n    -- to_char(e.eventdate, 'Mon, YYYY') screening_Month, \\r\\n    CASE WHEN o ->> 'formSubmissionField' = 'presumptive' AND (o ->> 'values' = '[\\"yes\\"]' OR o ->> 'humanReadableValues' = '[\\"yes\\"]') THEN 1 ELSE 0 END presumptive\\r\\nFROM event e JOIN client c ON e.baseentityid=c.baseentityid, jsonb_array_elements(c.addresses) as a, jsonb_array_elements(e.obs) as o \\r\\nWHERE e.eventtype='Screening' AND a ->> 'addressType' = 'usual_residence'\\r\\nAND (CASE WHEN o ->> 'formSubmissionField' = 'presumptive' AND (o ->> 'values' = '[\\"yes\\"]' OR o ->> 'humanReadableValues' = '[\\"yes\\"]') THEN TRUE ELSE FALSE END) \\r\\n","collection":"address","template_tags":{}}},"id":13,"display":"table","visualization_settings":{},"public_uuid":null}	f	f	\N
99	Dashboard	1	1	2018-05-25 07:08:12.022+05	{"description":"Summary of Program showing main indicators and status of program","name":"Summary Program","cards":[{"sizeX":7,"sizeY":3,"row":0,"col":11,"id":2,"card_id":1,"series":[]},{"sizeX":5,"sizeY":3,"row":0,"col":0,"id":4,"card_id":3,"series":[]},{"sizeX":6,"sizeY":3,"row":0,"col":5,"id":5,"card_id":2,"series":[]},{"sizeX":9,"sizeY":11,"row":3,"col":9,"id":6,"card_id":4,"series":[]},{"sizeX":9,"sizeY":11,"row":3,"col":0,"id":7,"card_id":5,"series":[]},{"sizeX":9,"sizeY":6,"row":14,"col":0,"id":8,"card_id":7,"series":[]},{"sizeX":9,"sizeY":6,"row":14,"col":9,"id":9,"card_id":9,"series":[]},{"sizeX":5,"sizeY":6,"row":20,"col":13,"id":10,"card_id":11,"series":[]},{"sizeX":13,"sizeY":6,"row":20,"col":0,"id":11,"card_id":12,"series":[]}]}	f	f	\N
91	Card	13	1	2018-05-12 21:20:25.129+05	{"description":null,"archived":false,"table_id":null,"result_metadata":[{"base_type":"type/Text","display_name":"Identifier","name":"identifier"},{"base_type":"type/Text","display_name":"Screening Date","name":"screening_date"},{"base_type":"type/Text","display_name":"Name","name":"_name"},{"base_type":"type/Text","display_name":"Last Name","name":"last_name"},{"base_type":"type/Text","display_name":"Address","name":"address"},{"base_type":"type/Text","display_name":"Phone Number","name":"phone_number"},{"base_type":"type/Text","display_name":"Dob Age","name":"dob_age"},{"base_type":"type/Integer","display_name":"Eventid","name":"eventid"},{"base_type":"type/*","display_name":"Identifiers","name":"identifiers"},{"base_type":"type/*","display_name":"Duration","name":"duration"},{"base_type":"type/Text","display_name":"Entitytype","name":"entitytype"},{"base_type":"type/DateTime","display_name":"Eventdate","name":"eventdate"},{"base_type":"type/Text","display_name":"Eventtype","name":"eventtype"},{"base_type":"type/Text","display_name":"Formsubmissionid","name":"formsubmissionid"},{"base_type":"type/Text","display_name":"Locationid","name":"locationid"},{"base_type":"type/Text","display_name":"Providerid","name":"providerid"},{"base_type":"type/Text","display_name":"Teamid","name":"teamid"},{"base_type":"type/*","display_name":"Status","name":"status"},{"base_type":"type/*","display_name":"Category","name":"category"},{"base_type":"type/*","display_name":"Reason","name":"reason"},{"base_type":"type/*","display_name":"Details","name":"details"},{"base_type":"type/*","display_name":"Obs","name":"obs"},{"base_type":"type/DateTime","display_name":"Datecreated","name":"datecreated"},{"base_type":"type/*","display_name":"Dateedited","name":"dateedited"},{"base_type":"type/*","display_name":"Voided","name":"voided"},{"base_type":"type/*","display_name":"Datevoided","name":"dateVoided"},{"base_type":"type/*","display_name":"Voidreason","name":"voidreason"},{"base_type":"type/*","display_name":"Creator","name":"creator"},{"base_type":"type/*","display_name":"Editor","name":"editor"},{"base_type":"type/*","display_name":"Voider","name":"voider"},{"base_type":"type/Integer","display_name":"Serverversion","name":"serverversion"},{"base_type":"type/Text","display_name":"ID","name":"_id"},{"base_type":"type/Text","display_name":"Baseentityid","name":"baseentityid"},{"base_type":"type/*","display_name":"Clientid","name":"clientid"},{"base_type":"type/*","display_name":"Fulldetails","name":"fulldetails"},{"base_type":"type/Integer","display_name":"Presumptive","name":"presumptive"}],"database_id":2,"enable_embedding":false,"collection_id":null,"query_type":"native","name":"TB-01","creator_id":1,"made_public_by_id":null,"embedding_params":null,"cache_ttl":null,"dataset_query":{"database":2,"type":"native","native":{"query":"SELECT c.identifiers->>'TBREACH ID' identifier, to_char(e.eventdate, 'dd-MM-yyyy') screening_date, c.firstname _name, c.lastname last_name, \\r\\nCONCAT(coalesce(a->'addressFields'->>'address1', ''), ', ', a->>'subTown', ', town: ', a->>'town', ', ', a->>'cityVillage') address,\\r\\nc.attributes->>'Primary Contact Number' phone_number, CONCAT(to_char(c.birthdate, 'dd-MM-yyyy'), ' (', DATE_PART('year', e.eventdate) - DATE_PART('year', c.birthdate), ')') dob_age,\\r\\n\\r\\n e.*,\\r\\n    -- to_char(e.eventdate, 'Mon, YYYY') screening_Month, \\r\\n    CASE WHEN o ->> 'formSubmissionField' = 'presumptive' AND (o ->> 'values' = '[\\"yes\\"]' OR o ->> 'humanReadableValues' = '[\\"yes\\"]') THEN 1 ELSE 0 END presumptive\\r\\nFROM event e JOIN client c ON e.baseentityid=c.baseentityid, jsonb_array_elements(c.addresses) as a, jsonb_array_elements(e.obs) as o \\r\\nWHERE e.eventtype='Screening' AND a ->> 'addressType' = 'usual_residence'\\r\\nAND (CASE WHEN o ->> 'formSubmissionField' = 'presumptive' AND (o ->> 'values' = '[\\"yes\\"]' OR o ->> 'humanReadableValues' = '[\\"yes\\"]') THEN TRUE ELSE FALSE END) \\r\\n","collection":"address","template_tags":{}}},"id":13,"display":"table","visualization_settings":{},"public_uuid":null}	f	f	\N
92	Dashboard	1	1	2018-05-22 09:45:37.739+05	{"description":"Summary of Program showing main indicators and status of program","name":"Summary Program","cards":[{"sizeX":4,"sizeY":3,"row":0,"col":8,"id":2,"card_id":1,"series":[]},{"sizeX":4,"sizeY":3,"row":0,"col":0,"id":4,"card_id":3,"series":[]},{"sizeX":4,"sizeY":3,"row":0,"col":4,"id":5,"card_id":2,"series":[]},{"sizeX":6,"sizeY":11,"row":0,"col":12,"id":6,"card_id":4,"series":[]},{"sizeX":12,"sizeY":8,"row":3,"col":0,"id":7,"card_id":5,"series":[]},{"sizeX":6,"sizeY":4,"row":11,"col":6,"id":8,"card_id":7,"series":[]},{"sizeX":6,"sizeY":4,"row":11,"col":0,"id":9,"card_id":9,"series":[]},{"sizeX":6,"sizeY":4,"row":11,"col":12,"id":10,"card_id":11,"series":[]},{"sizeX":18,"sizeY":6,"row":15,"col":0,"id":11,"card_id":12,"series":[]}]}	f	f	\N
93	Dashboard	1	1	2018-05-22 09:45:37.829+05	{"description":"Summary of Program showing main indicators and status of program","name":"Summary Program","cards":[{"sizeX":4,"sizeY":3,"row":0,"col":8,"id":2,"card_id":1,"series":[]},{"sizeX":4,"sizeY":3,"row":0,"col":0,"id":4,"card_id":3,"series":[]},{"sizeX":4,"sizeY":3,"row":0,"col":4,"id":5,"card_id":2,"series":[]},{"sizeX":6,"sizeY":11,"row":0,"col":12,"id":6,"card_id":4,"series":[]},{"sizeX":12,"sizeY":8,"row":3,"col":0,"id":7,"card_id":5,"series":[]},{"sizeX":6,"sizeY":4,"row":11,"col":6,"id":8,"card_id":7,"series":[]},{"sizeX":6,"sizeY":4,"row":11,"col":0,"id":9,"card_id":9,"series":[]},{"sizeX":6,"sizeY":4,"row":11,"col":12,"id":10,"card_id":11,"series":[]},{"sizeX":18,"sizeY":6,"row":15,"col":0,"id":11,"card_id":12,"series":[]}]}	f	f	\N
94	Dashboard	1	1	2018-05-25 07:00:22.331+05	{"description":"Summary of Program showing main indicators and status of program","name":"Summary Program","cards":[{"sizeX":6,"sizeY":3,"row":0,"col":12,"id":2,"card_id":1,"series":[]},{"sizeX":5,"sizeY":3,"row":0,"col":0,"id":4,"card_id":3,"series":[]},{"sizeX":5,"sizeY":3,"row":0,"col":6,"id":5,"card_id":2,"series":[]},{"sizeX":6,"sizeY":11,"row":3,"col":12,"id":6,"card_id":4,"series":[]},{"sizeX":12,"sizeY":11,"row":3,"col":0,"id":7,"card_id":5,"series":[]},{"sizeX":6,"sizeY":4,"row":14,"col":6,"id":8,"card_id":7,"series":[]},{"sizeX":6,"sizeY":4,"row":14,"col":0,"id":9,"card_id":9,"series":[]},{"sizeX":6,"sizeY":4,"row":14,"col":12,"id":10,"card_id":11,"series":[]},{"sizeX":18,"sizeY":6,"row":18,"col":0,"id":11,"card_id":12,"series":[]}]}	f	f	\N
95	Dashboard	1	1	2018-05-25 07:00:22.453+05	{"description":"Summary of Program showing main indicators and status of program","name":"Summary Program","cards":[{"sizeX":6,"sizeY":3,"row":0,"col":12,"id":2,"card_id":1,"series":[]},{"sizeX":5,"sizeY":3,"row":0,"col":0,"id":4,"card_id":3,"series":[]},{"sizeX":5,"sizeY":3,"row":0,"col":6,"id":5,"card_id":2,"series":[]},{"sizeX":6,"sizeY":11,"row":3,"col":12,"id":6,"card_id":4,"series":[]},{"sizeX":12,"sizeY":11,"row":3,"col":0,"id":7,"card_id":5,"series":[]},{"sizeX":6,"sizeY":4,"row":14,"col":6,"id":8,"card_id":7,"series":[]},{"sizeX":6,"sizeY":4,"row":14,"col":0,"id":9,"card_id":9,"series":[]},{"sizeX":6,"sizeY":4,"row":14,"col":12,"id":10,"card_id":11,"series":[]},{"sizeX":18,"sizeY":6,"row":18,"col":0,"id":11,"card_id":12,"series":[]}]}	f	f	\N
96	Dashboard	1	1	2018-05-25 07:05:08.463+05	{"description":"Summary of Program showing main indicators and status of program","name":"Summary Program","cards":[{"sizeX":6,"sizeY":3,"row":0,"col":12,"id":2,"card_id":1,"series":[]},{"sizeX":5,"sizeY":3,"row":0,"col":0,"id":4,"card_id":3,"series":[]},{"sizeX":5,"sizeY":3,"row":0,"col":6,"id":5,"card_id":2,"series":[]},{"sizeX":8,"sizeY":11,"row":3,"col":10,"id":6,"card_id":4,"series":[]},{"sizeX":9,"sizeY":11,"row":3,"col":0,"id":7,"card_id":5,"series":[]},{"sizeX":9,"sizeY":6,"row":14,"col":0,"id":8,"card_id":7,"series":[]},{"sizeX":6,"sizeY":4,"row":21,"col":12,"id":9,"card_id":9,"series":[]},{"sizeX":8,"sizeY":6,"row":14,"col":10,"id":10,"card_id":11,"series":[]},{"sizeX":12,"sizeY":5,"row":20,"col":0,"id":11,"card_id":12,"series":[]}]}	f	f	\N
97	Dashboard	1	1	2018-05-25 07:05:08.493+05	{"description":"Summary of Program showing main indicators and status of program","name":"Summary Program","cards":[{"sizeX":6,"sizeY":3,"row":0,"col":12,"id":2,"card_id":1,"series":[]},{"sizeX":5,"sizeY":3,"row":0,"col":0,"id":4,"card_id":3,"series":[]},{"sizeX":5,"sizeY":3,"row":0,"col":6,"id":5,"card_id":2,"series":[]},{"sizeX":8,"sizeY":11,"row":3,"col":10,"id":6,"card_id":4,"series":[]},{"sizeX":9,"sizeY":11,"row":3,"col":0,"id":7,"card_id":5,"series":[]},{"sizeX":9,"sizeY":6,"row":14,"col":0,"id":8,"card_id":7,"series":[]},{"sizeX":6,"sizeY":4,"row":21,"col":12,"id":9,"card_id":9,"series":[]},{"sizeX":8,"sizeY":6,"row":14,"col":10,"id":10,"card_id":11,"series":[]},{"sizeX":12,"sizeY":5,"row":20,"col":0,"id":11,"card_id":12,"series":[]}]}	f	f	\N
98	Dashboard	1	1	2018-05-25 07:08:12.003+05	{"description":"Summary of Program showing main indicators and status of program","name":"Summary Program","cards":[{"sizeX":7,"sizeY":3,"row":0,"col":11,"id":2,"card_id":1,"series":[]},{"sizeX":5,"sizeY":3,"row":0,"col":0,"id":4,"card_id":3,"series":[]},{"sizeX":6,"sizeY":3,"row":0,"col":5,"id":5,"card_id":2,"series":[]},{"sizeX":9,"sizeY":11,"row":3,"col":9,"id":6,"card_id":4,"series":[]},{"sizeX":9,"sizeY":11,"row":3,"col":0,"id":7,"card_id":5,"series":[]},{"sizeX":9,"sizeY":6,"row":14,"col":0,"id":8,"card_id":7,"series":[]},{"sizeX":9,"sizeY":6,"row":14,"col":9,"id":9,"card_id":9,"series":[]},{"sizeX":5,"sizeY":6,"row":20,"col":13,"id":10,"card_id":11,"series":[]},{"sizeX":13,"sizeY":6,"row":20,"col":0,"id":11,"card_id":12,"series":[]}]}	f	f	\N
100	Dashboard	1	1	2018-05-25 07:09:04.848+05	{"description":"Summary of Program showing main indicators and status of program","name":"Summary Program","cards":[{"sizeX":7,"sizeY":3,"row":0,"col":11,"id":2,"card_id":1,"series":[]},{"sizeX":5,"sizeY":3,"row":0,"col":0,"id":4,"card_id":3,"series":[]},{"sizeX":6,"sizeY":3,"row":0,"col":5,"id":5,"card_id":2,"series":[]},{"sizeX":9,"sizeY":11,"row":3,"col":9,"id":6,"card_id":4,"series":[]},{"sizeX":9,"sizeY":11,"row":3,"col":0,"id":7,"card_id":5,"series":[]},{"sizeX":9,"sizeY":6,"row":14,"col":0,"id":8,"card_id":7,"series":[]},{"sizeX":9,"sizeY":6,"row":14,"col":9,"id":9,"card_id":9,"series":[]},{"sizeX":6,"sizeY":6,"row":20,"col":12,"id":10,"card_id":11,"series":[]},{"sizeX":12,"sizeY":6,"row":20,"col":0,"id":11,"card_id":12,"series":[]}]}	f	f	\N
101	Dashboard	1	1	2018-05-25 07:09:04.868+05	{"description":"Summary of Program showing main indicators and status of program","name":"Summary Program","cards":[{"sizeX":7,"sizeY":3,"row":0,"col":11,"id":2,"card_id":1,"series":[]},{"sizeX":5,"sizeY":3,"row":0,"col":0,"id":4,"card_id":3,"series":[]},{"sizeX":6,"sizeY":3,"row":0,"col":5,"id":5,"card_id":2,"series":[]},{"sizeX":9,"sizeY":11,"row":3,"col":9,"id":6,"card_id":4,"series":[]},{"sizeX":9,"sizeY":11,"row":3,"col":0,"id":7,"card_id":5,"series":[]},{"sizeX":9,"sizeY":6,"row":14,"col":0,"id":8,"card_id":7,"series":[]},{"sizeX":9,"sizeY":6,"row":14,"col":9,"id":9,"card_id":9,"series":[]},{"sizeX":6,"sizeY":6,"row":20,"col":12,"id":10,"card_id":11,"series":[]},{"sizeX":12,"sizeY":6,"row":20,"col":0,"id":11,"card_id":12,"series":[]}]}	f	f	\N
\.


--
-- Name: revision_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('revision_id_seq', 101, true);


--
-- Data for Name: segment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY segment (id, table_id, creator_id, name, description, is_active, definition, created_at, updated_at, points_of_interest, caveats, show_in_getting_started) FROM stdin;
\.


--
-- Name: segment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('segment_id_seq', 1, false);


--
-- Data for Name: setting; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY setting (key, value) FROM stdin;
site-url	http://localhost:3000
site-name	IHS
admin-email	tbreach5.opensrp@gmail.com
anon-tracking-enabled	false
enable-advanced-humanization	false
enable-public-sharing	true
enable-embedding	true
embedding-secret-key	92a76460691ac36f38189fa2754f990c13e52c1a7de7d123fe5dd77489f280d1
version-info	{"latest":{"version":"v0.29.3","released":"2018-05-12T12:09:36.358Z","patch":true,"highlights":["Fix X-ray rules loading on Oracle JVM 8"]},"older":[{"version":"v0.29.2","released":"2018-05-10T12:09:36.358Z","patch":true,"highlights":["Fix Spark Driver"]},{"version":"v0.29.1","released":"2018-05-10T11:09:36.358Z","patch":true,"highlights":["Better heroku memory consumption","Fixed X-Ray Bugs","Drill through from line chart selects wrong date"]},{"version":"v0.29.0","released":"2018-05-01T11:09:36.358Z","patch":false,"highlights":["New and Improved X-Rays","Search field values","Spark SQL Support"]},{"version":"v0.28.6","released":"2018-04-12T11:09:36.358Z","patch":true,"highlights":["Fix chart rendering in pulses"]},{"version":"v0.28.5","released":"2018-04-04T11:09:36.358Z","patch":true,"highlights":["Fix memory consumption for SQL templates","Fix public dashboards parameter validation","Fix Unable to add cards to dashboards or search for cards, StackOverflowError on backend"]},{"version":"v0.28.4","released":"2018-03-29T11:09:36.358Z","patch":true,"highlights":["Fix broken embedded dashboards","Fix migration regression","Fix input typing bug"]},{"version":"v0.28.3","released":"2018-03-23T11:09:36.358Z","patch":true,"highlights":["Security improvements"]},{"version":"v0.28.2","released":"2018-03-20T11:09:36.358Z","patch":true,"highlights":["Security improvements","Sort on custom and saved metrics","Performance improvements for large numbers of questions and dashboards"]},{"version":"v0.28.1","released":"2018-02-09T11:09:36.358Z","patch":true,"highlights":["Fix admin panel update string","Fix pulse rendering bug","Fix CSV & XLS download bug"]},{"version":"v0.28.0","released":"2018-02-07T11:09:36.358Z","patch":false,"highlights":["Text Cards in Dashboards","Pulse + Alert attachments","Performance Improvements"]},{"version":"v0.27.2","released":"2017-12-12T11:09:36.358Z","patch":true,"highlights":["Migration bug fix"]},{"version":"v0.27.1","released":"2017-12-01T11:09:36.358Z","patch":true,"highlights":["Migration bug fix","Apply filters to embedded downloads"]},{"version":"v0.27.0","released":"2017-11-27T11:09:36.358Z","patch":false,"highlights":["Alerts","X-Ray insights","Charting improvements"]},{"version":"v0.26.2","released":"2017-09-27T11:09:36.358Z","patch":true,"highlights":["Update Redshift Driver","Support Java 9","Fix performance issue with fields listing"]},{"version":"v0.26.1","released":"2017-09-27T11:09:36.358Z","patch":true,"highlights":["Fix migration issue on MySQL"]},{"version":"v0.26.0","released":"2017-09-26T11:09:36.358Z","patch":true,"highlights":["Segment + Metric X-Rays and Comparisons","Better control over metadata introspection process","Improved Timezone support and bug fixes"]},{"version":"v0.25.2","released":"2017-08-09T11:09:36.358Z","patch":true,"highlights":["Bug and performance fixes"]},{"version":"v0.25.1","released":"2017-07-27T11:09:36.358Z","patch":true,"highlights":["After upgrading to 0.25, unknown protocol error.","Don't show saved questions in the permissions database lists","Elastic beanstalk upgrades broken in 0.25 "]},{"version":"v0.25.0","released":"2017-07-25T11:09:36.358Z","patch":false,"highlights":["Nested questions","Enum and custom remapping support","LDAP authentication support"]},{"version":"v0.24.2","released":"2017-06-01T11:09:36.358Z","patch":true,"highlights":["Misc Bug fixes"]},{"version":"v0.24.1","released":"2017-05-10T11:09:36.358Z","patch":true,"highlights":["Fix upgrades with MySQL/Mariadb"]},{"version":"v0.24.0","released":"2017-05-10T11:09:36.358Z","patch":false,"highlights":["Drill-through + Actions","Result Caching","Presto Driver"]},{"version":"v0.23.1","released":"2017-03-30T11:09:36.358Z","patch":true,"highlights":["Filter widgets for SQL Template Variables","Fix spurious startup error","Java 7 startup bug fixed"]},{"version":"v0.23.0","released":"2017-03-21T11:09:36.358Z","patch":false,"highlights":["Public links for cards + dashboards","Embedding cards + dashboards in other applications","Encryption of database credentials"]},{"version":"v0.22.2","released":"2017-01-10T11:09:36.358Z","patch":true,"highlights":["Fix startup on OpenJDK 7"]},{"version":"v0.22.1","released":"2017-01-10T11:09:36.358Z","patch":true,"highlights":["IMPORTANT: Closed a Collections Permissions security hole","Improved startup performance","Bug fixes"]},{"version":"v0.22.0","released":"2017-01-10T11:09:36.358Z","patch":false,"highlights":["Collections + Collections Permissions","Multiple Aggregations","Custom Expressions"]},{"version":"v0.21.1","released":"2016-12-08T11:09:36.358Z","patch":true,"highlights":["BigQuery bug fixes","Charting bug fixes"]},{"version":"v0.21.0","released":"2016-12-08T11:09:36.358Z","patch":false,"highlights":["Google Analytics Driver","Vertica Driver","Better Time + Date Filters"]},{"version":"v0.20.3","released":"2016-10-26T11:09:36.358Z","patch":true,"highlights":["Fix H2->MySQL/PostgreSQL migrations, part 2"]},{"version":"v0.20.2","released":"2016-10-25T11:09:36.358Z","patch":true,"highlights":["Support Oracle 10+11","Fix H2->MySQL/PostgreSQL migrations","Revision timestamp fix"]},{"version":"v0.20.1","released":"2016-10-18T11:09:36.358Z","patch":true,"highlights":["Lots of bug fixes"]},{"version":"v0.20.0","released":"2016-10-11T11:09:36.358Z","patch":false,"highlights":["Data access permissions","Oracle Driver","Charting improvements"]},{"version":"v0.19.3","released":"2016-08-12T11:09:36.358Z","patch":true,"highlights":["fix Dashboard editing header"]},{"version":"v0.19.2","released":"2016-08-10T11:09:36.358Z","patch":true,"highlights":["fix Dashboard chart titles","fix pin map saving"]},{"version":"v0.19.1","released":"2016-08-04T11:09:36.358Z","patch":true,"highlights":["fix Dashboard Filter Editing","fix CSV Download of SQL Templates","fix Metabot enabled toggle"]},{"version":"v0.19.0","released":"2016-08-01T21:09:36.358Z","patch":false,"highlights":["SSO via Google Accounts","SQL Templates","Better charting controls"]},{"version":"v0.18.1","released":"2016-06-29T21:09:36.358Z","patch":true,"highlights":["Fix for Hour of day sorting bug","Fix for Column ordering bug in BigQuery","Fix for Mongo charting bug"]},{"version":"v0.18.0","released":"2016-06-022T21:09:36.358Z","patch":false,"highlights":["Dashboard Filters","Crate.IO Support","Checklist for Metabase Admins","Converting Metabase Questions -> SQL"]},{"version":"v0.17.1","released":"2016-05-04T21:09:36.358Z","patch":true,"highlights":["Fix for Line chart ordering bug","Fix for Time granularity bugs"]},{"version":"v0.17.0","released":"2016-05-04T21:09:36.358Z","patch":false,"highlights":["Tags + Search for Saved Questions","Calculated columns","Faster Syncing of Metadata","Lots of database driver improvements and bug fixes"]},{"version":"v0.16.1","released":"2016-05-04T21:09:36.358Z","patch":true,"highlights":["Fixes for several time alignment issues (timezones)","Resolved problem with SQL Server db connections"]},{"version":"v0.16.0","released":"2016-05-04T21:09:36.358Z","patch":false,"highlights":["Fullscreen (and fabulous) Dashboards","Say hello to Metabot in Slack"]}]}
\.


--
-- Data for Name: view_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY view_log (id, user_id, model, model_id, "timestamp") FROM stdin;
1	1	dashboard	1	2018-05-10 09:36:33.563+05
2	1	dashboard	1	2018-05-10 09:36:47.76+05
3	1	card	1	2018-05-10 09:48:28.829+05
4	1	dashboard	1	2018-05-10 09:48:35.393+05
5	1	card	2	2018-05-10 09:49:40.957+05
6	1	dashboard	1	2018-05-10 09:49:44.07+05
7	1	dashboard	1	2018-05-10 09:50:34.307+05
8	1	dashboard	1	2018-05-10 16:01:31.005+05
9	1	dashboard	1	2018-05-10 16:01:48.858+05
10	1	card	2	2018-05-10 16:14:12.084+05
11	1	dashboard	1	2018-05-10 18:19:00.958+05
12	1	dashboard	1	2018-05-10 18:20:27.139+05
13	1	card	2	2018-05-10 18:20:36.187+05
14	1	dashboard	1	2018-05-10 18:24:30.802+05
15	1	card	2	2018-05-10 18:24:59.762+05
16	1	dashboard	1	2018-05-10 18:25:06.486+05
17	1	card	2	2018-05-10 18:25:49.734+05
18	1	dashboard	1	2018-05-10 18:26:17.958+05
19	1	card	2	2018-05-10 18:26:27.708+05
20	1	card	3	2018-05-10 18:31:03.521+05
21	1	dashboard	1	2018-05-10 18:31:50.788+05
22	1	dashboard	1	2018-05-10 18:32:55.776+05
23	1	card	2	2018-05-10 18:33:01.829+05
24	1	dashboard	1	2018-05-10 18:35:03.543+05
25	1	dashboard	1	2018-05-10 18:36:30.123+05
26	1	card	1	2018-05-10 18:36:33.839+05
27	1	card	4	2018-05-11 16:15:46.049+05
28	1	dashboard	1	2018-05-11 16:15:49.594+05
29	1	card	4	2018-05-11 16:18:01.495+05
30	1	dashboard	1	2018-05-11 17:20:53.789+05
31	1	dashboard	1	2018-05-11 17:21:18.966+05
32	1	dashboard	1	2018-05-11 17:21:23.963+05
33	1	dashboard	1	2018-05-11 17:22:33.965+05
34	1	card	4	2018-05-11 17:22:42.742+05
35	1	dashboard	1	2018-05-11 17:33:45.265+05
36	1	card	4	2018-05-11 17:37:42.594+05
37	1	card	5	2018-05-11 17:43:03.722+05
38	1	dashboard	1	2018-05-11 17:43:06.951+05
39	1	card	4	2018-05-11 17:43:16.393+05
40	1	dashboard	1	2018-05-11 17:43:40.414+05
41	1	dashboard	1	2018-05-11 17:45:44.132+05
42	1	dashboard	1	2018-05-11 17:46:41.693+05
43	1	card	5	2018-05-11 17:46:59.328+05
44	1	dashboard	1	2018-05-11 17:49:26.252+05
45	1	dashboard	1	2018-05-11 20:30:02.23+05
46	1	card	4	2018-05-11 20:32:04.424+05
47	1	card	5	2018-05-11 20:32:45.755+05
48	1	card	5	2018-05-11 20:34:05.552+05
49	1	card	5	2018-05-11 20:34:52.703+05
50	1	dashboard	1	2018-05-11 20:36:50.774+05
51	1	dashboard	1	2018-05-11 20:38:53.253+05
52	1	dashboard	1	2018-05-11 23:53:16.754+05
53	1	dashboard	1	2018-05-12 00:11:27.71+05
54	1	dashboard	1	2018-05-12 02:35:01.603+05
55	1	dashboard	1	2018-05-12 09:22:04.567+05
56	1	card	4	2018-05-12 09:24:22.496+05
57	1	card	6	2018-05-12 10:24:17.27+05
58	1	dashboard	1	2018-05-12 10:24:24.701+05
59	1	dashboard	1	2018-05-12 10:25:11.239+05
60	1	card	7	2018-05-12 10:30:36.789+05
61	1	dashboard	1	2018-05-12 10:30:40.181+05
62	1	dashboard	1	2018-05-12 10:31:52.366+05
63	1	card	6	2018-05-12 10:32:01.773+05
64	1	dashboard	1	2018-05-12 10:32:57.187+05
65	1	card	7	2018-05-12 10:33:12.024+05
66	1	dashboard	1	2018-05-12 10:34:03.265+05
67	1	dashboard	1	2018-05-12 11:21:44.431+05
68	1	card	2	2018-05-12 11:21:49.445+05
69	1	card	8	2018-05-12 11:37:41.51+05
70	1	card	1	2018-05-12 11:38:49.224+05
71	1	card	8	2018-05-12 11:39:02.448+05
72	1	card	8	2018-05-12 11:40:28.71+05
73	1	card	8	2018-05-12 11:46:11.665+05
74	1	card	1	2018-05-12 11:46:40.995+05
75	1	dashboard	1	2018-05-12 11:46:56.831+05
76	1	card	1	2018-05-12 11:47:44.124+05
77	1	dashboard	1	2018-05-12 11:48:18.566+05
78	1	card	8	2018-05-12 11:58:42.961+05
79	1	dashboard	1	2018-05-12 12:16:13.669+05
80	1	card	9	2018-05-12 12:17:28.474+05
81	1	card	8	2018-05-12 12:17:36.688+05
82	1	card	7	2018-05-12 12:20:38.969+05
83	1	card	6	2018-05-12 12:20:44.268+05
84	1	card	8	2018-05-12 12:21:01.982+05
85	1	dashboard	1	2018-05-12 12:21:22.187+05
86	1	card	9	2018-05-12 12:21:31.221+05
87	1	dashboard	1	2018-05-12 12:21:45.134+05
88	1	dashboard	1	2018-05-12 12:22:04.446+05
89	1	dashboard	1	2018-05-12 12:55:53.592+05
90	1	dashboard	1	2018-05-12 12:57:03.127+05
91	1	dashboard	1	2018-05-12 13:05:58.239+05
92	1	card	9	2018-05-12 13:09:45.52+05
93	1	card	8	2018-05-12 13:09:50.87+05
94	1	card	10	2018-05-12 14:03:50.406+05
95	1	dashboard	1	2018-05-12 14:03:54.841+05
96	1	card	8	2018-05-12 14:04:41.884+05
97	1	card	7	2018-05-12 14:05:07.058+05
98	1	card	6	2018-05-12 14:05:16.747+05
99	1	card	10	2018-05-12 14:06:11.854+05
100	1	card	7	2018-05-12 14:08:08.235+05
101	1	card	10	2018-05-12 14:09:41.96+05
102	1	dashboard	1	2018-05-12 14:20:47.894+05
103	1	card	7	2018-05-12 14:20:53.064+05
104	1	dashboard	1	2018-05-12 14:22:17.532+05
105	1	card	7	2018-05-12 14:22:43.478+05
106	1	dashboard	1	2018-05-12 14:23:01.342+05
107	1	dashboard	1	2018-05-12 14:23:46.266+05
108	1	card	11	2018-05-12 14:30:28.378+05
109	1	dashboard	1	2018-05-12 14:30:32.643+05
110	1	dashboard	1	2018-05-12 14:31:28.1+05
111	1	card	10	2018-05-12 14:51:19.403+05
112	1	card	12	2018-05-12 15:00:13.553+05
113	1	dashboard	1	2018-05-12 15:00:30.944+05
114	1	dashboard	1	2018-05-12 15:00:41.923+05
115	1	card	12	2018-05-12 15:06:05.109+05
116	1	dashboard	1	2018-05-12 15:18:06.67+05
117	1	card	12	2018-05-12 15:18:14.429+05
118	1	dashboard	1	2018-05-12 15:20:40.045+05
119	1	dashboard	1	2018-05-12 15:21:27.73+05
120	1	card	12	2018-05-12 15:22:30.823+05
121	1	dashboard	1	2018-05-12 15:23:06.128+05
122	1	dashboard	1	2018-05-12 15:35:10.578+05
123	1	card	10	2018-05-12 15:35:45.048+05
124	1	card	12	2018-05-12 15:35:50.765+05
125	1	card	12	2018-05-12 15:36:27.026+05
126	1	dashboard	1	2018-05-12 15:39:00.095+05
127	1	dashboard	2	2018-05-12 18:24:52.938+05
128	1	card	4	2018-05-12 18:28:45.799+05
129	1	card	13	2018-05-12 19:31:59.421+05
130	1	dashboard	1	2018-05-22 09:41:11.867+05
131	1	dashboard	1	2018-05-22 09:43:26.335+05
132	1	dashboard	1	2018-05-22 09:45:37.81+05
133	1	dashboard	1	2018-05-22 09:52:31.312+05
134	1	dashboard	2	2018-05-22 09:53:13.214+05
135	1	card	13	2018-05-22 11:49:15.149+05
136	1	dashboard	1	2018-05-24 18:53:25.628+05
137	1	dashboard	1	2018-05-24 18:58:14.852+05
138	1	dashboard	1	2018-05-25 06:54:01.342+05
139	1	dashboard	1	2018-05-25 06:57:36.435+05
140	1	dashboard	1	2018-05-25 07:00:22.376+05
141	1	dashboard	1	2018-05-25 07:05:08.522+05
142	1	dashboard	1	2018-05-25 07:08:12.04+05
143	1	dashboard	1	2018-05-25 07:09:04.889+05
144	1	dashboard	1	2018-05-25 18:19:09.92+05
145	1	dashboard	2	2018-05-25 18:19:12.692+05
146	1	card	13	2018-05-25 18:19:20.457+05
147	1	dashboard	1	2018-05-25 18:34:03.226+05
148	1	dashboard	1	2018-05-25 18:34:08.409+05
149	1	dashboard	1	2018-05-25 18:36:03.244+05
150	1	dashboard	2	2018-05-28 17:07:18.018+05
151	1	card	13	2018-05-28 17:07:26.652+05
152	1	dashboard	1	2018-05-29 02:00:29.141+05
153	1	card	13	2018-05-30 10:11:35.259+05
\.


--
-- Name: view_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('view_log_id_seq', 153, true);


--
-- Name: collection_slug_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY collection
    ADD CONSTRAINT collection_slug_key UNIQUE (slug);


--
-- Name: core_user_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY core_user
    ADD CONSTRAINT core_user_email_key UNIQUE (email);


--
-- Name: idx_unique_cardfavorite_card_id_owner_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY report_cardfavorite
    ADD CONSTRAINT idx_unique_cardfavorite_card_id_owner_id UNIQUE (card_id, owner_id);


--
-- Name: label_slug_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY label
    ADD CONSTRAINT label_slug_key UNIQUE (slug);


--
-- Name: permissions_group_id_object_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY permissions
    ADD CONSTRAINT permissions_group_id_object_key UNIQUE (group_id, object);


--
-- Name: pk_activity; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY activity
    ADD CONSTRAINT pk_activity PRIMARY KEY (id);


--
-- Name: pk_card_label; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY card_label
    ADD CONSTRAINT pk_card_label PRIMARY KEY (id);


--
-- Name: pk_collection; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY collection
    ADD CONSTRAINT pk_collection PRIMARY KEY (id);


--
-- Name: pk_collection_revision; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY collection_revision
    ADD CONSTRAINT pk_collection_revision PRIMARY KEY (id);


--
-- Name: pk_computation_job; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY computation_job
    ADD CONSTRAINT pk_computation_job PRIMARY KEY (id);


--
-- Name: pk_computation_job_result; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY computation_job_result
    ADD CONSTRAINT pk_computation_job_result PRIMARY KEY (id);


--
-- Name: pk_core_session; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY core_session
    ADD CONSTRAINT pk_core_session PRIMARY KEY (id);


--
-- Name: pk_core_user; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY core_user
    ADD CONSTRAINT pk_core_user PRIMARY KEY (id);


--
-- Name: pk_dashboard_favorite; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dashboard_favorite
    ADD CONSTRAINT pk_dashboard_favorite PRIMARY KEY (id);


--
-- Name: pk_dashboardcard_series; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dashboardcard_series
    ADD CONSTRAINT pk_dashboardcard_series PRIMARY KEY (id);


--
-- Name: pk_data_migrations; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY data_migrations
    ADD CONSTRAINT pk_data_migrations PRIMARY KEY (id);


--
-- Name: pk_databasechangeloglock; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY databasechangeloglock
    ADD CONSTRAINT pk_databasechangeloglock PRIMARY KEY (id);


--
-- Name: pk_dependency; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dependency
    ADD CONSTRAINT pk_dependency PRIMARY KEY (id);


--
-- Name: pk_dimension; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dimension
    ADD CONSTRAINT pk_dimension PRIMARY KEY (id);


--
-- Name: pk_label; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY label
    ADD CONSTRAINT pk_label PRIMARY KEY (id);


--
-- Name: pk_metabase_database; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY metabase_database
    ADD CONSTRAINT pk_metabase_database PRIMARY KEY (id);


--
-- Name: pk_metabase_field; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY metabase_field
    ADD CONSTRAINT pk_metabase_field PRIMARY KEY (id);


--
-- Name: pk_metabase_fieldvalues; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY metabase_fieldvalues
    ADD CONSTRAINT pk_metabase_fieldvalues PRIMARY KEY (id);


--
-- Name: pk_metabase_table; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY metabase_table
    ADD CONSTRAINT pk_metabase_table PRIMARY KEY (id);


--
-- Name: pk_metric; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY metric
    ADD CONSTRAINT pk_metric PRIMARY KEY (id);


--
-- Name: pk_metric_important_field; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY metric_important_field
    ADD CONSTRAINT pk_metric_important_field PRIMARY KEY (id);


--
-- Name: pk_permissions; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY permissions
    ADD CONSTRAINT pk_permissions PRIMARY KEY (id);


--
-- Name: pk_permissions_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY permissions_group
    ADD CONSTRAINT pk_permissions_group PRIMARY KEY (id);


--
-- Name: pk_permissions_group_membership; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY permissions_group_membership
    ADD CONSTRAINT pk_permissions_group_membership PRIMARY KEY (id);


--
-- Name: pk_permissions_revision; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY permissions_revision
    ADD CONSTRAINT pk_permissions_revision PRIMARY KEY (id);


--
-- Name: pk_pulse; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pulse
    ADD CONSTRAINT pk_pulse PRIMARY KEY (id);


--
-- Name: pk_pulse_card; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pulse_card
    ADD CONSTRAINT pk_pulse_card PRIMARY KEY (id);


--
-- Name: pk_pulse_channel; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pulse_channel
    ADD CONSTRAINT pk_pulse_channel PRIMARY KEY (id);


--
-- Name: pk_pulse_channel_recipient; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pulse_channel_recipient
    ADD CONSTRAINT pk_pulse_channel_recipient PRIMARY KEY (id);


--
-- Name: pk_query; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY query
    ADD CONSTRAINT pk_query PRIMARY KEY (query_hash);


--
-- Name: pk_query_cache; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY query_cache
    ADD CONSTRAINT pk_query_cache PRIMARY KEY (query_hash);


--
-- Name: pk_query_execution; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY query_execution
    ADD CONSTRAINT pk_query_execution PRIMARY KEY (id);


--
-- Name: pk_raw_column; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY raw_column
    ADD CONSTRAINT pk_raw_column PRIMARY KEY (id);


--
-- Name: pk_raw_table; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY raw_table
    ADD CONSTRAINT pk_raw_table PRIMARY KEY (id);


--
-- Name: pk_report_card; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY report_card
    ADD CONSTRAINT pk_report_card PRIMARY KEY (id);


--
-- Name: pk_report_cardfavorite; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY report_cardfavorite
    ADD CONSTRAINT pk_report_cardfavorite PRIMARY KEY (id);


--
-- Name: pk_report_dashboard; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY report_dashboard
    ADD CONSTRAINT pk_report_dashboard PRIMARY KEY (id);


--
-- Name: pk_report_dashboardcard; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY report_dashboardcard
    ADD CONSTRAINT pk_report_dashboardcard PRIMARY KEY (id);


--
-- Name: pk_revision; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY revision
    ADD CONSTRAINT pk_revision PRIMARY KEY (id);


--
-- Name: pk_segment; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY segment
    ADD CONSTRAINT pk_segment PRIMARY KEY (id);


--
-- Name: pk_setting; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY setting
    ADD CONSTRAINT pk_setting PRIMARY KEY (key);


--
-- Name: pk_view_log; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY view_log
    ADD CONSTRAINT pk_view_log PRIMARY KEY (id);


--
-- Name: report_card_public_uuid_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY report_card
    ADD CONSTRAINT report_card_public_uuid_key UNIQUE (public_uuid);


--
-- Name: report_dashboard_public_uuid_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY report_dashboard
    ADD CONSTRAINT report_dashboard_public_uuid_key UNIQUE (public_uuid);


--
-- Name: uniq_raw_column_table_name; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY raw_column
    ADD CONSTRAINT uniq_raw_column_table_name UNIQUE (raw_table_id, name);


--
-- Name: uniq_raw_table_db_schema_name; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY raw_table
    ADD CONSTRAINT uniq_raw_table_db_schema_name UNIQUE (database_id, schema, name);


--
-- Name: unique_card_label_card_id_label_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY card_label
    ADD CONSTRAINT unique_card_label_card_id_label_id UNIQUE (card_id, label_id);


--
-- Name: unique_dashboard_favorite_user_id_dashboard_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dashboard_favorite
    ADD CONSTRAINT unique_dashboard_favorite_user_id_dashboard_id UNIQUE (user_id, dashboard_id);


--
-- Name: unique_dimension_field_id_name; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dimension
    ADD CONSTRAINT unique_dimension_field_id_name UNIQUE (field_id, name);


--
-- Name: unique_metric_important_field_metric_id_field_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY metric_important_field
    ADD CONSTRAINT unique_metric_important_field_metric_id_field_id UNIQUE (metric_id, field_id);


--
-- Name: unique_permissions_group_membership_user_id_group_id; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY permissions_group_membership
    ADD CONSTRAINT unique_permissions_group_membership_user_id_group_id UNIQUE (user_id, group_id);


--
-- Name: unique_permissions_group_name; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY permissions_group
    ADD CONSTRAINT unique_permissions_group_name UNIQUE (name);


--
-- Name: idx_activity_custom_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_activity_custom_id ON activity USING btree (custom_id);


--
-- Name: idx_activity_timestamp; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_activity_timestamp ON activity USING btree ("timestamp");


--
-- Name: idx_activity_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_activity_user_id ON activity USING btree (user_id);


--
-- Name: idx_card_collection_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_card_collection_id ON report_card USING btree (collection_id);


--
-- Name: idx_card_creator_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_card_creator_id ON report_card USING btree (creator_id);


--
-- Name: idx_card_label_card_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_card_label_card_id ON card_label USING btree (card_id);


--
-- Name: idx_card_label_label_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_card_label_label_id ON card_label USING btree (label_id);


--
-- Name: idx_card_public_uuid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_card_public_uuid ON report_card USING btree (public_uuid);


--
-- Name: idx_cardfavorite_card_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_cardfavorite_card_id ON report_cardfavorite USING btree (card_id);


--
-- Name: idx_cardfavorite_owner_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_cardfavorite_owner_id ON report_cardfavorite USING btree (owner_id);


--
-- Name: idx_collection_slug; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_collection_slug ON collection USING btree (slug);


--
-- Name: idx_dashboard_creator_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_dashboard_creator_id ON report_dashboard USING btree (creator_id);


--
-- Name: idx_dashboard_favorite_dashboard_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_dashboard_favorite_dashboard_id ON dashboard_favorite USING btree (dashboard_id);


--
-- Name: idx_dashboard_favorite_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_dashboard_favorite_user_id ON dashboard_favorite USING btree (user_id);


--
-- Name: idx_dashboard_public_uuid; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_dashboard_public_uuid ON report_dashboard USING btree (public_uuid);


--
-- Name: idx_dashboardcard_card_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_dashboardcard_card_id ON report_dashboardcard USING btree (card_id);


--
-- Name: idx_dashboardcard_dashboard_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_dashboardcard_dashboard_id ON report_dashboardcard USING btree (dashboard_id);


--
-- Name: idx_dashboardcard_series_card_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_dashboardcard_series_card_id ON dashboardcard_series USING btree (card_id);


--
-- Name: idx_dashboardcard_series_dashboardcard_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_dashboardcard_series_dashboardcard_id ON dashboardcard_series USING btree (dashboardcard_id);


--
-- Name: idx_data_migrations_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_data_migrations_id ON data_migrations USING btree (id);


--
-- Name: idx_dependency_dependent_on_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_dependency_dependent_on_id ON dependency USING btree (dependent_on_id);


--
-- Name: idx_dependency_dependent_on_model; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_dependency_dependent_on_model ON dependency USING btree (dependent_on_model);


--
-- Name: idx_dependency_model; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_dependency_model ON dependency USING btree (model);


--
-- Name: idx_dependency_model_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_dependency_model_id ON dependency USING btree (model_id);


--
-- Name: idx_dimension_field_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_dimension_field_id ON dimension USING btree (field_id);


--
-- Name: idx_field_table_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_field_table_id ON metabase_field USING btree (table_id);


--
-- Name: idx_fieldvalues_field_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fieldvalues_field_id ON metabase_fieldvalues USING btree (field_id);


--
-- Name: idx_label_slug; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_label_slug ON label USING btree (slug);


--
-- Name: idx_metabase_table_db_id_schema; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_metabase_table_db_id_schema ON metabase_table USING btree (schema);


--
-- Name: idx_metabase_table_show_in_getting_started; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_metabase_table_show_in_getting_started ON metabase_table USING btree (show_in_getting_started);


--
-- Name: idx_metric_creator_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_metric_creator_id ON metric USING btree (creator_id);


--
-- Name: idx_metric_important_field_field_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_metric_important_field_field_id ON metric_important_field USING btree (field_id);


--
-- Name: idx_metric_important_field_metric_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_metric_important_field_metric_id ON metric_important_field USING btree (metric_id);


--
-- Name: idx_metric_show_in_getting_started; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_metric_show_in_getting_started ON metric USING btree (show_in_getting_started);


--
-- Name: idx_metric_table_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_metric_table_id ON metric USING btree (table_id);


--
-- Name: idx_permissions_group_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_permissions_group_id ON permissions USING btree (group_id);


--
-- Name: idx_permissions_group_id_object; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_permissions_group_id_object ON permissions USING btree (object);


--
-- Name: idx_permissions_group_membership_group_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_permissions_group_membership_group_id ON permissions_group_membership USING btree (group_id);


--
-- Name: idx_permissions_group_membership_group_id_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_permissions_group_membership_group_id_user_id ON permissions_group_membership USING btree (user_id);


--
-- Name: idx_permissions_group_membership_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_permissions_group_membership_user_id ON permissions_group_membership USING btree (user_id);


--
-- Name: idx_permissions_group_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_permissions_group_name ON permissions_group USING btree (name);


--
-- Name: idx_permissions_object; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_permissions_object ON permissions USING btree (object);


--
-- Name: idx_pulse_card_card_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_pulse_card_card_id ON pulse_card USING btree (card_id);


--
-- Name: idx_pulse_card_pulse_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_pulse_card_pulse_id ON pulse_card USING btree (pulse_id);


--
-- Name: idx_pulse_channel_pulse_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_pulse_channel_pulse_id ON pulse_channel USING btree (pulse_id);


--
-- Name: idx_pulse_channel_schedule_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_pulse_channel_schedule_type ON pulse_channel USING btree (schedule_type);


--
-- Name: idx_pulse_creator_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_pulse_creator_id ON pulse USING btree (creator_id);


--
-- Name: idx_query_cache_updated_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_query_cache_updated_at ON query_cache USING btree (updated_at);


--
-- Name: idx_query_execution_query_hash_started_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_query_execution_query_hash_started_at ON query_execution USING btree (started_at);


--
-- Name: idx_query_execution_started_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_query_execution_started_at ON query_execution USING btree (started_at);


--
-- Name: idx_rawcolumn_raw_table_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_rawcolumn_raw_table_id ON raw_column USING btree (raw_table_id);


--
-- Name: idx_rawtable_database_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_rawtable_database_id ON raw_table USING btree (database_id);


--
-- Name: idx_report_dashboard_show_in_getting_started; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_report_dashboard_show_in_getting_started ON report_dashboard USING btree (show_in_getting_started);


--
-- Name: idx_revision_model_model_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_revision_model_model_id ON revision USING btree (model_id);


--
-- Name: idx_segment_creator_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_segment_creator_id ON segment USING btree (creator_id);


--
-- Name: idx_segment_show_in_getting_started; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_segment_show_in_getting_started ON segment USING btree (show_in_getting_started);


--
-- Name: idx_segment_table_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_segment_table_id ON segment USING btree (table_id);


--
-- Name: idx_table_db_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_table_db_id ON metabase_table USING btree (db_id);


--
-- Name: idx_view_log_timestamp; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_view_log_timestamp ON view_log USING btree (model_id);


--
-- Name: idx_view_log_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_view_log_user_id ON view_log USING btree (user_id);


--
-- Name: fk_activity_ref_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY activity
    ADD CONSTRAINT fk_activity_ref_user_id FOREIGN KEY (user_id) REFERENCES core_user(id);


--
-- Name: fk_card_collection_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY report_card
    ADD CONSTRAINT fk_card_collection_id FOREIGN KEY (collection_id) REFERENCES collection(id);


--
-- Name: fk_card_label_ref_card_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY card_label
    ADD CONSTRAINT fk_card_label_ref_card_id FOREIGN KEY (card_id) REFERENCES report_card(id);


--
-- Name: fk_card_label_ref_label_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY card_label
    ADD CONSTRAINT fk_card_label_ref_label_id FOREIGN KEY (label_id) REFERENCES label(id);


--
-- Name: fk_card_made_public_by_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY report_card
    ADD CONSTRAINT fk_card_made_public_by_id FOREIGN KEY (made_public_by_id) REFERENCES core_user(id);


--
-- Name: fk_card_ref_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY report_card
    ADD CONSTRAINT fk_card_ref_user_id FOREIGN KEY (creator_id) REFERENCES core_user(id);


--
-- Name: fk_cardfavorite_ref_card_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY report_cardfavorite
    ADD CONSTRAINT fk_cardfavorite_ref_card_id FOREIGN KEY (card_id) REFERENCES report_card(id);


--
-- Name: fk_cardfavorite_ref_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY report_cardfavorite
    ADD CONSTRAINT fk_cardfavorite_ref_user_id FOREIGN KEY (owner_id) REFERENCES core_user(id);


--
-- Name: fk_collection_revision_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY collection_revision
    ADD CONSTRAINT fk_collection_revision_user_id FOREIGN KEY (user_id) REFERENCES core_user(id);


--
-- Name: fk_computation_job_ref_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY computation_job
    ADD CONSTRAINT fk_computation_job_ref_user_id FOREIGN KEY (creator_id) REFERENCES core_user(id);


--
-- Name: fk_computation_result_ref_job_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY computation_job_result
    ADD CONSTRAINT fk_computation_result_ref_job_id FOREIGN KEY (job_id) REFERENCES computation_job(id);


--
-- Name: fk_dashboard_favorite_dashboard_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dashboard_favorite
    ADD CONSTRAINT fk_dashboard_favorite_dashboard_id FOREIGN KEY (dashboard_id) REFERENCES report_dashboard(id) ON DELETE CASCADE;


--
-- Name: fk_dashboard_favorite_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dashboard_favorite
    ADD CONSTRAINT fk_dashboard_favorite_user_id FOREIGN KEY (user_id) REFERENCES core_user(id) ON DELETE CASCADE;


--
-- Name: fk_dashboard_made_public_by_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY report_dashboard
    ADD CONSTRAINT fk_dashboard_made_public_by_id FOREIGN KEY (made_public_by_id) REFERENCES core_user(id);


--
-- Name: fk_dashboard_ref_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY report_dashboard
    ADD CONSTRAINT fk_dashboard_ref_user_id FOREIGN KEY (creator_id) REFERENCES core_user(id);


--
-- Name: fk_dashboardcard_ref_card_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY report_dashboardcard
    ADD CONSTRAINT fk_dashboardcard_ref_card_id FOREIGN KEY (card_id) REFERENCES report_card(id);


--
-- Name: fk_dashboardcard_ref_dashboard_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY report_dashboardcard
    ADD CONSTRAINT fk_dashboardcard_ref_dashboard_id FOREIGN KEY (dashboard_id) REFERENCES report_dashboard(id);


--
-- Name: fk_dashboardcard_series_ref_card_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dashboardcard_series
    ADD CONSTRAINT fk_dashboardcard_series_ref_card_id FOREIGN KEY (card_id) REFERENCES report_card(id);


--
-- Name: fk_dashboardcard_series_ref_dashboardcard_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dashboardcard_series
    ADD CONSTRAINT fk_dashboardcard_series_ref_dashboardcard_id FOREIGN KEY (dashboardcard_id) REFERENCES report_dashboardcard(id);


--
-- Name: fk_dimension_displayfk_ref_field_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dimension
    ADD CONSTRAINT fk_dimension_displayfk_ref_field_id FOREIGN KEY (human_readable_field_id) REFERENCES metabase_field(id) ON DELETE CASCADE;


--
-- Name: fk_dimension_ref_field_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY dimension
    ADD CONSTRAINT fk_dimension_ref_field_id FOREIGN KEY (field_id) REFERENCES metabase_field(id) ON DELETE CASCADE;


--
-- Name: fk_field_parent_ref_field_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY metabase_field
    ADD CONSTRAINT fk_field_parent_ref_field_id FOREIGN KEY (parent_id) REFERENCES metabase_field(id);


--
-- Name: fk_field_ref_table_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY metabase_field
    ADD CONSTRAINT fk_field_ref_table_id FOREIGN KEY (table_id) REFERENCES metabase_table(id);


--
-- Name: fk_fieldvalues_ref_field_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY metabase_fieldvalues
    ADD CONSTRAINT fk_fieldvalues_ref_field_id FOREIGN KEY (field_id) REFERENCES metabase_field(id);


--
-- Name: fk_metric_important_field_metabase_field_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY metric_important_field
    ADD CONSTRAINT fk_metric_important_field_metabase_field_id FOREIGN KEY (field_id) REFERENCES metabase_field(id);


--
-- Name: fk_metric_important_field_metric_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY metric_important_field
    ADD CONSTRAINT fk_metric_important_field_metric_id FOREIGN KEY (metric_id) REFERENCES metric(id);


--
-- Name: fk_metric_ref_creator_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY metric
    ADD CONSTRAINT fk_metric_ref_creator_id FOREIGN KEY (creator_id) REFERENCES core_user(id);


--
-- Name: fk_metric_ref_table_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY metric
    ADD CONSTRAINT fk_metric_ref_table_id FOREIGN KEY (table_id) REFERENCES metabase_table(id);


--
-- Name: fk_permissions_group_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY permissions_group_membership
    ADD CONSTRAINT fk_permissions_group_group_id FOREIGN KEY (group_id) REFERENCES permissions_group(id);


--
-- Name: fk_permissions_group_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY permissions
    ADD CONSTRAINT fk_permissions_group_id FOREIGN KEY (group_id) REFERENCES permissions_group(id);


--
-- Name: fk_permissions_group_membership_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY permissions_group_membership
    ADD CONSTRAINT fk_permissions_group_membership_user_id FOREIGN KEY (user_id) REFERENCES core_user(id);


--
-- Name: fk_permissions_revision_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY permissions_revision
    ADD CONSTRAINT fk_permissions_revision_user_id FOREIGN KEY (user_id) REFERENCES core_user(id);


--
-- Name: fk_pulse_card_ref_card_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pulse_card
    ADD CONSTRAINT fk_pulse_card_ref_card_id FOREIGN KEY (card_id) REFERENCES report_card(id);


--
-- Name: fk_pulse_card_ref_pulse_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pulse_card
    ADD CONSTRAINT fk_pulse_card_ref_pulse_id FOREIGN KEY (pulse_id) REFERENCES pulse(id);


--
-- Name: fk_pulse_channel_recipient_ref_pulse_channel_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pulse_channel_recipient
    ADD CONSTRAINT fk_pulse_channel_recipient_ref_pulse_channel_id FOREIGN KEY (pulse_channel_id) REFERENCES pulse_channel(id);


--
-- Name: fk_pulse_channel_recipient_ref_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pulse_channel_recipient
    ADD CONSTRAINT fk_pulse_channel_recipient_ref_user_id FOREIGN KEY (user_id) REFERENCES core_user(id);


--
-- Name: fk_pulse_channel_ref_pulse_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pulse_channel
    ADD CONSTRAINT fk_pulse_channel_ref_pulse_id FOREIGN KEY (pulse_id) REFERENCES pulse(id);


--
-- Name: fk_pulse_ref_creator_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY pulse
    ADD CONSTRAINT fk_pulse_ref_creator_id FOREIGN KEY (creator_id) REFERENCES core_user(id);


--
-- Name: fk_rawcolumn_fktarget_ref_rawcolumn; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY raw_column
    ADD CONSTRAINT fk_rawcolumn_fktarget_ref_rawcolumn FOREIGN KEY (fk_target_column_id) REFERENCES raw_column(id);


--
-- Name: fk_rawcolumn_tableid_ref_rawtable; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY raw_column
    ADD CONSTRAINT fk_rawcolumn_tableid_ref_rawtable FOREIGN KEY (raw_table_id) REFERENCES raw_table(id);


--
-- Name: fk_report_card_ref_database_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY report_card
    ADD CONSTRAINT fk_report_card_ref_database_id FOREIGN KEY (database_id) REFERENCES metabase_database(id);


--
-- Name: fk_report_card_ref_table_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY report_card
    ADD CONSTRAINT fk_report_card_ref_table_id FOREIGN KEY (table_id) REFERENCES metabase_table(id);


--
-- Name: fk_revision_ref_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY revision
    ADD CONSTRAINT fk_revision_ref_user_id FOREIGN KEY (user_id) REFERENCES core_user(id);


--
-- Name: fk_segment_ref_creator_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY segment
    ADD CONSTRAINT fk_segment_ref_creator_id FOREIGN KEY (creator_id) REFERENCES core_user(id);


--
-- Name: fk_segment_ref_table_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY segment
    ADD CONSTRAINT fk_segment_ref_table_id FOREIGN KEY (table_id) REFERENCES metabase_table(id);


--
-- Name: fk_session_ref_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY core_session
    ADD CONSTRAINT fk_session_ref_user_id FOREIGN KEY (user_id) REFERENCES core_user(id);


--
-- Name: fk_table_ref_database_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY metabase_table
    ADD CONSTRAINT fk_table_ref_database_id FOREIGN KEY (db_id) REFERENCES metabase_database(id);


--
-- Name: fk_view_log_ref_user_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY view_log
    ADD CONSTRAINT fk_view_log_ref_user_id FOREIGN KEY (user_id) REFERENCES core_user(id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

