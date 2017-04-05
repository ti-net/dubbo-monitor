DROP TABLE IF EXISTS dubbo_invoke;
CREATE TABLE dubbo_invoke (
  id varchar(255) NOT NULL DEFAULT '',
  invoke_date date NOT NULL,
  service varchar(255) DEFAULT NULL,
  method varchar(255) DEFAULT NULL,
  consumer varchar(255) DEFAULT NULL,
  provider varchar(255) DEFAULT NULL,
  type varchar(255) DEFAULT '',
  invoke_time bigint NOT NULL DEFAULT (0)::bigint,
  success int DEFAULT 0,
  failure int DEFAULT 0,
  elapsed int DEFAULT 0,
  concurrent int DEFAULT 0,
  max_elapsed int DEFAULT 0,
  max_concurrent int DEFAULT 0,
  CONSTRAINT dubbo_invoke_pkey PRIMARY KEY (id )
)
WITH (
  OIDS=FALSE
);
ALTER TABLE dubbo_invoke OWNER TO postgres;

CREATE INDEX dubbo_invoke_id_index
  ON dubbo_invoke
  USING btree
  (id );
CREATE INDEX dubbo_invoke_service_index
  ON dubbo_invoke
  USING btree
  (service );
CREATE INDEX dubbo_invoke_method_index
  ON dubbo_invoke
  USING btree
  (method );
  
CREATE INDEX dubbo_invoke_time_index
  ON dubbo_invoke
  USING btree
  (invoke_time );
