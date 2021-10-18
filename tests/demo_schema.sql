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


CREATE SCHEMA main;


ALTER SCHEMA main OWNER TO postgres;


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
-- Name: alembic_version; Type: TABLE; Schema: main; Owner: postgres
--

CREATE TABLE main.alembic_version (
    version_num character varying(32) NOT NULL
);


ALTER TABLE main.alembic_version OWNER TO postgres;

--
-- Name: c2cgeoportal_version; Type: TABLE; Schema: main; Owner: postgres
--

CREATE TABLE main.c2cgeoportal_version (
    version_num character varying(32) NOT NULL
);


ALTER TABLE main.c2cgeoportal_version OWNER TO postgres;

--
-- Name: wmts_dimension_id_seq; Type: SEQUENCE; Schema: main; Owner: postgres
--

CREATE SEQUENCE main.wmts_dimension_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE main.wmts_dimension_id_seq OWNER TO postgres;

--
-- Name: dimension; Type: TABLE; Schema: main; Owner: postgres
--

CREATE TABLE main.dimension (
    id integer DEFAULT nextval('main.wmts_dimension_id_seq'::regclass) NOT NULL,
    name character varying,
    value character varying,
    description character varying,
    layer_id integer NOT NULL,
    field character varying
);


ALTER TABLE main.dimension OWNER TO postgres;

--
-- Name: functionality_id_seq; Type: SEQUENCE; Schema: main; Owner: postgres
--

CREATE SEQUENCE main.functionality_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE main.functionality_id_seq OWNER TO postgres;

--
-- Name: functionality; Type: TABLE; Schema: main; Owner: postgres
--

CREATE TABLE main.functionality (
    id integer DEFAULT nextval('main.functionality_id_seq'::regclass) NOT NULL,
    name character varying NOT NULL,
    value character varying NOT NULL,
    description character varying
);


ALTER TABLE main.functionality OWNER TO postgres;

--
-- Name: interface_id_seq; Type: SEQUENCE; Schema: main; Owner: postgres
--

CREATE SEQUENCE main.interface_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE main.interface_id_seq OWNER TO postgres;

--
-- Name: interface; Type: TABLE; Schema: main; Owner: postgres
--

CREATE TABLE main.interface (
    id integer DEFAULT nextval('main.interface_id_seq'::regclass) NOT NULL,
    name character varying,
    description character varying
);


ALTER TABLE main.interface OWNER TO postgres;

--
-- Name: interface_layer; Type: TABLE; Schema: main; Owner: postgres
--

CREATE TABLE main.interface_layer (
    interface_id integer NOT NULL,
    layer_id integer NOT NULL
);


ALTER TABLE main.interface_layer OWNER TO postgres;

--
-- Name: interface_theme; Type: TABLE; Schema: main; Owner: postgres
--

CREATE TABLE main.interface_theme (
    interface_id integer NOT NULL,
    theme_id integer NOT NULL
);


ALTER TABLE main.interface_theme OWNER TO postgres;

--
-- Name: layer; Type: TABLE; Schema: main; Owner: postgres
--

CREATE TABLE main.layer (
    id integer NOT NULL,
    public boolean,
    geo_table character varying,
    exclude_properties character varying
);


ALTER TABLE main.layer OWNER TO postgres;

--
-- Name: layer_restrictionarea; Type: TABLE; Schema: main; Owner: postgres
--

CREATE TABLE main.layer_restrictionarea (
    layer_id integer NOT NULL,
    restrictionarea_id integer NOT NULL
);


ALTER TABLE main.layer_restrictionarea OWNER TO postgres;

--
-- Name: layer_wms; Type: TABLE; Schema: main; Owner: postgres
--

CREATE TABLE main.layer_wms (
    id integer NOT NULL,
    ogc_server_id integer NOT NULL,
    layer character varying NOT NULL,
    style character varying,
    time_mode character varying DEFAULT 'disabled'::character varying NOT NULL,
    time_widget character varying DEFAULT 'slider'::character varying NOT NULL
);


ALTER TABLE main.layer_wms OWNER TO postgres;

--
-- Name: layer_wmts; Type: TABLE; Schema: main; Owner: postgres
--

CREATE TABLE main.layer_wmts (
    id integer NOT NULL,
    url character varying NOT NULL,
    layer character varying NOT NULL,
    style character varying,
    matrix_set character varying,
    image_type character varying(10) NOT NULL
);


ALTER TABLE main.layer_wmts OWNER TO postgres;

--
-- Name: layergroup; Type: TABLE; Schema: main; Owner: postgres
--

CREATE TABLE main.layergroup (
    id integer NOT NULL,
    is_expanded boolean
);


ALTER TABLE main.layergroup OWNER TO postgres;

--
-- Name: layergroup_treeitem_id_seq; Type: SEQUENCE; Schema: main; Owner: postgres
--

CREATE SEQUENCE main.layergroup_treeitem_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE main.layergroup_treeitem_id_seq OWNER TO postgres;

--
-- Name: layergroup_treeitem; Type: TABLE; Schema: main; Owner: postgres
--

CREATE TABLE main.layergroup_treeitem (
    treegroup_id integer NOT NULL,
    treeitem_id integer NOT NULL,
    id integer DEFAULT nextval('main.layergroup_treeitem_id_seq'::regclass) NOT NULL,
    ordering integer,
    description character varying
);


ALTER TABLE main.layergroup_treeitem OWNER TO postgres;

--
-- Name: layerv1; Type: TABLE; Schema: main; Owner: postgres
--

CREATE TABLE main.layerv1 (
    id integer NOT NULL,
    is_checked boolean,
    icon character varying,
    layer_type character varying(12),
    url character varying,
    image_type character varying(10),
    style character varying,
    dimensions character varying,
    matrix_set character varying,
    wms_url character varying,
    wms_layers character varying,
    query_layers character varying,
    kml character varying,
    is_single_tile boolean,
    legend boolean,
    legend_image character varying,
    legend_rule character varying,
    is_legend_expanded boolean,
    min_resolution double precision,
    max_resolution double precision,
    disclaimer character varying,
    identifier_attribute_field character varying,
    time_mode character varying(8),
    time_widget character varying(10),
    layer character varying
);


ALTER TABLE main.layerv1 OWNER TO postgres;

--
-- Name: ui_metadata_id_seq; Type: SEQUENCE; Schema: main; Owner: postgres
--

CREATE SEQUENCE main.ui_metadata_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE main.ui_metadata_id_seq OWNER TO postgres;

--
-- Name: metadata; Type: TABLE; Schema: main; Owner: postgres
--

CREATE TABLE main.metadata (
    id integer DEFAULT nextval('main.ui_metadata_id_seq'::regclass) NOT NULL,
    name character varying,
    value character varying,
    description character varying,
    item_id integer NOT NULL
);


ALTER TABLE main.metadata OWNER TO postgres;

--
-- Name: server_ogc_id_seq; Type: SEQUENCE; Schema: main; Owner: postgres
--

CREATE SEQUENCE main.server_ogc_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE main.server_ogc_id_seq OWNER TO postgres;

--
-- Name: ogc_server; Type: TABLE; Schema: main; Owner: postgres
--

CREATE TABLE main.ogc_server (
    id integer DEFAULT nextval('main.server_ogc_id_seq'::regclass) NOT NULL,
    name character varying NOT NULL,
    description character varying,
    url character varying NOT NULL,
    url_wfs character varying,
    type character varying NOT NULL,
    image_type character varying NOT NULL,
    auth character varying NOT NULL,
    wfs_support boolean DEFAULT false,
    is_single_tile boolean DEFAULT false
);


ALTER TABLE main.ogc_server OWNER TO postgres;

--
-- Name: restricted_role_theme; Type: TABLE; Schema: main; Owner: postgres
--

CREATE TABLE main.restricted_role_theme (
    role_id integer NOT NULL,
    theme_id integer NOT NULL
);


ALTER TABLE main.restricted_role_theme OWNER TO postgres;

--
-- Name: restrictionarea_id_seq; Type: SEQUENCE; Schema: main; Owner: postgres
--

CREATE SEQUENCE main.restrictionarea_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE main.restrictionarea_id_seq OWNER TO postgres;

--
-- Name: restrictionarea; Type: TABLE; Schema: main; Owner: postgres
--

CREATE TABLE main.restrictionarea (
    id integer DEFAULT nextval('main.restrictionarea_id_seq'::regclass) NOT NULL,
    name character varying,
    description character varying,
    readwrite boolean,
    area public.geometry(Polygon,21781)
);


ALTER TABLE main.restrictionarea OWNER TO postgres;

--
-- Name: role_id_seq; Type: SEQUENCE; Schema: main; Owner: postgres
--

CREATE SEQUENCE main.role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE main.role_id_seq OWNER TO postgres;

--
-- Name: role; Type: TABLE; Schema: main; Owner: postgres
--

CREATE TABLE main.role (
    id integer DEFAULT nextval('main.role_id_seq'::regclass) NOT NULL,
    name character varying NOT NULL,
    description character varying,
    extent public.geometry,
    CONSTRAINT enforce_dims_extent CHECK ((public.st_ndims(extent) = 2)),
    CONSTRAINT enforce_geotype_extent CHECK (((public.geometrytype(extent) = 'POLYGON'::text) OR (extent IS NULL))),
    CONSTRAINT enforce_srid_extent CHECK ((public.st_srid(extent) = 21781))
);


ALTER TABLE main.role OWNER TO postgres;

--
-- Name: role_functionality; Type: TABLE; Schema: main; Owner: postgres
--

CREATE TABLE main.role_functionality (
    role_id integer NOT NULL,
    functionality_id integer NOT NULL
);


ALTER TABLE main.role_functionality OWNER TO postgres;

--
-- Name: role_restrictionarea; Type: TABLE; Schema: main; Owner: postgres
--

CREATE TABLE main.role_restrictionarea (
    role_id integer NOT NULL,
    restrictionarea_id integer NOT NULL
);


ALTER TABLE main.role_restrictionarea OWNER TO postgres;

--
-- Name: theme; Type: TABLE; Schema: main; Owner: postgres
--

CREATE TABLE main.theme (
    id integer NOT NULL,
    icon character varying,
    ordering integer,
    public boolean
);


ALTER TABLE main.theme OWNER TO postgres;

--
-- Name: theme_functionality; Type: TABLE; Schema: main; Owner: postgres
--

CREATE TABLE main.theme_functionality (
    theme_id integer NOT NULL,
    functionality_id integer NOT NULL
);


ALTER TABLE main.theme_functionality OWNER TO postgres;

--
-- Name: treegroup; Type: TABLE; Schema: main; Owner: postgres
--

CREATE TABLE main.treegroup (
    id integer NOT NULL
);


ALTER TABLE main.treegroup OWNER TO postgres;

--
-- Name: treeitem_id_seq; Type: SEQUENCE; Schema: main; Owner: postgres
--

CREATE SEQUENCE main.treeitem_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE main.treeitem_id_seq OWNER TO postgres;

--
-- Name: treeitem; Type: TABLE; Schema: main; Owner: postgres
--

CREATE TABLE main.treeitem (
    type character varying(10) NOT NULL,
    id integer DEFAULT nextval('main.treeitem_id_seq'::regclass) NOT NULL,
    name character varying NOT NULL,
    description character varying,
    metadata_url character varying
);


ALTER TABLE main.treeitem OWNER TO postgres;

--
-- Name: tsearch_id_seq; Type: SEQUENCE; Schema: main; Owner: postgres
--

CREATE SEQUENCE main.tsearch_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE main.tsearch_id_seq OWNER TO postgres;

--
-- Name: tsearch; Type: TABLE; Schema: main; Owner: postgres
--

CREATE TABLE main.tsearch (
    id integer DEFAULT nextval('main.tsearch_id_seq'::regclass) NOT NULL,
    label character varying,
    layer_name character varying,
    ts tsvector,
    public boolean DEFAULT true,
    role_id integer,
    params character varying,
    the_geom public.geometry(Geometry,21781),
    interface_id integer,
    lang character varying(2),
    actions character varying,
    from_theme boolean DEFAULT false
);


ALTER TABLE main.tsearch OWNER TO postgres;



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
