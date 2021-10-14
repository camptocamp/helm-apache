--
-- PostgreSQL database dump
--

-- Dumped from database version 12.2
-- Dumped by pg_dump version 13.3 (Ubuntu 13.3-1.pgdg18.04+1)

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

CREATE SCHEMA geodata;


ALTER SCHEMA geodata OWNER TO postgres;


CREATE EXTENSION IF NOT EXISTS hstore WITH SCHEMA public;


--
-- Name: EXTENSION hstore; Type: COMMENT; Schema: -; Owner:
--

COMMENT ON EXTENSION hstore IS 'data type for storing sets of (key, value) pairs';


--
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -; Owner:
--

COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner:
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';


--
-- Name: unaccent; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS unaccent WITH SCHEMA public;


--
-- Name: EXTENSION unaccent; Type: COMMENT; Schema: -; Owner:
--

COMMENT ON EXTENSION unaccent IS 'text search dictionary that removes accents';


--
-- Name: osm_firestations; Type: TABLE; Schema: geodata; Owner: postgres
--

CREATE TABLE geodata.osm_firestations (
    osm_id integer NOT NULL,
    name text,
    geom public.geometry(Polygon,2056)
);


ALTER TABLE geodata.osm_firestations OWNER TO postgres;

--
-- Name: osm_firestations_; Type: TABLE; Schema: geodata; Owner: postgres
--

CREATE TABLE geodata.osm_firestations_ (
    osm_id bigint NOT NULL,
    name text,
    geom21781 public.geometry(Polygon,21781),
    geom public.geometry(Polygon,2056)
);


ALTER TABLE geodata.osm_firestations_ OWNER TO postgres;

--
-- Name: osm_firestations_osm_id_seq; Type: SEQUENCE; Schema: geodata; Owner: postgres
--

CREATE SEQUENCE geodata.osm_firestations_osm_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE geodata.osm_firestations_osm_id_seq OWNER TO postgres;

--
-- Name: osm_firestations_osm_id_seq; Type: SEQUENCE OWNED BY; Schema: geodata; Owner: postgres
--

ALTER SEQUENCE geodata.osm_firestations_osm_id_seq OWNED BY geodata.osm_firestations_.osm_id;


--
-- Name: osm_firestations_osm_id_seq1; Type: SEQUENCE; Schema: geodata; Owner: postgres
--

CREATE SEQUENCE geodata.osm_firestations_osm_id_seq1
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE geodata.osm_firestations_osm_id_seq1 OWNER TO postgres;

--
-- Name: osm_firestations_osm_id_seq1; Type: SEQUENCE OWNED BY; Schema: geodata; Owner: postgres
--

ALTER SEQUENCE geodata.osm_firestations_osm_id_seq1 OWNED BY geodata.osm_firestations.osm_id;


--
-- Name: osm_hospitals; Type: TABLE; Schema: geodata; Owner: postgres
--

CREATE TABLE geodata.osm_hospitals (
    osm_id integer NOT NULL,
    name text,
    email text,
    link text,
    datetime timestamp with time zone,
    date date,
    geom public.geometry(Point,2056)
);


ALTER TABLE geodata.osm_hospitals OWNER TO postgres;

--
-- Name: osm_hospitals_; Type: TABLE; Schema: geodata; Owner: postgres
--

CREATE TABLE geodata.osm_hospitals_ (
    osm_id bigint NOT NULL,
    name text,
    geom21781 public.geometry(Point,21781),
    email text,
    link text,
    geom public.geometry(Point,2056)
);


ALTER TABLE geodata.osm_hospitals_ OWNER TO postgres;

--
-- Name: osm_hospitals_osm_id_seq; Type: SEQUENCE; Schema: geodata; Owner: postgres
--

CREATE SEQUENCE geodata.osm_hospitals_osm_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE geodata.osm_hospitals_osm_id_seq OWNER TO postgres;

--
-- Name: osm_hospitals_osm_id_seq; Type: SEQUENCE OWNED BY; Schema: geodata; Owner: postgres
--

ALTER SEQUENCE geodata.osm_hospitals_osm_id_seq OWNED BY geodata.osm_hospitals_.osm_id;


--
-- Name: osm_hospitals_osm_id_seq1; Type: SEQUENCE; Schema: geodata; Owner: postgres
--

CREATE SEQUENCE geodata.osm_hospitals_osm_id_seq1
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE geodata.osm_hospitals_osm_id_seq1 OWNER TO postgres;

--
-- Name: osm_hospitals_osm_id_seq1; Type: SEQUENCE OWNED BY; Schema: geodata; Owner: postgres
--

ALTER SEQUENCE geodata.osm_hospitals_osm_id_seq1 OWNED BY geodata.osm_hospitals.osm_id;


--
-- Name: osm_landuse; Type: TABLE; Schema: geodata; Owner: postgres
--

CREATE TABLE geodata.osm_landuse (
    fid integer NOT NULL,
    osm_id bigint,
    name character varying(48),
    type character varying(16),
    geom_4326 public.geometry(Polygon,4326),
    geom public.geometry(Polygon,2056)
);


ALTER TABLE geodata.osm_landuse OWNER TO postgres;

--
-- Name: osm_landuse_fid_seq; Type: SEQUENCE; Schema: geodata; Owner: postgres
--

CREATE SEQUENCE geodata.osm_landuse_fid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE geodata.osm_landuse_fid_seq OWNER TO postgres;

--
-- Name: osm_landuse_fid_seq; Type: SEQUENCE OWNED BY; Schema: geodata; Owner: postgres
--

ALTER SEQUENCE geodata.osm_landuse_fid_seq OWNED BY geodata.osm_landuse.fid;


--
-- Name: osm_points; Type: TABLE; Schema: geodata; Owner: postgres
--

CREATE TABLE geodata.osm_points (
    fid integer NOT NULL,
    osm_id bigint,
    "timestamp" character varying(20),
    name character varying(48),
    type character varying(16),
    geom_4326 public.geometry(Point,4326),
    geom public.geometry(Point,2056)
);


ALTER TABLE geodata.osm_points OWNER TO postgres;

--
-- Name: osm_points_fid_seq; Type: SEQUENCE; Schema: geodata; Owner: postgres
--

CREATE SEQUENCE geodata.osm_points_fid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE geodata.osm_points_fid_seq OWNER TO postgres;

--
-- Name: osm_points_fid_seq; Type: SEQUENCE OWNED BY; Schema: geodata; Owner: postgres
--

ALTER SEQUENCE geodata.osm_points_fid_seq OWNED BY geodata.osm_points.fid;


--
-- Name: osm_railways; Type: TABLE; Schema: geodata; Owner: postgres
--

CREATE TABLE geodata.osm_railways (
    fid integer NOT NULL,
    osm_id bigint,
    name character varying(48),
    type character varying(16),
    geom_4326 public.geometry(LineString,4326),
    geom public.geometry(LineString,2056)
);


ALTER TABLE geodata.osm_railways OWNER TO postgres;

--
-- Name: osm_railways_fid_seq; Type: SEQUENCE; Schema: geodata; Owner: postgres
--

CREATE SEQUENCE geodata.osm_railways_fid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE geodata.osm_railways_fid_seq OWNER TO postgres;

--
-- Name: osm_railways_fid_seq; Type: SEQUENCE OWNED BY; Schema: geodata; Owner: postgres
--

ALTER SEQUENCE geodata.osm_railways_fid_seq OWNED BY geodata.osm_railways.fid;
