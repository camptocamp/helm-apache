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

COPY geodata.osm_firestations (osm_id, name, geom) FROM stdin;
9	\N	0103000020080800000100000005000000BCDDDCBAD8534341D3164306A9DD314133F28A42D9534341923F9F55AFDD314145AAA9C7E0534341242BF1CDACDD3141A5396C3DE0534341B5BAB383A6DD3141BCDDDCBAD8534341D3164306A9DD3141
10	\N	01030000200808000001000000090000003FF06BFDE75B4341D756973ECC9631410194DC9AEA5B43418EB22641D796314166041A05F25B4341FABCFDE4D09631419D0EF1A8F25B43415EA84F9DD39631414B60A907FA5B4341E889CAB1CC963141ABC60FCEFA5B4341539E78F9CF96314166EF6BBD015C434129E65974C9963141CFD0E691FD5B4341DF6B45C6B79631413FF06BFDE75B4341D756973ECC963141
\.

COPY geodata.osm_hospitals (osm_id, name, email, link, datetime, date, geom) FROM stdin;
7	Clinique de Jolimont	camptocamp@example.com	https://camptocamp.com/geo/	\N	\N	0101000020080800000922F56C120F434102A3BCEADF153141
8	EMS	camptocamp@example.com	https://camptocamp.com/geo/	\N	\N	010100002008080000FB3E7D30700F4341B3A12D9A47103141
\.

COPY geodata.osm_landuse (fid, osm_id, name, type, geom_4326, geom) FROM stdin;
16	4732772	Rundbuck	industrial	0103000020E6100000010000001400000059B78B7AD23321404DF910548DD647407B8670CCB23321400DD4731C89D64740869F49ACD633214025523F1471D64740FDB15AAA1C3421401F5E7C7665D647401D7F5825473421405E352ACB6BD64740E966DA594F342140B0D128136DD647400432E0D16B342140E462B1F270D64740CFD2BAB2B0342140716D4D5F74D647403AC9FBDDE03421408F102F9974D647409631F43E44352140B311E39068D64740E4CCC012593521408B259B6159D647402629FA8DC03521401878EE3D5CD64740E13F82870E362140BC4B981F6ED64740D2AD32AE13362140DEE7F86871D64740E88711C2A335214055A69883A0D6474008A57911B73421401D6DC1F7A3D64740E62329E961342140AD7598E5A1D64740E9B57E9F16342140338001CE9CD6474030D5CC5A0A3421407480BB4791D6474059B78B7AD23321404DF910548DD64740	01030000200808000001000000140000002DD9D28EA48044416406E905F08C3341C615DE969B8044412E69F271E18C3341F01B3178A6804441E7908135908C3341E86396CFBA8044411590B363698C33415DF1F5D1C68044419BE5073B7F8C334146CF6523C9804441ED78C2A5838C334137451832D1804441836BF307918C33415E24EED6E48044412BEA263C9D8C33411CF4BBA1F28044411FB764699E8C334138CFDD660F8144412568656E768C33410A3D21C015814441281E4316438C334103B6215233814441EF0094AC4D8C334126D5A33449814441D09A98028B8C3341D15425994A81444175559E34968C3341546FBB59298144417AA55F13358D334158D14B77E5804441627EC9C73E8D33410F212720CD80444171D6AB07378D33417D3D2EB0B7804441A76CDF1C258D33414F96BF76B48044414C37F0E7FD8C33412DD9D28EA48044416406E905F08C3341
40	4941965	\N	meadow	0103000020E6100000010000000D000000A9DC442DCD6D204078EA364D44C74740E48409A3596D2040CD0EA78240C74740ED80EB8A196D2040FDF49F353FC7474098C349F5F86C20401B22B8DB3FC74740F9A3A833F76C2040345FCA6548C74740389B3347FB6C204021167B794BC74740B9E6E9B70A6D20408B92EB014EC74740C6FCDCD0946D2040DE6575615AC74740F984ECBC8D6D204040F61F3E55C747408285DDC1996D20401813510251C747401DEF44FFBA6D2040A186CA1A50C747407A443B5DCC6D204050C829954BC74740A9DC442DCD6D204078EA364D44C74740	010300002008080000010000000D000000D76E0AEC2C4844412B6684F2AB5733415C932CD00B48444165E3946D9E573341EC7FD96EF9474441FE6A9DA69957334111E31E11F0474441C60FEEAA9B573341060A736BEF474441E560D3A1B85733415C65E089F0474441F7F86718C35733419D29DFEDF447444199EEFAC6CB573341CE28D15E1C4844419B2EFB8AF65733418B0FA56C1A484441D3E6B611E5573341B15D36F21D4844418F65C1C5D6573341EADC2F81274844417DBB74E4D35733417F980E912C4844417202CDA5C4573341D76E0AEC2C4844412B6684F2AB573341
\.

COPY geodata.osm_points (fid, osm_id, "timestamp", name, type, geom_4326, geom) FROM stdin;
1	172251	2010-02-21T22:29:30Z	Lausanne Malley	motorway_junctio	0101000020E610000061E86C5C5A581A4053ED2EAB0B434740	010100002008080000ACD2AF2963564341F337799457973141
2	280593	2009-11-29T14:51:58Z	\N	crossing	0101000020E6100000A8D19AD5F1761A4018BC9E9E2D424740	010100002008080000227CC24FD95A43417E41E4CE4D943141
\.

COPY geodata.osm_railways (fid, osm_id, name, type, geom_4326, geom) FROM stdin;
230	8062814	\N	rail	0102000020E610000002000000D4676215CA9D20407A257FE662BB4740B89F4264479D2040A53220D676BB4740	01020000200808000002000000A3689A262D564441072C2391A62F33411C3C54300756444117961F60E92F3341
267	9702636	\N	abandoned	0102000020E6100000090000006C8DAD0C4FF02040309B00C3F2BA47405DC87E7104F02040D12D2A98E7BA474028603B18B1EF2040FD87F4DBD7BA474045F064DC79EF2040637E6E68CABA47405AE322ADE7EE204004C35ECDA6BA474012781673C6EE2040C7F1E8EB9EBA474038AA89F491EE2040372E88ED93BA4740AD7EB61F3AEE20404A6E5EE685BA4740C501F4FBFEED2040A11408967EBA4740	010200002008080000090000000D0B9F3CEB6D44410D6DFA37BD2E334192680907D66D444163E938C4962E33410455B067BE6D4441B23C33C0602E3341021E60D1AE6D444122AC4BB2322E334175B01E90856D44412D1C7BCAB82D334145BE592E7C6D4441FDF388CD9D2D334140B882536D6D44413FA3AA1B782D3341D1CFD65F546D44414FD642DA472D3341E9D5A586436D44419F28DC972E2D3341
\.
